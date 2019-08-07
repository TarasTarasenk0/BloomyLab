//
//  ViewController.swift
//  BloomyLab
//
//  Created by md760 on 8/6/19.
//  Copyright © 2019 md760. All rights reserved.
//

import UIKit
import RealmSwift


final class PhotoViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - Properties
    let realm = try! Realm()
    var items: Results<RealmPhotoModel>!
    var searchText = ""
    var photosArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        checkInternet()
        setupDragDelegate()
        fillPhotoArray()
    }
}

//MARK: - Private Func
private extension PhotoViewController {
    
    //MARK: - FillPhotoArray
    func fillPhotoArray() {
        let itemsArray = Array(items)
        
        for i in itemsArray {
            photosArray.append(i.imageString)
        }
    }
    
    //MARK: - SetupView
    func setupView() {
        self.collectionView.register(UINib(nibName: "PhotoCell", bundle: nil), forCellWithReuseIdentifier: "cellId")
        items = realm.objects(RealmPhotoModel.self)
    }
    
    //MARK: - SetupDragDelegate
    func setupDragDelegate() {
        collectionView.dragInteractionEnabled = true
        collectionView.dragDelegate = self
        collectionView.dropDelegate = self
    }
    
    //MARK: - CheckInternet
    func checkInternet() {
        if !Reachability.isConnectedToNetwork() {
            Alert.showAlert(title: ConstName.internetTitle + "?", msg: ConstName.errorMessage, customActions: []) { [weak self] (alert) in
                self?.present(alert, animated: true, completion: nil)
            }
        }
    }
}
