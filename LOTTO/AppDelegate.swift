//
//  AppDelegate.swift
//  LOTTO
//
//  Created by Fahad on 31/10/2021.
//
func delay(_ delay:Double, closure:@escaping ()->()) {
    let when = DispatchTime.now() + delay
    DispatchQueue.main.asyncAfter(deadline: when, execute: closure)
}


import UIKit
import Firebase
import FirebaseMessaging
@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate, MessagingDelegate {

    var window:UIWindow?
    var navigaitonController = UINavigationController()


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
       
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UIStoryboard(name: "LaunchScreen", bundle: nil).instantiateInitialViewController()
              window?.makeKeyAndVisible()
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
        registerForPushNotification(application: application)
        RemoteConfigManager.shared.intilizeRemoteConfig()
        delay(3.0) {
            self.setUpScreen()
        }
       
        return true
    }

    func registerForPushNotification(application:UIApplication){
        if #available(iOS 10.0, *) {
          // For iOS 10 display notification (sent via APNS)
          UNUserNotificationCenter.current().delegate = self

          let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
          UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: { _, _ in }
          )
        } else {
          let settings: UIUserNotificationSettings =
            UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
          application.registerUserNotificationSettings(settings)
        }
        application.registerForRemoteNotifications()
        retriveToken()

    }
    
    func retriveToken() {
        Messaging.messaging().token { token, error in
            if let error = error {
                print("Error fetching FCM registration token: \(error)")
            } else if let token = token {                print("FCM registration token: \(token)")
                print("Remote FCM registration token: \(token)")
            }
        }
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("APNs token retrieved: \(deviceToken)")
        // With swizzling disabled you must set the APNs token here.
        Messaging.messaging().apnsToken = deviceToken
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("Firebase registration token: \(String(describing: fcmToken))")
        
        let dataDict:[String: String] = ["token": fcmToken ?? ""]
        NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
        // TODO: If necessary send token to application server.
        // Note: This callback is fired at each app startup and whenever a new token is generated.
        if let token = fcmToken {
           
        }
    }

    
    func setUpScreen(){
        if RemoteConfigManager.shared.getAPP_MODE() == "0"{
            if RemoteConfigManager.shared.isWEBVIEW_ENABLE(){
               let mainStoryboard = UIStoryboard(name: "Main" , bundle: nil)
               let servicePage = mainStoryboard.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
               navigaitonController = UINavigationController(rootViewController: servicePage)
                        window!.rootViewController = navigaitonController
                        window!.makeKeyAndVisible()
            }else{
                let mainStoryboard = UIStoryboard(name: "Main" , bundle: nil)
                let servicePage = mainStoryboard.instantiateViewController(withIdentifier: "BrowserViewController") as! BrowserViewController
                navigaitonController = UINavigationController(rootViewController: servicePage)
                         window!.rootViewController = navigaitonController
                         window!.makeKeyAndVisible()
                
                if  let url = URL(string:RemoteConfigManager.shared.getUrlType()) {
                       UIApplication.shared.open(url)
                }
            }
        }
    else if RemoteConfigManager.shared.getAPP_MODE() == "4"{
         let mainStoryboard = UIStoryboard(name: "Main" , bundle: nil)
         let servicePage = mainStoryboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
         navigaitonController = UINavigationController(rootViewController: servicePage)
                  window!.rootViewController = navigaitonController
                  window!.makeKeyAndVisible()
     }else if RemoteConfigManager.shared.getAPP_MODE() == "1"{
         if RemoteConfigManager.shared.isWEBVIEW_ENABLE(){
            let mainStoryboard = UIStoryboard(name: "Main" , bundle: nil)
            let servicePage = mainStoryboard.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
            navigaitonController = UINavigationController(rootViewController: servicePage)
                     window!.rootViewController = navigaitonController
                     window!.makeKeyAndVisible()
         }else{
             let mainStoryboard = UIStoryboard(name: "Main" , bundle: nil)
             let servicePage = mainStoryboard.instantiateViewController(withIdentifier: "BrowserViewController") as! BrowserViewController
             navigaitonController = UINavigationController(rootViewController: servicePage)
                      window!.rootViewController = navigaitonController
                      window!.makeKeyAndVisible()
             
             if  let url = URL(string:RemoteConfigManager.shared.getUrlType()) {
                    UIApplication.shared.open(url)
             }
         }
     }
                                            
        
    }


}

