//
//  SourcesViewController.swift
//  simple-news-app
//
//  Created by Hamzhya Salsatinnov Hairy on 01/04/20.
//  Copyright © 2020 Hamzhya Salsatinnov Hairy. All rights reserved.
//

import UIKit

class SourcesViewController: BaseView, UITableViewDelegate, UITableViewDataSource, SearchViewProtocol {
    
    @IBOutlet weak var tableview: UITableView!
    var categoryName = ""
    var sourceList = sourceModels()
    var viewModel = SourceViewModel()
    var loadingView = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self
        tableview.separatorStyle = .none
        tableview.register(SearchTableViewCell.reusableNIB(), forCellReuseIdentifier: SearchTableViewCell.reusableIndentifier)
        tableview.register(SourcesTableViewCell.reusableNIB(), forCellReuseIdentifier: SourcesTableViewCell.reusableIndentifier)
        self.hideKeyboardWhenTappedAround() 
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        let withSubtitle = self.setTitleBarWithColor(title: "NEWS SOURCES", titleColor: .black, subtitle: self.categoryName, subtitleColor: .systemGray3)
        self.navigationItem.titleView = withSubtitle
        self.navigationItem.largeTitleDisplayMode = .automatic
        self.navigationController?.navigationBar.dropShadow()
        self.navigationController?.navigationBar.backgroundColor = .white
        setupViewModel()
    }
    
    func setupViewModel() {
        self.viewModel.showAlertClosure = { [weak self] in
            let alert = self?.viewModel.alertMessage ?? ""
            self?.showAlert(alert, completion: {})
        //            self?.showToast(message: alert, font: .systemFont(ofSize: 12))
        }
                
        self.viewModel.updateLoadingStatus = { [weak self] in
            if self?.viewModel.isLoading ?? true {
                self?.loadingView.startAnimating()
            } else {
                self?.loadingView.stopAnimating()
            }
        }
        self.viewModel.internetConnectionStatus = { [weak self] in
            print("Internet disconnected")
            self?.tableview.reloadData()
        }
        
        self.viewModel.serverErrorStatus = {
            print("Server Error / Unknown Error")
            // show UI Server is Error
        }
        self.viewModel.getSourceByCat(cat: self.categoryName.lowercased(), completion: {
            self.sourceList = self.viewModel.sourceList
            print(self.sourceList)
            self.tableview.reloadData()
        }) { (error) in
            print(error)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return self.sourceList.count
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.reusableIndentifier, for: indexPath) as! SearchTableViewCell
            cell.delegate = self
            cell.searchTextField.placeholder = "Search Source"
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: SourcesTableViewCell.reusableIndentifier, for: indexPath) as! SourcesTableViewCell
            cell.setupView(data: self.sourceList[indexPath.row])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let views = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ArticleViewController") as! ArticleViewController
        views.sourceName = self.sourceList[indexPath.row].name ?? ""
        views.sourceId = self.sourceList[indexPath.row].id ?? ""
        self.navigationController?.pushViewController(views, animated: true)
    }
    
    // MARK: -- SEARCH DELEGATE
    
    func didSearchEnd(_ key: String) {
        if key == "" {
            self.view.endEditing(true)
            self.sourceList = self.viewModel.sourceList
            self.tableview.reloadData()
        } else {
            self.sourceList = self.sourceList.filter { item -> Bool in
                return item.name?.lowercased().range(of: key.lowercased()) != nil
            }
            self.tableview.reloadData()
        }
    }
    
    

}
