//
//  Enviroment.swift
//  MovieApp
//
//  Created by ömer atmaca on 17.09.2023.
//

import Foundation

public enum Environment {
    
    enum Keys {
        enum Plist {
            static let baseURL = "BASE_URL"
            static let apiKey = "API_KEY"
            static let buildNumber = "APP_BUILD_NUMBER"
            static let versionNumber = "APP_VERSION_NUMBER"
        }
    }
    
    // MARK: - Plist
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("Plist file not found")
        }
        return dict
    }()
    
    // MARK: - Plist values
    static let baseURL: String = {
        guard let baseURL = Environment.infoDictionary[Keys.Plist.baseURL] as? String else {
            fatalError("Root URL not set in plist for this environment")
        }
        return baseURL
    }()
    
    static let apiKey: String = {
        guard let apiKey = Environment.infoDictionary[Keys.Plist.apiKey] as? String else {
            fatalError("Root URL not set in plist for this environment")
        }
        return apiKey
    }()
    
    static let buildNumber : String = {
        guard let buildNumber = Environment.infoDictionary[Keys.Plist.buildNumber] as? String else {
            fatalError("Root BUILD NUMBER not set in plist for this environment")
        }
        return buildNumber
    }()
    
    static let versionNumber : String = {
        guard let buildNumber = Environment.infoDictionary[Keys.Plist.versionNumber] as? String else {
            fatalError("Root VERSION NUMBER not set in plist for this environment")
        }
        return buildNumber
    }()
}


