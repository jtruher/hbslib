import Foundation
#if !os(macOS)
import UIKit
#endif
// swiftlint:disable all

enum BackgroundImage : String, CaseIterable {
    
    case diagonalbrick, crisscross, box, eight, diagonal, heartshape, darkdots, themehighlight, darkgrid, nine, clown, scrolldots, seven, box_spark, one, jack, twobytwo, lightvertical, openpattern, pegyello, five, diamondshape, spaceysquares, shinning, queen, six, two, ace, twobytwoalpha, heartshapefat, spadeshape, zero, three, four, orbs, squigglebrick, depthbox, king, diamond, vertical, theme, clubshape, box_checked, ten, pegwhite
    
    var name : String {
        return "backgrounds_(self.rawValue).png"
    }
}
// swiftlint:disable all
extension BackgroundImage {
    
    var image : UIImage {
        return UIImage.convertBase64StringToImage(imageBase64String: base64)
    }
    
    var base64 : String {
        switch self {
        
        case .diagonalbrick:
            return "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAMAAAAoLQ9TAAAAAXNSR0IArs4c6QAAAAlQTFRFAAAA////AAAAc8aDcQAAAAN0Uk5TAP//RFDWIQAAADVJREFUGJVjYIQCJiYIzYBDgAkMcAvAlINoTAGYUpgQNgFGFIApgMoFasErAHcHDgEUvyAEAKiIATXDtFlKAAAAAElFTkSuQmCC"
        case .crisscross:
            return "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAMAAAAoLQ9TAAAAAXNSR0IArs4c6QAAAAlQTFRFAAAA////AAAAc8aDcQAAAAN0Uk5TAP//RFDWIQAAADRJREFUGJVjYIIDRjBgwBBgZIRxIULYBGBMCI1NAMEFAUwBVC42AYRx+AQIuwPhNag7kAUAy0ABeX/SoMEAAAAASUVORK5CYII="
        case .box:
            return "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAMAAAAoLQ9TAAAAAXNSR0IArs4c6QAAAAlQTFRFAAAA////AAAAc8aDcQAAAAN0Uk5TAP//RFDWIQAAABlJREFUGJVjYEIDDEyMyFxGkAAKGGYCaAAAtH4BSaara7EAAAAASUVORK5CYII="
        case .eight:
            return "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAMAAAAoLQ9TAAAAAXNSR0IArs4c6QAAAAlQTFRFAAAA////AAAAc8aDcQAAAAN0Uk5TAP//RFDWIQAAACpJREFUGJVjYAACJihggAImJjQRKAtZAJUmSgDNDAxrsbmD+tZieA7FWgBrUADJgqFU3QAAAABJRU5ErkJggg=="
        case .diagonal:
            return "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAMAAAAoLQ9TAAAAAXNSR0IArs4c6QAAAAlQTFRFAAAA////AAAAc8aDcQAAAAN0Uk5TAP//RFDWIQAAACNJREFUGJVjYAIDRkYYzYBVAMFlYsImgMzFJoDKxSYwSNwBAO8QAcHN6P/UAAAAAElFTkSuQmCC"
        case .heartshape:
            return "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAMAAAAoLQ9TAAAAAXNSR0IArs4c6QAAAAlQTFRFAAAA////AAAAc8aDcQAAAAN0Uk5TAP//RFDWIQAAACxJREFUGJVjYCAGMDExIVFgBogJpaAMOKCSAAM6H1kEyWUofJgImutR+PgAAI9OAP0uAUfkAAAAAElFTkSuQmCC"
        case .darkdots:
            return "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAMAAAAoLQ9TAAAAAXNSR0IArs4c6QAAAAlQTFRFAAAA////AAAAc8aDcQAAAAN0Uk5TAP//RFDWIQAAACFJREFUGJVjYAICRkYmJhjNgFUAGWAKICvHLkDYjEHiDgD90AHhqTy9sAAAAABJRU5ErkJggg=="
        case .themehighlight:
            return "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAMAAAAoLQ9TAAAAAXNSR0IArs4c6QAAAAlQTFRFAAAA////AAAAc8aDcQAAAAN0Uk5TAP//RFDWIQAAADdJREFUGJVjYAABJjBggAEmOEDnQ0RANCMYQEVAfIg0I1gAxgepAIvQRADDWkyHYTgd03Oo3gcAxbsBcy/OlbIAAAAASUVORK5CYII="
        case .darkgrid:
            return "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAMAAAAoLQ9TAAAAAXNSR0IArs4c6QAAAAlQTFRFAAAA////AAAAc8aDcQAAAAN0Uk5TAP//RFDWIQAAABlJREFUGJVjYGRkYkLGDBgCTGgAU2AYmQEA6pABwVuAJeIAAAAASUVORK5CYII="
        case .nine:
            return "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAMAAAAoLQ9TAAAAAXNSR0IArs4c6QAAAAlQTFRFAAAA////AAAAc8aDcQAAAAN0Uk5TAP//RFDWIQAAACxJREFUGJVjYAACJihggAImJjQRKAtZAJUmTwDDUJwOYUAFJAhAGcTYAmIDAGb0AL21EniuAAAAAElFTkSuQmCC"
        case .clown:
            return "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAMAAAAoLQ9TAAAAAXNSR0IArs4c6QAAAAlQTFRFAAAA////AAAAc8aDcQAAAAN0Uk5TAP//RFDWIQAAADtJREFUGJV1z1EKACAIA1C3+x9ahonBdB8mLzIMEiBVFTIM6mgAdujo4oJ6tMO0b+gBE4f/yx1mrRpukLwQAWE3CY1wAAAAAElFTkSuQmCC"
        case .scrolldots:
            return "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAMAAAAoLQ9TAAAAAXNSR0IArs4c6QAAAAlQTFRFAAAA////AAAAc8aDcQAAAAN0Uk5TAP//RFDWIQAAABpJREFUGJVjYGJiBAMYzYAhgMwB0ZgCw8gMAKtQAUGHVukqAAAAAElFTkSuQmCC"
        case .seven:
            return "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAMAAAAoLQ9TAAAAAXNSR0IArs4c6QAAAAlQTFRFAAAA////AAAAc8aDcQAAAAN0Uk5TAP//RFDWIQAAACJJREFUGJVjYGBgYEIABjDAEIABLAL4FVDKJ0YBQSeSIgAAUZAAffVEHksAAAAASUVORK5CYII="
        case .box_spark:
            return "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAMAAAAoLQ9TAAAAAXNSR0IArs4c6QAAAAlQTFRFAAAA////AAAAc8aDcQAAAAN0Uk5TAP//RFDWIQAAADVJREFUGJVjYEIDDEyMKAC7AFyMCaaCCc6HaUEioGbANSIMhWnDZS26FnRD0a3FdBgBv6ABALIAAU5mtZ61AAAAAElFTkSuQmCC"
        case .one:
            return "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAMAAAAoLQ9TAAAAAXNSR0IArs4c6QAAAAlQTFRFAAAA////AAAAc8aDcQAAAAN0Uk5TAP//RFDWIQAAACFJREFUGJVjYIACJiYGFMCEJsBEUADTjMEqwMSE5niEAAAsrgBbeoe+QwAAAABJRU5ErkJggg=="
        case .jack:
            return "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAMAAAAoLQ9TAAAAAXNSR0IArs4c6QAAAAlQTFRFAAAA////AAAAc8aDcQAAAAN0Uk5TAP//RFDWIQAAACFJREFUGJVjYIAAJihgYMAlABZjQAWDUADCxOsRTI8hAAA9tgBt88D5QQAAAABJRU5ErkJggg=="
        case .twobytwo:
            return "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAMAAAAoLQ9TAAAAAXNSR0IArs4c6QAAAAlQTFRFAAAA////AAAAc8aDcQAAAAN0Uk5TAP//RFDWIQAAABpJREFUGJVjYGJiZETGDBgCqFwmJkyBYWQGAM0QAYGvefCZAAAAAElFTkSuQmCC"
        case .lightvertical:
            return "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAMAAAAoLQ9TAAAAAXNSR0IArs4c6QAAAAlQTFRFAAAA////AAAAc8aDcQAAAAN0Uk5TAP//RFDWIQAAABJJREFUGJVjYGJiBAMYzTCyBQCr0AFBdl/DfgAAAABJRU5ErkJggg=="
        case .openpattern:
            return "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAMAAAAoLQ9TAAAAAXNSR0IArs4c6QAAAAlQTFRFAAAA////AAAAc8aDcQAAAAN0Uk5TAP//RFDWIQAAAC9JREFUGJVjYGRkYmKEAyYmBgwBGBdGYwoguBAhTAEYE4YxBYgzg5A7iPELXncAALCQAVHLrx8lAAAAAElFTkSuQmCC"
        case .pegyello:
            return "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAMAAAAoLQ9TAAAAAXNSR0IArs4c6QAAAAlQTFRFAAAA////AAAAc8aDcQAAAAN0Uk5TAP//RFDWIQAAADlJREFUGJVjYAACRihggAIgkwkI4CIgLiMjhITyYVrAIkh8iAimABIfJEKWAEFbMByG6XRMz6F6HwCG8AD9gsqKDAAAAABJRU5ErkJggg=="
        case .five:
            return "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAMAAAAoLQ9TAAAAAXNSR0IArs4c6QAAAAlQTFRFAAAA////AAAAc8aDcQAAAAN0Uk5TAP//RFDWIQAAACZJREFUGJVjYGBgYIIDBgjAIsCACqgjgGoJNhHKbYMxcHuOAZkPAFSIAJ07sWoFAAAAAElFTkSuQmCC"
        case .diamondshape:
            return "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAMAAAAoLQ9TAAAAAXNSR0IArs4c6QAAAAlQTFRFAAAA////AAAAc8aDcQAAAAN0Uk5TAP//RFDWIQAAADBJREFUGJWNzzEKAAAIw8CS/z/awckIYseDok06kBkDSAwgMcAUkCxYlceVx6fX2gJaUACpN8UrdQAAAABJRU5ErkJggg=="
        case .spaceysquares:
            return "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAMAAAAoLQ9TAAAAAXNSR0IArs4c6QAAAAlQTFRFAAAA////AAAAc8aDcQAAAAN0Uk5TAP//RFDWIQAAACNJREFUGJVjYGJiZETGDBgCjGgAUwCkDL8A8WbAaEwBurgDAKDQASEn+VAWAAAAAElFTkSuQmCC"
        case .shinning:
            return "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAMAAAAoLQ9TAAAAAXNSR0IArs4c6QAAAAlQTFRFAAAA////AAAAc8aDcQAAAAN0Uk5TAP//RFDWIQAAAClJREFUGJVjYAQCJiZGOGDAIgDiIoQwBWBMGD1QAghHQxyITwAihCEAAKcYATmw1+sbAAAAAElFTkSuQmCC"
        case .queen:
            return "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAMAAAAoLQ9TAAAAAXNSR0IArs4c6QAAAAlQTFRFAAAA////AAAAc8aDcQAAAAN0Uk5TAP//RFDWIQAAAC9JREFUGJVjYAACJihggAImJjQRGIO+AnAHIAswoWmBCCGbge50JmSd2HzHgMQDAGQoAMliReDvAAAAAElFTkSuQmCC"
        case .six:
            return "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAMAAAAoLQ9TAAAAAXNSR0IArs4c6QAAAAlQTFRFAAAA////AAAAc8aDcQAAAAN0Uk5TAP//RFDWIQAAACVJREFUGJVjYAACJihggAImJjQRGANDgIGBBAGybaGyAC6HgNgAXnQAs+y9GowAAAAASUVORK5CYII="
        case .two:
            return "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAMAAAAoLQ9TAAAAAXNSR0IArs4c6QAAAAlQTFRFAAAA////AAAAc8aDcQAAAAN0Uk5TAP//RFDWIQAAACpJREFUGJVjYAACJghggAEmJlQRGAsugiTDgArQBZjQBAaaj/Abwi/IAgBPuACbr7VfXAAAAABJRU5ErkJggg=="
        case .ace:
            return "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAMAAAAoLQ9TAAAAAXNSR0IArs4c6QAAAAlQTFRFAAAA////AAAAc8aDcQAAAAN0Uk5TAP//RFDWIQAAACVJREFUGJVjYAABJjBggAMmJlQRKBMhAmNQWQDNXiwCNLEWiQYAX6AAqbu74ycAAAAASUVORK5CYII="
        case .twobytwoalpha:
            return "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAMAAAAoLQ9TAAAAAXNSR0IArs4c6QAAAAlQTFRFAAAA////AAAAc8aDcQAAAAN0Uk5TAP//RFDWIQAAABhJREFUGJVjYGJiYEDGDBgCWITQBIaRGQCJEAEByVysjAAAAABJRU5ErkJggg=="
        case .heartshapefat:
            return "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAMAAAAoLQ9TAAAAAXNSR0IArs4c6QAAAAlQTFRFAAAA////AAAAc8aDcQAAAAN0Uk5TAP//RFDWIQAAAEhJREFUGJWNjlEOACAIQoP7HzrzOV0/LTZHkIpr/UDSIUOp7dRy6wCchlVaGLyrzq7+Ndtn3pUTXA4p5FB9memaW2d+nFu/sAFokAC6Bu8o1wAAAABJRU5ErkJggg=="
        case .spadeshape:
            return "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAMAAAAoLQ9TAAAAAXNSR0IArs4c6QAAAAlQTFRFAAAA////AAAAc8aDcQAAAAN0Uk5TAP//RFDWIQAAADVJREFUGJWVzzEOACAIBEEy/3+0URsPC+OGagoCVTsqIoUUUkihSQeavOFeOqXWnMf+/nI2AI7oAQGqn/seAAAAAElFTkSuQmCC"
        case .zero:
            return "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAMAAAAoLQ9TAAAAAXNSR0IArs4c6QAAAAlQTFRFAAAA////AAAAc8aDcQAAAAN0Uk5TAP//RFDWIQAAADxJREFUGJVlz0EOACAIA8Gm/3+0QUVh6QknJBYp4h292F3u+CUHAjcMMCBeFXyw1hAA31qAUQzVx3Ht/AVpMADFQ1tHWQAAAABJRU5ErkJggg=="
        case .three:
            return "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAMAAAAoLQ9TAAAAAXNSR0IArs4c6QAAAAlQTFRFAAAA////AAAAc8aDcQAAAAN0Uk5TAP//RFDWIQAAAC1JREFUGJVjYAACJihggAImJjQRKANJCaoECQIoZqBai02AYmsxnI7hORTvAwBRJACZd09/nAAAAABJRU5ErkJggg=="
        case .four:
            return "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAMAAAAoLQ9TAAAAAXNSR0IArs4c6QAAAAlQTFRFAAAA////AAAAc8aDcQAAAAN0Uk5TAP//RFDWIQAAACZJREFUGJVjYAADJiYIhgN0ATAbnwCEiUcAysIrAAU4BVB10kIAAElOAH0eKsOdAAAAAElFTkSuQmCC"
        case .orbs:
            return "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAMAAAAoLQ9TAAAAAXNSR0IArs4c6QAAAAlQTFRFAAAA////AAAAc8aDcQAAAAN0Uk5TAP//RFDWIQAAAClJREFUGJVjYGRkAgMYzYAhAGKCAITGL4ChhWgBYt0BEQIBbAIwQLYAANpwAZnJb479AAAAAElFTkSuQmCC"
        case .squigglebrick:
            return "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAMAAAAoLQ9TAAAAAXNSR0IArs4c6QAAAAlQTFRFAAAA////AAAAc8aDcQAAAAN0Uk5TAP//RFDWIQAAADFJREFUGJVjYEQCTEDAgCHAxITggkhMARgDJoFNAGIYTCN2AWRB3AIwg/ELgITIEAAAqFABNYMSqU8AAAAASUVORK5CYII="
        case .depthbox:
            return "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAMAAAAoLQ9TAAAAAXNSR0IArs4c6QAAAAlQTFRFAAAA////AAAAc8aDcQAAAAN0Uk5TAP//RFDWIQAAACBJREFUGJVjYGJiZGRCAgwYAoxoAFOAsBnEC2AYSl8BANdYAYW9dbiQAAAAAElFTkSuQmCC"
        case .king:
            return "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAMAAAAoLQ9TAAAAAXNSR0IArs4c6QAAAAlQTFRFAAAA////AAAAc8aDcQAAAAN0Uk5TAP//RFDWIQAAADpJREFUGJVjYGBgYmKAABgDQaMKMKGpRPAhAkh8sAAyHySAwgfxUPjYBDC0YBqKaS2mwzCdjuk5KAMAVOYAnVJXj0IAAAAASUVORK5CYII="
        case .diamond:
            return "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAMAAAAoLQ9TAAAAAXNSR0IArs4c6QAAAAlQTFRFAAAA////AAAAc8aDcQAAAAN0Uk5TAP//RFDWIQAAACtJREFUGJVjYEQDDDgFmJjwC4C4ECHsAjAuCGMTQOYyMWETIGwGMe7A6xcAppABQdE9i5IAAAAASUVORK5CYII="
        case .vertical:
            return "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAMAAAAoLQ9TAAAAAXNSR0IArs4c6QAAAAlQTFRFAAAA////AAAAc8aDcQAAAAN0Uk5TAP//RFDWIQAAABJJREFUGJVjYGJiZETGDCNbAADNkAGBjmio+wAAAABJRU5ErkJggg=="
        case .theme:
            return "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAMAAAAoLQ9TAAAAAXNSR0IArs4c6QAAAAlQTFRFAAAA////AAAAc8aDcQAAAAN0Uk5TAP//RFDWIQAAADdJREFUGJVjYAABJjBggAEmOIDzGcEAKgLiQ+ShIiAGRBokAuczwtTQRgDDWkyHYTgd03Oo3gcAvOcBYy2GRjoAAAAASUVORK5CYII="
        case .clubshape:
            return "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAMAAAAoLQ9TAAAAAXNSR0IArs4c6QAAAAlQTFRFAAAA////AAAAc8aDcQAAAAN0Uk5TAP//RFDWIQAAADBJREFUGJVjYIAAJiYGFMDEhCrCxIQmQlgAzQwQB4yYkNUj6SIsgGEGWU5HNRINAABqyADJgxWReQAAAABJRU5ErkJggg=="
        case .box_checked:
            return "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAMAAAAoLQ9TAAAAAXNSR0IArs4c6QAAAAlQTFRFAAAA////AAAAc8aDcQAAAAN0Uk5TAP//RFDWIQAAADxJREFUGJVjYEIDDFgFGKEAoQLBBwkwQkWYwEyQAEQESoAFIIohDAa4ciiNQwBdC7qh6NZiOAyb0/H5FgDmkAGxeHVKoAAAAABJRU5ErkJggg=="
        case .ten:
            return "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAMAAAAoLQ9TAAAAAXNSR0IArs4c6QAAAAlQTFRFAAAA////AAAAc8aDcQAAAAN0Uk5TAP//RFDWIQAAAClJREFUGJVjYGBgYmIAEWDAAGHC+TA5KMEAVwLVBqMGuQCG01G8i+x9AH++AO1FwJGPAAAAAElFTkSuQmCC"
        case .pegwhite:
            return "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAMAAAAoLQ9TAAAAAXNSR0IArs4c6QAAAAlQTFRFAAAA////AAAAc8aDcQAAAAN0Uk5TAP//RFDWIQAAADlJREFUGJVjYAACRihggAIgkwkI4CIgLiMjhITyYVrAIkh8iAimABIfJEKWAEFbMByG6XRMz6F6HwCG8AD9gsqKDAAAAABJRU5ErkJggg=="
        }
    }
}
