//
//  TagListTests.swift
//  Dice_TestTests
//
//  Created by Venugopalan, Vimal on 12/08/19.
//  Copyright © 2019 Venugopalan, Vimal. All rights reserved.
//

import XCTest
@testable import Dice_Test

class TagListTests: XCTestCase {
    var tagListViewModel:TagListViewModel?
    let tagListView = TagListViewController()
    var tagArray:[String]?
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        tagListViewModel = tagListView.viewModel
        if let tagList = tagListViewModel?.tagListArray{
            tagArray = tagList
        }
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        tagListViewModel = nil
        tagArray = nil
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
        tagListView.loadViewIfNeeded()
        XCTAssertNotNil(tagListView.tableView)
    }
    
    func testTableViewHasCorrectRowCount() {
        tagListView.loadViewIfNeeded()
        XCTAssertEqual(tagListView.tableView.numberOfRows(inSection: 0), tagArray?.count)
    }
    
    func testEachCellHasCorrectText() {
        tagListView.loadViewIfNeeded()
        
        let expected = expectation(description: "Check if data has been fetched")
        expected.expectedFulfillmentCount = 1
        
        tagListViewModel?.getTagList(completion: {[weak self]
            success, error in
            if success == true{
                expected.fulfill()
                if let tagList = self?.tagListViewModel?.tagListArray{
                    self?.tagListView.tableView.reloadSections(IndexSet.init(integer: 0), with: .none)
                    XCTAssertEqual(self?.tagListView.tableView.numberOfRows(inSection: 0), tagList.count)
                    for(index, tag) in tagList.enumerated() {
                        let indexPath = IndexPath(item: index, section: 0)
                        if let cell = self?.tagListView.tableView.cellForRow(at: indexPath) as? TagListViewCell{
                            XCTAssertEqual(cell.nameLabel.text, String("\(tag)"), "Tag name don't match")
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
        tagListView.loadViewIfNeeded()
        XCTAssertEqual(tagListView.title, "Tags")
        
    }
}
