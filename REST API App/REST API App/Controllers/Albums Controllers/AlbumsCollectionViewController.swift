//
//  AlbumsCollectionViewController.swift
//  REST API App
//
//  Created by Apple Macbook Pro 13 on 4.09.22.
//

import UIKit

final class AlbumsCollectionViewController: UICollectionViewController {

    // MARK: - Properties
    var user: User?
    var albums: [Album] = []
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAlbums()
        title = "Albums"
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if
            let photosCVC = segue.destination as? PhotosCollectionViewController,
            let indexPath = sender as? IndexPath,
            segue.identifier == "GoToPhotosCVC"
        {
            photosCVC.album = albums[indexPath.row]
        }
    }
    
    // MARK: - UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        albums.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: AlbumsCollectionViewCell.identifier,
                for: indexPath) as? AlbumsCollectionViewCell
        else {
            return UICollectionViewCell()
        }
        let album = albums[indexPath.row]
        cell.titleLabel.text = album.title
    
        return cell
    }

    // MARK: - UICollectionViewDelegate

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "GoToPhotosCVC", sender: indexPath)
    }

    // MARK: - Functions
    private func fetchAlbums() {
        guard
            let user = user,
            let urlAlbum = URL(string: ApiConstants.albumsPath + "?userId=\(user.id)")
        else { return }

        let task = URLSession.shared.dataTask(with: urlAlbum) { [weak self] data, response, error in
            if let error = error {
                print(error)
            }
            if let response = response {
                print(response)
            }
            if let data = data {
                do {
                    self?.albums = try JSONDecoder().decode([Album].self, from: data)
                } catch {
                    print(error)
                }
            }
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
        task.resume()
    }
}

// MARK: - Extensions
extension AlbumsCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width/2 - 5
        return CGSize(width: (width), height: width)
    }
}
