#if !os(macOS)
import UIKit

public extension UIView {
    @available(iOS 9.0, *)
    func applyAutolayoutHugging() {
        if let parent = self.superview {
            self.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([
                self.topAnchor.constraint(equalTo: parent.topAnchor),
                self.bottomAnchor.constraint(equalTo: parent.bottomAnchor),
                self.leadingAnchor.constraint(equalTo: parent.leadingAnchor),
                self.trailingAnchor.constraint(equalTo: parent.trailingAnchor)
            ])
        }
    }
    
    @available(iOS 9.0, *)
    func wobble() {
        var values = [0.0]
        
        for i in 0...11 {
            
        }
    }
//
//    - (void)wobble {
//        NSMutableArray* newValues = [NSMutableArray arrayWithObject:@0];
//
//        float start = 0.075 + drand48() * 0.05;
//
//        NSInteger flip = -1;
//        if (drand48() > 0.5) {
//            flip = 1;
//        }
//
//        for(int i = 1; i < 11; i++) {
//            [newValues addObject:@(start / i * (i % 2 == 0 ? flip : -flip ) * 7 * (drand48()) / M_PI_2)];
//        }
//
//        CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"];
//        animation.repeatCount = 1;
//        animation.beginTime = CACurrentMediaTime();
//    //    animation.beginTime = CACurrentMediaTime() + drand48() * 0.125;
//        CGFloat duration = 0.57 + drand48() * 0.25;
//        animation.duration = duration;
//        animation.fillMode = kCAFillModeForwards;
//        animation.values = newValues;
//        //    animation.keyTimes = @[@0.0, @0.25, @, @0.66, @1.0];
//        animation.removedOnCompletion = YES; // final stage is equal to starting stage
//        animation.autoreverses = NO;
//
//        [self.imageView.layer addAnimation:animation forKey:@"wobble"];
//        [self.darkShadow addAnimation:animation forKey:@"wobble"];
//    //    [self.lightShadow addAnimation:animation forKey:@"wobble"];
//
//        [UIView animateWithDuration:0.225 animations:^{
//            self.imageView.transform = CGAffineTransformMakeScale(1.15, 1.15);
//            self.darkShadow.transform = CATransform3DMakeScale(1.15, 1.15, 1.0);
//            self.lightShadow.transform = CATransform3DMakeScale(1.15, 1.15, 1.0);
//        } completion:^(BOOL finished) {
//            [UIView animateWithDuration:0.125 animations:^{
//                self.imageView.transform = CGAffineTransformMakeScale(1, 1);
//                self.darkShadow.transform = CATransform3DMakeScale(1, 1, 1.0);
//                self.lightShadow.transform = CATransform3DMakeScale(1, 1, 1.0);
//
//            }];
//        }];
//    }

    
}

public extension UIFont {
    func withTraits(traits: UIFontDescriptor.SymbolicTraits) -> UIFont {
        if let descriptor = fontDescriptor.withSymbolicTraits(traits) {
            return UIFont(descriptor: descriptor, size: 0) //size 0 means keep the size as it is
        }
        return self
    }

    func bold() -> UIFont {
        return withTraits(traits: .traitBold)
    }

    func italic() -> UIFont {
        return withTraits(traits: .traitItalic)
    }

    static func footnote() -> UIFont {
        return UIFont.preferredFont(forTextStyle: .footnote)
    }

    @available(iOS 11.0, *)
    static func largeTitle() -> UIFont {
        return UIFont.preferredFont(forTextStyle: .largeTitle)
    }

    static func body() -> UIFont {
        return UIFont.preferredFont(forTextStyle: .body)
    }

    static func title2() -> UIFont {
        return UIFont.preferredFont(forTextStyle: .title2)
    }

    static func headline() -> UIFont {
        return UIFont.preferredFont(forTextStyle: .headline)
    }

}

import GameplayKit

