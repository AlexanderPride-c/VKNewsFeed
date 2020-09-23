//
//  ViewController.swift
//  VKNewsFeed
//
//  Created by Александр Прайд on 23.09.2020.
//  Copyright © 2020 Alexander Pride. All rights reserved.
//

import UIKit

class AuthViewController: UIViewController {

    private var autSrv: AuthService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        autSrv = SceneDelegate.shared().authServ
    }

    @IBAction func signInTouch(_ sender: UIButton) {
        autSrv.wakeUpSession()
    }
    
}

