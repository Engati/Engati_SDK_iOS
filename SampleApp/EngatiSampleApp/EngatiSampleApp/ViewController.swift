//
//  ViewController.swift
//  EngatiSampleApp
//
//  Created by Mayur Kothawade on 17/07/19.
//  Copyright © 2019 Mayur Kothawade. All rights reserved.
//

import UIKit
import EngatiChat
import Alamofire

class ViewController: UITableViewController, UITextFieldDelegate, CVSDKEngatiBotCallBack {
    
    

    enum LaunchMode: String, CaseIterable {
        case push = "Push"
        case present = "Present"
        case popup = "Popup"
    }
    
    var currentLaunchMode : LaunchMode = .push
    @IBOutlet weak var botKeyField: UITextField!
    @IBOutlet weak var botNameField: UITextField!
    @IBOutlet weak var botUserIdField: UITextField!
    
    @IBOutlet weak var doneButtonEnabled: UISwitch!
    @IBOutlet weak var chatHistoryLimitField: UITextField!
    @IBOutlet weak var rtlButtonEnabled: UISwitch!
    @IBOutlet weak var launchModeLabel: UILabel!
    var chatController : ENSDKChatViewController?
    var containerView : UIView?
    
    @IBAction func changeLaunchMode(_ sender: Any) {
        let alertController = UIAlertController(title: "Luanch Mode", message: "Please select the chat launch mode", preferredStyle: .actionSheet)
        LaunchMode.allCases.forEach { (launchMode) in
            alertController.addAction(UIAlertAction(title: launchMode.rawValue, style: .default, handler: { (action) in
                self.currentLaunchMode = LaunchMode(rawValue: action.title!)!
                self.launchModeLabel.text = "Launch Mode : \(self.currentLaunchMode.rawValue)"
            }))
        }
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func initiateChat(_ sender: Any) {
        var aBotKey = "7b2f8fe62c8d4176"
        var aBotName = "Engati Secure"
        var aBotUserID = "jgcjghcj"
        var aChatHistoryLimitInInt = 10
        if let botKey = botKeyField.text, !botKey.isEmpty {
            aBotKey = botKey
        }
        if let botName = botNameField.text, !botName.isEmpty {
            aBotName = botName
        }
        if let botUserID = botNameField.text, !botUserID.isEmpty {
            aBotUserID = botUserID
        }
        if let chatHistoryLimit = chatHistoryLimitField.text, !chatHistoryLimit.isEmpty, let chatHistoryLimitInInt = Int(chatHistoryLimit) {
            aChatHistoryLimitInInt = chatHistoryLimitInInt
        }
        let chatDoneButtonEnabled = doneButtonEnabled.isOn
        let rtlEnabled = rtlButtonEnabled.isOn
        
        let chatConfig = ENSDKChatConfig.init(botKey: aBotKey, botName: aBotName, userId: aBotUserID, chatHistorySize: aChatHistoryLimitInInt, showDone: chatDoneButtonEnabled, language:rtlEnabled ? ENSDKChatConfig.CVSDKLanguage.rtl : ENSDKChatConfig.CVSDKLanguage.default, sendMessageButtonIcon: #imageLiteral(resourceName: "exit_ico"))
        
        
        self.botKeyField.resignFirstResponder()
        self.botNameField.resignFirstResponder()
        self.botUserIdField.resignFirstResponder()
        self.chatHistoryLimitField.resignFirstResponder()
        chatController = ENSDKChatViewController.init(chatConfig: chatConfig, callBackDelegate: self)
        if let chatController = self.chatController {
            DispatchQueue.main.async {
                switch self.currentLaunchMode {
                case .push:
                    if let parentController = self.parent?.parent { parentController.navigationController?.pushViewController(chatController, animated: true)
                    }
                case .present:
                    if let parentController = self.parent?.parent {
                        parentController.present(UINavigationController(rootViewController: chatController) , animated: true, completion: nil)
                    }
                case .popup:
                    if let parentController = self.parent?.parent, let containerView = self.parent?.parent?.view.viewWithTag(9999) {
                        let nav = UINavigationController(rootViewController: chatController)
                        nav.view.frame = containerView.bounds
                        containerView.layer.borderWidth = 2.0
                        containerView.layer.borderColor = UIColor.black.cgColor
                        containerView.addSubview(nav.view)
                        parentController.addChild(nav)
                        containerView.isHidden = false
                    }
                    
                }
            }
        }
    }
    
    func didCloseEngati(_ withInfo: Any?) {
        if currentLaunchMode == .popup {
            chatController?.view.removeFromSuperview()
            chatController?.removeFromParent()
            self.containerView?.isHidden = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String, let build = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String {
            self.navigationItem.title = "\(version)(\(build))"
        }
        containerView = self.parent?.parent?.view.viewWithTag(9999)
        self.containerView?.isHidden = true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}

