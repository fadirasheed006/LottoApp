//
//  NumberCollectionViewCell.swift
//  LOTTO
//
//  Created by Fahad on 02/11/2021.
//

import UIKit

class NumberCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var lblNumber: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }
    func loadCellData(model:String){
        lblNumber.text = model
    }
}
