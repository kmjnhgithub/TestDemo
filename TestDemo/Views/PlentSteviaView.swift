//
//  PlentView.swift
//  TestDemo
//
//  Created by mike liu on 2023/6/19.
//

import UIKit
import Stevia


class PlentView: UIView {
    
    let plentDetailPosterImageView = UIImageView()
    
    let nameChLabel = UILabel()

    convenience init() {
        self.init(frame:CGRect.zero)
        
        subviews {
            plentDetailPosterImageView
            nameChLabel
                }
        
        layout {
            self.plentDetailPosterImageView.top(100)
            self.nameChLabel.Top == self.plentDetailPosterImageView.Bottom + 8
            self.nameChLabel.fillHorizontally(padding: 8).height(80)
        }
        
        plentDetailPosterImageView.style(imageStyle)
        nameChLabel.style(commonFieldStyle).style { f in
            f.numberOfLines = 0
        }
        
        
    }
    
    func imageStyle(_ f:UIImageView) {
        f.contentMode = .scaleAspectFill
        f.clipsToBounds = true
    }
    
    func commonFieldStyle(_ f:UILabel) {
//        f.numberOfLines = 0
        f.font = .systemFont(ofSize: 15)
        
    }

}
