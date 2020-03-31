//
//  SourceModel.swift
//  simple-news-app
//
//  Created by Hamzhya Salsatinnov Hairy on 01/04/20.
//  Copyright © 2020 Hamzhya Salsatinnov Hairy. All rights reserved.
//

import Foundation

typealias sourceModels = [SourceModel]

struct SourceModel: Codable {
    var id: String?
    var name: String?
    var category: String?
    var description: String?
    var url: String?
    var language: String?
    var country: String?
}

struct sourceModelDecoder: Codable {
    var status: String?
    var sources: [SourceModel]?
}
