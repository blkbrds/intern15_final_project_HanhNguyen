//
//  ViewController.swift
//  MyApp
//
//  Created by iOSTeam on 2/21/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupData()
    }

    func setupUI() {
        navigationController?.navigationBar.backgroundColor = .brown
        navigationController?.navigationBar.isTranslucent = false
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
        let logo = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
        logo.image = #imageLiteral(resourceName: "ic-logo-youtube.png")
        leftView.addSubview(logo)
        let leftBarButton = UIBarButtonItem(customView: leftView)
        self.navigationItem.leftBarButtonItem = leftBarButton

        let searchButton = UIButton(type: .custom)
        searchButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let image = #imageLiteral(resourceName: "ic-search").withRenderingMode(.alwaysTemplate)
        searchButton.setImage(image, for: .normal)
        searchButton.tintColor = #colorLiteral(red: 0.3764705882, green: 0.3764705882, blue: 0.3764705882, alpha: 1)
        searchButton.addTarget(self, action: #selector(searchButtonTouchUpInside), for: .allEvents)

        let accountButton = UIButton(type: .custom)
        accountButton.frame = CGRect(x: 50, y: 0, width: 30, height: 30)
        accountButton.setImage(#imageLiteral(resourceName: "avatar"), for: .normal)
        accountButton.contentMode = UIView.ContentMode.scaleAspectFit
        accountButton.layer.cornerRadius = 15
        accountButton.layer.masksToBounds = true
        accountButton.addTarget(self, action:
                #selector(accountTouchUpInside), for: .allEvents)

        let rightView = UIView(frame: CGRect(x: 0, y: 0, width: 80, height: 30))
        rightView.addSubview(searchButton)
        rightView.addSubview(accountButton)

        let rightBarButtonItem = UIBarButtonItem(customView: rightView)
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }

    @objc func searchButtonTouchUpInside() {

    }

    @objc func accountTouchUpInside() {

    }

    func setupData() { }

}
