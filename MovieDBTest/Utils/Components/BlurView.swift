//
//  BlurView.swift
//  MovieDBTest
//
//  Created by MyMacBookPro on 04/07/2021.
//

import UIKit

@IBDesignable
class BlurView: UIVisualEffectView {

    override func layoutSubviews() {
        let blurEffectc = UIBlurEffect(style: .dark)
        self.effect = blurEffectc
    }
    
}
