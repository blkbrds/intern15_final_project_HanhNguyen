//
//  PopularViewController.swift
//  MyApp
//
//  Created by ANH NGUYỄN on 2/7/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

final class PopularViewController: ViewController {

    @IBOutlet  private weak var segmentControl: UISegmentedControl!
    @IBOutlet private weak var contentView: UIView!
    private var buttonBar: UIView!
    private var pageViewController: UIPageViewController!
    private var rootViewControllers: [ChildPopularViewController] = []

    var viewModel = PopularViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func setupUI() {
        super.setupUI()
        configSegmentControlUI()
        configRootViewControllers()
        configPageViewController()
    }

    private func configSegmentControlUI() {
        segmentControl.backgroundColor = #colorLiteral(red: 0.06274509804, green: 0.09019607843, blue: 0.2941176471, alpha: 1)
        if #available(iOS 13.0, *) {
            self.segmentControl.selectedSegmentTintColor = .clear
        }
        segmentControl.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor.white
            ], for: .normal)

        segmentControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.996_078_431_4, green: 0, blue: 0, alpha: 1)
            ], for: .selected)

        buttonBar = UIView()
        buttonBar.translatesAutoresizingMaskIntoConstraints = false
        buttonBar.backgroundColor = #colorLiteral(red: 0.9960784314, green: 0, blue: 0, alpha: 1)
        view.addSubview(buttonBar)
        buttonBar.topAnchor.constraint(equalTo: segmentControl.bottomAnchor).isActive = true
        buttonBar.heightAnchor.constraint(equalToConstant: 3).isActive = true
        buttonBar.leftAnchor.constraint(equalTo: segmentControl.leftAnchor).isActive = true
        buttonBar.widthAnchor.constraint(equalTo: segmentControl.widthAnchor, multiplier: 1 / CGFloat(segmentControl.numberOfSegments)).isActive = true
    }

    private func configPageViewController() {
        pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)

        pageViewController.view.frame = contentView.bounds

        pageViewController.setViewControllers([rootViewControllers[0]], direction: .reverse, animated: false, completion: nil)
        contentView.addSubview(pageViewController.view)
        addChild(pageViewController)
        pageViewController.didMove(toParent: self)
    }

    private func configRootViewControllers() {
        for category in VideoCategory.allCases {
            let vc = ChildPopularViewController()
            vc.viewModel = ChildPopularViewModel(videoCategory: category)
            rootViewControllers.append(vc)
        }
    }

    @IBAction func sementControlValueChaned(_ sender: UISegmentedControl) {
        UIView.animate(withDuration: 0.3,
                       animations: {
                        var x: CGFloat = 0
                        if self.segmentControl.selectedSegmentIndex != 0 {
                            x = 10
                        } else {
                            x = 0
                        }
                        self.buttonBar.frame.origin.x = (self.segmentControl.frame.width / CGFloat(self.segmentControl.numberOfSegments)) * CGFloat(self.segmentControl.selectedSegmentIndex) + x
        }, completion: { [weak self] _ in
            guard let this = self else {
                return
            }
            let vc = this.rootViewControllers[sender.selectedSegmentIndex]
            this.pageViewController.setViewControllers([vc], direction: .reverse, animated: false, completion: nil)
        })
    }
}
