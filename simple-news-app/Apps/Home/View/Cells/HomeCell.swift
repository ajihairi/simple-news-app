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
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func generateData(Category data: HomeModel) {
        self.selectionStyle = .none
        self.catImage.image = data.cat_Img ?? UIImage()
        self.titleLabel.text = data.cat_name
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
