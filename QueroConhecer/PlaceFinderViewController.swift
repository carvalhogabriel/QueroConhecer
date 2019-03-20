//
//  PlaceFinderViewController.swift
//  QueroConhecer
//
//  Created by Gabriel Carvalho Guerrero on 20/03/19.
//  Copyright © 2019 Gabriel Carvalho Guerrero. All rights reserved.
//

import UIKit
import MapKit

class PlaceFinderViewController: UIViewController {

    @IBOutlet weak var textFieldCity: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var viewLoading: UIView!
    @IBOutlet weak var aiLoading: UIActivityIndicatorView!
    
    @IBAction func findCity(_ sender: UIButton) {
        
    }
    
    @IBAction func close(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
