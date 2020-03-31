//
//  String+Extension.swift
//  simple-news-app
//
//  Created by Hamzhya Salsatinnov Hairy on 01/04/20.
//  Copyright © 2020 Hamzhya Salsatinnov Hairy. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    func toDouble(StringData string: String)-> Double {
        let number = NumberFormatter().number(from: string)
        if let number = number {
            let DoubleValue = Double(truncating: number)
            return DoubleValue
        } else {
            return Double(string) ?? 0.0
        }
        /**
         String.numberFormatter.decimalSeparator = "."
         if let result =  String.numberFormatter.number(from: self) {
             return result.doubleValue
         } else {
             String.numberFormatter.decimalSeparator = ","
             if let result = String.numberFormatter.number(from: self) {
                 return result.doubleValue
             }
         }
         return 0
         */
        }
}
