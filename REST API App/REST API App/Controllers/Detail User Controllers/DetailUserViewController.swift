//
//  DetailUserViewController.swift
//  REST API App
//
//  Created by Apple Macbook Pro 13 on 2.09.22.
//

import UIKit

class DetailUserViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var usernameLabel: UILabel!
    @IBOutlet private weak var emailLabel: UILabel!
    @IBOutlet private weak var phoneLabel: UILabel!
    @IBOutlet private weak var websiteLabel: UILabel!
    @IBOutlet private weak var streetLabel: UILabel!
    @IBOutlet private weak var suiteLabel: UILabel!
    @IBOutlet private weak var cityLabel: UILabel!
    @IBOutlet private weak var zipcodeLabel: UILabel!
    @IBOutlet private weak var geoLabel: UILabel!
    @IBOutlet private weak var companyNameLabel: UILabel!
    @IBOutlet private weak var catchPhraseLabel: UILabel!
    @IBOutlet private weak var bsLabel: UILabel!
    
    // MARK: - Properties
    var user: User?
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "User"
        setupUI()
    }
    
    // MARK: - Private functions
    private func setupUI() {
        guard let user = user else { return }
        nameLabel.text = user.name
        usernameLabel.text = user.username
        emailLabel.text = user.email
        phoneLabel.text = user.phone
        websiteLabel.text = user.website
        streetLabel.text = user.address?.street
        suiteLabel.text = user.address?.suite
        cityLabel.text = user.address?.city
        zipcodeLabel.text = user.address?.zipcode
        geoLabel.text = (user.address?.geo?.lat)! + ", " + (user.address?.geo?.lng)!
        companyNameLabel.text = user.company?.name
        catchPhraseLabel.text = user.company?.catchPhrase
        bsLabel.text = user.company?.bs
    }

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let postsTVC = segue.destination as? PostsTableViewController,
           segue.identifier == "GoToPostsTVC" {
            postsTVC.user = user
        }
        if let albumsCVC = segue.destination as? AlbumsCollectionViewController,
           segue.identifier == "GoToAlbumsCVC" {
            albumsCVC.user = user
        }
        if let todosTVC = segue.destination as? TodosTableViewController,
           segue.identifier == "GoToTodosTVC" {
            todosTVC.user = user
        }
        if let locationVC = segue.destination as? LocationViewController,
           segue.identifier == "GoToLocationVC" {
            locationVC.user = user
        }
    }
}
