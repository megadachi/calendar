//
//  WeekCell.swift
//  calendar
//
//  Created by M A on 15/05/2020.
//  Copyright © 2020 M A. All rights reserved.
//

import UIKit



class WeekCell: UICollectionViewCell {

    
    @IBOutlet var weekLabel: UILabel!
    
    
//    var weekLabel : UILabel?
////    var imgView : UIImageView!
//
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        // UILabelを生成.
        weekLabel = UILabel(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        weekLabel?.textAlignment = NSTextAlignment.center

//        imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: 34, height: 34))
//        imgView.center = CGPoint(x: frame.width / 2, y: frame.height / 2)
//        imgView.contentMode = .scaleAspectFit

        // Cellに追加.
//        self.contentView.addSubview(imgView)
        self.contentView.addSubview(weekLabel!)
    }
}
