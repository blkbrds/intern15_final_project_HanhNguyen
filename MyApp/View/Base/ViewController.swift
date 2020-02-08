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
