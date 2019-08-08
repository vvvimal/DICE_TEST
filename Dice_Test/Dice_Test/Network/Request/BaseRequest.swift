//
//  BaseRequest.swift
//  Dice_Test
//
//  Created by Venugopalan, Vimal on 09/08/19.
//  Copyright © 2019 Venugopalan, Vimal. All rights reserved.
//

// MARK: - BaseRequest protocol for the URLRequest
import UIKit
protocol BaseRequest {
    var urlString: String { get }
}

// MARK: - BaseRequest protocol extension
extension BaseRequest {
    var urlComponents: URLComponents? {
        return URLComponents(string: urlString)
    }
    
    var request: URLRequest? {
        if let url = urlComponents?.url{
            return URLRequest(url: url)
        }
        return nil
    }
    
}
