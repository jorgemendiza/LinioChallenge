//
//  FavoritosFlowLayout.swift
//  LinioFavoritos
//
//  Created by Jorge Mendizabal on 1/17/19.
//  Copyright © 2019 Jorge Mendizabal. All rights reserved.
//

import UIKit

class FavoritosFlowLayout: UICollectionViewLayout {
    
    private var cacheCells = [UICollectionViewLayoutAttributes]()
    private var contentHeight: CGFloat  = 0.0
    private var cacheHeaders = [UICollectionViewLayoutAttributes]()
    
    override func prepare() {
        
        guard let collectionView = self.collectionView else {return}
        
        let width = (collectionView.frame.width / 2) - (9.0 + 4.5)
        let size = CGSize(width: width, height: width)
        var xOffset = 0.0
        var yOffset = 0.0
        for section in 0..<collectionView.numberOfSections {
            let numberOfItems = collectionView.numberOfItems(inSection: section)
            
            if section == 1 {
                let frame = CGRect(origin: CGPoint(x: xOffset, y: yOffset + 27), size: CGSize(width: collectionView.frame.width - 18 , height: 20.0))
                let attributes = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, with: IndexPath(row: 0, section: section))
                attributes.frame = frame
                cacheHeaders.append(attributes)
                yOffset = yOffset + 51.0
            }
            for item in 0..<numberOfItems {
                let frame = CGRect(origin: CGPoint(x: xOffset, y: yOffset), size: size)
                let attributes = UICollectionViewLayoutAttributes(forCellWith: IndexPath(row: item, section: section))
                attributes.frame = frame
                cacheCells.append(attributes)
                
                if item % 2 == 0 {
                    xOffset = Double(width + 9.0)
                } else {
                    yOffset = Double(frame.maxY + 9.0)
                    xOffset = 0.0
                }
                self.contentHeight = frame.maxY
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
        return CGSize(width: self.collectionView!.frame.width - 18.0, height: contentHeight)
    }
}
