//
//  PhotosCollectionViewController.swift
//  REST API App
//
//  Created by Apple Macbook Pro 13 on 4.09.22.
//

import UIKit

class PhotosCollectionViewController: UICollectionViewController {

    var album: Album?
    var photos: [Photo] = []
    var images: [UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView!.register(
            UINib(nibName: PhotosCollectionViewCell.identifier, bundle: nil),
            forCellWithReuseIdentifier: PhotosCollectionViewCell.identifier)
        fetchPhotos()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        images.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: PhotosCollectionViewCell.identifier,
                for: indexPath) as? PhotosCollectionViewCell
        else {
            return UICollectionViewCell()
        }
        let image = images[indexPath.row]
        cell.refresh(image: image)
        return cell
    }

    // MARK: UICollectionViewDelegate

    func fetchPhotos() {
        guard
            let album = album,
            let url = URL(string: ApiConstants.photoPath+"?albumId=\(album.id)") else { return }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let error = error {
                print(error)
            }
            if let response = response {
                print(response)
            }
            if let data = data {
                do {
                    self?.photos = try JSONDecoder().decode([Photo].self, from: data)
                } catch {
                    print(error)
                }
            }
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
                self?.fetchImages()
            }
        }
        task.resume()
    }
    
    func fetchImages() {
        for photo in photos {
            guard
                let urlString = photo.url,
                let url = URL(string: urlString)
            else {
                return
            }
            let task = URLSession.shared.dataTask(
                with: url) { [weak self] data, response, error in
                    if let error = error {
                        print(error)
                    }
                    if let data = data,
                        let image = UIImage(data: data){
                        self!.images.append(image)
                    }
                    DispatchQueue.main.async {
                        self?.collectionView.reloadData()
                    }
                }
            task.resume()
        }
    }
}
