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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.activityStartAnimating()
        viewModel.getTagDetail()
    }
    
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
        
        self.tableView.accessibilityLabel = "TagListTableView"
        self.tableView.isAccessibilityElement = true
        self.tableView.dataSource = viewModel
        self.tableView.delegate = viewModel
        self.tableView.tableFooterView = UIView()
        self.tableView.register(TagDetailListViewCell.self, forCellReuseIdentifier: AppIdentifierStrings.kTagDetailListViewCellReuseIdentifier)

    }

}

extension TagDetailListViewController: TagDetailListDataSourceUpdater {
    
    /// Datasource received custom delegate method
    func reloadTableView() {
        DispatchQueue.main.async() { () -> Void in
            self.activityStopAnimating()
            self.tableView.reloadData()
            self.refreshControl?.endRefreshing()
        }
        
    }
    
    /// Error received custom delegate method
    ///
    /// - Parameter error: APIError
    func setError(error:APIError){
        DispatchQueue.main.async() { () -> Void in
            self.activityStopAnimating()
            self.showAlert(withTitle: "Error", message: error.message)
        }
    }
    
    func open(url:String){
        if let link = URL(string: url) {
            if UIApplication.shared.canOpenURL(link){
                UIApplication.shared.open(link, options: [:], completionHandler: nil)
            }
        }
    }
}

