//
//  MapViewController.swift
//  MyApp
//
//  Created by MBA0258P on 2/3/21.
//  Copyright © 2021 Asian Tech Co., Ltd. All rights reserved.
//
import CoreLocation
import UIKit
import GoogleMaps
import GooglePlaces

struct MyPlace {
    var name: String
    var lat: Double
    var long: Double
}

final class MapViewController: UIViewController {

    let myMapView: GMSMapView = {
        let v = GMSMapView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    let btnMyLocation: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor.white
        btn.setImage(#imageLiteral(resourceName: "my_location"), for: .normal)
        btn.layer.cornerRadius = 25
        btn.clipsToBounds = true
        btn.tintColor = UIColor.gray
        btn.imageView?.tintColor = UIColor.gray
        btn.addTarget(self, action: #selector(btnMyLocationAction), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()

//    private let dataProvider = GoogleDataProvider()
    private let searchRadius: Double = 1000
    let currentLocationMarker = GMSMarker()
    var chosenPlace: MyPlace?
    var centerMapCoordinate: CLLocationCoordinate2D?

    let customMarkerWidth: Int = 50
    let customMarkerHeight: Int = 70
    var newAppendData = [CLLocationCoordinate2D]()
    let locationManager = CLLocationManager()
    var viewModel = MapViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Home"
        self.view.backgroundColor = UIColor.white
        myMapView.delegate = self
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.startMonitoringSignificantLocationChanges()
        setupViews()
        initGoogleMaps()
    }

    func setupViews() {
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
        view.addSubview(myMapView)
        myMapView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        myMapView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        myMapView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        myMapView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 60).isActive = true

        self.view.addSubview(btnMyLocation)
        btnMyLocation.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30).isActive = true
        btnMyLocation.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        btnMyLocation.widthAnchor.constraint(equalToConstant: 50).isActive = true
        btnMyLocation.heightAnchor.constraint(equalTo: btnMyLocation.widthAnchor).isActive = true
    }

    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print("ERROR AUTO COMPLETE \(error)")
    }

    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        self.dismiss(animated: true, completion: nil)
    }

    func initGoogleMaps() {
        let camera = GMSCameraPosition.camera(withLatitude: 28.7041, longitude: 77.1025, zoom: 14.0)
        self.myMapView.camera = camera
        self.myMapView.delegate = self
        self.myMapView.isMyLocationEnabled = true
    }

    func coordinate(from location: CLLocationCoordinate2D, to location2: CLLocationCoordinate2D) -> CLLocationDistance {
        let coordinate0 = CLLocation(latitude: location.latitude, longitude: location.longitude)
        let coordinate1 = CLLocation(latitude: location2.latitude, longitude: location2.longitude)
        let distanceInMeters = coordinate0.distance(from: coordinate1)
        return distanceInMeters
    }

    // MARK: CLLocation Manager Delegate
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error while getting location \(error)")
    }

    func showPartyMarkers(lat: Double, long: Double) {
        for i in 0..<viewModel.mydata.count {
            let marker = GMSMarker()
            if let image = UIImage(named: viewModel.mydata[i].name) {
                let customMarker = CustomMarkerView(frame: CGRect(x: 0, y: 0, width: customMarkerWidth, height: customMarkerHeight), image: image, borderColor: UIColor.darkGray, tag: i)
                marker.iconView = customMarker
                marker.position = viewModel.mydata[i].coordinates
                marker.map = self.myMapView
            }
        }
    }

    @objc func btnMyLocationAction() {
        let location: CLLocation? = myMapView.myLocation
        if let location = location {
            myMapView.animate(toLocation: location.coordinate)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.myMapView.animate(toZoom: 14.0)
            }
        }
    }

    func effectionMotion() -> UIMotionEffectGroup {
        let horizontalEffect = UIInterpolatingMotionEffect(
            keyPath: "center.x",
            type: .tiltAlongHorizontalAxis)
        horizontalEffect.minimumRelativeValue = -16
        horizontalEffect.maximumRelativeValue = 16

        let verticalEffect = UIInterpolatingMotionEffect(
            keyPath: "center.y",
            type: .tiltAlongVerticalAxis)
        verticalEffect.minimumRelativeValue = -16
        verticalEffect.maximumRelativeValue = 16

        let effectGroup = UIMotionEffectGroup()
        effectGroup.motionEffects = [ horizontalEffect,
                                      verticalEffect]
        return effectGroup
    }

    @objc func restaurantTapped(tag: Int) {
        print("DEtail")
    }

    func placeMarkerOnCenter(centerMapCoordinate: CLLocationCoordinate2D) {
        let marker = GMSMarker()
        marker.position = centerMapCoordinate
        marker.map = self.myMapView
    }
}

extension MapViewController: GMSMapViewDelegate {

    func didTapMyLocationButton(for mapView: GMSMapView) -> Bool {
        return false
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.delegate = nil
        locationManager.stopUpdatingLocation()
        guard let location = locations.last else { return }
        let lat = location.coordinate.latitude
        let long = location.coordinate.longitude
        let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: long, zoom: 14.0)
        self.myMapView.animate(to: camera)
        showPartyMarkers(lat: lat, long: long)
    }

    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
        myMapView.clear()
    }

    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        let latitude = mapView.camera.target.latitude
        let longitude = mapView.camera.target.longitude
        centerMapCoordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        guard let centerMapCoordinate = centerMapCoordinate  else {
            return
        }
        let path = GMSMutablePath()
        let radius = 1000
        for i in 0...60 {
        let offsetLocation = GMSGeometryOffset(centerMapCoordinate, CLLocationDistance(radius), CLLocationDirection(i*6))
        path.add(offsetLocation)
        }
        let length: [NSNumber] = [10, 10]
        let circle = GMSPolyline(path: path)
        let styles = [GMSStrokeStyle.solidColor(.clear), GMSStrokeStyle.solidColor(.red)]
        showPartyMarkers(lat: latitude, long: longitude)
        if let path = circle.path {
            circle.spans = GMSStyleSpans(path, styles, length, GMSLengthKind.rhumb)
            circle.strokeWidth = 1.0
            circle.map = myMapView
        }
    }
}

extension MapViewController: CLLocationManagerDelegate {
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        guard let customMarkerView = marker.iconView as? CustomMarkerView, let img = customMarkerView.imageView else { return false }
        let customMarker = CustomMarkerView(frame: CGRect(x: 0, y: 0, width: customMarkerWidth, height: customMarkerHeight), image: img, borderColor: UIColor.white, tag: customMarkerView.tag)
        marker.iconView = customMarker
        return false
    }
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        guard let customMarkerView = marker.iconView as? CustomMarkerView else { return }
        let tag = customMarkerView.tag
        restaurantTapped(tag: tag)
    }
    func mapView(_ mapView: GMSMapView, didCloseInfoWindowOf marker: GMSMarker) {
        guard let customMarkerView = marker.iconView as? CustomMarkerView, let img = customMarkerView.imageView else { return }
        let customMarker = CustomMarkerView(frame: CGRect(x: 0, y: 0, width: customMarkerWidth, height: customMarkerHeight), image: img, borderColor: UIColor.darkGray, tag: customMarkerView.tag)
        marker.iconView = customMarker
    }
}
