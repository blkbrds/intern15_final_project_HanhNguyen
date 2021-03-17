//
//  CustomMarkerView.swift
//  MyApp
//
//  Created by PCI0015 on 3/3/21.
//  Copyright © 2021 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import UIKit

final class CustomMarkerView: UIView {

    var imageView: UIImage?
    var borderColor: UIColor?
    init(frame: CGRect, image: UIImage, borderColor: UIColor, tag: Int) {
        super.init(frame: frame)
        self.imageView = image
        self.borderColor = borderColor
        self.tag = tag
        setupView()
    }

    func setupView() {
        let imgView = UIImageView(image: imageView)
        imgView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        imgView.layer.cornerRadius = 25
        imgView.layer.borderColor = borderColor?.cgColor
        imgView.layer.borderWidth = 1
        imgView.clipsToBounds = true
        let lbl = UILabel(frame: CGRect(x: 0, y: 45, width: 50, height: 10))
        lbl.text = "▾"
        lbl.font = UIFont.systemFont(ofSize: 24)
        lbl.textColor = borderColor
        lbl.textAlignment = .center

        self.addSubview(imgView)
        self.addSubview(lbl)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
