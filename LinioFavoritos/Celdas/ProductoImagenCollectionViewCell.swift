//
//  ProductoImagenCollectionViewCell.swift
//  LinioFavoritos
//
//  Created by Jorge Mendizabal on 1/17/19.
//  Copyright © 2019 Jorge Mendizabal. All rights reserved.
//

import UIKit
import AlamofireImage

class ProductoImagenCollectionViewCell: UICollectionViewCell {
    
    static let identifier: String = "ProductoImagenCollectionViewCell"
    static let nib: UINib = UINib(nibName: "ProductoImagenCollectionViewCell", bundle: nil)
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var imageProducto: UIImageView!
    
    var badges: [Badge] = [] {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 8.0
        self.layer.masksToBounds = true
        self.collectionView.backgroundColor = .clear
        self.collectionView.dataSource = self
        ProductoImagenCollectionViewCell.registrar(collectionView: self.collectionView)
    }
    
    class func registrar(collectionView: UICollectionView) {
        collectionView.register(nib , forCellWithReuseIdentifier: identifier)
    }
}

extension ProductoImagenCollectionViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.badges.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductoImagenCollectionViewCell.identifier, for: indexPath) as! ProductoImagenCollectionViewCell
        cell.configura(badge: self.badges[indexPath.row])
        return cell
    }
    
}

extension ProductoImagenCollectionViewCell {
    
    func configurar(favorito: NSDictionary) {
        self.collectionView.isHidden = true
        self.configurar(producto: favorito)
    }
    
    func configurar(producto: NSDictionary) {
        self.imageProducto.image = nil
        if let urlstring = producto.value(forKey: "image") as? String {
            if let url = URL(string: urlstring) {
                self.imageProducto.af_setImage(withURL: url)
            }
        }
        self.badges = Badge.cargarBadges(producto: producto)
    }
    
    func configura(badge: Badge) {
        self.imageProducto.image = badge.imagen
        self.layer.cornerRadius = 0.0
    }
}
