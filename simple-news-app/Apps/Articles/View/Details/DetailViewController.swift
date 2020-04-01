//
//  DetailViewController.swift
//  simple-news-app
//
//  Created by Hamzhya Salsatinnov Hairy on 01/04/20.
//  Copyright © 2020 Hamzhya Salsatinnov Hairy. All rights reserved.
//

import UIKit
import SafariServices

class DetailViewController: BaseView, UITableViewDataSource, UITableViewDelegate, SFSafariViewControllerDelegate, UIViewControllerTransitioningDelegate {

    @IBOutlet weak var readFullBtn: BXButton!
    @IBOutlet weak var tableview: UITableView!
    
    var newsDetail = ArticleModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.separatorStyle = .none
        tableview.delegate = self
        tableview.dataSource = self
        tableview.rowHeight = UITableView.automaticDimension
        tableview.estimatedRowHeight = 100
        tableview.bounces = false
        tableview.register(HomeCell.reusableNIB(), forCellReuseIdentifier: HomeCell.reusableIndentifier)
        tableview.register(ArticleDetailCell.reusableNIB(), forCellReuseIdentifier: ArticleDetailCell.reusableIndentifier)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.transparentBar()
        self.setArrowBack(imageArrow: R.image.close()!)
    }
    
    @IBAction func readFullAction(_ sender: Any) {
        openInSafari()
    }
    
    func openInSafari() {
        guard let articleString = self.newsDetail.url, let url = URL(string: articleString) else { return }
        let svc = DFSafariViewController(url: url)
        svc.delegate = self
        self.present(svc, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: HomeCell.reusableIndentifier, for: indexPath) as! HomeCell
            cell.catImage.contentMode = .center
            cell.setupArticles(Article: newsDetail)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: ArticleDetailCell.reusableIndentifier, for: indexPath) as! ArticleDetailCell
            cell.descriptionLabel.text = newsDetail.description ?? "-"
            cell.articleLabel.text = newsDetail.content ?? "-"
            cell.sourceLabel.text = "source : \(newsDetail.source?.name ?? "-")"
            return cell
        }
    }
    

}
