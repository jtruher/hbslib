//
//  GameCenterHelper.swift
//  hbslib
//
//  Created by James Truher on 11/25/20.
//

import Foundation
// Copyright (c) 2018 Razeware LLC
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
// distribute, sublicense, create a derivative work, and/or sell copies of the
// Software in any work that is designed, intended, or marketed for pedagogical or
// instructional purposes related to programming, coding, application development,
// or information technology.  Permission for such use, copying, modification,
// merger, publication, distribution, sublicensing, creation of derivative works,
// or sale is expressly withheld.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
import GameKit
#if !os(macOS)
import UIKit

protocol GameCenterFeedback {
    var messageToDisplay: String { get set }
}

public class Game: Codable, GameCenterFeedback {
    var messageToDisplay: String
}

public class GameCenterHelper: NSObject, GKLocalPlayerListener, GKTurnBasedMatchmakerViewControllerDelegate {
    typealias CompletionBlock = (Error?) -> Void

    public static var helper = GameCenterHelper()

    public static var isAuthenticated: Bool {
        return GKLocalPlayer.local.isAuthenticated
    }

    public var viewController: UIViewController?
    public var currentMatchmakerVC: GKTurnBasedMatchmakerViewController?

    enum GameCenterHelperError: Error {
        case matchNotFound
    }

    public var currentMatch: GKTurnBasedMatch?
    public var currentBoard: Game?

    public var canTakeTurnForCurrentMatch: Bool {
        guard let match = currentMatch else {
            return true
        }

        return match.isLocalPlayersTurn
    }

    public var canStartNewMatch: Bool {
        return GameCenterHelper.isAuthenticated && matches.count < 5
    }

    public var matches = [GKTurnBasedMatch]()

    override init() {
        super.init()

        GKLocalPlayer.local.authenticateHandler = { gcAuthVC, error in

            print(String(describing: gcAuthVC), error as Any)

            NotificationCenter.default.post(name: .authenticationChanged, object: GKLocalPlayer.local.isAuthenticated)
            self.loadMatches { _ in

            }

            if GKLocalPlayer.local.isAuthenticated {
                GKLocalPlayer.local.register(self)
            } else if let authVC = gcAuthVC {
                self.viewController?.present(authVC, animated: true)
            } else {
                print("Error authentication to GameCenter: \(error?.localizedDescription ?? "none")")
            }
        }
    }

    func buildGKMatchRequest(group: Int) -> GKMatchRequest {
        let request = GKMatchRequest()

        request.minPlayers = 2
        request.maxPlayers = 2
        request.inviteMessage = "Would you like to play Gomoku?"
        request.playerGroup = group

        return request
    }

    func presentMatchmaker(group: Int) {
        guard GKLocalPlayer.local.isAuthenticated else {
            return
        }

        let request = buildGKMatchRequest(group: group)

//        request.minPlayers = 2
//        request.maxPlayers = 2
//        request.inviteMessage = "Would you like to play Gomoku?"
//        // TODO: This should probably be passed in as a parameter, yeah?
//        request.playerGroup = group
//        print("PLAYER GROUP \(group)")

        let vc = GKTurnBasedMatchmakerViewController(matchRequest: request)
        vc.turnBasedMatchmakerDelegate = self

        currentMatchmakerVC = vc
        viewController?.present(vc, animated: true)
    }

    // Not sure if this guy should own this or what
    func loadMatches(_ completion: @escaping CompletionBlock) {
        guard GameCenterHelper.isAuthenticated else { return }

        GKTurnBasedMatch.loadMatches { (matches, error) in
            if error == nil, let gameMatches = matches?.filter({$0.status != .ended}) {
                self.matches = gameMatches
                self.matches.sort { (match1, match2) -> Bool in
                    return match1.isLocalPlayersTurn && !match2.isLocalPlayersTurn
                }
                self.matches.sort { (match1, match2) -> Bool in
                    return match1.creationDate < match2.creationDate
                }

                //                for m in self.matches {
                //                    print(m)
                //                }
                completion(nil)
            } else {
                completion(error)
            }

        }

    }

    func endTurn(_ model: Game, completion: @escaping CompletionBlock) {
        guard let match = currentMatch else {
            completion(GameCenterHelperError.matchNotFound)
            return
        }

        do {
            match.message = model.messageToDisplay

            match.endTurn(
                withNextParticipants: match.others,
                turnTimeout: GKExchangeTimeoutDefault,
                match: try JSONEncoder().encode(model),
                completionHandler: completion
            )
        } catch {
            completion(error)
        }
    }

    func win(_ model: Game, completion: @escaping CompletionBlock) {
        guard let match = currentMatch else {
            completion(GameCenterHelperError.matchNotFound)
            return
        }

        match.currentParticipant?.matchOutcome = .won
        match.others.forEach { other in
            other.matchOutcome = .lost
        }

        var data: Data?

        do {
            data = try JSONEncoder().encode(model)
        } catch {
            print(error)
        }

        match.endMatchInTurn(
            withMatch: data ?? match.matchData ?? Data(),
            completionHandler: completion
        )
    }
    
