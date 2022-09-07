//
//  PhotosCollectionViewCell.swift
//  REST API App
//
//  Created by Apple Macbook Pro 13 on 4.09.22.
//

import UIKit
import SwiftyJSON
import Alamofire
import AlamofireImage

final class PhotosCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var photoImageView: UIImageView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    static let identifier = "PhotosCollectionViewCell"
    
    var photo: Photo?
    
    func refresh() {
        if let thumbnailURL = photo?.thumbnailUrl {
            if let image = CacheManager.shared.imageCache.image(withIdentifier: thumbnailURL) {
                activityIndicator.stopAnimating()
                photoImageView.image = image
            } else {
                NetworkService.getImageData(url: thumbnailURL) { [weak self] result in
                    if case .success(let image) = result.result {
                        self?.activityIndicator.stopAnimating()
                        self?.photoImageView.image = image
                        CacheManager.shared.imageCache.add(image, withIdentifier: thumbnailURL)
                    }
                }
            }
        }
    }
}
