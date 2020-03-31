//
//  APIManager.swift
//  simple-news-app
//
//  Created by Hamzhya Salsatinnov Hairy on 01/04/20.
//  Copyright © 2020 Hamzhya Salsatinnov Hairy. All rights reserved.
//

import Foundation
import Alamofire


struct APIEnv {
    static var shared = APIEnv()
    var APIKey = "ce478194ea1043609a2327f47a900460"
    var baseUrl = "https://newsapi.org/v2/"
}

struct APIManager {
    
    /// GET FROM API
    ///
    /// - Parameters:
    ///   - url: URL API
    ///   - method: methods
    ///   - parameters: parameters
    ///   - encoding: encoding
    ///   - headers: headers
    ///   - completion: completion
    ///   - failure: failure
    static func request(_ url: String, method: HTTPMethod, parameters: Parameters, encoding: ParameterEncoding, headers: HTTPHeaders, completion: @escaping (_ response: Data) ->(), failure: @escaping (_ error: String, _ errorCode: Int) -> ()) {
        
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 120
        
        let apiURL = APIEnv.shared.baseUrl + url
        print("-- URL API: \(apiURL), \n\n-- headers: \(headers), \n\n-- Parameters: \(parameters)")
        
        manager.request(
            apiURL,
            method: method,
            parameters: parameters,
            encoding: encoding,
            headers: headers).responseString(
                queue: DispatchQueue.main,
                encoding: String.Encoding.utf8) { response in
                    if let resp = response.response {
                        if resp.statusCode >= 200 && resp.statusCode < 230 {
                            guard let callback = response.data else {
                                failure(self.generateRandomError(), resp.statusCode)
                                return
                            }
                            DispatchQueue.main.async {
                                completion(callback)
                            }
                            /***if response.result.value == "{\"status\":\"Success\",\"id\":\"\"}\n" {
                                 DispatchQueue.main.async {
                                     completion(callback)
                                 }
                            }
                            else if callback.count <= 21 || callback.count <= 31 {
                                failure("ERROR: INTERNAL SERVER ERROR!.", 0000)
                            } else {
                                
                            }*/
                        } else if resp.statusCode > 229 {
                            if resp.statusCode == NSURLErrorTimedOut {
                                failure("Request is Timeout", 500)
                            } else {
                                guard let callbackError = response.data else {
                                    failure(self.generateRandomError(), resp.statusCode)
                                    return
                                }
                                
                                do {
                                    let decoded = try JSONDecoder().decode(
                                        APIError.self, from: callbackError)
                                    if let messageError = decoded.data?.errors?.messages, let errorCode = decoded.statusCode {
                                        let messages = messageError.joined(separator: ", ")
                                        failure(messages, errorCode)
                                    } else {
                                        failure(response.result.value ?? APIManager.generateRandomError(), resp.statusCode)
                                    }
                                } catch _ {
                                    failure(response.result.value ?? APIManager.generateRandomError(), resp.statusCode)
                                }
                            }
                        }
                    } else {
                        failure("CONNECTION ERROR: \(response.result.description)", -1005)
                    }
                    
                    print("--\n \n CALLBACK RESPONSE: \(response), \(String(describing: response.response?.statusCode))")
                    
        }
        
    }
    
    
    /// GENERATE RANDOM ERROR
    ///
    /// - Returns: string error randoms
    static func generateRandomError() -> String {
        return "Oops. Unknown error occured. \n dat error decoded"
    }
    static func requestHeader() -> HTTPHeaders {
        
        let token = "UserToken.token()"
        
        return [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(token)",
//            "X-localization": Profile.shared?.lang ?? "en",
        ]
    }
    static func getHeaders() -> HTTPHeaders {
        let headers: HTTPHeaders = [
            "Authorization": "bearer \(APIEnv.shared.APIKey)",
            "Accept": "application/json"
        ]
        return headers
    }
    
    static func getSourceNewsLogoUrl(source: String) -> String {
        let sourceLogoUrl = "https://res.cloudinary.com/news-logos/image/upload/v1557987666/\(source).png"
        return sourceLogoUrl
    }
    
}


struct typeNews {
    var sources = "sources"
    var topHeadlines = "top-headlines"
}
