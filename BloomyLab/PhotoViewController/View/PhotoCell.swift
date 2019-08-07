//
//  PhotoCell.swift
//  BloomyLab
//
//  Created by md760 on 8/6/19.
//  Copyright © 2019 md760. All rights reserved.
//

import UIKit

final class PhotoCell: UICollectionViewCell {
    
    //Outlets
    @IBOutlet private weak var imageView: CustomUIImage!
    
    var setImage: String? {
        get { return "" }
        set { imageView.setImageFromStringUrl = newValue }
    }
    
    var currentImage: UIImage? {
        return imageView.image
    }

}
