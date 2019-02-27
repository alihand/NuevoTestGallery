//
//  DetailViewController.swift
//  NuevoTestGallery
//
//  Created by Alihan Demir on 26.02.2019.
//  Copyright © 2019 Alihan Demir. All rights reserved.
//

import UIKit
import SwiftyJSON

class DetailViewController: UIViewController {
    
    @IBOutlet weak var lblTitle : UILabel!
    @IBOutlet weak var lblBody : UILabel!
    
    var titleArray:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblTitle.text! = "\(titleArray[0])"

    }
    


}
