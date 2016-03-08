//
//  GuideCollectionViewCell.swift
//  LoadingADView
//
//  Created by SuperDanny on 16/3/7.
//  Copyright © 2016年 SuperDanny. All rights reserved.
//

import UIKit

class GuideCollectionViewCell: UICollectionViewCell {
    private var imageView = UIImageView(frame: ScreenBounds)
    private var nextBtn = UIButton(frame: CGRect(x: (ScreenWidth-101)/2, y: ScreenHeight-110, width: 101, height: 33))
    
    var image: UIImage? {
        didSet {
            imageView.image = image
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView.contentMode = .ScaleAspectFit
        contentView.addSubview(imageView)
        
        nextBtn.setImage(UIImage(named: "icon_next"), forState: UIControlState.Normal)
        nextBtn.hidden = true
        nextBtn.addTarget(self, action: "nextButtonClick", forControlEvents: UIControlEvents.TouchUpInside)
        contentView.addSubview(nextBtn)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setHiddenNextButton(isHidden: Bool) {
        nextBtn.hidden = isHidden
    }
    
    func nextButtonClick() {
        NSNotificationCenter.defaultCenter().postNotificationName(GuideViewControllerDidFinish, object: nil)
    }
}
