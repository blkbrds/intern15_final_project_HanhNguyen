//
//  IntExt.swift
//  MyApp
//
//  Created by ANH NGUYỄN on 2/13/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
extension Int {
    func getFormatText() -> String {
        var viewCount: Double = 0.0
        if self < 1_000 {
            return "\(self)"
        } else if self >= 1_000 && self < 1_000_000 {
            viewCount = Double(self) / 1_000
            return "\(Int(viewCount)) N"
        } else if self < 1_000_000_000 {
            viewCount = Double(self) / 1_000_000
            return "\(Double(round(10 * viewCount) / 10)) Tr"
        } else {
            viewCount = Double(self) / 1_000_000_000
            return "\(Double(round(10 * viewCount) / 10)) T"
        }
    }
}
