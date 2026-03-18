//
//  CollectionViewDelegate.swift
//  PixelVault
//
//  Created by Abdulkarim Mziya on 2026-03-17.
//

import UIKit

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PostCollectionViewCell.reuseIdentifier, for: indexPath) as! PostCollectionViewCell
        let post = posts[indexPath.item]

        if let cachedImage = imageCache[post.id] {
            cell.configure(with: post, image: cachedImage)
        } else {
            // 1. Show a placeholder or nil while loading
            cell.configure(with: post, image: nil)

            // 2. Start the async fetch
            Task {
                if let image = try? await PixelApiService.fetchImage(from: post.previewImageURL) {
                    self.imageCache[post.id] = image

                    // 3. IMPORTANT: Update only the visible cell on the main thread
                    if let visibleCell = collectionView.cellForItem(at: indexPath) as? PostCollectionViewCell {
                        visibleCell.configure(with: post, image: image)
                    }
                }
            }
        }
        return cell
    }

    
    
}


extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numCells: CGFloat = 3
        let numSpaces: CGFloat = numCells + 1
        let cellSpacing: CGFloat = 1
        
        let screenWidth = collectionView.bounds.width
        let screenHeight = collectionView.bounds.height
        
        return CGSize(width: (screenWidth - (cellSpacing * numSpaces)) / numCells, height: screenHeight * 0.25)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1, left: 1, bottom: 0, right: 1)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 1
    }
}

extension ViewController: UICollectionViewDataSourcePrefetching {
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        
        for indexpath in indexPaths {
            let post = posts[indexpath.item]
            
            Task{
                if imageCache[post.id] == nil {
                    if let image = try? await PixelApiService.fetchImage(from: post.previewImageURL) {
                        imageCache[post.id] = image
                    }
                }
            }
        }
    }
    
    
}
