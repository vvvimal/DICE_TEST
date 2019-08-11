//
//  TagListViewModel.swift
//  Dice_Test
//
//  Created by Venugopalan, Vimal on 08/08/19.
//  Copyright © 2019 Venugopalan, Vimal. All rights reserved.
//

import UIKit

protocol TagListDataSourceUpdater {
    func reloadTableView()
    func setError(error:APIError)
    func showDetail(tag:String)
}
class TagListViewModel: NSObject {

    var delegate: TagListDataSourceUpdater?

    var tagListArray:[String] = []
    
    private let tagListGetManager = TagListGetManager()
    
    /// Trigger Customer Fetch Request
    func getTagList(){
        tagListGetManager.getTagList(from: TagListGetRequest(), completion: {
            result in
            switch result {
            case .success(let tagListModel):
                self.tagListArray = tagListModel?.tagNameArray ?? []
                self.delegate?.reloadTableView()
            case .failure(let error):
                self.delegate?.setError(error: error)
            }
        })
    }
}

extension TagListViewModel: UITableViewDataSource, UITableViewDelegate{
    
    /// Tableview datasource for number of rows
    ///
    /// - Parameters:
    ///   - tableView: UITableView Object
    ///   - section: Section of the tableview
    /// - Returns: Integer representing the number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tagListArray.count
    }
    
    /// Tableview datasource method for getting cell at indexpath
    ///
    /// - Parameters:
    ///   - tableView: UITableView object
    ///   - indexPath: indexPath of the cell
    /// - Returns: UITableViewCell object
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AppIdentifierStrings.kTagListViewCellReuseIdentifier, for: indexPath) as? TagListViewCell else{fatalError("Unable to dequeue cell")}
        
        let tagName = self.tagListArray[indexPath.row]
        cell.data = tagName
        cell.isAccessibilityElement = true
        
        return cell
    }
    
    /// TableView Delegate method for height of the cell
    ///
    /// - Parameters:
    ///   - tableView: UITableView object
    ///   - indexPath: indexPath of the cell
    /// - Returns: CGFloat value representing the height of the cell
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tagName = self.tagListArray[indexPath.row]
        self.delegate?.showDetail(tag: tagName)
    }
}
