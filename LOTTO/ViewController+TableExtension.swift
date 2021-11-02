//
//  ViewController+TableExtension.swift
//  LOTTO
//
//  Created by Fahad on 02/11/2021.
//

import UIKit

extension ViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(dataSource.count)
        return self.dataSource.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = dataSource[indexPath.row]
        if  row.cellType == .txt{
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
        } else if row.cellType == .first{
            let cell = tableView.dequeueReusableCell(withIdentifier: "FristPrizeTableViewCell", for: indexPath) as! FristPrizeTableViewCell
            let model = row.model
            cell.loadCellData(list:model)
            return cell
            
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "RewardsLsitTableViewCell", for: indexPath) as! RewardsLsitTableViewCell
           
            let model = row.rewardModel ?? LatestDateResultList()
            cell.loadCellData(model:model)
            
            return cell
        }
     
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
        return 250
        }else if indexPath.row == 1{
            return 382
        }else{
           return UITableView.automaticDimension
        }
    }
    

}
