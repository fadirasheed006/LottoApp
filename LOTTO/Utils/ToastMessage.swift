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
extension UIView {
    
    func dropShadow(scale: Bool = true,opacity:Float = 0.1,shadowRadius:CGFloat = 1) {
      layer.masksToBounds = true
        layer.shadowColor = UIColor(named: "couponBorderColor")?.cgColor
      layer.shadowOpacity = 0.5
        layer.shadowOffset = .zero // CGSize(width: -1, height: 1)
        layer.shadowRadius = 1.0

      layer.shadowPath = UIBezierPath(rect: bounds).cgPath
      layer.shouldRasterize = true
      layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}
