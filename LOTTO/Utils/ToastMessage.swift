//
//  ToastMessage.swift
//  LOTTO
//
//  Created by Fahad on 02/11/2021.
//

import Foundation
import SwiftMessages

class ToastMessages: SwiftMessages {

    static func showMessage(message: String, theme: Theme, duration: Duration = .automatic,title:String) {
    
        var config: SwiftMessages.Config = SwiftMessages.defaultConfig
        config.duration = duration
        config.presentationStyle = .top
        SwiftMessages.show(config: config) { () -> UIView in
            let view = MessageView.viewFromNib(layout: .cardView)
            view.button?.isHidden = true
            view.configureTheme(theme)
            view.configureDropShadow()
          
          
            view.configureContent(title: title, body: message)
            

            
            return view

        }
        

    }

}
