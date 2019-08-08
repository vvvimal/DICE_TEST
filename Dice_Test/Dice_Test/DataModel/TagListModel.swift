//
//  TagListModel.swift
//  Dice_Test
//
//  Created by Venugopalan, Vimal on 09/08/19.
//  Copyright © 2019 Venugopalan, Vimal. All rights reserved.
//

import UIKit

struct TagListModel: Decodable{
    let count:Int?
    let total:Int?
    let tagNameArray:[String]
    
    
    enum CodingKeys: String, CodingKey {
        case count
        case total
        case tagNameArray = "_embedded"
    }
    init(from coder: Decoder) throws {
        let container = try coder.container(keyedBy: CodingKeys.self)
        self.count = try container.decode(Int.self, forKey: .count)
        self.total = try container.decode(Int.self, forKey: .total)
        self.tagNameArray = try container.decode([String].self, forKey: .tagNameArray)
    }
}
