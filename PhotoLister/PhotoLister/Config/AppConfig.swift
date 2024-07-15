//
//  AppConfig.swift
//  PhotoLister
//
//  Created by ali Jamaldin on 14/07/2024.
//

import Foundation

class AppConfig {
    public static var shared = AppConfig();
    
    let baseURL: String
    let apiSecret: String
    let apiKey: String
    
    private init() { 
        guard let infoPlist = Bundle.main.infoDictionary else {
            fatalError("Somthing wrong with info.plist")
        }
        baseURL = infoPlist["BASE_API_URL"] as! String
        apiKey = infoPlist["API_KEY"] as! String
        apiSecret = infoPlist["API_SECRET"] as! String
    }
}
