//
//  LocalStorage.swift
//  MovieApp
//
//  Created by ömer atmaca on 19.09.2023.
//

import Foundation


class LocalStorage {
    static let shared = LocalStorage()
    private init() { }
    let defaults = UserDefaults.standard
    
    func logout() {
        self.token = nil
        self.refreshToken = nil
        self.nowPlayingModel = nil
    }
    
    var token: String? {
        get {
            return defaults.string(forKey: Constants.UserDefaultsKey.token)
        }
        set {
            defaults.set(newValue, forKey: Constants.UserDefaultsKey.token)
        }
    }
    
    var refreshToken: String? {
        get {
            return defaults.string(forKey: Constants.UserDefaultsKey.refreshToken)
        }
        set {
            defaults.set(newValue, forKey: Constants.UserDefaultsKey.refreshToken)
        }
    }
    
    var isLoggedIn: Bool { !(token?.isEmpty ?? true) }
    
    var fcmToken: String? {
        get {
            return defaults.string(forKey: Constants.UserDefaultsKey.fcmToken)
        }
        set {
            defaults.set(newValue, forKey: Constants.UserDefaultsKey.fcmToken)
        }
    }
    
    var nowPlayingModel: Data? {
        get {
            return defaults.value(forKey: Constants.UserDefaultsKey.nowPlaying) as? Data
        }
        set {
            defaults.set(newValue, forKey: Constants.UserDefaultsKey.nowPlaying)
        }
    }
    
 
    
    func getNowPlaying() -> NowPlaying? {
        guard let data = self.nowPlayingModel else {return nil}
        let decoder = JSONDecoder()
        if let loadedNowPlaying = try? decoder.decode(NowPlaying.self, from: data) {
            return loadedNowPlaying
        } else {
            return nil
        }
    }
    
    func setNowPlaying(nowPlaying: NowPlaying) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(nowPlaying) {
            self.nowPlayingModel = encoded
        }
    }
}

