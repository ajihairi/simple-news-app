//
//  HomeViewController.swift
//  simple-news-app
//
//  Created by Hamzhya Salsatinnov Hairy on 01/04/20.
//  Copyright © 2020 Hamzhya Salsatinnov Hairy. All rights reserved.
//

import UIKit

class HomeViewController: BaseView, UITableViewDelegate, UITableViewDataSource, SearchViewProtocol {
    

    @IBOutlet weak var tableview: UITableView!
    
    var viewModel = HomeViewModel()
    var catList = homeModels()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.delegate = self
        tableview.dataSource = self
        tableview.rowHeight = UITableView.automaticDimension
        tableview.estimatedRowHeight = 100
        tableview.bounces = false
        tableview.register(HomeCell.reusableNIB(), forCellReuseIdentifier: HomeCell.reusableIndentifier)
        tableview.register(SearchTableViewCell.reusableNIB(), forCellReuseIdentifier: SearchTableViewCell.reusableIndentifier)
        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        let withSubtitle = self.setTitleBar(title: "NEWS APP")
        self.navigationItem.titleView = withSubtitle
        self.navigationController?.navigationBar.dropShadow()
        self.navigationController?.navigationBar.backgroundColor = .white
        
        setupViewModel()
    }
    
    func setupViewModel() {
        self.viewModel.generateSomeCats {
            self.catList = self.viewModel.catList
            self.tableview.reloadData()
        }
    }
    
    // MARK: - TABLEVIEW DELEGATES
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return self.catList.count
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.reusableIndentifier, for: indexPath) as! SearchTableViewCell
            cell.delegate = self
            cell.searchTextField.placeholder = "Search News Here..."
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: HomeCell.reusableIndentifier, for: indexPath) as! HomeCell
            cell.generateData(Category: self.catList[indexPath.row])
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let views = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SourcesViewController") as! SourcesViewController
        views.categoryName = self.catList[indexPath.row].cat_name
        self.navigationController?.pushViewController(views, animated: true)
    }
    
    func didSearchEnd(_ key: String) {
        if key == "" {
            self.tableview.scrollToRow(at: IndexPath(row: 0, section: 1), at: .top, animated: true)
        } else {
            let views = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ArticleViewController") as! ArticleViewController
            views.sourceName = key
            views.shortCut = .true
            self.navigationController?.pushViewController(views, animated: true)
        }
    }
    

}
