//
//  Cell.swift
//  UICollectionViewTest
//
//  Created by Александр Дергилёв on 17.11.2019.
//  Copyright © 2019 Александр Дергилёв. All rights reserved.
//

import UIKit

class Cell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageView.image = nil
    }
}
