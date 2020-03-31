//
//  HomeViewModel.swift
//  simple-news-app
//
//  Created by Hamzhya Salsatinnov Hairy on 01/04/20.
//  Copyright © 2020 Hamzhya Salsatinnov Hairy. All rights reserved.
//

import Foundation

class HomeViewModel {
    var catList = homeModels()
    //MARK: -- Network checking
    
    /// Define networkStatus for check network connection
    var networkStatus = Reach().connectionStatus()
    
    /// Define boolean for internet status, call when network disconnected
    var isDisconnected: Bool = false {
        didSet {
            self.alertMessage = "No network connection. Please connect to the internet"
            self.internetConnectionStatus?()
        }
    }
    
    //MARK: -- UI Status
    
    /// Update the loading status, use HUD or Activity Indicator UI
    var isLoading: Bool = false {
        didSet {
            self.updateLoadingStatus?()
        }
    }
    
    /// Showing alert message, use UIAlertController or other Library
    var alertMessage: String? {
        didSet {
            self.showAlertClosure?()
        }
    }
    
    /// Define selected model
    
    //MARK: -- Closure Collection
    var showAlertClosure: (() -> ())?
    var updateLoadingStatus: (() -> ())?
    var internetConnectionStatus: (() -> ())?
    var serverErrorStatus: (() -> ())?
    var didGetData: (() -> ())?
    
    func generateSomeCats(completion: @escaping() -> ()) {
        let cat1 = HomeModel(cat_id: 0, cat_name: "Health", cat_Img: R.image.health_Img()!)
        let cat2 = HomeModel(cat_id: 1, cat_name: "Sports", cat_Img: R.image.sport_img()!)
        let cat3 = HomeModel(cat_id: 2, cat_name: "Business", cat_Img: R.image.business_img()!)
        let cat4 = HomeModel(cat_id: 3, cat_name: "Entertainments", cat_Img: R.image.entertainment_img()!)
        let cat5 = HomeModel(cat_id: 4, cat_name: "Musics", cat_Img: R.image.music_img()!)
        let cat6 = HomeModel(cat_id: 5, cat_name: "Technologies", cat_Img: R.image.tech_img()!)
        let cat7 = HomeModel(cat_id: 6, cat_name: "Politics", cat_Img: R.image.politics_img()!)
        self.catList = [cat1, cat2, cat3, cat4, cat5, cat6, cat7].sorted(by: {$0.cat_id < $1.cat_id})
        completion()
    }
}
