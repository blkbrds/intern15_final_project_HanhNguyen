//
//  DateExt.swift
//  MyApp
//
//  Created by ANH NGUYỄN on 2/8/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

extension Date {
    func string(withFormat format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }

    func startOfDate() -> Date {
        let current = Calendar.current
        return current.startOfDay(for: self)
    }
}
