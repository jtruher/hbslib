//
//  KeyboardLanguage.swift
//  hbslib
//
//  Created by James Truher on 12/21/20.
//

import Foundation
#if !os(macOS)
import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var textField: TestKoreanTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        let koreanLanguageCode = "ko-KR"
//        let ??LanguageCode = "??"
        
        textField.tryLoggingPrimaryLanguageInfoOnKeyboard()
        textField.languageCode = koreanLanguageCode
//        textField.languageCode = ??LanguageCode
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}


class TestKoreanTextField: UITextField {
    func tryLoggingPrimaryLanguageInfoOnKeyboard() {
        print("Total number of keyboards. : \(UITextInputMode.activeInputModes.count)")
        for keyboardInputModes in UITextInputMode.activeInputModes{
            if let language = keyboardInputModes.primaryLanguage{
               dump(language)
            }
        }
    }
    
    var languageCode: String?{
        didSet {
            if self.isFirstResponder{
                self.resignFirstResponder();
                self.becomeFirstResponder();
            }
        }
    }
    
    override var textInputMode: UITextInputMode?{
        print("Total number of keyboards. : \(UITextInputMode.activeInputModes.count)")
        
        if let languageCode = self.languageCode {
            for keyboardInputModes in UITextInputMode.activeInputModes {
                if let language = keyboardInputModes.primaryLanguage {
                    if language == languageCode {
                        print("success")
                        return keyboardInputModes;
                    }
                }
            }
        }
        print("failed")
        return super.textInputMode;
    }
}
#endif
