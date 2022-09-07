//
//  DetailPhotoViewController.swift
//  REST API App
//
//  Created by Apple Macbook Pro 13 on 4.09.22.
//

import UIKit

class DetailPhotoViewController: UIViewController {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var urlLabel: UILabel!
    @IBOutlet private weak var thumbnaiUrlLabel: UILabel!
    
    var photo: Photo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Photo"
        setupUI()
    }
    
    private func setupUI() {
//        titleLabel.text = photo?.title
//        imageView.image = image
//        urlLabel.text = photo?.url
//        thumbnaiUrlLabel.text = photo?.thumbnailUrl
    }
}
