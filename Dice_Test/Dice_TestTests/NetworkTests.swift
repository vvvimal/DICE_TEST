//
//  NetworkTests.swift
//  Dice_TestTests
//
//  Created by Venugopalan, Vimal on 13/08/19.
//  Copyright © 2019 Venugopalan, Vimal. All rights reserved.
//

import XCTest
@testable import Dice_Test

struct UnsuccessfulResponseRequest: BaseRequest {
    
    var urlString: String {
        return "https://api.tronalddump.io/foo"
    }
}

struct RequestFailedRequest: BaseRequest {
    
    var urlString: String {
        return "www.google.com"
    }
}

class NetworkTests: XCTestCase {

    let tagListGetManager = TagListGetManager()
    let tagDetailGetManager = TagDetailGetManager()
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    /// Testing taglist API with an invalid url for unsuccessful response
    func testTagListResponseUnsuccessful() {
        let expected = expectation(description: "Check unsucessful response")
        tagListGetManager.getTagList(from: UnsuccessfulResponseRequest(), completion: {
            result in
            switch result {
            case .success( _):
                XCTFail()
            case .failure(let error):
                expected.fulfill()
                XCTAssertEqual(error, APIError.responseUnsuccessful)
                XCTAssertEqual(error.message, "Response Unsuccessful")
            }
        })
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    /// Testing taglist API with an invalid url for failed response
    func testTagListResponseRequestFailed() {
        let expected = expectation(description: "Check request failed response")
        tagListGetManager.getTagList(from: RequestFailedRequest(), completion: {
            result in
            switch result {
            case .success( _):
                XCTFail()
            case .failure(let error):
                expected.fulfill()
                XCTAssertEqual(error, APIError.requestFailed)
                XCTAssertEqual(error.message, "Request Failed")
            }
        })
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    /// Testing taglist API with an valid url for successful response
    func testTagListSuccessfulResponse() {
        let expected = expectation(description: "Check response is successful")
        tagListGetManager.getTagList(from: TagListGetRequest(), completion: {
            result in
            switch result {
            case .success(let tagsArray):
                if tagsArray != nil{
                    expected.fulfill()
                }
            case .failure( _):
                XCTFail()
            }
        })
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    /// Testing tag detail list API with an invalid url for unsuccessful response
    func testTagDetailResponseUnsuccessful() {
        let expected = expectation(description: "Check unsucessful response")
        tagDetailGetManager.getTagDetail(from: UnsuccessfulResponseRequest(), completion: {
            result in
            switch result {
            case .success( _):
                XCTFail()
            case .failure(let error):
                expected.fulfill()
                XCTAssertEqual(error, APIError.responseUnsuccessful)
                XCTAssertEqual(error.message, "Response Unsuccessful")
            }
        })
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    /// Testing tag detail list API with an invalid url for failed response
    func testTagDetailResponseRequestFailed() {
        let expected = expectation(description: "Check request failed response")
        tagDetailGetManager.getTagDetail(from: RequestFailedRequest(), completion: {
            result in
            switch result {
            case .success( _):
                XCTFail()
            case .failure(let error):
                expected.fulfill()
                XCTAssertEqual(error, APIError.requestFailed)
                XCTAssertEqual(error.message, "Request Failed")
            }
        })
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    /// Testing tag detail list API with an valid url for successful response
    func testTagDetailSuccessfulResponse() {
        let expected = expectation(description: "Check response is successful")
        tagDetailGetManager.getTagDetail(from: TagDetailGetRequest(tagName: "Hillary Clinton", nextPage: 1), completion: {
            result in
            switch result {
            case .success(let tagsArray):
                if tagsArray != nil{
                    expected.fulfill()
                }
            case .failure( _):
                XCTFail()
            }
        })
        waitForExpectations(timeout: 5, handler: nil)
    }
}
