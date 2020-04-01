//
//  ArticleViewController.swift
//  simple-news-app
//
//  Created by Hamzhya Salsatinnov Hairy on 01/04/20.
//  Copyright © 2020 Hamzhya Salsatinnov Hairy. All rights reserved.
//

import UIKit

enum isShortCut {
    case `true`
    case `false`
}

class ArticleViewController: BaseView, UITableViewDelegate, UITableViewDataSource, SearchViewProtocol {

    @IBOutlet weak var tableview: UITableView!
    
    var viewModel = SourceViewModel()
    var articleList = articleModels()
    var sourceName = ""
    var sourceId = ""
    var shortCut = isShortCut.false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.separatorStyle = .none
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
        self.setupNavBar(title: nil, sub: nil)
        setupViewModel()
        }
        
    func setupNavBar(title: String?, sub: String?) {
        let withSubtitle = self.setTitleBarWithColor(title: title ?? self.sourceName.uppercased(), titleColor: .black, subtitle: sub ?? "Articles", subtitleColor: .darkGray)
        self.navigationItem.titleView = withSubtitle
        self.navigationItem.largeTitleDisplayMode = .automatic
        self.navigationController?.navigationBar.dropShadow()
        self.navigationController?.navigationBar.backgroundColor = .white
    }
    func setupViewModel() {
        self.viewModel.showAlertClosure = { [weak self] in
            let alert = self?.viewModel.alertMessage ?? ""
            self?.showAlert(alert, completion: {})
        }
                
        self.viewModel.updateLoadingStatus = { [weak self] in
            if self?.viewModel.isLoading ?? true {
                self?.showSpinner(onView: self!.view)
            } else {
                self?.removeSpinner()
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
        if shortCut == .true {
            self.viewModel.getArticleSearch(q: self.sourceName, completion: {
                self.articleList = self.viewModel.articleList
                self.tableview.reloadData()
                self.setupNavBar(title: self.sourceName, sub: "Search Result for : \(self.sourceName)")
            }) { (err) in
                print(err)
            }
        } else {
            self.viewModel.getArticleBySource(source: self.sourceId.lowercased(), completion: {
                self.articleList = self.viewModel.articleList
                self.tableview.reloadData()
            }) { (err) in
                print(err)
            }
        }
            
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return self.articleList.count
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.reusableIndentifier, for: indexPath) as! SearchTableViewCell
            cell.delegate = self
            cell.searchTextField.placeholder = "Search Article's Title"
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: HomeCell.reusableIndentifier, for: indexPath) as! HomeCell
            cell.setupArticles(Article: self.articleList[indexPath.row])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let views = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        views.newsDetail = self.articleList[indexPath.row]
        self.present(views, animated: true) {
            self.setupViewModel()
        }
    }
    
    func didSearchEnd(_ key: String) {
        self.sourceName = key
        self.setupNavBar(title: self.sourceName, sub: "Search Result for : \(self.sourceName)")
        self.viewModel.getArticleSearch(q: key, completion: {
            self.articleList = self.viewModel.articleList
            self.tableview.reloadData()
        }) { (err) in
            print(err)
        }
    }

}
