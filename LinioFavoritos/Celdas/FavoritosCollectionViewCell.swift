//
//  FavoritosCollectionViewCell.swift
//  LinioFavoritos
//
//  Created by Jorge Mendizabal on 1/17/19.
//  Copyright © 2019 Jorge Mendizabal. All rights reserved.
//

import UIKit

class FavoritosCollectionViewCell: UICollectionViewCell {

    static let identifier: String = "FavoritosCollectionViewCell"
    static let nib: UINib = UINib(nibName: "FavoritosCollectionViewCell", bundle: nil)
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var labelNombreColeccion: UILabel!
    @IBOutlet weak var labelNumeroElementos: UILabel!
    
    fileprivate var productos: [NSDictionary] = [] {
        didSet {
            self.collectionView.reloadData()
            self.labelNumeroElementos.text = "\(productos.count)"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.collectionView.dataSource = self
        self.backgroundColor = .white
        self.collectionView.backgroundColor = UIColor(red: 247.0/255.0, green: 247.0/255.0, blue: 247.0/255.0, alpha: 1.0)
        self.collectionView.layer.cornerRadius = 8.0
        ProductoImagenCollectionViewCell.registrar(collectionView: self.collectionView)
        let favoritoFlowLayout = MisFavoritosFlowLayout()
        self.collectionView.setCollectionViewLayout(favoritoFlowLayout, animated: true)
    }
    
    class func registrar(collectionView: UICollectionView) {
        collectionView.register(nib, forCellWithReuseIdentifier: identifier)
    }

}

extension FavoritosCollectionViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductoImagenCollectionViewCell.identifier, for: indexPath) as! ProductoImagenCollectionViewCell
        cell.configurar(favorito: self.productos[indexPath.row])
        
        return cell
    }
}

extension FavoritosCollectionViewCell {
    
    func configurar(favoritos: NSDictionary) {
        self.labelNombreColeccion.text = favoritos.value(forKey: "name") as? String
        if let productos = favoritos.value(forKey: "products") as? NSDictionary {
            let productsArray = productos.map { (arg) -> NSDictionary in
                let (_, value) = arg
                return value as! NSDictionary
            }
            self.productos = productsArray
        }
    }
}
