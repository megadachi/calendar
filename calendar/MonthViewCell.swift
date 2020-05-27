//
//  MonthViewCell.swift
//  calendar
//
//  Created by M A on 17/05/2020.
//  Copyright © 2020 M A. All rights reserved.
//

import UIKit

class MonthViewCell: UICollectionViewCell {

    var txtLabel : UILabel?
    var imgView : UIImageView!

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        // UILabelを生成.
        txtLabel = UILabel(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        txtLabel?.textAlignment = NSTextAlignment.center

        imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        imgView.center = CGPoint(x: frame.width / 2, y: frame.height / 2)
        imgView.contentMode = .redraw

        // Cellに追加.
        self.contentView.addSubview(imgView)
        self.contentView.addSubview(txtLabel!)
    }
}
