//
//  DayViewController.swift
//  calendar
//
//  Created by M A on 25/05/2020.
//  Copyright © 2020 M A. All rights reserved.
//

import UIKit

class DayViewController: UIViewController {
    // 前画面からのテキスト
    var sentText:String?
    
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var imgCollection: UICollectionView!
    
    
    @IBOutlet weak var dateLabel: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateLabel.text = sentText
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
