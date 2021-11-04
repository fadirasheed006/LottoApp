//
//  ViewController.swift
//  mentionedUser
//
//  Created by Fahad on 14/10/2021.
//

import UIKit
import Hakawai

class ViewController: UIViewController{

    @IBOutlet weak var txtView: HKWTextView!
    
    var plugIn:HKWMentionsPlugin!
    var Model:[User] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        let mode = HKWMentionsChooserPositionMode.enclosedTop
        let cchar = CharacterSet(charactersIn:"@")
        HKWTextView.setEnableMentionsPluginV2(true)
        HKWTextView.setDirectlyUpdateQueryWithCustomDelegate(true)
        HKWTextView.setEnableControlCharactersToPrepend(true)
       var mentionPlugin:HKWMentionsPlugin!
        if (HKWTextView.enableMentionsPluginV2()) {
            mentionPlugin = HKWMentionsPluginV2.mentionsPlugin(withChooserMode: mode, controlCharacters: cchar, searchLength: 1)
        } else {
            mentionPlugin = HKWMentionsPluginV1.mentionsPlugin(withChooserMode: mode, controlCharacters: cchar, searchLength: 1)
        }
       // mentionPlugin.resumeMentionsCreationEnabled = true
       mentionPlugin.chooserViewEdgeInsets = UIEdgeInsets(top: 2, left: 0.5, bottom: 0.5, right: 0.5)
        mentionPlugin.defaultChooserViewDelegate = MentionManager.shared
        mentionPlugin.stateChangeDelegate = MentionManager.shared
        
        self.plugIn = mentionPlugin
        self.plugIn.chooserViewBackgroundColor = UIColor.clear
        self.txtView.controlFlowPlugin = mentionPlugin
       
      
    }
  
   
    @IBAction func buttonPReseed(_ sender: Any) {
        let list = self.plugIn.mentions() as? [HKWMentionsAttribute]
        for item in list ?? [] {
            let user = User(id: item.entityId(), name: item.entityName())
            Model.append(user)
        }
    }
    
}

