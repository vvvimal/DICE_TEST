//
//  TagDetailResponseModel.swift
//  Dice_Test
//
//  Created by Venugopalan, Vimal on 11/08/19.
//  Copyright © 2019 Venugopalan, Vimal. All rights reserved.
//

import UIKit

public let iso8601HalfFormatter = DateFormatter.iso8601Half
public let iso8601FullFormatter = DateFormatter.iso8601Full



struct TagDetailResponseModel: Decodable {
    let count:Int?
    let total:Int?
    let tagDetailDict:TagDetailList?
    
    
    enum CodingKeys: String, CodingKey {
        case count
        case total
        case tagDetailDict = "_embedded"
    }
    init(from coder: Decoder) throws {
        let container = try coder.container(keyedBy: CodingKeys.self)
        self.count = try container.decodeIfPresent(Int.self, forKey: .count)
        self.total = try container.decodeIfPresent(Int.self, forKey: .total)
        self.tagDetailDict = try container.decodeIfPresent(TagDetailList.self, forKey: .tagDetailDict)
    }
}

struct TagDetailList:Decodable {
    let tagDetailArray:[TagDetailModel]?
    
    enum CodingKeys: String, CodingKey {
        case tagDetailArray = "tags"
    }
    init(from coder: Decoder) throws {
        let container = try coder.container(keyedBy: CodingKeys.self)
        self.tagDetailArray = try container.decodeIfPresent([TagDetailModel].self, forKey: .tagDetailArray)
    }
}

struct TagDetailModel: Decodable{
    let appearedAt: Date?
    let createdAt: Date?
    let quoteId:String?
    let tags:[String]?
    let updatedAt: Date?
    let value:String?
    let additionalDetail:AdditionalDetail?

    enum CodingKeys:String, CodingKey {
        case appearedAt = "appeared_at"
        case createdAt = "created_at"
        case quoteId = "quote_id"
        case tags
        case updatedAt = "updated_at"
        case value
        case additionalDetail = "_embedded"
    }
    
    init(from coder: Decoder) throws {
        let container = try coder.container(keyedBy: CodingKeys.self)
        let appearedDateString = try container.decode(String.self, forKey: .appearedAt)
        if let date = iso8601HalfFormatter.date(from: appearedDateString) {
            self.appearedAt = date
        } else {
            throw DecodingError.dataCorruptedError(forKey: .appearedAt,
                                                   in: container,
                                                   debugDescription: "Date string does not match format expected by formatter.")
        }
        

        let createdDateString = try container.decode(String.self, forKey: .createdAt)
        if let date = iso8601FullFormatter.date(from: createdDateString) {
            self.createdAt = date
        } else {
            throw DecodingError.dataCorruptedError(forKey: .createdAt,
                                                   in: container,
                                                   debugDescription: "Date string does not match format expected by formatter.")
        }
        self.quoteId = try container.decodeIfPresent(String.self, forKey: .quoteId)
        self.tags = try container.decodeIfPresent([String].self, forKey: .tags)
        let updatedDateString = try container.decode(String.self, forKey: .updatedAt)
        if let date = iso8601FullFormatter.date(from: updatedDateString) {
            self.updatedAt = date
        } else {
            throw DecodingError.dataCorruptedError(forKey: .updatedAt,
                                                   in: container,
                                                   debugDescription: "Date string does not match format expected by formatter.")
        }
        self.value = try container.decodeIfPresent(String.self, forKey: .value)
        
        self.additionalDetail = try container.decodeIfPresent(AdditionalDetail.self, forKey: .additionalDetail)

    }
}

struct AdditionalDetail:Decodable {
    let author : [TagAuthor]?
    let source : [TagSource]?
    
    enum CodingKeys: String, CodingKey {
        case author, source
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.author = try container.decodeIfPresent([TagAuthor].self, forKey: .author)
        self.source = try container.decodeIfPresent([TagSource].self, forKey: .source)
    }
}



struct TagAuthor:Decodable{
    let createdAt:Date?
    let bio:String?
    let authorId:String?
    let name:String?
    let slug:String?
    let updatedAt:Date?
    
    enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
        case bio
        case authorId = "author_id"
        case name
        case slug
        case updatedAt = "updated_at"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
//        let iso8601FullFormatter = DateFormatter.iso8601Full
        
        let createdDateString = try container.decode(String.self, forKey: .createdAt)
        if let date = iso8601FullFormatter.date(from: createdDateString) {
            self.createdAt = date
        } else {
            throw DecodingError.dataCorruptedError(forKey: .createdAt,
                                                   in: container,
                                                   debugDescription: "Date string does not match format expected by formatter.")
        }
        self.bio = try container.decodeIfPresent(String.self, forKey: .bio)
        self.authorId = try container.decodeIfPresent(String.self, forKey: .authorId)

        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.slug = try container.decodeIfPresent(String.self, forKey: .slug)

        let updatedDateString = try container.decode(String.self, forKey: .updatedAt)
        if let date = iso8601FullFormatter.date(from: updatedDateString) {
            self.updatedAt = date
        } else {
            throw DecodingError.dataCorruptedError(forKey: .updatedAt,
                                                   in: container,
                                                   debugDescription: "Date string does not match format expected by formatter.")
        }
    }
}

struct TagSource:Decodable{
    let createdAt:Date?
    let filename:String?
    let quoteSourceId: String?
    let remarks:String?
    let updatedAt:Date?
    let url:String?
    
    enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
        case filename
        case quoteSourceId = "quote_source_id"
        case remarks
        case updatedAt = "updated_at"
        case url
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
//        let iso8601FullFormatter = DateFormatter.iso8601Full
        
        let createdDateString = try container.decode(String.self, forKey: .createdAt)
        if let date = iso8601FullFormatter.date(from: createdDateString) {
            self.createdAt = date
        } else {
            throw DecodingError.dataCorruptedError(forKey: .createdAt,
                                                   in: container,
                                                   debugDescription: "Date string does not match format expected by formatter.")
        }
        self.filename = try container.decodeIfPresent(String.self, forKey: .filename)
        self.quoteSourceId = try container.decodeIfPresent(String.self, forKey: .quoteSourceId)
        
        self.remarks = try container.decodeIfPresent(String.self, forKey: .remarks)
        
        let updatedDateString = try container.decode(String.self, forKey: .updatedAt)
        if let date = iso8601FullFormatter.date(from: updatedDateString) {
            self.updatedAt = date
        } else {
            throw DecodingError.dataCorruptedError(forKey: .updatedAt,
                                                   in: container,
                                                   debugDescription: "Date string does not match format expected by formatter.")
        }
        self.url = try container.decodeIfPresent(String.self, forKey: .url)
    }
}
