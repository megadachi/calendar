//
//  MonthScrollView.swift
//  calendar
//
//  Created by M A on 16/05/2020.
//  Copyright © 2020 M A. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class MonthScrollView : UIView, UIScrollViewDelegate, UINavigationBarDelegate {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let viewController = ViewController()
    
    var currentYear:Int = 0
    var currentMonth:Int = 0
    var currentDay:Int = 0
    let daysPerWeek: Int = 7
    var currentDate = Date()
    let myCalendar = Calendar.current
    
    var currentMonthView : MonthView!
    var postMonthView : MonthView!
    var preMonthView : MonthView!
    
    var scrollView: UIScrollView!
    
    required init(coder aDecoder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }

       var postMonth:Date!
       var preMonth:Date!

       override init(frame:CGRect){
           super.init(frame: frame)

        let screenWidth : CGFloat = frame.size.width
//        let screenHeight : CGFloat = screenWidth * 1.2
        
        /* scrollviewの構造設定 */
        scrollView = UIScrollView(frame: self.bounds)
        scrollView.backgroundColor = UIColor.white
        // scrollViewのサイズを指定（幅は1メニューに表示するViewの幅×ページ数）
        scrollView.contentSize = CGSize(width: frame.size.width, height: frame.size.height * 3.0)
        //scrollViewの初期表示位置を指定
        scrollView.contentOffset = CGPoint(x: 0 , y: screenWidth)
        scrollView.delegate = self
        // メニュー単位のスクロールを可能にする
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        self.addSubview(scrollView)
        /* 日付設定 */
        // 当月1日を取得し表示月初日に代入
        appDelegate.firstDay = getFirstDay(day: currentDate)
        print("firstday", appDelegate.firstDay)
        // 各月生成
        setViews()
    }
    
    func setViews(){
        // 表示月起点に前後月を設定
        postMonth = myCalendar.date(byAdding: .month, value: 1, to: myCalendar.startOfDay(for: appDelegate.firstDay))
        preMonth = myCalendar.date(byAdding: .month, value: -1, to: myCalendar.startOfDay(for: appDelegate.firstDay))
        let screenWidth : CGFloat = frame.size.width
        // 各月のviewを作成
        preMonthView = MonthView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenWidth), selDate: preMonth!)
        currentMonthView = MonthView(frame: CGRect(x: 0, y: screenWidth, width: screenWidth, height: screenWidth), selDate: appDelegate.firstDay)
        postMonthView = MonthView(frame: CGRect(x: 0, y: screenWidth * 2, width: screenWidth, height: screenWidth), selDate: postMonth!)
        // 各月のviewを描画
        scrollView.addSubview(preMonthView)
        scrollView.addSubview(currentMonthView)
        scrollView.addSubview(postMonthView)
    }
    // 表示月をタイトルに設定
//    func setTitle(i: Int){
//          var title = 1 + i
//          ViewController().navigationItem.title = String(title)
//          print("scroll中 表示月", title, "前月と翌月", preMonth!,"&", postMonth!)
//      }
//    func setTitle(i: Int){
//        let titleFormatter:DateFormatter = DateFormatter()
//        titleFormatter.dateFormat = "MMM/yyyy"
//        let firstDay = myCalendar.date(byAdding: .month, value: i, to: myCalendar.startOfDay(for: appDelegate.firstDay))
//        let monthTitle = titleFormatter.string(from: firstDay!)
//        viewController.navigationItem.title = monthTitle
//        print("scroll中 表示月", firstDay, "前月と翌月", preMonth!,"&", postMonth!)
//    }
    func setTitle(){
        let titleFormatter:DateFormatter = DateFormatter()
        titleFormatter.dateFormat = "MMM yyyy"
        let firstDay = appDelegate.firstDay
        let monthTitle = titleFormatter.string(from: firstDay)
        viewController.title = monthTitle
        print("scroll中 表示月", appDelegate.firstDay, "前月と翌月", preMonth!,"&", postMonth!)
    }
    // 月の初日を取得
    func getFirstDay(day: Date) -> Date{
           var components = myCalendar.dateComponents([.year, .month], from: day)
           components.day = 1
           let firstDayOfMonth = myCalendar.date(from: components)!
           return firstDayOfMonth
       }
    // スクロール中（画面に指が触れている状態）に画面設定し直す
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetX = self.scrollView.contentOffset.y
        // 下へスクロール 翌月を当月にセット
        if (offsetX > self.scrollView.frame.size.width * 1.5){
            showPostView()
            setTitle()
//            setTitle(i: +1)
        }
        // 上へスクロール 前月を当月にセット
        if (offsetX < self.scrollView.frame.size.width * 0.5){
            showPreView()
            setTitle()
//            setTitle(i: -1)
        }
    }
    // 翌月を表示する設定
    func showPostView (){
        // 翌月初日が表示月初日になる
        appDelegate.firstDay = postMonth
        setViews()
        // scrollViewの初期表示位置を指定
        self.resetContentOffSet()
    }
    // 前月を表示する設定
    func showPreView (){
        // 翌月初日が表示月初日になる
        appDelegate.firstDay = preMonth
        setViews()
        // scrollViewの初期表示位置を指定
        self.resetContentOffSet()
    }
    // scrollViewの初期表示位置の再設定
    func resetContentOffSet () {
        let viewSize = frame.size.width
        //position調整
        preMonthView.frame = CGRect(x: 0, y: 0, width: viewSize, height: viewSize)
        currentMonthView.frame = CGRect(x: 0, y: viewSize, width: viewSize, height: viewSize)
        postMonthView.frame = CGRect(x: 0, y: viewSize * 2, width: viewSize, height: viewSize)

        let scrollViewDelegate:UIScrollViewDelegate = scrollView.delegate!
        scrollView.delegate = nil
        // delegateを呼びたくないので
        scrollView.contentOffset = CGPoint(x:  0.0, y: frame.size.width)
        scrollView.delegate = scrollViewDelegate
    }
}

