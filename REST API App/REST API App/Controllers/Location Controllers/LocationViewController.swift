//
//  LocationViewController.swift
//  REST API App
//
//  Created by Apple Macbook Pro 13 on 4.09.22.
//

import UIKit
import MapKit

class LocationViewController: UIViewController {

    @IBOutlet private weak var map: MKMapView!
    
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        title = "Location"
    }
    
    func setupUI() {
        if
            let user = user,
            let username = user.username,
            let geo = user.address?.geo,
            let lngStr = geo.lng,
            let latStr = geo.lat,
            let lng = Double(lngStr),
            let lat = Double(latStr)
        {
            let annotaion = MKPointAnnotation()
            annotaion.coordinate.latitude = lat
            annotaion.coordinate.longitude = lng
            annotaion.title = "\(username)'s location"
            annotaion.subtitle = "Detail user location"
            map.addAnnotation(annotaion)
        }
    }
}
