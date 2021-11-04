//
//  MentionManager.swift
//  mentionedUser
//
//  Created by Fahad on 04/11/2021.
//

import UIKit
import Hakawai
class MentionManager: NSObject {
 static let shared = MentionManager()
}

extension MentionManager:HKWMentionsStateChangeDelegate,HKWMentionsDefaultChooserViewDelegate{
    func asyncRetrieveEntities(forKeyString keyString: String, searchType type: HKWMentionsSearchType, controlCharacter character: unichar, completion completionBlock: (([Any]?, Bool, Bool) -> Void)!) {
        let data = [User(id:"1",name:"fahad"),User(id:"2",name:"fahadRasheed")]
        completionBlock(data,false,true)

    }
    
    
    func cell(forMentionsEntity entity: HKWMentionsEntityProtocol!, withMatch matchString: String!, tableView: UITableView!, at indexPath: IndexPath!) -> UITableViewCell! {
        tableView.register(UINib(nibName: "UserTableViewCell", bundle: nil), forCellReuseIdentifier: "UserTableViewCell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell") as! UserTableViewCell
        cell.lblName.text = entity.entityName()
        return cell
    }
    
    func heightForCell(forMentionsEntity entity: HKWMentionsEntityProtocol!, tableView: UITableView!) -> CGFloat {
        return 50.0
    }
    
    func selected(_ entity: HKWMentionsEntityProtocol!, at indexPath: IndexPath!) {
        
    }
    func mentionsPlugin(_ plugin: HKWMentionsPlugin!, createdMention entity: HKWMentionsEntityProtocol!, atLocation location: UInt) {
        print("\(entity.entityName())","\(location)")
    }
}
