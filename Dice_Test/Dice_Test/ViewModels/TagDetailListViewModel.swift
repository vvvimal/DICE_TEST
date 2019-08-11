//
//  TagDetailListViewModel
//  Dice_Test
//
//  Created by Venugopalan, Vimal on 10/08/19.
//  Copyright © 2019 Venugopalan, Vimal. All rights reserved.
//

import UIKit

protocol TagDetailListDataSourceUpdater {
    func reloadTableView()
    func setError(error:APIError)
    func open(url:String)
}

class TagDetailListViewModel: NSObject {

    var delegate: TagDetailListDataSourceUpdater?

    private let tagDetailGetManager = TagDetailGetManager()
    
    var tagDetailListArray: [TagDetailModel] = []
    
    var tagName:String = ""

    func getTagDetail(){
        if tagName.count > 0{
            tagDetailGetManager.getTagDetail(from: TagDetailGetRequest(tagName: tagName), completion: { result in
                switch result {
                case .success(let tagDetailListModel):
                    self.tagDetailListArray = tagDetailListModel?.tagDetailDict?.tagDetailArray ?? []
                    self.delegate?.reloadTableView()
                case .failure(let error):
                    self.delegate?.setError(error: error)
                }
            })
        }
        
    }
}

extension TagDetailListViewModel: UITableViewDataSource, UITableViewDelegate{
    
    /// Tableview datasource for number of rows
    ///
    /// - Parameters:
    ///   - tableView: UITableView Object
    ///   - section: Section of the tableview
    /// - Returns: Integer representing the number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tagDetailListArray.count
    }
    
    /// Tableview datasource method for getting cell at indexpath
    ///
    /// - Parameters:
    ///   - tableView: UITableView object
    ///   - indexPath: indexPath of the cell
    /// - Returns: UITableViewCell object
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AppIdentifierStrings.kTagDetailListViewCellReuseIdentifier, for: indexPath) as? TagDetailListViewCell else{fatalError("Unable to dequeue cell")}
        
        let tagDetail = tagDetailListArray[indexPath.row]
        cell.data = tagDetail
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tagDetail = self.tagDetailListArray[indexPath.row]
        if let url = tagDetail.additionalDetail?.source?[0].url{
            self.delegate?.open(url: url)
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
}
