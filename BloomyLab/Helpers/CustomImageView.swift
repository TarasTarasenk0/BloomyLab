//
//  CustomImageView.swift
//  BloomyLab
//
//  Created by md760 on 8/6/19.
//  Copyright © 2019 md760. All rights reserved.
//

import UIKit
import SDWebImage

final class CustomUIImage: UIImageView {
    var setImageFromStringUrl: String? {
        didSet {
            if let urlString = setImageFromStringUrl, let url = URL(string: urlString) {
                sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"),
                            options: SDWebImageOptions()) { _,_,_,_ in
                }
            } else {
                self.image = UIImage(named: "placeholder")
            }
        }
    }
}
