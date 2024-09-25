//
//  AppConfiguration.swift
//  Swipbox_Task
//
//  Created by Muneeb Ali on 22/09/2024.
//

import Foundation

final class AppConfiguration {
    // BASE URL
    lazy var apiBaseURL: String = {
        guard let apiBaseURL = Bundle.main.object(forInfoDictionaryKey: "ApiBaseURL") as? String else {
            fatalError("BaseURL must not be empty in plist")
        }
        return apiBaseURL
    }()
    
    lazy var imageBaseURL: String = {
        guard let imageBaseURL = Bundle.main.object(forInfoDictionaryKey: "ImageBaseURL") as? String else {
            fatalError("BaseURL must not be empty in plist")
        }
        return imageBaseURL
    }()
    
    lazy var bannerImageBaseURL: String = {
        guard let imageBaseURL = Bundle.main.object(forInfoDictionaryKey: "BannerImageBaseURL") as? String else {
            fatalError("BaseURL must not be empty in plist")
        }
        return imageBaseURL
    }()
    
    lazy var apiaccessToken: String = {
        guard let apiaccessToken = Bundle.main.object(forInfoDictionaryKey: "ApiAccessToken") as? String else {
            fatalError("API Access Token must not be empty in plist")
        }
        return apiaccessToken
    }()
}
