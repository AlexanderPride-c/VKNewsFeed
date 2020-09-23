//
//  AuthServ.swift
//  VKNewsFeed
//
//  Created by Александр Прайд on 23.09.2020.
//  Copyright © 2020 Alexander Pride. All rights reserved.
//

import Foundation
import VKSdkFramework

protocol AuthServiceDelegate: class {
    func authServiceShouldShow(_ viewController: UIViewController)
    func authServiceSignIn()
    func authServiceDidSignInFail()
}

class AuthService: NSObject, VKSdkDelegate, VKSdkUIDelegate {

    private var appId = "7606369"
    private var vkSdk: VKSdk
    
    override init() {
        vkSdk = VKSdk.initialize(withAppId: appId)
        super.init()
        print("VKSdk.initialize")
        vkSdk.register(self)
        vkSdk.uiDelegate = self
        
    }
    
    weak var delegate: AuthServiceDelegate?
    
    func wakeUpSession() {
        let scope = ["offline"]
        VKSdk.wakeUpSession(scope) { [delegate](state, error) in
            switch state {
            case .authorized:
                print("authorized")
                delegate?.authServiceSignIn()
            case .initialized:
                print("initialized")
                VKSdk.authorize(scope)
            default:
                delegate?.authServiceDidSignInFail()
                fatalError(error!.localizedDescription)
            }
        }
    }
    
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        print(#function)
        if result.token != nil {
            delegate?.authServiceSignIn()
        } else {
            print(result.error.localizedDescription)
        }
        
    }
    
    func vkSdkUserAuthorizationFailed() {
        print(#function)
        //delegate?.AuthServiceSignInDidFaile()
    }
    
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        print(#function)
        delegate?.authServiceShouldShow(controller)
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        print(#function)
    }
    
}
