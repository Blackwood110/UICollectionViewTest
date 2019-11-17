//
//  ViewController.swift
//  UICollectionViewTest
//
//  Created by Александр Дергилёв on 17.11.2019.
//  Copyright © 2019 Александр Дергилёв. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let collectionViewLayout = UICollectionViewFlowLayout()
//        collectionViewLayout.scrollDirection = .horizontal
        let customSuperLayout = PhotoCollectionViewLayout()
        customSuperLayout.delegate = self
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: customSuperLayout)
        collectionView.dataSource = self
//        collectionView.delegate = self
        let nib = UINib(nibName: "Cell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "Cell")
        
        self.view.addSubview(collectionView)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.frame = self.view.frame
    }
    
    private func image(at indexPath: IndexPath) -> UIImage? {
        return UIImage(named: "\(indexPath.row + 1)")
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let dequeuedCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        guard let cell = dequeuedCell as? Cell else {
            return dequeuedCell
        }
        cell.imageView.image = self.image(at: indexPath)
        return dequeuedCell
    }
}

extension ViewController: PhotoCollectionViewLayoutDelegate {
    func ratio(forItemAt indexPath: IndexPath) -> CGFloat {
        guard let image = self.image(at: indexPath) else {
            return 1.0
        }
        return image.size.width / image.size.height
    }
}
//extension ViewController: UICollectionViewDelegateFlowLayout {
//    //   размер ячейки
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 100, height: 100)
//    }
//    // отступы от краев
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 50, left: 20, bottom: 0, right: 20)
//    }
//    // растояние между ячейками вертикально
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 20.0
//    }
//    // растояние между ячейками горизонтально
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 10
//    }
//}
