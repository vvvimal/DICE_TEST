//
//  TagListViewController.swift
//  Dice_Test
//
//  Created by Venugopalan, Vimal on 08/08/19.
//  Copyright © 2019 Venugopalan, Vimal. All rights reserved.
//

import UIKit

class TagListViewController: UITableViewController {
    let viewModel = TagListViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.setupView()
        self.setupTableView()
        viewModel.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.activityStartAnimating()
        viewModel.getTagList()
    }
    
    
    /// Set up UI elements
    func setupView(){
        self.title = "Tags"
    }
    
    /// Setup Table View properties
    func setupTableView(){
        
        self.tableView.accessibilityLabel = "TagListTableView"
        self.tableView.isAccessibilityElement = true
        self.tableView.dataSource = viewModel
        self.tableView.delegate = viewModel
        self.tableView.tableFooterView = UIView()
        self.tableView.register(TagListViewCell.self, forCellReuseIdentifier: AppIdentifierStrings.kTagListViewCellReuseIdentifier)

        
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl?.addTarget(self, action: #selector(refresh(sender:)), for: UIControl.Event.valueChanged)
    }
    
    //MARK: Actions
    
    /// Refresh Control Action
    ///
    /// - Parameter sender: UIRefreshControl object
    @objc func refresh(sender:AnyObject) {
        // Code to refresh table view
        self.activityStartAnimating()
        viewModel.getTagList()
        
    }
    
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
        if segue.identifier == "showTagDetail"{
            if let tagDetailViewController = segue.destination as? TagDetailListViewController{
                tagDetailViewController.setUpWith(data: sender ?? "")
            }
        }
     }

}

extension TagListViewController: TagListDataSourceUpdater {
    
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
    
    func showDetail(tag: String) {
        self.performSegue(withIdentifier: "showTagDetail", sender: tag)
    }
    
}