    public func player(_ player: GKPlayer, wantsToQuitMatch match: GKTurnBasedMatch) {
        let activeOthers = match.others.filter { other in
            return other.status == .active
        }

        match.currentParticipant?.matchOutcome = .lost
        activeOthers.forEach { participant in
            participant.matchOutcome = .won
        }

        match.endMatchInTurn(
            withMatch: match.matchData ?? Data()
        )
    }

    public func player(_ player: GKPlayer, receivedTurnEventFor match: GKTurnBasedMatch, didBecomeActive: Bool) {
        if let vc = currentMatchmakerVC {
            currentMatchmakerVC = nil
            vc.dismiss(animated: true)
        }

        guard didBecomeActive else {
            NotificationCenter.default.post(name: .activityHappened, object: match)
            return
        }

        NotificationCenter.default.post(name: .presentGame, object: match)
    }

    public func turnBasedMatchmakerViewControllerWasCancelled(_ viewController: GKTurnBasedMatchmakerViewController) {
        viewController.dismiss(animated: true)
    }

    public func turnBasedMatchmakerViewController(_ viewController: GKTurnBasedMatchmakerViewController, didFailWithError error: Error) {
        print("Matchmaker vc \(viewController) did fail with error: \(error.localizedDescription).")
    }

}

//extension GameCenterHelper: GKTurnBasedMatchmakerViewControllerDelegate {
//    func turnBasedMatchmakerViewControllerWasCancelled(_ viewController: GKTurnBasedMatchmakerViewController) {
//        viewController.dismiss(animated: true)
//    }
//
//    func turnBasedMatchmakerViewController(_ viewController: GKTurnBasedMatchmakerViewController, didFailWithError error: Error) {
//        print("Matchmaker vc did fail with error: \(error.localizedDescription).")
//    }
//}

//extension GameCenterHelper: GKInviteEventListener {
//
//}

//extension GameCenterHelper: GKLocalPlayerListener {
//    func player(_ player: GKPlayer, wantsToQuitMatch match: GKTurnBasedMatch) {
//        let activeOthers = match.others.filter { other in
//            return other.status == .active
//        }
//
//        match.currentParticipant?.matchOutcome = .lost
//        activeOthers.forEach { participant in
//            participant.matchOutcome = .won
//        }
//
//        match.endMatchInTurn(
//            withMatch: match.matchData ?? Data()
//        )
//    }
//
//    func player(_ player: GKPlayer, receivedTurnEventFor match: GKTurnBasedMatch, didBecomeActive: Bool) {
//        if let vc = currentMatchmakerVC {
//            currentMatchmakerVC = nil
//            vc.dismiss(animated: true)
//        }
//
//        guard didBecomeActive else {
//            NotificationCenter.default.post(name: .activityHappened, object: match)
//            return
//        }
//
//        NotificationCenter.default.post(name: .presentGame, object: match)
//    }
//}

extension Notification.Name {
    static let presentGame = Notification.Name(rawValue: "presentGame")
    static let authenticationChanged = Notification.Name(rawValue: "authenticationChanged")
    static let activityHappened = Notification.Name(rawValue: "activityHappened")

}

//public extension UserDefaults {
//    // note: `defaults.fontName` does not have to match the property name `defaultFontName`
//    static let defaultFontName = "defaults.fontName"
//}

extension GKTurnBasedMatch  {
    var isLocalPlayersTurn: Bool {
        return currentParticipant?.player == GKLocalPlayer.local
    }

    var others: [GKTurnBasedParticipant] {
        return participants.filter {
            return $0.player != GKLocalPlayer.local
        }
    }

    var opponent: GKTurnBasedParticipant? {
        return participants.filter {
            return $0.player != GKLocalPlayer.local
        }.first
    }
    
    @available(iOS 13, *)
    var tableDescription: String {
        if let opp = opponent {
            if isLocalPlayersTurn {
                return "\(String(describing: getLastActivityString()))Your Turn - vs. \(opp.player?.displayName ?? "Auto-Match")"
            } else {
                return "\(String(describing: getLastActivityString()))\nTheir Turn - vs. \(opp.player?.displayName ?? "Auto-Match")"
            }
        }

        print("no opponent yet, maybe an auto-match?")
        return "Auto-Match - \(self.isLocalPlayersTurn ? "Your Turn" : "Their Turn")"
    }

    @available(iOS 13, *)
    func getLastActivityString() -> String {
        if let lastMove = getLastActionDate() {
            let formatter = RelativeDateTimeFormatter()
            formatter.unitsStyle = .full

            let relativeDate = formatter.localizedString(for: lastMove, relativeTo: Date())

            return relativeDate
        } else {
            return "No move yet."
        }
    }

    func getLastActionDate() -> Date? {
        var date = Date(timeIntervalSince1970: 0)
        var changed = false
        for player in participants {
            if let lastDate = player.lastTurnDate {

                print(lastDate)
                if date < lastDate {
                    date = lastDate
                    changed = true
                }
            }
        }
        return changed ? date : nil
    }

    func getMatchData() {

        loadMatchData { data, _ in
            var model: Game

            if let data = data {
                do {
                    // 3
                    model = try JSONDecoder().decode(Game.self, from: data)
                    GameCenterHelper.helper.currentBoard = model
                } catch {

                    //            model = Board(width: 9, height: 9)
                }
            }
        }

    }
}
#endif
