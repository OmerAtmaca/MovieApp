//
//  BaseDateFormatter.swift
//  ios-base
//
//  Created by Özkan Bölükbaş on 1.03.2022.
//

import Foundation

class BaseDateFormatter: DateFormatter {
    override init() {
        super.init()
        locale = Locale(identifier: LanguageManager.shared.currentLanguage.rawValue)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        locale = Locale(identifier: LanguageManager.shared.currentLanguage.rawValue)
    }
}
