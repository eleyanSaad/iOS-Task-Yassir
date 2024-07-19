//
//  ActivityIndicatorManager.swift
//  kindergarten
//
//  Created by Amar Amassi  on 4/17/18.
//  Copyright © 2018 Amar Amassi . All rights reserved.
//

import Foundation
import SVProgressHUD

class ActivityIndicatorManager: NSObject {
    
    public class func start(_ title: String = ""){
        SVProgressHUD.setBackgroundColor(.clear)
        SVProgressHUD.setForegroundColor(UIColor.green)
        SVProgressHUD.show()
    }

    public class func startWithBackGroundWithoutTitle(_ title: String = "Restore") {
        SVProgressHUD.setBackgroundColor(.lightGray)
        SVProgressHUD.setForegroundColor(UIColor.black)
        SVProgressHUD.show()
    }
    
    public class func stop() {
        SVProgressHUD.dismiss()
    }

}
