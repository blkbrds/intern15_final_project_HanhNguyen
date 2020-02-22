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
    private let buttonBar = UIView()
    let child = ChildPopularViewController()

    var viewModel = PopularViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func setupUI() {
        super.setupUI()
        configSegmentControlUI()
        addChild(child)
        contentView.addSubview(child.view)
        child.didMove(toParent: self)
    }

    @IBAction func sementControlValueChaned(_ sender: UISegmentedControl) {
        UIView.animate(withDuration: 0.3, animations: {
            self.buttonBar.frame.origin.x = (self.segmentControl.frame.width / CGFloat(self.segmentControl.numberOfSegments)) * CGFloat(self.segmentControl.selectedSegmentIndex)
        }) { [weak self] _ in
            guard let this = self, let videoCategory = VideoCategory(rawValue: sender.selectedSegmentIndex) else {
                return
            }
            this.child.viewModel = ChildPopularViewModel(videoCategory: videoCategory)
        }
    }

    
    private func configSegmentControlUI() {
        segmentControl.backgroundColor = #colorLiteral(red: 0.06447852011, green: 0.09186394825, blue: 0.2959798357, alpha: 1)
        if #available(iOS 13.0, *) {
            self.segmentControl.selectedSegmentTintColor = .clear
        }
        segmentControl.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor.white
            ], for: .normal)

        segmentControl.setTitleTextAttributes([            NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.9960784314, green: 0, blue: 0, alpha: 1)
            ], for: .selected)

        buttonBar.translatesAutoresizingMaskIntoConstraints = false
        buttonBar.backgroundColor = #colorLiteral(red: 0.9960784314, green: 0, blue: 0, alpha: 1)
        view.addSubview(buttonBar)
        // Constrain the top of the button bar to the bottom of the segmented control
        buttonBar.topAnchor.constraint(equalTo: segmentControl.bottomAnchor).isActive = true
        buttonBar.heightAnchor.constraint(equalToConstant: 3).isActive = true
        // Constrain the button bar to the left side of the segmented control
        buttonBar.leftAnchor.constraint(equalTo: segmentControl.leftAnchor).isActive = true
        // Constrain the button bar to the width of the segmented control divided by the number of segments
        buttonBar.widthAnchor.constraint(equalTo: segmentControl.widthAnchor, multiplier: 1 / CGFloat(segmentControl.numberOfSegments)).isActive = true
    }
}
