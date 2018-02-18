//
//  CommonClass.swift
//  MovieDB
//
//  Created by Atit Modi on 2/18/18.
//  Copyright © 2018 Atit Modi. All rights reserved.
//

import UIKit

class CommonClass: NSObject {

    func showAlertView(errorMessage : String){
        
        let okBtnAction = UIAlertAction(title: "OK", style: .default, handler: {(alertAction) in
            AppAlertViewHelper.sharedInstance.hideAlertView()
        })
        
        AppAlertViewHelper.sharedInstance.showAlertView(withMessage: errorMessage, title: "Error", actions: okBtnAction)
        
    }
    
    
    
}
