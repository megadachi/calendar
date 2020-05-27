//
//  ViewController.swift
//  calendar
//
//  Created by M A on 11/05/2020.
//  Copyright © 2020 M A. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    
    @IBAction func menu(_ sender: UIBarButtonItem) {
    }
    
    // 曜日ラベル用
    @IBOutlet var daysOfWeek: UICollectionView!
    // キャプション表示用
    @IBOutlet weak var caption: UILabel!
    
    var selectedDate = NSDate()
    let myCalendar = Calendar.current
    
    // 曜日ラベル日付設定用
    let formatter = DateFormatter()
    var daysOfWeekArray: [String] = []
    
    let cellMargin: CGFloat = 0
    let cellHeight: CGFloat = 40
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("now", Date())
//        setTitle()
        // タイトルの間の線を消す
        self.navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.shadowImage = coloredImage(.clear)
        // 次の画面のBackボタンを<に変更
        self.navigationItem.backBarButtonItem = UIBarButtonItem(
            title:  "",
            style:  .plain,
            target: nil,
            action: nil
        )
/* 曜日ラベルの設定 */
        // CollectionViewのレイアウトを生成
        let layout = UICollectionViewFlowLayout()
        let statusBarHeight: CGFloat = {
            var heightToReturn: CGFloat = 0.0
                 for window in UIApplication.shared.windows {
                     if let height = window.windowScene?.statusBarManager?.statusBarFrame.height, height > heightToReturn {
                         heightToReturn = height
                     }
                 }
            return heightToReturn
        }()
        let navigationBarHeight = (self.navigationController?.navigationBar.frame.size.height)!
        let barHeight = statusBarHeight + navigationBarHeight
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        // 曜日ラベルのサイズと位置を指定
        daysOfWeek = UICollectionView(frame:CGRect(x: 0, y: barHeight, width: screenWidth, height: cellHeight), collectionViewLayout:layout)
        // セルの背景色
        daysOfWeek.backgroundColor = #colorLiteral(red: 0.5, green: 0.8090446002, blue: 0.9884150257, alpha: 1)
        // Cellに使われるクラスを登録
        daysOfWeek.register(WeekCell.self, forCellWithReuseIdentifier: "WeekLabelCell")
        daysOfWeek.delegate = self
        daysOfWeek.dataSource = self
        self.view.addSubview(daysOfWeek)
/* 日付表示の設定 */
        // スクロール設定
        let scrollY = barHeight + cellHeight
        let monthScrollView = MonthScrollView(frame: CGRect(x: 0, y: scrollY, width: screenWidth, height: screenWidth))
        self.view.addSubview(monthScrollView)
        // キャプション設定
        let captionY = scrollY + screenWidth
        caption.frame = CGRect(x: 0, y: captionY, width: screenWidth, height: screenHeight - captionY)
    }
    override func viewWillAppear(_ animated: Bool) {
        self.title = setTitle(date: appDelegate.firstDay)
        }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // 選択日情報を遷移先へ送る
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextView = segue.destination as! DayViewController
        nextView.sentText = myCalendar.dateFormatter(date: appDelegate.selectedDay)
    }
/* ラベル設定 */
    // タイトル
    func setTitle(date: Date) -> String{
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor : UIColor.white]
        let titleFormatter:DateFormatter = DateFormatter()
        titleFormatter.dateFormat = "MMM yyyy"
        let selectMonth = titleFormatter.string(from: date as Date)
        return selectMonth
    }
    // 曜日ラベル
    func getWeekDaySymbols(){
        var array = Calendar.current.shortStandaloneWeekdaySymbols
        let slice = array[0]
        array.append(slice)
        array.removeFirst()
       daysOfWeekArray = array
    }
    // section数
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
        cell.backgroundColor = .clear
        getWeekDaySymbols()
        // UILabelを生成
        cell.weekLabel.text = daysOfWeekArray[indexPath.row]
        cell.weekLabel.textColor = UIColor.white
        cell.weekLabel.frame = CGRect(x: 0, y: 0, width: cell.bounds.width, height: 40)
        return cell
    }
       //セルの配置について決める
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth : CGFloat = self.view.bounds.width / 7
        return CGSize(width: cellWidth, height: cellHeight)
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
    // navigationbarの境界設定
    func coloredImage(_ color: UIColor) -> UIImage {
        let size = CGSize(width: 1, height: 1)
        return UIGraphicsImageRenderer(size: size).image { context in
            color.setFill()
            context.fill(CGRect(origin: .zero, size: size))
        }
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
extension Calendar{
    func dateFormatter(date: Date) -> String {
        let formatter = ISO8601DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.formatOptions = .withFullDate
        return formatter.string(from: date)
    }
}
//    func string(with format: String) -> String {
//           let formatter = DateFormatter()
//           formatter.dateFormat = format
//
//        formatter.timeZone = TimeZone.current
//        formatter.locale = Locale.current
//           return formatter.string(from: self)
//       }
//}
// 日本時間で出力する
//extension Date {
//    func toStringWithCurrentLocale() -> String {
//        let formatter = DateFormatter()
//        formatter.timeZone = TimeZone.current
//        formatter.locale = Locale.current
//        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//        return formatter.string(from: self)
//    }
//}
//extension DateFormatter {
//    static func current(_ dateFormat: String) -> DateFormatter {
//        let df = DateFormatter()
//        df.timeZone = TimeZone.current
//        df.locale = Locale.current
//        df.dateFormat = dateFormat
//        return df
//    }  
//}
//extension Date{
//    func dateFormatter(date: Date) -> String {
//        let formatter = DateFormatter()
//        formatter.timeZone = TimeZone.current
//        formatter.locale = Locale.current
//        return formatter.string(from: date)
//    }
//}
//extension Date {
//   func getFormattedDate(format: Date) -> String {
//        let dateformat = DateFormatter()
//        dateformat.dateFormat = format
//    dateformat.timeZone = TimeZone.current
//    dateformat.locale = Locale.current
//        return dateformat.string(from: self)
//    }
//}
//extension Date{
//    func getFormatedDateInString(_ dateString: String) -> String? {
//        let dateFormatter = DateFormatter()
//        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
//        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
//        dateFormatter.timeZone = TimeZone(identifier: "UTC")
//        if let date = dateFormatter.date(from: dateString) {
//            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
//            dateFormatter.timeZone = TimeZone.current
//            let timeStamp = dateFormatter.string(from: date)
//            return timeStamp
//        }
//        return nil
//    }
//}
