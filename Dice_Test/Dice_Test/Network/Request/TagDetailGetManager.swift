//
//  TagDetailGetManager.swift
//  Dice_Test
//
//  Created by Venugopalan, Vimal on 10/08/19.
//  Copyright © 2019 Venugopalan, Vimal. All rights reserved.
//

import UIKit

struct TagDetailGetRequest: BaseRequest {
    var urlString: String
    
    init(tagName:String, nextPage:Int) {
        var originalString = ""
        if nextPage <= 1{
            originalString = NetworkData.kBaseURL + NetworkData.kTagEndPoint + "/\(tagName)"
        }
        else{
            originalString = NetworkData.kBaseURL + NetworkData.kTagEndPoint + "/\(tagName)?page=\(nextPage)"
        }
        urlString = originalString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
    }
}

class TagDetailGetManager: NetworkManager {
    var session: URLSession
    
    
    /// Init function with URLSession configuration
    ///
    /// - Parameter configuration: URLSessionConfiguration
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    
    /// Get Tag List
    ///
    /// - Parameters:
    ///   - request: BaseRequest object to test negative case, but should be TagListGetRequest
    ///   - completion: Result consisting of the TagDetailResponseModel Object or APIError
    func getTagDetail(from request: BaseRequest, completion: @escaping (Result<TagDetailResponseModel?, APIError>) -> Void) {
        if let requestObj = request.request{
            fetch(with: requestObj, decode: { json -> TagDetailResponseModel? in
                guard let tagListModelResult = json as? TagDetailResponseModel else { return  nil }
                return tagListModelResult
            }, completion: completion)
        }
        else{
            completion(Result.failure(.requestFailed))
        }
    }
}
