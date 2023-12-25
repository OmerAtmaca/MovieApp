//
//  BundleExt.swift
//  ios-base
//
//  Created by Özkan Bölükbaş on 1.03.2022.
//

import Foundation
import UIKit
import Localize_Swift

private var bundleKey: UInt8 = 0

final class BundleExtension: Bundle {
     override func localizedString(forKey key: String, value: String?, table tableName: String?) -> String {
        return (objc_getAssociatedObject(self, &bundleKey) as? Bundle)?.localizedString(forKey: key, value: value, table: tableName) ?? super.localizedString(forKey: key, value: value, table: tableName)
    }
}

extension Bundle {
    static let once: Void = { object_setClass(Bundle.main, type(of: BundleExtension())) }()

    static func set(language: LanguageManager.Language, completion: () -> Void) {
        Localize.setCurrentLanguage(language.code)
        Bundle.once
        let isLanguageRTL = Locale.characterDirection(forLanguage: language.code) == .rightToLeft
        UIView.appearance().semanticContentAttribute = isLanguageRTL == true ? .forceRightToLeft : .forceLeftToRight
        UserDefaults.standard.set(isLanguageRTL,   forKey: "AppleTextDirection")
        UserDefaults.standard.set(isLanguageRTL,   forKey: "NSForceRightToLeftWritingDirection")
        UserDefaults.standard.set([language.code], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
        guard let path = Bundle.main.path(forResource: language.code, ofType: "lproj") else {
            assertionFailure("Failed to get a bundle path.")
            return
        }
        objc_setAssociatedObject(Bundle.main, &bundleKey, Bundle(path: path), objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        completion()
    }
}
