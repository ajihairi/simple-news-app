//
//  SourceServices.swift
//  simple-news-app
//
//  Created by Hamzhya Salsatinnov Hairy on 01/04/20.
//  Copyright © 2020 Hamzhya Salsatinnov Hairy. All rights reserved.
//

import Foundation
import Alamofire

struct SourceServices: SourceProtocol {
    
    func getArticleBySearch(query: String, success: @escaping (articleModels) -> (), failure: @escaping (String) -> Void) {
        let params: [String:Any] = [
            "q" : query,
            "sortBy" : "popularity",
            "language" : "en"
        ]
        APIManager.request(typeNews().everything, method: .get, parameters: params, encoding: URLEncoding.default, headers: APIManager.getHeaders(), completion: { (data) in
            do {
                let decoded = try JSONDecoder().decode(ArticleEncoding.self, from: data)
                let successdata = decoded.articles!
                success(successdata)
                
            } catch {
                failure(APIManager.generateRandomError())
            }
        }) { (error, code) in
                failure("\(error) \(code)")
        }
    }
    
    
    func getArticleBySource(source: String, success: @escaping (articleModels) -> (), failure: @escaping (String) -> Void) {
        let params: [String:Any] = [
            "sources" : source,
            "language" : "en"
        ]
        APIManager.request(typeNews().topHeadlines, method: .get, parameters: params, encoding: URLEncoding.default, headers: APIManager.getHeaders(), completion: { (data) in
            do {
                let decoded = try JSONDecoder().decode(ArticleEncoding.self, from: data)
                let successdata = decoded.articles!
                success(successdata)
            } catch {
                failure(APIManager.generateRandomError())
            }
        }) { (error, code) in
            failure("\(error) \(code)")
        }
    }
    
    func getSourcesByCat(cat: String, success: @escaping (sourceModels) -> (), failure: @escaping (String) -> Void) {
        let params: [String:Any] = [
            "country" : "us",
            "category" : cat,
            "language" : "en"
        ]
        APIManager.request(typeNews().sources, method: .get, parameters: params, encoding: URLEncoding.default, headers: APIManager.getHeaders(), completion: { (data) in
            do {
                let decoded = try JSONDecoder().decode(sourceModelDecoder.self, from: data)
                let succesData = decoded.sources
                success(succesData!)
            } catch {
                failure(APIManager.generateRandomError())
            }
        }) { (error, code) in
            failure("\(error) \(code)")
        }
    }
    
}
