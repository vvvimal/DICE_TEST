//
//  AppConstants.swift
//  Dice_Test
//
//  Created by Venugopalan, Vimal on 08/08/19.
//  Copyright © 2019 Venugopalan, Vimal. All rights reserved.
//

import UIKit

/// Network URLs
struct NetworkData {
    static let kBaseURL = "https://api.tronalddump.io/"
    static let kTagEndPoint = "tag"
}

/// Constant String used in the app
struct AppIdentifierStrings {
    static var kTagListViewCellReuseIdentifier = "TagListViewCellIdentifier"
    static var kTagDetailListViewCellReuseIdentifier = "TagDetailListViewCellIdentifier"
}

/// API related errors
enum APIError: Error {
    case requestFailed
    case jsonConversionFailure
    case invalidData
    case responseUnsuccessful
    case jsonParsingFailure
    case noInternetError
    
    var message: String {
        switch self {
        case .requestFailed: return "Request Failed"
        case .invalidData: return "Invalid Data"
        case .responseUnsuccessful: return "Response Unsuccessful"
        case .jsonParsingFailure: return "JSON Parsing Failure"
        case .jsonConversionFailure: return "JSON Conversion Failure"
        case .noInternetError: return "No Internet Connection"
        }
    }
}

// completion handler returning success or APIError object
typealias DiceAPIFetchCompletionHandler = (Bool, APIError?) -> Void

