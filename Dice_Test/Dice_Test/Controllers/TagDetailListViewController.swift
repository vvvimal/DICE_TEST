//
//  TagDetailListViewController.swift
//  Dice_Test
//
//  Created by Venugopalan, Vimal on 10/08/19.
//  Copyright © 2019 Venugopalan, Vimal. All rights reserved.
//

import UIKit

class TagDetailListViewController: UITableViewController {
    
    let viewModel = TagDetailListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupView()
        self.setupTableView()
        viewModel.delegate = self
        self.getTagDetailList()
    }
    
    /// Get tag detail list from API
    func getTagDetailList(){
        DispatchQueue.main.async() { () -> Void in
            self.activityStartAnimating()
        }
        viewModel.getTagDetail(completion: {[weak self] success, error in
            if let errorObj = error{
                self?.setError(error: errorObj)
            }
            else{
                self?.reloadTableView()
            }
        })
    }
    
    /// Set selected tag name to viewmodel
    func setUpWith(data: Any) {
        if let tagName = data as? String {
            viewModel.tagName = tagName
        }
    }
    
    /// Set up UI elements
    func setupView(){
        self.title = viewModel.tagName
    }
    
    /// Setup Table View properties
    func setupTableView(){
        self.tableView.accessibilityLabel = "TagDetailListTableView"
        self.tableView.isAccessibilityElement = true
        self.tableView.dataSource = viewModel
        self.tableView.delegate = viewModel
        self.tableView.tableFooterView = UIView()
        self.tableView.register(TagDetailListViewCell.self, forCellReuseIdentifier: AppIdentifierStrings.kTagDetailListViewCellReuseIdentifier)
    }
    
    /// Reload data after successful API request
    func reloadTableView() {
        DispatchQueue.main.async() { () -> Void in
            self.activityStopAnimating()
            self.tableView.reloadData()
        }
    }
    
    /// Error received from API request
    ///
    /// - Parameter error: APIError
    func setError(error:APIError){
        DispatchQueue.main.async() { () -> Void in
            self.activityStopAnimating()
            self.showAlert(withTitle: "Error", message: error.message)
        }
    }
}

extension TagDetailListViewController: TagDetailListDataSourceUpdater {
    
    /// Open url in Safari browser
    ///
    /// - Parameter url: Url string value
    func open(url:String){
        if let link = URL(string: url) {
            if UIApplication.shared.canOpenURL(link){
                UIApplication.shared.open(link, options: [:], completionHandler: nil)
            }
        }
    }
    
    /// Fetch next page data
    func getNextPageData() {
        self.getTagDetailList()
    }
}

