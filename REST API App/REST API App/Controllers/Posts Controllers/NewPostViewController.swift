//
//  NewPostViewController.swift
//  REST API App
//
//  Created by Apple Macbook Pro 13 on 6.09.22.
//

import UIKit
import Alamofire
import SwiftyJSON

class NewPostViewController: UIViewController {

    var delegate: UpdatePostsData?
    var userId: Int?
    
    @IBOutlet weak var postTitleLabel: UITextField!
    @IBOutlet weak var postBodyTextView: UITextView!
    
    @IBAction func savePostAction() {
        guard
            let url = ApiConstants.postsURL,
            let userId = userId,
            let title = postTitleLabel.text,
            let body = postBodyTextView.text else { return }
        
        let model: Parameters = [
            "userId":userId,
            "title":title,
            "body":body]
        
        NetworkService.postData(url: url, parameters: model) { result, error in
            if result != nil {
                if let delegate = self.delegate {
                    delegate.update()
                }
                self.navigationController?.popViewController(animated: true)
            } else {
                print(error!)
            }
        }
    }
}