/// Make a random seed and store in a database
///
///  ```
///  let seed = UInt64.random(in: UInt64.min ... UInt64.max)
///  var generator = Generator(seed: seed)
///  ```
///
/// Or if you just need the seeding ability for testing,
///
/// ```
/// var generator = Generator()
/// ```
/// uses a default seed of 0
///
/// ```
/// let chars = ['a','b','c','d','e','f']`
/// let randomChar = chars.randomElement(using: &generator)
/// let randomInt = Int.random(in: 0 ..< 1000, using: &generator)
/// ```
public class SeededGenerator: RandomNumberGenerator {
    let seed: UInt64
    private let generator: GKMersenneTwisterRandomSource
    convenience init() {
        self.init(seed: 0)
    }
    init(seed: UInt64) {
        self.seed = seed
        generator = GKMersenneTwisterRandomSource(seed: seed)
    }
    public func next<T>(upperBound: T) -> T where T: FixedWidthInteger, T: UnsignedInteger {
        return T(abs(generator.nextInt(upperBound: Int(upperBound))))
    }
    public func next<T>() -> T where T: FixedWidthInteger, T: UnsignedInteger {
        return T(abs(generator.nextInt()))
    }
    public func next() -> UInt64 {
        return UInt64(abs(generator.nextInt()))
    }
}


public typealias UIButtonTargetClosure = (UIButton) -> Void

public class ClosureWrapper: NSObject {
    let closure: UIButtonTargetClosure
    init(_ closure: @escaping UIButtonTargetClosure) {
        self.closure = closure
    }
}

extension UIButton {
    private struct AssociatedKeys {
        static var targetClosure = "targetClosure"
    }

