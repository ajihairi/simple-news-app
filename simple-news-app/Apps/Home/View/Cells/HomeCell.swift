//
//  HomeCell.swift
//  simple-news-app
//
//  Created by Hamzhya Salsatinnov Hairy on 01/04/20.
//  Copyright © 2020 Hamzhya Salsatinnov Hairy. All rights reserved.
//

import UIKit

class HomeCell: UITableViewCell {

    @IBOutlet weak var containerView: GSView!
    @IBOutlet weak var catImage: GSImageView!
    @IBOutlet weak var overlayView: GSView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var publisher: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func generateData(Category data: HomeModel) {
        self.selectionStyle = .none
        self.catImage.image = data.cat_Img ?? UIImage()
        self.titleLabel.text = data.cat_name
        self.publisher.isHidden = true
    }
    func setupArticles(Article data: ArticleModel) {
        self.selectionStyle = .none
        self.catImage.downloadedFromLink(data.urlToImage ?? "", contentMode: .scaleAspectFill)
        self.titleLabel.text = data.title ?? ""
        self.publisher.isHidden = false
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from:data.publishedAt ?? "2016-04-14T10:44:00+0000") ?? Date()
        
        self.publisher.text = "\(data.author ?? "") \n \(date.toString(dateFormat: "dd' 'MMM' 'yyyy' at 'hh':'mm")) "
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    class var reusableIndentifier: String { return String(describing: self) }
    static func reusableNIB() -> UINib {
        return UINib(nibName: self.reusableIndentifier, bundle: Bundle.main)
    }
    
}
