//
//  TagDetailListViewCell.swift
//  Dice_Test
//
//  Created by Venugopalan, Vimal on 11/08/19.
//  Copyright © 2019 Venugopalan, Vimal. All rights reserved.
//

import UIKit

class TagDetailListViewCell: UITableViewCell {
    /// Tweet Label
    lazy var tweetLabel: UILabel = {
        let tl = UILabel()
        tl.numberOfLines = 0
        addSubview(tl)
        tl.translatesAutoresizingMaskIntoConstraints = false
        return tl
    }()
    
    /// Author Label
    lazy var authorLabel: UILabel = {
        let al = UILabel()
        al.numberOfLines = 0
        al.textAlignment = .right
        addSubview(al)
        al.translatesAutoresizingMaskIntoConstraints = false
        return al
    }()
    
    /// UITableViewCell init method
    ///
    /// - Parameters:
    ///   - style: Tableview cell style
    ///   - reuseIdentifier: Identifier for cell
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.accessoryType = .disclosureIndicator
        NSLayoutConstraint.activate([
            tweetLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10.0),
            tweetLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.0),
            tweetLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32.0),
            
            authorLabel.topAnchor.constraint(equalTo: tweetLabel.bottomAnchor, constant: 5.0),
            authorLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.0),
            authorLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32.0),
            authorLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10.0),
            ])
        tweetLabel.isAccessibilityElement = true
        tweetLabel.accessibilityIdentifier = "tweetLabel"
        
        authorLabel.isAccessibilityElement = true
        authorLabel.accessibilityIdentifier = "authorLabel"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Data to be shown in cell represented by TagDetailModel
    var data: TagDetailModel! {
        didSet {
            tweetLabel.text = "\(data.value ?? "")"
            authorLabel.text = "- \(data.additionalDetail?.author?[0].name ?? "")"
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
