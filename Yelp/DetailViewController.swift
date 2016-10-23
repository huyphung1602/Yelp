//
//  DetailViewController.swift
//  Yelp
//
//  Created by Quoc Huy on 10/23/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class DetailViewController: UIViewController {
    
    // UI variables for restaurant detail

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var restaurantImage: UIImageView!
    @IBOutlet weak var reviewImage: UIImageView!
    @IBOutlet weak var reviewCountLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    // Variable used to transfer one business from segue
    var business: Business!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Change titleView to white color
        navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
        if business.imageURL != nil {
            restaurantImage.setImageWith(business.imageURL!)
        }
        
        nameLabel.text = business.name
        distanceLabel.text = business.distance
        reviewImage.setImageWith(business.ratingImageURL!)
        reviewCountLabel.text = String(describing: business.reviewCount!) + " reviews"
        let city = business.city!
        if city != "" {
            addressLabel.text = business.address! + ", " + city
        }
        else {
            addressLabel.text = business.address
        }
        categoryLabel.text = business.categories
        
        let latitude = Double(business.latitude!)
        let longitude = Double(business.longitude!)
        
        print("Latitude : \(latitude)")
        print("Longitude: \(longitude)")
        
        // Pick the location from latitude and longitude
        let centerLocation = CLLocation(latitude: latitude, longitude: longitude)
        
        // Center that location
        goToLocation(location: centerLocation)
        
        // Point it on the map with the restaurant name
        addAnnotationAtCoordinate(coordinate: centerLocation.coordinate)
        
    }
    
    // Function used to center the restaurant location
    func goToLocation(location: CLLocation) {
        let span = MKCoordinateSpanMake(0.1, 0.1)
        let region = MKCoordinateRegionMake(location.coordinate, span)
        mapView.setRegion(region, animated: false)
    }
    
    // Function used to point the restaurant on the map with restaurant's name
    func addAnnotationAtCoordinate(coordinate: CLLocationCoordinate2D) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = business.name
        mapView.addAnnotation(annotation)
    }
    
    // Function for custom back image
    @IBAction func onBack(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
}
