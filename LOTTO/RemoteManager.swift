//
//  RemoteManager.swift
//  LOTTO
//
//  Created by Fahad on 31/10/2021.
//
import Firebase
import FirebaseRemoteConfig
class RemoteConfigManager: NSObject {
    
    static var shared = RemoteConfigManager()
    
    override init() {
    }
    
    
    var remoteConfig:RemoteConfig!
    
    func intilizeRemoteConfig(){
        remoteConfig = RemoteConfig.remoteConfig()
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings
        remoteConfig.setDefaults(fromPlist: "RemoteConfigDefaults")
       fetchConfig()
    }
    
    func isWEBVIEW_ENABLE()->Bool{
        let value = RemoteConfig.remoteConfig().configValue(forKey: "IS_WEBVIEW").stringValue
        return Bool(value ?? "false")!
    }
    
    func getAPP_MODE()->String{
       // return "4"
       return RemoteConfig.remoteConfig().configValue(forKey: "APP_MODE").stringValue ?? "0"
    }
    
    func getUrlType()->String{
        let value = getAPP_MODE()
        if value == "0"{
           let url0 = RemoteConfig.remoteConfig().configValue(forKey: "URL_0").stringValue ?? "bad url"
            return url0
        }else if value == "1"{
            let url1 = RemoteConfig.remoteConfig().configValue(forKey: "URL_1").stringValue ?? "bad url"
             print(url1)
             return url1
        }else{
            return ""
        }
   }
    
    func fetchConfig(){
       
        remoteConfig.fetch() { (status, error) -> Void in
          if status == .success {
            print("Config fetched!")
            self.remoteConfig.activate() { (changed, error) in
              print(self.getAPP_MODE())
                print(self.getUrlType())
                print(self.isWEBVIEW_ENABLE())
                //print(changed)
                
//                print(RemoteConfig.remoteConfig().configValue(forKey: "APP_MODE").stringValue)
                
            }
          } else {
            print("Config not fetched")
            print("Error: \(error?.localizedDescription ?? "No error available.")")
          }
        }
    }
    
}
