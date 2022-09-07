//
//  ActionsCollectionViewController.swift
//  REST API App
//
//  Created by Apple Macbook Pro 13 on 30.08.22.
//

import UIKit

// MARK: - Enum

enum Actions: String, CaseIterable {
    case downloadImage = "Download Image"
    case users = "Users"
}

// MARK: - Class
final class ActionsCollectionViewController: UICollectionViewController {

    // MARK: Properties
    
    private let actions = Actions.allCases
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let usersTVC = segue.destination as? UsersTableViewController {
            usersTVC.fetchUsersData()
        }
    }
    

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return actions.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ActionCollectionViewCell.identifier,
            for: indexPath) as? ActionCollectionViewCell
        else {
            return UICollectionViewCell()
        }
    
        let action = actions[indexPath.row]
        cell.ActionLabel.text = action.rawValue
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let action = actions[indexPath.row]
        switch action {
        case .downloadImage:
            performSegue(withIdentifier: "GoToImageVC", sender: nil)
        case .users:
            performSegue(withIdentifier: "GoToUsersTVC", sender: nil)
        }
    }
}

// MARK: - Extensions
extension ActionsCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width - 60
        return CGSize(width: (width), height: width / 2)
    }
}
