//
//  RewardsLsitTableViewCell.swift
//  LOTTO
//
//  Created by Fahad on 02/11/2021.
//

import UIKit

class RewardsLsitTableViewCell: UITableViewCell {

    @IBOutlet weak var heightConstrain: NSLayoutConstraint!
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var lblReward: UILabel!
    @IBOutlet weak var lblName: UILabel!
    
    var rewardNumbers:[String] = []
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "NumberCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "NumberCollectionViewCell")
        viewContainer.layer.cornerRadius = 15.0
        viewContainer.dropShadow()
        heightConstrain.constant = 100.0
        self.selectionStyle = .none
        
       
    }
    override func layoutSubviews() {
        collectionView.collectionViewLayout.invalidateLayout()

    }
    func loadCellData(model:LatestDateResultList){
        lblName.text = model.name
        lblReward.text = "\(model.reward ?? 0) บาท"
        var number:[String] = []
        if  let value = model.number as? [String]{
            number = value
        }else if let value = model.number as? String{
            number = [value]
        }
        self.rewardNumbers = number
        collectionView.reloadData()
    }


    
}

extension RewardsLsitTableViewCell:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("numbers\(rewardNumbers.count)")
        return rewardNumbers.count
    }
    
 
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NumberCollectionViewCell", for: indexPath) as! NumberCollectionViewCell
        let model = rewardNumbers[indexPath.row]
        cell.loadCellData(model:model)
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
            let lay = collectionViewLayout as! UICollectionViewFlowLayout
            let widthPerItem = collectionView.frame.width / 5 - lay.minimumInteritemSpacing

        return CGSize(width: widthPerItem, height:50)
        
    }
    
    
}
