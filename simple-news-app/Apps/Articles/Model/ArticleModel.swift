//
//  ArticleModel.swift
//  simple-news-app
//
//  Created by Hamzhya Salsatinnov Hairy on 01/04/20.
//  Copyright © 2020 Hamzhya Salsatinnov Hairy. All rights reserved.
//

import Foundation

typealias articleModels = [ArticleModel]
struct sourceArticleModel: Codable {
    var id: String?
    var name: String?
}
struct ArticleModel: Codable {
    var source: sourceArticleModel?
    var author: String?
    var title: String?
    var description: String?
    var url: String?
    var urlToImage: String?
    var publishedAt: String?
    var content: String?
}
struct ArticleEncoding: Codable {
    var status: String?
    var totalResults: Int?
    var articles: [ArticleModel]?
}
