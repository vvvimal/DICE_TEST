//
//  TagListGetManager.swift
//  Dice_Test
//
//  Created by Venugopalan, Vimal on 09/08/19.
//  Copyright © 2019 Venugopalan, Vimal. All rights reserved.
//

import UIKit

struct TagListGetRequest: BaseRequest {
    var urlString: String = NetworkData.kBaseURL + NetworkData.kTagEndPoint
}

class TagListGetManager: NetworkManager {
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
    ///   - request: BaseRequest object to check negative cases, should be TagListGetRequest
    ///   - completion: Result consisting of the TagListResponseModel Object or APIError
    func getTagList(from request: BaseRequest, completion: @escaping (Result<TagListResponseModel?, APIError>) -> Void) {
        if let requestObj = request.request{
            fetch(with: requestObj, decode: { json -> TagListResponseModel? in
                guard let tagListModelResult = json as? TagListResponseModel else { return  nil }
                return tagListModelResult
            }, completion: completion)
        }
        else{
            completion(Result.failure(.requestFailed))
        }
    }
}
