//
//  SourcesTableViewCell.swift
//  simple-news-app
//
//  Created by Hamzhya Salsatinnov Hairy on 01/04/20.
//  Copyright © 2020 Hamzhya Salsatinnov Hairy. All rights reserved.
//

import UIKit

class SourcesTableViewCell: UITableViewCell {

    @IBOutlet weak var sourceLogo: UIImageView!
    @IBOutlet weak var sourceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupView(data: SourceModel) {
        let imageLink = APIManager.getSourceNewsLogoUrl(source: data.id ?? "")
        self.sourceLogo.downloadedFromLink(imageLink, contentMode: .scaleAspectFit)
        self.sourceLabel.text = data.url ?? ""
    }
    
    class var reusableIndentifier: String { return String(describing: self) }
    static func reusableNIB() -> UINib {
        return UINib(nibName: self.reusableIndentifier, bundle: Bundle.main)
    }
    
}
