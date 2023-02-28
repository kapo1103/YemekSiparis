//
//  SiparisSonuc.swift
//  YemekSiparis
//
//  Created by Ethem Fatih Hocaoğlu on 27.02.2023.
//

import UIKit
import CoreLocation
import MapKit
import Lottie

class SiparisSonuc: UIViewController {

    @IBOutlet weak var animationViewSiparis: LottieAnimationView!
    
    @IBOutlet weak var labelHiz: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.desiredAccuracy = kCLLocationAccuracyBest //lokasyon kalitesi
        locationManager.requestWhenInUseAuthorization() //lokasyon izni
        locationManager.startUpdatingLocation() //lokasyon güncelleme
        
        locationManager.delegate = self
        
        animationViewSiparis = .init(name: "siparis")
        animationViewSiparis!.frame = view.bounds
        animationViewSiparis!.contentMode = .scaleAspectFit
        animationViewSiparis!.animationSpeed = 1
        view.addSubview(animationViewSiparis!)
        animationViewSiparis!.loopMode = .playOnce
        animationViewSiparis!.play(completion: { ( finished) in
            if finished { //animasyon bitince durdurma
                self.animationViewSiparis.isHidden = true
            }
        })
    }
}


extension SiparisSonuc : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) { // bütün konumları hafızasında tutmaya çalışır
        let sonKonum = locations[locations.count-1]
        
        let enlem = sonKonum.coordinate.latitude
        let boylam = sonKonum.coordinate.longitude
        labelHiz.text = "\(sonKonum.speed)"
        
        let konum = CLLocationCoordinate2D(latitude: enlem, longitude: boylam)
        let span = MKCoordinateSpan(latitudeDelta: 0.002, longitudeDelta: 0.002) //yakınlaştırma
        let bolge = MKCoordinateRegion(center: konum, span: span)
        
        mapView.setRegion(bolge, animated: true)
        
        let pin = MKPointAnnotation()
        pin.coordinate = konum
        pin.title = "Kurye"
        
        mapView.addAnnotation(pin)
        
        mapView.showsUserLocation = true
    }
}
