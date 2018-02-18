//
//  AppAlertViewHelper.swift
//  MovieDB
//
//  Created by Atit Modi on 2/18/18.
//  Copyright © 2018 Atit Modi. All rights reserved.
//

import UIKit

class AppAlertViewHelper: NSObject {
    
    private var alertController : UIAlertController?
    
    static let sharedInstance = AppAlertViewHelper()
    
    func showAlertView(withMessage message:String, title: String, actions: UIAlertAction...)
    {
        do
        {
            alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            
            //Add All the actions in the alertController.
            for action in actions
            {
                alertController?.addAction(action)
            }
            
            UIApplication.shared.keyWindow?.rootViewController?.present(alertController!, animated: true, completion: nil)
        }
    }
    
    func hideAlertView()
    {
        alertController?.dismiss(animated: true, completion: nil)
    }
}
