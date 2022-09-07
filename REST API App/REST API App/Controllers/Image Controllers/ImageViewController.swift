//
//  ImageViewController.swift
//  REST API App
//
//  Created by Apple Macbook Pro 13 on 30.08.22.
//

import UIKit

final class ImageViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet private weak var downloadedImageView: UIImageView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: Properties
    
    private let imageStringURL = "https://wallpapershome.ru/images/wallpapers/stalker-2-1440x2560-stalker-2-22746.jpg"
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchImageData()
    }
    
    // MARK: Functions
    
    private func fetchImageData() {
        guard let url = URL(string: imageStringURL) else { return }
        let task = URLSession.shared.dataTask(
            with: url) { [weak self] data, response, error in
                DispatchQueue.main.async {
                    self?.activityIndicator.stopAnimating()
                    if let error = error {
                        print(error)
                    }
                    if let response = response {
                        print(response)
                    }
                    if let data = data {
                        print(data)
                        self?.downloadedImageView.image = UIImage(data: data)
                    }
                }
            }
        task.resume()
    }
}
