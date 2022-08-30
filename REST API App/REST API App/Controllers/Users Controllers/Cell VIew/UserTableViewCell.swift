//
//  UserTableViewCell.swift
//  REST API App
//
//  Created by Apple Macbook Pro 13 on 30.08.22.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    // MARK: Outlets
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    // MARK: Properties
    static let identifier = "UserTableViewCell"
    
    // MARK: awakeFromNib
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // MARK: Functions
    func refresh(model: User) {
        idLabel.text = model.id.description
        nameLabel.text = model.name
        cityLabel.text = "City: " + (model.address?.city ?? "error city")
        emailLabel.text = "Email: " + (model.email ?? "error email")
    }
}
