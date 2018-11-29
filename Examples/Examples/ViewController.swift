//
//  ViewController.swift
//  Examples
//
//  Created by Alex Melnichuk on 11/12/18.
//  Copyright © 2018 Baltic International Group OU. All rights reserved.
//

import UIKit
import PaytomatSDK

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func didTapLogin(_ sender: Any) {
        let request = PaytomatSDK.LoginRequest(appName: "Examples",
                                               appIcon: "http://daramghaus.github.io/icontester/images/iTunesArtwork.png",
                                               appVersion: "1.0",
                                               appDescription: "Example description",
                                               uuID: "test-uuid",
                                               loginUrl: nil,
                                               callbackUrl: "PaytomatSDKExamples://eos.io")
        PaytomatSDK.shared.login(request: request)
    }
    
    @IBAction func didTapTransfer(_ sender: Any) {
        let request = PaytomatSDK.TransferRequest(appName: "Examples",
                                                  appIcon: "http://daramghaus.github.io/icontester/images/iTunesArtwork.png",
                                                  appVersion: "1.0",
                                                  appDescription: "Example description",
                                                  to: "metcondition",
                                                  amount: 0.0001,
                                                  contract: "eosio.token",
                                                  symbol: "EOS",
                                                  precision: 4,
                                                  memo: nil,
                                                  callbackUrl: "PaytomatSDKExamples://eos.io")
        PaytomatSDK.shared.transfer(request: request)
    }
    
    
}

