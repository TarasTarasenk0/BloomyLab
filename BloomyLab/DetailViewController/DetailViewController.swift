//
//  DetailViewController.swift
//  BloomyLab
//
//  Created by md760 on 8/6/19.
//  Copyright © 2019 md760. All rights reserved.
//

import UIKit
import RealmSwift
import Cosmos

final class DetailViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet private weak var imageView: CustomUIImage!
    @IBOutlet private weak var cosmosView: CosmosView!
    @IBOutlet private weak var titleLabel: UILabel!
    
    //MARK: - Properties
    private let realm = try! Realm()
    var photo: String?
    var realmModel: RealmPhotoModel?
    
    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRating()
        setupModel()
    }
}

//MARK: - Private Func
private extension DetailViewController {
    func setupModel() {
        guard let model = realmModel else { return }
        imageView.setImageFromStringUrl = photo
        titleLabel.text = model.searchText
        cosmosView.rating = model.starRating
    }
    //MARK: - Func
    func setupRating() {
        cosmosView.didFinishTouchingCosmos = { [weak self] rating in
            guard let photo = self?.photo,
                var model = self?.realmModel else {
                    return
            }
            model = RealmPhotoModel.getRealmModel(photo)
            let realm = try! Realm()
            try! realm.write {
                model.starRating = rating
                realm.add(model, update: true)
            }
        }
    }
}
