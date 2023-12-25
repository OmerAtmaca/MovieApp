//
//  LanguageManager.swift
//  ios-base
//
//  Created by Özkan Bölükbaş on 1.03.2022.
//

import Foundation
import UIKit
import Localize_Swift
import IQKeyboardManagerSwift

class LanguageManager {
    public enum Language: String, CaseIterable {
        case tr = "tr"
        case en = "en"
        case ar = "ar"
        
        var code: String { self.rawValue }
    }
    
    private let rtlLanguages: [Language] = [.ar]
    
    var isLangRTL: Bool { rtlLanguages.contains(currentLanguage) }
    
    static let shared = LanguageManager()
    
    var currentLanguage: Language {
        guard let lang = Language(rawValue: Localize.currentLanguage()) else {
            assertionFailure("Unhandled language in use!!")
            return .en
        }
        return lang
    }
    
    var langText: String {localizedLangText(lang: currentLanguage) }
    
    func localizedLangText(lang: Language) -> String {
        switch lang {
        case .en:
            return "english".localized()
        case .tr:
            return "turkish".localized()
        case .ar:
            return "arabic".localized()
        }
    }
    
    private init() {
        
    }
    
    func localizeObject(_ object: Any?) {
        switch object {
        case let object as UIButton:
            object.semanticContentAttribute = isLangRTL ? .forceRightToLeft : .forceLeftToRight
        case let object as NSMutableParagraphStyle:
            object.alignment = isLangRTL ? .right : .left
        case let object as UITextView:
            object.textAlignment = isLangRTL ? .right : .left
        case let object as UILabel:
            object.textAlignment = isLangRTL ? .right : .left
        case let object as UITextField:
            object.textAlignment = isLangRTL ? .right : .left
        case let object as DateFormatter:
            object.locale = Locale(identifier: LanguageManager.shared.currentLanguage.rawValue)
        case let object as UIPageControl:
            object.transform = CGAffineTransform(scaleX: (isLangRTL ? -1 : 1), y: (isLangRTL ? 1 : -1))
        default:
            assertionFailure("unlocalizable object is passed")
        }
    }
    
    // a source: Icon direction post https://useyourloaf.com/blog/flipping-and-localizing-image-assets/
    // bundle source: https://stackoverflow.com/questions/29985614/how-can-i-change-locale-programmatically-with-swift
    func changeCurrentLanguage(to lang: Language, completion: () -> Void) {
        Bundle.set(language: lang, completion: completion)
        IQKeyboardManager.shared.toolbarDoneBarButtonItemText = "Done".localized()
    }
}
