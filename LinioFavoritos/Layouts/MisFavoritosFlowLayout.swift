//
//  FavoritoFlowLayout.swift
//  LinioFavoritos
//
//  Created by Jorge Mendizabal on 1/16/19.
//  Copyright © 2019 Jorge Mendizabal. All rights reserved.
//

import UIKit

class MisFavoritosFlowLayout: UICollectionViewLayout {

    private var cacheCells = [UICollectionViewLayoutAttributes]()
    private var cacheHeaders = [UICollectionViewLayoutAttributes]()
    
    private var contentHeight: CGFloat  = 0.0
    private var lastSizeItem: CGSize? = nil
    
    private var contentWidth: CGFloat {
        let insets = collectionView!.contentInset
        return collectionView!.bounds.width - (insets.left + insets.right)
    }
    
    override func prepare() {
        super.prepare()
        
        guard let collectionView = self.collectionView else { return }
        
        var xOffset: CGFloat = 9.0
        var yOffset: CGFloat = 10.0
        
        for section  in 0..<collectionView.numberOfSections {
            let numberOfItems = collectionView.numberOfItems(inSection: section)
            for item in 0..<numberOfItems {
                
                let indexPath = IndexPath(item: item, section: section)
                let itemWidth: CGFloat
                let itemHeight: CGFloat
                
                if (item % 3) == 0 {
                    itemWidth = (collectionView.frame.width * 0.6) - xOffset
                    itemHeight = collectionView.frame.height - (yOffset * 2)
                } else {
                    xOffset = (collectionView.frame.width * 0.6) + 9.0
                    itemWidth = (collectionView.frame.width * 0.4) - (9.0 * 2)
                    itemHeight = collectionView.frame.height / 2 - (14.0)
                }
                
                let xpositionitem = xOffset
                let ypositionitem = yOffset
                
                let frame = CGRect(x: xpositionitem, y:  ypositionitem, width: itemWidth, height: itemHeight)
                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                attributes.frame = frame
                cacheCells.append(attributes)
                
                if (item % 3) == 0 {
                    xOffset = 70.0
                } else {
                    yOffset = frame.maxY + 10.0
                }
                contentHeight = frame.maxY
            }
        }
    }
    
    
    override func invalidateLayout() {
        super.invalidateLayout()
        self.cacheCells = []
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        for attributes in cacheCells {
            if attributes.frame.intersects(rect) {
                layoutAttributes.append(attributes)
            }
        }
        
        for attributes in cacheHeaders {
            if attributes.frame.intersects(rect) {
                layoutAttributes.append(attributes)
            }
        }
        
        return layoutAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cacheCells.first { attributes -> Bool in
            return attributes.indexPath == indexPath
        }
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: self.collectionView!.frame.width, height: contentHeight)
    }
    
    func needInvalidate() -> Bool {
        guard let collectionView = self.collectionView else {
            return false
        }
        guard let lastSize = self.lastSizeItem else {return false }
        
        if lastSize.width != collectionView.frame.width / 2 {
            return true
        }
        return false
    }
    
    override func layoutAttributesForSupplementaryView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return self.cacheHeaders[indexPath.section]
    }

}
