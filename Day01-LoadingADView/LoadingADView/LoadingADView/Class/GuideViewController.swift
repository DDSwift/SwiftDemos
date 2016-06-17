//
//  GuideViewController.swift
//  LoadingADView
//
//  Created by SuperDanny on 16/3/7.
//  Copyright © 2016年 SuperDanny. All rights reserved.
//

import UIKit

private let iPhone35 = "iphone35"
private let iPhone40 = "iphone40"
private let iPhone47 = "iphone47"
private let iPhone55 = "iphone55"

class GuideViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    private var collectionV: UICollectionView?
    private var pageController = UIPageControl(frame: CGRect(x: 0, y: ScreenHeight-30, width: ScreenWidth, height: 20))
    private var guideImagesDic = [iPhone35 : ["guide_35_1", "guide_35_2", "guide_35_3", "guide_35_4"],
                                  iPhone40 : ["guide_40_1", "guide_40_2", "guide_40_3", "guide_40_4"]]
    private let cellIdentity   = "Cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.sharedApplication().setStatusBarHidden(false, withAnimation: .None)
        buildCollectionView()
        buildPageController()
    }
    
    // MARK: - Build UI
    private func buildCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing      = 0
        layout.itemSize                = ScreenBounds.size
        layout.scrollDirection         = .Horizontal
        
        collectionV = UICollectionView(frame: ScreenBounds, collectionViewLayout: layout)
        collectionV!.delegate      = self
        collectionV!.dataSource    = self
        collectionV!.pagingEnabled = true
        collectionV!.bounces       = false
        collectionV!.showsHorizontalScrollIndicator = false
        collectionV!.showsVerticalScrollIndicator   = false
        collectionV?.registerClass(GuideCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentity)
        self.view.addSubview(collectionV!)
    }
    
    private func buildPageController() {
        pageController.numberOfPages = guideImagesDic[iPhone35]!.count
        pageController.currentPage = 0
        view.addSubview(pageController)
    }
    
    //MARK: UICollectionViewDataSource
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return guideImagesDic[iPhone35]!.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellIdentity, forIndexPath: indexPath) as! GuideCollectionViewCell
        var keyString: String?
        switch UIDevice.currentDeviceScreenMeasurement() {
        case 3.5:
            keyString = iPhone35
        case 4.0:
            keyString = iPhone40
        default:
            keyString = iPhone40
        }
        let dataArr = guideImagesDic[keyString!]!
        cell.image = UIImage(named: dataArr[indexPath.row])
        if indexPath.row == dataArr.count - 1 {
            cell.setHiddenNextButton(false)
        } else {
            cell.setHiddenNextButton(true)
        }
        return cell
    }
    
    // MARK: - UIScrollViewDelegate
    func scrollViewDidScroll(scrollView: UIScrollView) {
        pageController.currentPage = Int(scrollView.contentOffset.x / ScreenWidth + 0.5)
    }
    
    // MARK: -
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
