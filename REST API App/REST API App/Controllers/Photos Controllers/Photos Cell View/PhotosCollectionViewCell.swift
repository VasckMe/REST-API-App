//
//  PhotosCollectionViewCell.swift
//  REST API App
//
//  Created by Apple Macbook Pro 13 on 4.09.22.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var photoImageView: UIImageView!
    
    static let identifier = "PhotosCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func refresh(image: UIImage) {
        photoImageView.image = image
    }
}
