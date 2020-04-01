//
//  SourceProtocol.swift
//  simple-news-app
//
//  Created by Hamzhya Salsatinnov Hairy on 01/04/20.
//  Copyright © 2020 Hamzhya Salsatinnov Hairy. All rights reserved.
//

import Foundation

protocol SourceProtocol {
    func getSourcesByCat(cat: String, success: @escaping(sourceModels) -> (), failure: @escaping(String) -> Void)
    func getArticleBySource(source: String, success: @escaping(articleModels) -> (), failure: @escaping(String) -> Void)
    func getArticleBySearch(query: String, success: @escaping(articleModels) -> (), failure: @escaping(String) -> Void)
}
