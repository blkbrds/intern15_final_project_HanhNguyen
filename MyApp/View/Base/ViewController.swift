//
//  ViewController.swift
//  MyApp
//
//  Created by iOSTeam on 2/21/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit
import GoogleAPIClientForREST
import GoogleSignIn

class ViewController: UIViewController {
    private let scopes = [kGTLRAuthScopeYouTubeReadonly]
    private let service = GTLRYouTubeService()
    let signInButton = GIDSignInButton()
    let output = UITextView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupData()
        // Configure Google Sign-in.
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().scopes = scopes
        GIDSignIn.sharedInstance().signInSilently()

        // Add the sign-in button.
        view.addSubview(signInButton)

        // Add a UITextView to display output.
        output.frame = view.bounds
        output.isEditable = false
        output.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
        output.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        output.isHidden = true
        view.addSubview(output)
    }

    // List up to 10 files in Drive
        func fetchChannelResource() {
            let query = GTLRYouTubeQuery_ChannelsList.query(withPart: "snippet,statistics")
            query.identifier = "UC_x5XG1OV2P6uZZ5FSM9Ttw"
            service.executeQuery(query,
                                 delegate: self,
                                 didFinish: #selector(displayResultWithTicket(ticket:finishedWithObject:error:)))
        }

        // Process the response and display output
    @objc func displayResultWithTicket(
            ticket: GTLRServiceTicket,
            finishedWithObject response: GTLRYouTube_ChannelListResponse,
            error: NSError?
        ) {
            if let error = error {
                alert(title: "Error", msg: error.localizedDescription, buttons: ["OK"], handler: nil)
                return
            }
            navigationItem.rightBarButtonItems?.removeFirst()
        }

    func setupUI() {
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

extension ViewController: GIDSignInDelegate, GIDSignInUIDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
              withError error: Error!) {
        if error != nil {
            self.service.authorizer = nil
        } else {
            self.service.authorizer = user.authentication.fetcherAuthorizer()
            fetchChannelResource()
//            UserDefaults.standard.set(user.authentication.accessToken, forKey: "youtubeAccessToken")
        }
    }
}
