//
//  SPlace.swift
//  MyApp
//
//  Created by PCI0015 on 3/5/21.
//  Copyright © 2021 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import GoogleMaps

final class SPlace {
    var name: String = ""
    var address: String?
    var coordinates: CLLocationCoordinate2D

    init(name: String = "", address: String, coordinates: CLLocationCoordinate2D) {
        self.name = name
        self.address = address
        self.coordinates = coordinates
    }
}
