//
//  PopularViewController.swift
//  MyApp
//
//  Created by ANH NGUYỄN on 2/7/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

final class PopularViewController: ViewController {
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var contentView: UIView!
    let child = ChildPopularViewController()
    
    var viewModel = PopularViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func setupUI() {
        super.setupUI()
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
}
