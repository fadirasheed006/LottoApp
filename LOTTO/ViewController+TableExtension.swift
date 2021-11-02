//
//  ViewController+TableExtension.swift
//  LOTTO
//
//  Created by Fahad on 02/11/2021.
//

import UIKit

extension ViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RewardChekcTableViewCell", for: indexPath) as! RewardChekcTableViewCell
        
        cell.onDropDownCallBack = {
            self.pickerView.isHidden = false
        }
        cell.validationCallBack = {
            model in
            if model == "" {
            self.showPopUpToast(message:"Enter atleast 6 Digits")
            }else{
                self.GetVerifyDataAPiCall(date: lotteryNumber, textValue: model)
                print(model)
            }
        }
        cell.loadCellData(value:latestThaiDate)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    

}
