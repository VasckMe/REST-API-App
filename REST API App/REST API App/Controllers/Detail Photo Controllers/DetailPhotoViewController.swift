//
//  DetailPhotoViewController.swift
//  REST API App
//
//  Created by Apple Macbook Pro 13 on 4.09.22.
//

import UIKit

final class DetailPhotoViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var urlLabel: UILabel!
    @IBOutlet private weak var thumbnaiUrlLabel: UILabel!
    
    // MARK: - Properties
    var photo: Photo?
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Photo"
        setupUI()
    }
    
    // MARK: - Private functions
    private func setupUI() {
        titleLabel.text = photo?.title
        urlLabel.text = photo?.url
        thumbnaiUrlLabel.text = photo?.thumbnailUrl
        
        if let url = photo?.url {
            if let image = CacheManager.shared.imageCache.image(withIdentifier: url) {
                imageView.image = image
            } else {
                NetworkService.getImageData(url: url) { [weak self] result in
                    if case .success(let image) = result.result {
                        self?.imageView.image = image
                        CacheManager.shared.imageCache.add(image, withIdentifier: url)
                    }
                }
            }
        }
    }
}
