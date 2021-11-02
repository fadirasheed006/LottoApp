//
//  RewardChekcTableViewCell.swift
//  LOTTO
//
//  Created by Fahad on 01/11/2021.
//

import UIKit

class RewardChekcTableViewCell: UITableViewCell {

    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var txtField: UITextField!
    @IBOutlet weak var viewDropDown: UIView!
    @IBOutlet weak var viewText: UIView!
    
    @IBOutlet weak var viewButton: UIView!
    var onDropDownCallBack:(()->Void)?
    var validationCallBack:((String)->Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
        
        viewDropDown.layer.cornerRadius = 20.0
        viewDropDown.layer.borderWidth = 0.9
        viewDropDown.layer.borderColor = UIColor(named: "borderColor")?.cgColor
        viewText.layer.cornerRadius = 20.0
        viewText.layer.borderWidth = 0.9
        viewText.layer.borderColor = UIColor(named: "borderColor")?.cgColor
        viewButton.layer.cornerRadius = 20.0
        txtField.delegate = self
        txtField.keyboardType = .numberPad
        self.selectionStyle = .none
    }

    func loadCellData(value:String){
        if isTextEmpty{
            txtField.text = ""
            isTextEmpty = false
        }
        lblDate.text = value
    }
    @IBAction func applyButtonPressed(_ sender: Any) {
        if txtField.text?.count ?? 0 < 6 {
            validationCallBack?("")
        }else{
            validationCallBack?(txtField.text ?? "")
        }
    }
    
    @IBAction func dropButtonPressed(_ sender: Any) {
        onDropDownCallBack?()
    }
}

extension RewardChekcTableViewCell:UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) {
       
    }
}

