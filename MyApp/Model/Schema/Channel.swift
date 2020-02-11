//
//  Channel.swift
//  MyApp
//
//  Created by ANH NGUYỄN on 2/7/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import ObjectMapper
final class Channel: Mappable {
    var id: String = ""
    var imageURL: String = "https://images.unsplash.com/photo-1537815749002-de6a533c64db?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=545&q=80"
    var name: String = ""

    init() { }

    init?(map: Map) { }

    func mapping(map: Map) { }
}
