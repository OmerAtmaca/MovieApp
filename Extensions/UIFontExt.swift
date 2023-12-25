//
//  UIFontExt.swift
//  ios-base
//
//  Created by Özkan Bölükbaş on 1.03.2022.
//

import Foundation

import UIKit


struct AppFontName {
    static var regular: String {
        switch LanguageManager.shared.currentLanguage {
        case .en, .tr:
            return "MavenPro-Regular"
        case .ar:
            return "DINNextLTArabic-Regular"
        }
    }
    static var bold: String {
        switch LanguageManager.shared.currentLanguage {
        case .en, .tr:
            return "MavenPro-Bold"
        case .ar:
            return "DINNextLTArabic-Bold"
        }
    }
    static var medium: String {
        switch LanguageManager.shared.currentLanguage {
        case .en, .tr:
            return "MavenPro-Medium"
        case .ar:
            return "DINNextLTArabic-Medium"
        }
    }
    static var semiBold: String {
        switch LanguageManager.shared.currentLanguage {
        case .en, .tr:
            return "MavenPro-SemiBold"
        case .ar:
            return "DINNextLTArabic-Medium"
        }
    }
}

extension UIFontDescriptor.AttributeName {
    static let nsctFontUIUsage = UIFontDescriptor.AttributeName(rawValue: "NSCTFontUIUsageAttribute")
}

extension UIFont {
    static var isOverrided: Bool = false

    @objc class func mySystemFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: AppFontName.regular, size: size)!
    }

    @objc class func myBoldSystemFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: AppFontName.bold, size: size)!
    }

    @objc class func myMediumSystemFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: AppFontName.medium, size: size)!
    }
    
    @objc class func mySemiboldSystemFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: AppFontName.semiBold, size: size)!
    }

    @objc convenience init(myCoder aDecoder: NSCoder) {
        guard
            let fontDescriptor = aDecoder.decodeObject(forKey: "UIFontDescriptor") as? UIFontDescriptor,
            let fontAttribute = fontDescriptor.fontAttributes[.nsctFontUIUsage] as? String else {
                self.init(myCoder: aDecoder)
                return
        }
        var fontName = ""
        switch fontAttribute {
        case "CTFontRegularUsage":
            fontName = AppFontName.regular
        case "CTFontEmphasizedUsage", "CTFontBoldUsage":
            fontName = AppFontName.bold
        case "CTFontMediumUsage":
            fontName = AppFontName.medium
        case "CTFontDemiUsage":
            fontName = AppFontName.semiBold
        default:
            fontName = AppFontName.regular
        }
        self.init(name: fontName, size: fontDescriptor.pointSize)!
    }

    class func overrideInitialize() {
        guard self == UIFont.self, !isOverrided else { return }

        // Avoid method swizzling run twice and revert to original initialize function
        isOverrided = true

        if let systemFontMethod = class_getClassMethod(self, #selector(systemFont(ofSize:))),
            let mySystemFontMethod = class_getClassMethod(self, #selector(mySystemFont(ofSize:))) {
            method_exchangeImplementations(systemFontMethod, mySystemFontMethod)
        }

        if let boldSystemFontMethod = class_getClassMethod(self, #selector(boldSystemFont(ofSize:))),
            let myBoldSystemFontMethod = class_getClassMethod(self, #selector(myBoldSystemFont(ofSize:))) {
            method_exchangeImplementations(boldSystemFontMethod, myBoldSystemFontMethod)
        }

        if let italicSystemFontMethod = class_getClassMethod(self, #selector(italicSystemFont(ofSize:))),
            let myItalicSystemFontMethod = class_getClassMethod(self, #selector(myMediumSystemFont(ofSize:))) {
            method_exchangeImplementations(italicSystemFontMethod, myItalicSystemFontMethod)
        }
        
        if let semiBoldSystemFontMethod = class_getClassMethod(self, #selector(boldSystemFont(ofSize:))),
            let mySemiboldSystemFontMethod = class_getClassMethod(self, #selector(mySemiboldSystemFont(ofSize:))) {
            method_exchangeImplementations(semiBoldSystemFontMethod, mySemiboldSystemFontMethod)
        }

        if let initCoderMethod = class_getInstanceMethod(self, #selector(UIFontDescriptor.init(coder:))), // Trick to get over the lack of UIFont.init(coder:))
            let myInitCoderMethod = class_getInstanceMethod(self, #selector(UIFont.init(myCoder:))) {
            method_exchangeImplementations(initCoderMethod, myInitCoderMethod)
        }
    }
}
