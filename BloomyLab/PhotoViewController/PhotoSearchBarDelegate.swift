//
//  PhotoSearchBarDelegate.swift
//  BloomyLab
//
//  Created by md760 on 8/6/19.
//  Copyright © 2019 md760. All rights reserved.
//

import UIKit
import RealmSwift

//MARK: - UISearchBarDelegate
extension PhotoViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
            searchText = text
            searchBar.text = ""
            
            SearchedPhoto.getImageBy(name: text) { [weak self] (model) in
                
                if let photos = model?.photos, photos.count != 0 {
                    guard let `self` = self,
                        let imageString = model?.photos?.first?.imageSize?.landscape else {
                            return
                    }
                    self.photosArray.append(imageString)
                    DispatchQueue.main.async {
                        let modelObject = RealmPhotoModel()
                        modelObject.searchText = self.searchText
                        modelObject.imageString = imageString
                        
                        do {
                            try self.realm.write {
                                self.realm.add([modelObject])
                            }
                            self.collectionView.reloadData()
                        } catch let error {
                            print(error)
                            Alert.showAlert(title: "Error!", msg: ConstName.errorMessage, customActions: []) { [weak self] (alert) in
                                self?.present(alert, animated: true, completion: nil)
                            }
                        }
                    }
                    
                } else {
                    Alert.showAlert(title: "🔍", msg: ConstName.emptyResult, customActions: [], completion: { [weak self] (alert) in
                        self?.present(alert, animated: true, completion: nil)
                    })
                }
            }
        }
    }
}
