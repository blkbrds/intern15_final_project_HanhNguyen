//
//  UIImageViewExt.swift
//  MyApp
//
//  Created by ANH NGUYỄN on 2/8/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

extension UIImageView {
    func setImage(url: String, defaultImage: UIImage = UIImage()) {
        guard let url = URL(string: url) else {
            self.image = defaultImage
            return
        }
        self.kf.setImage(with: url)
    }
}
