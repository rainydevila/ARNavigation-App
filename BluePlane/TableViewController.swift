//
//  TableViewController.swift
//  BluePlane
//
//  Created by 原田龍青 on 2019/12/09.
//  Copyright © 2019 原田龍青. All rights reserved.
//

import Foundation
import UIKit

class TableViewController: UIViewController {
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
 }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
           // セルの選択を解除
           tableView.deselectRow(at: indexPath, animated: true)
    
           // 別の画面に遷移
           performSegue(withIdentifier: "toNextViewController", sender: nil)
       }
    
}
