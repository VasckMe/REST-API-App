//
//  DetailPhotoViewController.swift
//  REST API App
//
//  Created by Apple Macbook Pro 13 on 4.09.22.
//

import UIKit

class DetailPhotoViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var urlLabel: UILabel!
    @IBOutlet weak var thumbnaiUrlLabel: UILabel!
    
    var photo: Photo?
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    private func setupUI() {
        titleLabel.text = photo?.title
        imageView.image = image
        urlLabel.text = photo?.url
        thumbnaiUrlLabel.text = photo?.thumbnailUrl
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
