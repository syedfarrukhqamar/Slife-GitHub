//
//  LegTripNextDeparturesTableViewCell.swift
//  SLife
//
//  Created by syed farrukh Qamar on 2016-12-08.
//  Copyright © 2016 Be My Competence AB. All rights reserved.
//

import UIKit

class LegTripNextDeparturesTableViewCell: UITableViewCell {

    @IBOutlet weak var NextDepOutLet: UIButton!
    @IBOutlet weak var PrevDepOutLet: UIButton!
    var indexPathSelected = IndexPath()
    var keyName = String()
    var legIndexForDepartureShow = Int()
    var currentIndexPathRow = Int()
    var currentIndexPathSection = Int()
        @IBOutlet weak var nextDeparturesCollectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func setCollectionViewDataSourceDelegate
        <D: protocol<UICollectionViewDataSource, UICollectionViewDelegate>>
        (dataSourceDelegate: D, forRow row: Int) {
        
        
        print("data source has been called-...")
        nextDeparturesCollectionView.delegate = dataSourceDelegate
        nextDeparturesCollectionView.dataSource = dataSourceDelegate
        nextDeparturesCollectionView.tag = row
        nextDeparturesCollectionView.reloadData()
    }
    


}
