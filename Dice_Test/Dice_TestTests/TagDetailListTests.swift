//
//  TagDetailListTests.swift
//  Dice_TestTests
//
//  Created by Venugopalan, Vimal on 12/08/19.
//  Copyright © 2019 Venugopalan, Vimal. All rights reserved.
//

import XCTest
@testable import Dice_Test

class TagDetailListTests: XCTestCase {
    var tagDetailListViewModel:TagDetailListViewModel?
    let tagDetailListView = TagDetailListViewController()
    var tagDetailArray:[TagDetailModel]?
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        tagDetailListViewModel = tagDetailListView.viewModel
        tagDetailListViewModel?.tagName = "Hillary Clinton"
        if let tagDetailList = tagDetailListViewModel?.tagDetailListArray{
            tagDetailArray = tagDetailList
        }
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        tagDetailListViewModel = nil
        tagDetailArray = nil
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testIfTableViewExists() {
        tagDetailListView.loadViewIfNeeded()
        XCTAssertNotNil(tagDetailListView.tableView)
    }
    
    func testTableViewHasCorrectRowCount() {
        tagDetailListView.loadViewIfNeeded()
        XCTAssertEqual(tagDetailListView.tableView.numberOfRows(inSection: 0), tagDetailArray?.count)
    }
    
    func testEachCellHasCorrectText() {
        tagDetailListView.loadViewIfNeeded()
        
        let expected = expectation(description: "Check if data has been fetched")
        expected.expectedFulfillmentCount = 1
        
        tagDetailListViewModel?.getTagDetail(completion: {[weak self]
            success, error in
            if success == true{
                expected.fulfill()
                if let tagDetailList = self?.tagDetailListViewModel?.tagDetailListArray{
                    self?.tagDetailListView.tableView.reloadSections(IndexSet.init(integer: 0), with: .none)
                    XCTAssertEqual(self?.tagDetailListView.tableView.numberOfRows(inSection: 0), tagDetailList.count)
                    for(index, tagDetail) in tagDetailList.enumerated() {
                        let indexPath = IndexPath(item: index, section: 0)
                        if let cell = self?.tagDetailListView.tableView.cellForRow(at: indexPath) as? TagDetailListViewCell{
                            XCTAssertEqual(cell.tweetLabel.text, tagDetail.value, "Tweet value don't match")
                            if let authorName = tagDetail.additionalDetail?.author?[0].name{
                                XCTAssertEqual(cell.authorLabel.text, String("- \(authorName)"), "Author name don't match")
                            }
                        }
                    }
                }
                else{
                    XCTFail()
                }
            }
            else{
                XCTFail()
            }
        })
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testNavigationBarHasTitle() {
        tagDetailListView.loadViewIfNeeded()
        XCTAssertEqual(tagDetailListView.title, tagDetailListViewModel?.tagName)
        
    }
}
