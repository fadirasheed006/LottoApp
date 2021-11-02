//
//  FristPrizeTableViewCell.swift
//  LOTTO
//
//  Created by Fahad on 02/11/2021.
//

import UIKit

class FristPrizeTableViewCell: UITableViewCell {

    @IBOutlet weak var lblLotto1NAme: UILabel!
    
    @IBOutlet weak var lblLotto1Reward: UILabel!
    
    @IBOutlet weak var lblLotto1Number: UILabel!
    
    @IBOutlet weak var lbl2ndName: UILabel!
    
    @IBOutlet weak var lbl2ndReward: UILabel!
    
    @IBOutlet weak var lbl2ndNunber1: UILabel!
    
    @IBOutlet weak var lbl2ndNumber2: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var viewContainer: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        viewContainer.layer.cornerRadius = 15.0
        viewContainer.dropShadow()
        self.selectionStyle = .none
       
    }
    func loadCellData(list:[LatestDateResultList]){
        lblDate.text = latestThaiDate
        
        for (index,item) in list.enumerated() {
            if index == 0 {
                let number = item.number as? String
                lblLotto1Number.text = number
                lblLotto1Reward.text = "\(item.reward ?? 0) บาท"
                lblLotto1NAme.text = item.name
            }else if index == 1 {
                let number = item.number as? [String]
                lbl2ndName.text = item.name
                lbl2ndReward.text = "\(item.reward ?? 0) บาท"
                lbl2ndNunber1.text = number?[0]
                lbl2ndNumber2.text = number?[1]
                
                break
            }
        }
    }
  
    
}
