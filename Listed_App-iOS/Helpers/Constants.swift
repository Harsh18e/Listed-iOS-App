//
//  Constants.swift
//  Listed_App-iOS
//
//  Created by Harsh Kumar Agrawal on 07/04/23.
//

import Foundation
import UIKit

struct Constants {
    
    static let URL = "https://api.inopenapp.com/api/v1/dashboardNew" //
    static let BEARER_TOKEN = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjU5MjcsImlhdCI6MTY3NDU1MDQ1MH0.dCkW0ox8tbjJA2GgUx2UEwNlbTZ7Rr38PVFJevYcXFI"
    
}

func showToast(message: String, _ view: UIView) {
        
        let toastLabel = UILabel()
        toastLabel.text = message
        toastLabel.font = UIFont.systemFont(ofSize: 14)
        toastLabel.textColor = UIColor.white
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        toastLabel.textAlignment = .center
        toastLabel.alpha = 0.0
        toastLabel.layer.cornerRadius = 10
        toastLabel.clipsToBounds  =  true
        
        let toastWidth = min(view.frame.size.width - 20, 300)
        let toastHeight: CGFloat = 35
        let toastX = (view.frame.size.width - toastWidth) / 2.0
        let toastY = view.frame.size.height - (toastHeight * 3)
        toastLabel.frame = CGRect(x: toastX, y: toastY, width: toastWidth, height: toastHeight)
        
        view.addSubview(toastLabel)
        
    UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseOut, animations: {
            toastLabel.alpha = 1.0
        }, completion: {(isCompleted) in
            UIView.animate(withDuration: 0.5, delay: 0.5, options: .curveEaseOut, animations: {
                toastLabel.alpha = 0.0
            }, completion: {(isCompleted) in
                toastLabel.removeFromSuperview()
            })
        })
}
