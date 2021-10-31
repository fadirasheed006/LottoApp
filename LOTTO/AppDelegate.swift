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
@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window:UIWindow?
    var navigaitonController = UINavigationController()


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
       
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UIStoryboard(name: "LaunchScreen", bundle: nil).instantiateInitialViewController()
              window?.makeKeyAndVisible()
        FirebaseApp.configure()
        RemoteConfigManager.shared.intilizeRemoteConfig()
        delay(3.0) {
            self.setUpScreen()
        }
       
        return true
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

