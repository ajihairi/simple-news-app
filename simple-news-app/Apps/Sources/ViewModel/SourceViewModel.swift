//
//  SourceViewModel.swift
//  simple-news-app
//
//  Created by Hamzhya Salsatinnov Hairy on 01/04/20.
//  Copyright © 2020 Hamzhya Salsatinnov Hairy. All rights reserved.
//

import Foundation
class SourceViewModel {
    
    private let service: SourceProtocol
    
    var sourceList = sourceModels()
    
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
    
    
    init(withPondOverView serviceProtocol: SourceProtocol = SourceServices() ) {
        self.service = serviceProtocol
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.networkStatusChanged(_:)), name: NSNotification.Name(rawValue: ReachabilityStatusChangedNotification), object: nil)
        Reach().monitorReachabilityChanges()
    }
    
    //MARK: Internet monitor status
    @objc func networkStatusChanged(_ notification: Notification) {
        self.networkStatus = Reach().connectionStatus()
    }
    
    func filteringSources() -> sourceModels {
        return self.sourceList.sorted(by: {$0.name! < $1.name!})
    }
    
    func getSourceByCat(cat: String, completion: @escaping() -> (), failed: @escaping(String) -> ()) {
        switch networkStatus {
        case .offline:
            self.isDisconnected = true
            self.internetConnectionStatus?()
        case .online:
            self.isLoading = true
            self.service.getSourcesByCat(cat: cat.lowercased(), success: { (data) in
                self.sourceList = data
                self.isLoading = false
                completion()
            }) { (error) in
                self.isLoading = false
                failed(error)
                self.alertMessage = error
            }
        default:
            break
        }
    }
}
