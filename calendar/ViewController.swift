//
//  ViewController.swift
//  calendar
//
//  Created by M A on 11/05/2020.
//  Copyright © 2020 M A. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var daysOfWeek: UICollectionView!
    
    
    // 曜日ラベル設定用
    let formatter = DateFormatter()
    var daysOfWeekArray: [String] = []
    
    let cellMargin: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getDaysOfWeek()
//        //UICollectionViewFlowLayout()をインスタンス化
//        let layout = UICollectionViewFlowLayout()
//        layout.sectionInset = UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)//レイアウトを調整
//        daysOfWeek.collectionViewLayout = layout
//        daysOfWeek.collectionViewLayout = layout
        // DelegateとDataSourceの紐付け
        daysOfWeek.delegate = self
        daysOfWeek.dataSource = self

        self.view.addSubview(daysOfWeek)
//        
        print(daysOfWeekArray)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func getDaysOfWeek(){
        var dateComponents = DateComponents()
        var d = 10
        let calendar = Calendar(identifier: .gregorian)
        while d < 17 {
            dateComponents.year = 2020
            dateComponents.month = 5
            dateComponents.day = d
            let referencePoint = calendar.date(from: dateComponents)!
            formatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "EEEEE", options: 0, locale: Locale.current)
            print(formatter.string(from: referencePoint))
            d += 1
            daysOfWeekArray.append(formatter.string(from: referencePoint))
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // section数は１つ
        return 1
        }
    // 表示するセルの数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
     // cellに情報を入れていく関数
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //表示するCellの登録
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeekLabelCell", for: indexPath) as! WeekCell
        //セルの背景色
        cell.backgroundColor = #colorLiteral(red: 0.5, green: 0.8090446002, blue: 0.9884150257, alpha: 1)
        // UILabelを生成.
        cell.weekLabel.text = daysOfWeekArray[indexPath.row]
        cell.weekLabel.textColor = UIColor.white
        cell.weekLabel.frame = CGRect(x: 0, y: 0, width: cell.bounds.width, height: cell.bounds.height)
        return cell
    }
       //セルの配置について決める
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth : CGFloat = self.view.bounds.width / 7
        return CGSize(width: cellWidth, height: 30)
    }
    //セルの垂直方向のマージンを設定
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return cellMargin
    }

    //セルの水平方向のマージンを設定
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return cellMargin
    }
    // セクションヘッダのサイズ
    func collectionView(_ collectionView: UICollectionView, layout _: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize.zero
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
    }
}

extension Date {
    
    var calendar: Calendar {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = .current
        calendar.locale   = .current
        return calendar
    }
}
