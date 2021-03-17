//
//  MapViewModel.swift
//  MyApp
//
//  Created by PCI0015 on 3/5/21.
//  Copyright © 2021 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import GoogleMaps
final class MapViewModel {
    let mydata: [SPlace] = [SPlace(name: "Icon-60", address: "N 36th St", coordinates: CLLocationCoordinate2D(latitude: 16.08069483524283, longitude: 108.2207137628257)),
                  SPlace(name: "Icon-60", address: "N 36th St", coordinates: CLLocationCoordinate2D(latitude: 16.08069483524283, longitude: 108.2207137628257)),
                  SPlace(name: "Icon-60", address: "N 36th St", coordinates: CLLocationCoordinate2D(latitude: 16.079107236168028, longitude: 108.2224303765897)),
                  SPlace(name: "Icon-60", address: "N 36th St", coordinates: CLLocationCoordinate2D(latitude: 16.077931992321805, longitude: 108.22185101944436)),
                  SPlace(name: "Icon-60", address: "N 36th St", coordinates: CLLocationCoordinate2D(latitude: 16.07646808237504, longitude: 108.21858945329274)),
                  SPlace(name: "Icon-60", address: "N 36th St", coordinates: CLLocationCoordinate2D(latitude: 16.076385608254466 , longitude: 108.21850362260453)),
                  SPlace(name: "Icon-60", address: "N 36th St", coordinates: CLLocationCoordinate2D(latitude: 16.076188988205853, longitude: 108.21846948481989)),
                  SPlace(name: "Icon-60", address: "N 36th St", coordinates: CLLocationCoordinate2D(latitude: 16.075177893136605, longitude: 108.22029165846958)),
                  SPlace(name: "Icon-60", address: "Orlando, FL, United States", coordinates: CLLocationCoordinate2D (latitude: 16.07359958811722, longitude: 108.21904693421592)),
                  SPlace(name: "Icon-60", address: "Orlando, FL, United States", coordinates: CLLocationCoordinate2D(latitude: 16.073991029473117, longitude: 108.22157172390595)),
                  SPlace(name: "Icon-60", address: "Orlando, FL, United States", coordinates: CLLocationCoordinate2D(latitude: 16.07343612584393, longitude: 108.22457461708753)),
                  SPlace(name: "Icon-60", address: "Orlando, FL, United States", coordinates: CLLocationCoordinate2D(latitude: 16.07283960271552, longitude: 108.2166198375536)),
                  SPlace(name: "Icon-60", address: "Arizona, United States", coordinates: CLLocationCoordinate2D(latitude: 16.066363474057603, longitude: 108.22977431967507)) ,
                  SPlace(name: "Icon-60", address: "Arizona, United States", coordinates: CLLocationCoordinate2D(latitude: 16.06489691923164, longitude: 108.23124891872793)),
                  SPlace(name: "Icon-60", address: "Arizona, United States", coordinates: CLLocationCoordinate2D(latitude: 16.067146292816297, longitude: 108.22955777016381)) ,
                  SPlace(name: "Icon-60", address: "Arizona, United States", coordinates: CLLocationCoordinate2D(latitude: 16.067304838012568, longitude: 108.2342290524781)) ,
                  SPlace(name: "Icon-60", address: "Arizona, United States", coordinates: CLLocationCoordinate2D(latitude: 16.06404472700206, longitude: 108.2348580772489)),
                  SPlace(name: "Icon-60", address: "Arizona, United States", coordinates: CLLocationCoordinate2D(latitude: 16.082723309510357, longitude: 108.22914299630173)) ,
                  SPlace(name: "Icon-60", address: "Arizona, United States", coordinates: CLLocationCoordinate2D(latitude: 16.083883179155304, longitude: 108.22221691926359)),
                  SPlace(name: "Icon-60", address: "Arizona, United States", coordinates: CLLocationCoordinate2D(latitude: 16.080517637083094, longitude: 108.23620759488065)) ,
                  SPlace(name: "Icon-60", address: "Arizona, United States", coordinates: CLLocationCoordinate2D(latitude: 16.073634260590275, longitude: 108.23832499557517)) ,
                  SPlace(name: "Icon-60", address: "Arizona, United States", coordinates: CLLocationCoordinate2D(latitude: 16.08646507574862, longitude: 108.23625774027431))
    ]
}
