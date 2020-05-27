//
//  MonthView.swift
//  calendar
//
//  Created by M A on 17/05/2020.
//  Copyright © 2020 M A. All rights reserved.
//

import UIKit

class MonthView : UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    let viewController = ViewController()
    
    var collectionView : UICollectionView!
  
    var cellSize: CGFloat = 0.0
    let cellMargin: CGFloat = 0
    
    let formatter = DateFormatter()
    let today = Date()
    //表記する月の配列
    var currentMonthDayArray: [Date] = []
    var stringArray: [String] = []
    // カレンダー表示用
    var myCalendar = Calendar.current
    var currentDate: Date!
    var numberOfItems: Int!
    var ordinalNb : Int!
    var todayID : Int!
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(frame: CGRect, selDate: Date){
        super.init(frame: frame)
        
        self.setUp(selDate)
        // 曜日番号をセット
        ordinalNb = getOrdinalDay() - 1
        // 当月の日数＝セルの数をセット
        numberOfItems = countDaysOfMonth() + ordinalNb
        // 日の配列を月の配列内にセット
        dateForCellAtIndexPath()
        // セルに表記するStringを生成
        stringArray = convertDateFormat()
    }

    func setUp(_ selDate: Date){
        currentDate = selDate
        // CollectionViewのレイアウトを生成
        let layout = UICollectionViewFlowLayout()
        let screenWidth : CGFloat = frame.size.width
        // Cell一つ一つの大きさ
        cellSize = frame.size.width / 7
        layout.itemSize = CGSize(width: cellSize, height: 40)
        // CollectionViewを生成
        collectionView = UICollectionView(frame: CGRect(x: screenWidth, y: 0, width: frame.size.width, height: frame.size.width), collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.isScrollEnabled = false
        collectionView.center = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        // Cellに使われるクラスを登録
        collectionView.register(MonthViewCell.self, forCellWithReuseIdentifier: "MonthViewCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.frame =  CGRect(x: 0, y: 0, width: screenWidth, height: screenWidth)
        self.addSubview(collectionView)
    }
   
    //  月の初日が週の何日目かを計算 土曜始まりのところを月曜始まりにする
    func getOrdinalDay() -> Int {
        var ordinalDay = myCalendar.ordinality(of: .day, in: .weekOfMonth, for: currentDate)! - 1
        if ordinalDay < 1 {
            ordinalDay += 7
        }
        return ordinalDay
    }
    // 当月の日数 …セル数に使う
    func countDaysOfMonth() -> Int {
        // 当月から当該年月を生成
        let year = myCalendar.component(.year, from: currentDate)
        let month = myCalendar.component(.month, from: currentDate)
        let date = myCalendar.date(from: DateComponents(year: year, month: month))!
        // 生成月に何日あるかカウント
        let n = myCalendar.range(of: .day, in: .month, for: date)!.count
        return n
    }
    // 表記する日の配列取得
    func dateForCellAtIndexPath() {
        // 日付を一時保管する配列
        var array : [Date] = []//
        var dateComponents = DateComponents()
        // 当月の日数に相当する日付を生成する
        for i in 0 ..< numberOfItems {
            dateComponents.day = i - ordinalNb
            // 表示する月の初日にiを足した日付を取得
            let date = myCalendar.date(byAdding: dateComponents, to: currentDate)!
            // 配列に追加
            array.append(date)
        }
        // 当月の日の配列に代入
        currentMonthDayArray = array
        array.removeAll()
    }
    // 日付表記用に数列を生成
    func convertDateFormat() -> [String]{
        // 日付を一時保管する配列
        var array : [String] = []
        var intArray :[Int] = []
        // 当月の日数に相当する日付番号を生成する
        for i in 1 ... numberOfItems {
            let date = i - ordinalNb
            // 配列に追加
            intArray.append(date)
        }
        array = intArray.map { String($0)}
        intArray.removeAll()
        return array
    }
    // 日付を設定
    func setDay(d: Date) -> Date{
        let setDay = myCalendar.date(byAdding: .month, value: 0, to: myCalendar.startOfDay(for: d))
        return setDay!
    }
    // 後で設定 キャプション表示に使う!
//    func compareDate(selDate: Date) -> Bool {
//        let isSameDay = myCalendar.isDate(appDelegate.scheduleAt!, inSameDayAs: selDate)
//
//        return isSameDay
//    }
    // セクションの数
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    // Cellの総数を返す
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // 当月日数 ＋ 曜日番号
        return numberOfItems
    }
    // セルの内容を表示
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: MonthViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MonthViewCell", for: indexPath as IndexPath) as! MonthViewCell
        cell.txtLabel?.textColor = UIColor.gray
        if indexPath.row < ordinalNb {
            cell.txtLabel?.text = nil
            cell.backgroundColor = .white
        } else {
            // 日の表示
            if indexPath.row < numberOfItems {
                // 当日の設定
                if let firstIndex = currentMonthDayArray.firstIndex(of: setDay(d: today)){
                    if indexPath.row == firstIndex{
                    cell.txtLabel?.textColor = #colorLiteral(red: 0.5, green: 0.8090446002, blue: 0.9884150257, alpha: 1)
                    }
                }
                // 選択時の背景設定
                let selectedBGView = UIView()
                selectedBGView.backgroundColor = #colorLiteral(red: 1, green: 0.6794118285, blue: 0.8373190165, alpha: 1)
                cell.selectedBackgroundView = selectedBGView
                // テキスト設定
                cell.txtLabel?.text = stringArray[indexPath.row]
            } else {
                // 月最終日以降を空欄に
                cell.txtLabel?.text = nil
                cell.backgroundColor = .white
            }
        }
//            // 現在のセルアイテムの日付を取得
//            //            let itemDay = currentMonthDayArray[indexPath.row]
//            // イベント予定日と同じかどうかをチェック
//            //            let isSelectedDay = compareDate(selDate: itemDay)
//            //            if isSelectedDay == true {
//            //                //                    appDelegate.selCalDayID = indexPath.row
//            //                cell.imgView.image = UIImage(named: "cal-bg")
//            //                cell.txtLabel?.textColor = UIColor.white
//            cell.txtLabel?.text = dayArray[indexPath.row]
//            //            } else {
//            //                cell.txtLabel?.text = day
//            //                cell.imgView.image = UIImage()
//            }
//        }
        return cell
    }
    // セル配置設定
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth : CGFloat = self.bounds.width / 7
        return CGSize(width: cellWidth, height: cellWidth)
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
    // セルをタップした時の処理
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // タップしたセルアイテムの日付を取得
        appDelegate.selectedDay = currentMonthDayArray[indexPath.row]
        print("selectedday", appDelegate.selectedDay)
        // DayViewへ画面遷移
