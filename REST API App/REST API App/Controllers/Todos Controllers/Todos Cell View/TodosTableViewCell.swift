//
//  TodosTableViewCell.swift
//  REST API App
//
//  Created by Apple Macbook Pro 13 on 4.09.22.
//

import UIKit

class TodosTableViewCell: UITableViewCell {

    @IBOutlet private weak var markImageView: UIImageView!
    @IBOutlet private weak var todoLabel: UILabel!

    static let identifier = "TodosTableViewCell"
    
    func refresh(model: Todo) {
        todoLabel.text = model.title
        if model.completed! {
            markImageView.image = UIImage(systemName: "checkmark")

            markImageView.tintColor = .green
        } else {
            markImageView.image = UIImage(systemName: "xmark")
            markImageView.tintColor = .red
        }
    }
    
}
