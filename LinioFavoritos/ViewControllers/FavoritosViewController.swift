//
//  ViewController.swift
//  LinioFavoritos
//
//  Created by Jorge Mendizabal on 1/16/19.
//  Copyright © 2019 Jorge Mendizabal. All rights reserved.
//

import UIKit

class FavoritosViewController: BaseViewController {

    var items: [NSDictionary] = []
    var todosLosProductos: [NSDictionary] = []
    
    var flowLayout: UICollectionViewFlowLayout {
        return self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Favoritos"
        FavoritosCollectionViewCell.registrar(collectionView: self.collectionView)
        ProductoImagenCollectionViewCell.registrar(collectionView: self.collectionView)
        self.collectionView.register(UINib(nibName: "HeaderCollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HEADER")
        self.collectionView.contentInset = UIEdgeInsets(top: 0.0, left: 9.0, bottom: 0.0, right: 9.0)
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        flowLayout.minimumInteritemSpacing = 9
        flowLayout.minimumLineSpacing = 9
        self.collectionView.backgroundColor = UIColor(red: 247.0/255.0, green: 247.0/255.0, blue: 247.0/255.0, alpha: 1.0)
        Services.favoritos.load { [weak self] (response) in
            self?.manageResponse(response: response)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        let currentSize = self.flowLayout.itemSize
//        let width = (self.collectionView.frame.width / 2) - (9.0 + 4.5)
//        let newSize = CGSize(width: width, height: width)
//        if currentSize != newSize {
//            flowLayout.itemSize = newSize
//            self.collectionView.setCollectionViewLayout(FavoritosFlowLayout(), animated: false)
//        }
        self.collectionView.setCollectionViewLayout(FavoritosFlowLayout(), animated: false)
        self.collectionView.reloadData()
    }
    
    override func manageData(data: Any) {
        if let array = data as? [NSDictionary] {
            for favoritos in array {
                if let productos = favoritos.value(forKey: "products") as? NSDictionary {
                    let _ = productos.map { [weak self] (arg) -> NSDictionary in
                        let (_, value) = arg
                        self?.todosLosProductos.append(value as! NSDictionary)
                        return value as! NSDictionary
                    }
                }
            }
            self.items = array
            self.collectionView.setCollectionViewLayout(FavoritosFlowLayout(), animated: false)
            self.collectionView.reloadData()
        }
    }
    
}

extension FavoritosViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HEADER", for: indexPath) as! HeaderCollectionReusableView
        header.labelHeader.text = "Todos mis favoritos (\(self.todosLosProductos.count))"
        return header
    }
}

extension FavoritosViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return self.items.count
        } else {
            return self.todosLosProductos.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoritosCollectionViewCell.identifier, for: indexPath) as! FavoritosCollectionViewCell
            cell.configurar(favoritos: self.items[indexPath.row])
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductoImagenCollectionViewCell.identifier, for: indexPath) as! ProductoImagenCollectionViewCell
            cell.configurar(producto: self.todosLosProductos[indexPath.row])
            return cell
        }
    }
    
}
