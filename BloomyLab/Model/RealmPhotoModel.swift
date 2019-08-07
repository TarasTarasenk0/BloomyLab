//
//  PhotoModel.swift
//  BloomyLab
//
//  Created by md760 on 8/6/19.
//  Copyright © 2019 md760. All rights reserved.
//

import Foundation
import RealmSwift

final class RealmPhotoModel: Object {
    
    @objc dynamic var searchText = String()
    @objc dynamic var imageString = String()
    @objc dynamic var starRating = Double()
    
    override public static func primaryKey() -> String? { return "imageString" }
    
    static func getRealmModel(_ imageString: String) -> RealmPhotoModel {
        let realm = try! Realm()
        return realm.objects(RealmPhotoModel.self).filter("imageString = %@", imageString).first!
    }
}

