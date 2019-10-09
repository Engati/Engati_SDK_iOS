# Engati_SDK_iOS
Engati SDK for iOS
Setup Engati Chat in iOS

<b>01</b>

Open Deploy section of https://app.engati.com/
Click on the Website chatbot tab, where you will get to see Website widget  script. 
Initialization script will be like following:

<br>
<br>
EngtChat.init({"bot_key": "<bot_key>", "e":"p", "bot_name":"<bot_name>","welcome_msg":true, "branding_key":"<branding_key>" });


Note down down bot_key, bot_name and branding_key from that initialization script

<b>02</b>
Initialize using pod

Add following to podfile<br>
<b>pod 'EngatiChat'<b/>

And then
pod install


<b>03</b>

Add following framework to iOS project if not added already:
AVFoundation
UIKit


<b>04</b>

Use EngatiChat

Import EngatiChat from where you want to initiate chat screen:

import EngatiChat

Use bot_key and bot_name from step 1 to initialize ENSDKChatConfig class

let chatConfig = ENSDKChatConfig.init(botKey: "bot_key", botName: "bot_name", brandingKey: "branding_key", userId: “anyUserId”, chatHistorySize: 100, showDone: true/false, language = .default/.rtl, headerTitleFont: UIFont(name: "Helvetica", size: 15), headerDescriptionFont: UIFont(name: "Helvetica", size: 15), sendMessageButtonIcon: UIImage(named:”your_image”))

Initialize ChatController :
let chatController = ENSDKChatViewController.init(chatConfig: chatConfig, callBackDelegate: self) // self: UIViewController which confirms to “CVSDKEngatiBotCallBack” protocol

public protocol CVSDKEngatiBotCallBack {
    func didCloseEngati(_ withInfo: Any?)
}

From current controller:
- push chat controller
self.navigationController?.pushViewController(chatController, animated: true)
- present chat controller
self.present(UINavigationController(rootViewController: chatController), animated: true, completion: nil)
- popup chat controller
Create a “containerView”
let cvc = UINavigationController(rootViewController: chatController)
cvc.view.frame = containerView.bounds
        	containerView.addSubview(cvc.view)
self.addChild(cvc)
cvc?.didMove(toParent: self)

In didCloseEngati() - (to close the bot) 
cvc?.willMove(toParent: nil)   
cvc?.view.removeFromSuperview()
cvc?.removeFromParent()



Note: If you are serving images or media content(any of path node or carousel image) from non secure source(non https) then please add following to application’s info.plist file:

<key>NSAppTransportSecurity</key>
<dict>
<key>NSAllowsArbitraryLoads</key>
<true/>
</dict>



Or add respective domain url list as NSExceptionDomains.

For more details on setting up exception domains pls check:
https://developer.apple.com/library/content/documentation/General/Reference/InfoPlistKeyReference/Articles/CocoaKeys.html#//apple_ref/doc/uid/TP40009251-SW35
 


For uploading File from bot using Camera, Photo Library and Files,  add the following to application’s info.plist file:
<key>LSSupportsOpeningDocumentsInPlace</key>
	<true/>
	<key>NSPhotoLibraryUsageDescription</key>
	<string>To upload image into bot</string>
	<key>NSCameraUsageDescription</key>
	<string>To upload picture in bot</string>

To support all the fonts, add the following keys to application’s info.plist file:
	<key>UIAppFonts</key>
	<array>
		<string>Calibri.ttf</string>
		<string>Roboto-Regular.ttf</string>
		<string>Roboto-Light.ttf</string>
		<string>Garamond.ttf</string>
		<string>Garamond Light.ttf</string>
		<string>IndieFlower-Regular.ttf</string>
	</array>

And add the corresponding ttf files in application


Please find below the demo app for chat sdk:

https://s3.ap-south-1.amazonaws.com/branding-resources/bot-sdk/iOS/1.4.0/EngatiSampleApp.zip


