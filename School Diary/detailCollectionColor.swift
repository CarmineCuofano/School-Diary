//
//  detailCollectionColor.swift
//  School Diary
//
//  Created by Carmine Cuofano on 19/08/17.
//  Copyright © 2017 Yuji Hato. All rights reserved.
//

import UIKit

class detailCollectionColor: UITableViewCell, UICollectionViewDelegate,UICollectionViewDataSource {

    @IBOutlet var collection: UICollectionView!
    var delegate: didTapOnCellDelegate?
    var indexSelected : Int? = 0

    let colors : [UIColor] = [.blue,.brown,.cyan,.gray,.green,.lightGray,.magenta,.orange,.purple,.red,.yellow]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.collection.delegate = self
        self.collection.dataSource = self
        self.collection.showsHorizontalScrollIndicator = false
        // Initialization code
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cella = collection.dequeueReusableCell(withReuseIdentifier: "cellaColor", for: indexPath) as! colorCollectCell
        cella.backgroundColor = colors[indexPath.row]
        if let indSel = indexSelected {
            cella.check.isHidden = indSel != indexPath.row
        } else {
            cella.check.isHidden = true
        }
        return cella
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.indexSelected = indexPath.row
        delegate?.didTapForColor?(color: colors[indexPath.row])
        self.collection.reloadData()
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
