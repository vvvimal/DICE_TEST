//
//  TagDetailListViewModel
//  Dice_Test
//
//  Created by Venugopalan, Vimal on 10/08/19.
//  Copyright © 2019 Venugopalan, Vimal. All rights reserved.
//

import UIKit

protocol TagDetailListDataSourceUpdater {
    func open(url:String)
    func getNextPageData()
}

class TagDetailListViewModel: NSObject {

    var delegate: TagDetailListDataSourceUpdater?

    private let tagDetailGetManager = TagDetailGetManager()
    
    var tagDetailListArray: [TagDetailModel] = []
    
    var tagName:String = ""
    
    var nextPage = 1
    
    var totalRecords = 0

    func getTagDetail(completion:@escaping DiceAPIFetchCompletionHandler){
        if tagName.count > 0{
            tagDetailGetManager.getTagDetail(from: TagDetailGetRequest(tagName: tagName, nextPage:nextPage), completion: {[weak self] result in
                switch result {
                case .success(let tagDetailListModel):
                    self?.tagDetailListArray.append(contentsOf: tagDetailListModel?.tagDetailDict?.tagDetailArray ?? [])
                    self?.totalRecords = tagDetailListModel?.total ?? 0
                    self?.nextPage = (self?.nextPage ?? 0) + 1
                    completion(true, nil)
                case .failure(let error):
                    completion(false, error)
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
    /// - Returns: Automatic height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    /// Tableview did select cell action
    ///
    /// - Parameters:
    ///   - tableView: UITableView object
    ///   - indexPath: indexPath of the cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tagDetail = self.tagDetailListArray[indexPath.row]
        if let url = tagDetail.additionalDetail?.source?[0].url{
            self.delegate?.open(url: url)
        }
    }
    
    /// Estimated height for tableview row cell
    ///
    /// - Parameters:
    ///   - tableView: UITableView object
    ///   - indexPath: indexPath of the cell
    /// - Returns: CGFloat value representing the estimated height of the cell
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if ((scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height)
        {
            if (self.tagDetailListArray.count < self.totalRecords) {
                self.delegate?.getNextPageData()
            }
        }
    }
}