//        // ①storyboardのインスタンス取得
//               let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//               // ②遷移先ViewControllerのインスタンス取得
//               let nextView = storyboard.instantiateViewController(withIdentifier: "DayView") as! DayViewController
//               // ③画面遷移
//               viewController.navigationController?.pushViewController(nextView, animated: true)
//        viewController.performSegue(withIdentifier: "toDayView", sender: nil)
        
        //        // イベント予定日と同じかどうかをチェック
        //        let isSelectedDate = calMng.compareDate(selDate: selItemDay)
//        var selectedNb = indexPath.row
//        if appDelegate.selectedDay == currentDate {
//            // 現状の選択したIDを一旦保持
//            let tmpItemID = selectedNb
//            // 選択したIDを新規にセット
//            selectedNb = indexPath.row
//            // 日付の内容を変更
//            appDelegate.firstDay = currentMonthDayArray[indexPath.row]
//            // 古いセルをリロード
//            reloadItem(selItem: tmpItemID)
//            // 新しいセルをリロード
//            reloadItem(selItem: selectedNb)
//            print("selectedNb",selectedNb, "tmpItemID", tmpItemID, "firstDay", appDelegate.firstDay)
//        }
    }
    
//    func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        guard let identifier = segue.identifier else {
//            // identifierが取れなかったら処理やめる
//            return
//        }
         
//        if(identifier == "ncSegue") {
//            // NavigationControllerへの遷移の場合
//
//            // segueから遷移先のNavigationControllerを取得
//            let nc = segue.destination as! UINavigationController
//
//            // NavigationControllerの一番目のViewControllerが次の画面
//            let vc = nc.topViewController as! NavitukiViewController
//
//            // 次画面のテキスト表示用のStringに、本画面のテキストフィールドのテキストを入れる
//            vc.receiveText = self.sendingTextField.text
//        }
//         if segue.identifier == "toDayView" {
//
//            let dayViewController:DayViewController = segue.destination as! DayViewController
//
//           // 変数:遷移先ViewController型 = segue.destinationViewController as 遷移先ViewController型
//           // segue.destinationViewController は遷移先のViewController
//
//            dayViewController.receiveText = myCalendar.dateFormatter(date: appDelegate.selectedDay)
//
//         }
//       }
    // ハイライト表示する
    func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    func reloadItem(selItem: Int) {
        collectionView.reloadItems(at: [IndexPath(row: selItem, section: 1)])
    }
}
