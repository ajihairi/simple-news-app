//
//  SearchTableViewCell.swift
//  simple-news-app
//
//  Created by Hamzhya Salsatinnov Hairy on 01/04/20.
//  Copyright © 2020 Hamzhya Salsatinnov Hairy. All rights reserved.
//

import UIKit

protocol SearchViewProtocol {
    func didSearchEnd(_ key: String)
}

class SearchTableViewCell: UITableViewCell, UITextFieldDelegate {

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var dismissSearch: DismissButton!
    
    var delegate: SearchViewProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        searchTextField.delegate = self
        dismissSearch.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func dismissAction(_ sender: Any) {
        self.searchTextField.text = ""
        self.delegate?.didSearchEnd("")
        dismissSearch.isHidden = true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        dismissSearch.isHidden = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        dismissSearch.isHidden = true
        self.delegate?.didSearchEnd(self.searchTextField.text ?? "")
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.resignFirstResponder()
        return true
    }
    
    class var reusableIndentifier: String { return String(describing: self) }
    static func reusableNIB() -> UINib {
        return UINib(nibName: self.reusableIndentifier, bundle: Bundle.main)
    }
}


