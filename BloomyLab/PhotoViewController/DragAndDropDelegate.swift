//
//  DragAndDropDelegate.swift
//  BloomyLab
//
//  Created by md760 on 8/6/19.
//  Copyright © 2019 md760. All rights reserved.
//

import UIKit

//MARK: - Drop Funcionts
extension PhotoViewController {
    
    func photo(for indexPath: IndexPath) -> String {
        return self.photosArray[indexPath.item]
    }
    
    func insertPhoto(_ image: String, at indexPath: IndexPath) {
        photosArray.insert(image, at: indexPath.item)
    }
    
    func removePhoto(at indexPath: IndexPath) {
        photosArray.remove(at: indexPath.item)
    }
}

//MARK: - UICollectionViewDragDelegate
extension PhotoViewController: UICollectionViewDragDelegate {
    
    func collectionView(_ collectionView: UICollectionView,
                        itemsForBeginning session: UIDragSession,
                        at indexPath: IndexPath) -> [UIDragItem] {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! PhotoCell
        let thumbnail = cell.currentImage ?? UIImage()
        let item = NSItemProvider(object: thumbnail)
        let dragItem = UIDragItem(itemProvider: item)
        return [dragItem]
    }
}

//MARK: - UICollectionViewDropDelegate
extension PhotoViewController: UICollectionViewDropDelegate {
    
    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
        guard let destinationIndexPath = coordinator.destinationIndexPath else {
            return
        }
        
        coordinator.items.forEach { dropItem in
            guard let sourceIndexPath = dropItem.sourceIndexPath else {
                return
            }
            
            collectionView.performBatchUpdates({
                let image = photo(for: sourceIndexPath)
                removePhoto(at: sourceIndexPath)
                insertPhoto(image, at: destinationIndexPath)
                collectionView.deleteItems(at: [sourceIndexPath])
                collectionView.insertItems(at: [destinationIndexPath])
            }, completion: { _ in
                coordinator.drop(dropItem.dragItem,
                                 toItemAt: destinationIndexPath)
            })
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        canHandle session: UIDropSession) -> Bool {
        return true
    }
    func collectionView(
        _ collectionView: UICollectionView,
        dropSessionDidUpdate session: UIDropSession,
        withDestinationIndexPath destinationIndexPath: IndexPath?)
        -> UICollectionViewDropProposal {
            return UICollectionViewDropProposal(
                operation: .move,
                intent: .insertAtDestinationIndexPath)
    }
    
}

