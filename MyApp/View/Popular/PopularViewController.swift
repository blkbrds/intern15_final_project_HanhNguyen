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
        contentView.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    @IBAction func sementControlValueChaned(_ sender: UISegmentedControl) {
        guard let videoCategory = VideoCategory(rawValue: sender.selectedSegmentIndex) else {
            return
        }
        child.viewModel = ChildPopularViewModel(videoCategory: videoCategory)
    }
}
