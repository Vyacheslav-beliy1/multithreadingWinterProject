//
//  MyTableViewCell.swift
//  TableViewApp
//
//  Created by bws2007 on 10/7/18.
//  Copyright © 2018 bws2007. All rights reserved.
//

import UIKit

class MyTableViewCell: UITableViewCell {

    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var activityView: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    var imagePath: String? {
        didSet {
            activityView.startAnimating()
            myImageView.image = nil
            if let path = imagePath {
                DispatchQueue.global(qos: .userInitiated).async {
                    let imageModel = ImageModel(imagePath: path)
                    if path == self.imagePath {
                        DispatchQueue.main.async {
                            self.myImageView.image = imageModel.image
                            self.activityView.stopAnimating()
                        }
                    }
                }
            }
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
