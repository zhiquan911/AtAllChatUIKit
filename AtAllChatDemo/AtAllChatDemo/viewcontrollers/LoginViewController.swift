//
//  LoginViewController.swift
//  AtAllChatDemo
//
//  Created by Chance on 2017/11/20.
//  Copyright © 2017年 blocktree. All rights reserved.
//

import UIKit
import AIChatKit
import SVProgressHUD
import AIPushKit
import AIPushDepOCKit

class LoginViewController: UIViewController {
    
    @IBOutlet var buttonLiLei: UIButton!
    @IBOutlet var buttonHanMeimei: UIButton!
    
    lazy var users: [AIUserInfo] = {
        return GetUsers()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    @IBAction func handleLoginPress(sender: UIButton) {
        var user: AIUserInfo
        if sender === buttonLiLei {
            user = self.users[0]
        } else {
            user = self.users[1]
        }
        
        
        SVProgressHUD.show()
        AIChat.login(user: user) {
            (flag, result) in
            if flag {
                SVProgressHUD.dismiss()
                let vc = ContactsViewController()
                vc.userkey = user.userkey
                vc.title = user.nickname
                self.navigationController?.pushViewController(vc, animated: true)
            } else {
                SVProgressHUD.showError(withStatus: "出错")
            }
        }
    }

}
