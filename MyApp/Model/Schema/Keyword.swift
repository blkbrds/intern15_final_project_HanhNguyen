//
//  Keyword.swift
//  MyApp
//
//  Created by ANH NGUYỄN on 2/23/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import RealmSwift
@objcMembers final class Keyword: Object {
    dynamic var keyword: String = ""
    dynamic var searchTime: Date = Date()

    init(keyword: String, searchTime: Date) {
        self.keyword = keyword
        self.searchTime = searchTime
    }

    required init() { }

    override static func primaryKey() -> String? {
      return "keyword"
    }
}