    private var targetClosure: UIButtonTargetClosure? {
        get {
            guard let closureWrapper = objc_getAssociatedObject(self, &AssociatedKeys.targetClosure)
                    as? ClosureWrapper else { return nil }
            return closureWrapper.closure
        }
        set(newValue) {
            guard let newValue = newValue else { return }
            objc_setAssociatedObject(self,
                                     &AssociatedKeys.targetClosure,
                                     ClosureWrapper(newValue),
                                     objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    public func addTargetClosure(closure: @escaping UIButtonTargetClosure) {
        targetClosure = closure
        addTarget(self, action: #selector(UIButton.closureAction), for: .touchUpInside)
    }

    func addTargetClosure(eventType: UIControl.Event, closure: @escaping UIButtonTargetClosure) {
        targetClosure = closure
        addTarget(self, action: #selector(UIButton.closureAction), for: eventType)
    }

    @objc func closureAction() {
        guard let targetClosure = targetClosure else { return }
        targetClosure(self)
    }
}

public extension UIColor {
    /// randomColor generates a random color.
    /// - Returns: a random UIColor.
    static func randomColor() -> UIColor {
        return UIColor.init(red: CGFloat.random(in: 0...1),
                            green: CGFloat.random(in: 0...1),
                            blue: CGFloat.random(in: 0...1),
                            alpha: 1.0)
    }

    @available(iOS 10.0, *)
    static func randomP3Color() -> UIColor {
        return UIColor.init(displayP3Red: CGFloat.random(in: 0...1),
                            green: CGFloat.random(in: 0...1),
                            blue: CGFloat.random(in: 0...1),
                            alpha: 1.0)
    }
}

public extension UIImage {
    func toBase64() -> String? {
        guard let imageData = self.pngData() else { return nil }
        return imageData.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)
    }

    static func convertBase64StringToImage(imageBase64String: String) -> UIImage {
        let imageData = Data.init(base64Encoded: imageBase64String, options: .init(rawValue: 0))
        let image = UIImage(data: imageData!)

        return image!
    }
}

@available(iOS 11.0, *)
public final class ScaledFont {
    private struct FontDescription: Decodable {
        let fontSize: CGFloat
        let fontName: String
    }

    private typealias StyleDictionary = [UIFont.TextStyle.RawValue: FontDescription]
    private var styleDictionary: StyleDictionary?

    /// Create a `ScaledFont`
    ///
    /// - Parameter fontName: Name of a plist file (without the extension)
    ///   in the main bundle that contains the style dictionary used to
    ///   scale fonts for each text style.

    public init(fontName: String) {
        if let url = Bundle.main.url(forResource: fontName, withExtension: "plist"),
            let data = try? Data(contentsOf: url) {
            let decoder = PropertyListDecoder()
            styleDictionary = try? decoder.decode(StyleDictionary.self, from: data)
        }
    }

    /// Get the scaled font for the given text style using the
    /// style dictionary supplied at initialization.
    ///
    /// - Parameter textStyle: The `UIFontTextStyle` for the
    ///   font.
    /// - Returns: A `UIFont` of the custom font that has been
    ///   scaled for the users currently selected preferred
    ///   text size.
    ///
    /// - Note: If the style dictionary does not have
    ///   a font for this text style the default preferred
    ///   font is returned.

    public func font(forTextStyle textStyle: UIFont.TextStyle) -> UIFont {
        guard let fontDescription = styleDictionary?[textStyle.rawValue],
            let font = UIFont(name: fontDescription.fontName, size: fontDescription.fontSize) else {
            return UIFont.preferredFont(forTextStyle: textStyle)
        }

        let fontMetrics = UIFontMetrics(forTextStyle: textStyle)
        return fontMetrics.scaledFont(for: font)
    }
}

#endif

public extension String {
    func deletingPrefix(_ prefix: String) -> String {
        guard self.hasPrefix(prefix) else { return self }
        return String(self.dropFirst(prefix.count))
    }

    func deletingSuffix(_ suffix: String) -> String {
        guard self.hasSuffix(suffix) else { return self }
        return String(self.dropLast(suffix.count))
    }
    
    var titleized: String {
        let SMALL_WORDS = ["a", "an", "and", "as", "at", "but", "by", "en", "for", "if", "in", "of", "on", "or", "the", "to", "v", "v.", "via", "vs", "vs."]

        var words = self.lowercased().split(separator: " ").map({ String($0)})
        words[0] = words[0].capitalized
        for i in 1 ..< words.count {
            if !SMALL_WORDS.contains(words[i]) {
                words[i] = words[i].capitalized
            }
        }
        return words.joined(separator: " ")
    }
}

public extension Sequence where Iterator.Element: Hashable {
    func unique() -> [Iterator.Element] {
        var seen: Set<Iterator.Element> = []
        return filter { seen.insert($0).inserted }
    }
}

//  Created by Keith Harrison https://useyourloaf.com
//  Copyright (c) 2017 Keith Harrison. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without
//  modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright
//  notice, this list of conditions and the following disclaimer.
//
//  2. Redistributions in binary form must reproduce the above copyright
//  notice, this list of conditions and the following disclaimer in the
//  documentation and/or other materials provided with the distribution.
//
//  3. Neither the name of the copyright holder nor the names of its
//  contributors may be used to endorse or promote products derived from
//  this software without specific prior written permission.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
//  AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
//  IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
//  ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
//  LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
//  CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
//  SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
//  INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
//  CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
//  ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
//  POSSIBILITY OF SUCH DAMAGE.

//import UIKit

/// A utility class to help you use custom fonts with
/// dynamic type.
///
/// To use this class you must supply the name of a style
/// dictionary for the font when creating the class. The
/// style dictionary should be stored as a property list
/// file in the main bundle.
///
/// The style dictionary contains an entry for each text
/// style that uses the raw string value for each
/// `UIFontTextStyle` as the key.
///
/// The value of each entry is a dictionary with two keys:
///
/// + fontName: A String which is the font name.
/// + fontSize: A number which is the point size to use
///             at the `.large` content size.
///
/// For example to use a 17 pt Noteworthy-Bold font
/// for the `.headline` style at the `.large` content size:
///
///     <dict>
///         <key>UICTFontTextStyleHeadline</key>
///         <dict>
///             <key>fontName</key>
///             <string>Noteworthy-Bold</string>
///             <key>fontSize</key>
///             <integer>17</integer>
///         </dict>
///     </dict>
///
/// You do not need to include an entry for every text style
/// but if you try to use a text style that is not included
/// in the dictionary it will fallback to the system preferred
/// font.

struct HBSLib {
    var text = "Hello, World!"
}

public extension Comparable {

    /// Clamps a `Comparable` between `lower` and `upper`.
    /// It is expected that lower is less than upper.
    /// - Parameters:
    ///   - lower: a lower bound for clamping
    ///   - upper: an upper bound for clamping
    /// - Returns: The clamped value.
    func clamp<T: Comparable>(lower: T, _ upper: T) -> T {
        if let val = self as? T {
            return min(max(val, lower), upper)
        }
        return lower
    }
}
