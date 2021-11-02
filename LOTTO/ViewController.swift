//
//  ViewController.swift
//  LOTTO
//
//  Created by Fahad on 31/10/2021.
//

import UIKit
import Alamofire
import ObjectMapper
import NVActivityIndicatorView

var latestThaiDate:String = ""
var lotteryNumber:String = ""
var isTextEmpty:Bool = false
let headers = ["Content-Type": "application/json","x-api-key": "74336a6e284ba4be8ce7fad7742a6f86"]

let httpHeaderContentType = HTTPHeaders(headers)

class ViewController: UIViewController {
    
 
    @IBOutlet weak var activityView: NVActivityIndicatorView!

    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    var pickerArray:[AllDates] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "RewardChekcTableViewCell", bundle: nil), forCellReuseIdentifier: "RewardChekcTableViewCell")
        GetALlDateAPiCall()
            pickerView.isHidden = true
        
    }
    
    //
    
    func GetVerifyDataAPiCall(date:String,textValue:String){
    activityView.startAnimating()
  let url = "https://www.krupreecha.com/api/verify/01102564/\(textValue)"
  AF.request(url, method: .post, parameters: nil, encoding: URLEncoding.default, headers:httpHeaderContentType).responseJSON{
      response in
      self.activityView.stopAnimating()
      switch response.result {
      case .success( let value):
         
          if  let json = value as? [String:Any] {
              let status = json["code"] as? String
              guard let userData = Mapper<VerifyResponse>().map(JSON: json) else { return }
              if (status == "200"){
                  isTextEmpty = true
                  if !(userData.winner ?? false){
                      ToastMessages.showMessage(message: "เสียใจด้วยนะ โอกาสหน้าลองใหม่อีกครั้ง", theme: .error, title: "หมายเลข \(textValue)")
                  }else{
                      let reward = userData.result?.first?.reward ?? 0
                      ToastMessages.showMessage(message: "คุณถูกรางวัลที่ 1 จำนวน \(reward) บาท", theme: .success, title: "หมายเลข \(textValue)")
                      print(userData.result?.first?.toJSON())
                  }
                  self.tableView.reloadData()
              }
              
          }
        
      case .failure(let message):
          print(message)
      
      }
      
  }
  }
    
    
    
        // GetALlDates
    func GetALlDateAPiCall(){
        activityView.startAnimating()
      let url = "https://www.krupreecha.com/api/lotteryday"
      AF.request(url, method: .post, parameters: nil, encoding: URLEncoding.default, headers:httpHeaderContentType).responseJSON{
          response in
          self.activityView.stopAnimating()
          switch response.result {
          case .success( let value):
             
              if  let json = value as? [String:Any] {
                  let status = json["code"] as? String
                  guard let userData = Mapper<AllDateResponse>().map(JSON: json) else { return }
                  if (status == "200"){
                      latestThaiDate = userData.result?.first?.thaidate ?? ""
                      lotteryNumber = userData.result?.first?.lottoNameSpace ?? ""
                      self.GetDataFromLatestDateAPiCall(date:lotteryNumber)
                      self.pickerArray = userData.result ?? []
                      self.pickerView.reloadAllComponents()
                      self.tableView.reloadData()
                  }
                  
              }
            
          case .failure(let message):
              print(message)
          
          }
          
      }
      }
    
    
    func GetDataFromLatestDateAPiCall(date:String){
        activityView.startAnimating()
      let url = "https://www.krupreecha.com/api/\(date)"
      AF.request(url, method: .post, parameters: nil, encoding: URLEncoding.default, headers:httpHeaderContentType).responseJSON{
          response in
          self.activityView.stopAnimating()
          switch response.result {
          case .success( let value):
             
              if  let json = value as? [String:Any] {
                  let status = json["code"] as? String
                  guard let userData = Mapper<LatestDateResponse>().map(JSON: json) else { return }
                  if (status == "200"){
                     print(userData.result?.toJSON())
                   //   self.tableView.reloadData()
                  }
                  
              }
            
          case .failure(let message):
              print(message)
          
          }
          
      }
      }
    
    func showPopUpToast(message:String){
        let alertDisapperTimeInSeconds = 2.0
        let alert = UIAlertController(title: nil, message:message, preferredStyle:.alert)
        self.present(alert, animated: true)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + alertDisapperTimeInSeconds) {
          alert.dismiss(animated: true)
        }
    }

}



extension ViewController:UIPickerViewDelegate,UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
      return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerArray.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
       let model = pickerArray[row]
        return model.thaidate
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let model = pickerArray[row]
        latestThaiDate = model.thaidate ?? ""
        lotteryNumber = model.lottoNameSpace ?? ""
        GetDataFromLatestDateAPiCall(date:lotteryNumber)
        self.tableView.reloadData()
        print(model.lottoNameSpace)
        self.pickerView.isHidden  = true
        
    }
    
    
}
