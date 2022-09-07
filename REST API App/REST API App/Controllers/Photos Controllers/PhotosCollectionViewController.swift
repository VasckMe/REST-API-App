//
//  PhotosCollectionViewController.swift
//  REST API App
//
//  Created by Apple Macbook Pro 13 on 4.09.22.
//

import UIKit
import SwiftyJSON

final class PhotosCollectionViewController: UICollectionViewController {

    // MARK: - Properties
    var album: Album?
    var photos: [Photo] = []
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Photos"
        self.collectionView!.register(
            UINib(nibName: PhotosCollectionViewCell.identifier, bundle: nil),
            forCellWithReuseIdentifier: PhotosCollectionViewCell.identifier)
        fetchPhotos()
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailPhotoVC = segue.destination as? DetailPhotoViewController,
           let indexPath = sender as? IndexPath {
            detailPhotoVC.photo = photos[indexPath.row]
        }
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: PhotosCollectionViewCell.identifier,
                for: indexPath) as? PhotosCollectionViewCell
        else {
            return UICollectionViewCell()
        }
        let photo = photos[indexPath.row]
        cell.photo = photo
        cell.refresh()
        return cell
    }

    // MARK: UICollectionViewDelegate

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "GoToDetailPhotoVC", sender: indexPath)
    }
    
    // MARK: - Functions
    func fetchPhotos() {
        guard let album = album else { return }
            let url = ApiConstants.photoPath+"?albumId=\(album.id)"
        NetworkService.getData(url: url) {[weak self] result, error in
            if let data = result {
                do {
                    self?.photos = try JSONDecoder().decode([Photo].self, from: data)
                } catch {
                    print("Error with Decoding JSON data")
                }
                self?.collectionView.reloadData()
            } else {
                print(error!)
            }
        }
    }
}
