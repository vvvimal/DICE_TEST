//
//  TagListViewCell.swift
//  Dice_Test
//
//  Created by Venugopalan, Vimal on 09/08/19.
//  Copyright © 2019 Venugopalan, Vimal. All rights reserved.
//

import UIKit

class TagListViewCell: UITableViewCell {
    /// Name Label
    lazy var nameLabel: UILabel = {
        let nl = UILabel()
        addSubview(nl)
        nl.translatesAutoresizingMaskIntoConstraints = false
        return nl
    }()
    
    /// UITableViewCell init method
    ///
    /// - Parameters:
    ///   - style: Tableview cell style
    ///   - reuseIdentifier: Identifier for cell
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16.0),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.0),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 16.0),
            nameLabel.topAnchor.constraint(equalTo: bottomAnchor, constant: 16.0),
            ])
        nameLabel.isAccessibilityElement = true
        nameLabel.accessibilityIdentifier = "nameLabel"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var data: String! {
        didSet {
            nameLabel.text = "\(data ?? "")"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
