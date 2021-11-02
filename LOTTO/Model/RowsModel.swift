//
//  RowsModel.swift
//  LOTTO
//
//  Created by Fahad on 03/11/2021.
//

import UIKit

enum Row:Int{
    case txt = 0
    case first
    case rewards
}
class RowsModel: NSObject {
    var cellType:Row = .txt
    var model:[LatestDateResultList] = []
    
    var rewardModel:LatestDateResultList?
}
