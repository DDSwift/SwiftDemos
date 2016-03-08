//
//  AppDelegate.swift
//  LoadingADView
//
//  Created by SuperDanny on 16/3/7.
//  Copyright © 2016年 SuperDanny. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var adViewController: ADViewController?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        addNotification()
        buildKeyWindow()
        return true
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func addNotification() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "showMainTabbarControllerSuccess:", name: ADImageLoadSuccess, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "showMainTabbarControllerFale", name: ADImageLoadFail, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "shoMainTabBarController", name: GuideViewControllerDidFinish, object: nil)
    }
    
    // MARK: - Action
    func shoMainTabBarController() {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let tabbar = sb.instantiateViewControllerWithIdentifier("mainIdentifier")
        window?.rootViewController = tabbar
    }
    func showMainTabbarControllerSuccess(noti: NSNotification) {
        let adImage = noti.object as! UIImage
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let tabbar = sb.instantiateViewControllerWithIdentifier("mainIdentifier") as! MainTabBarViewController
        tabbar.adImage = adImage
        window?.rootViewController = tabbar
    }
    func showMainTabbarControllerFale() {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let tabbar = sb.instantiateViewControllerWithIdentifier("mainIdentifier")
        window?.rootViewController = tabbar
    }
    
    
    func buildKeyWindow() {
        window = UIWindow(frame: ScreenBounds)
        window?.makeKeyAndVisible()
        let isFirstOpen = NSUserDefaults.standardUserDefaults().objectForKey("FirstOpenAPP")
        if isFirstOpen == nil {
            window?.rootViewController = GuideViewController()
            NSUserDefaults.standardUserDefaults().setObject(false, forKey: "FirstOpenAPP")
        } else {
            buildADRootViewController()
        }
    }
    
    func buildADRootViewController() {
        adViewController = ADViewController()
        weak var tmpSelf = self
        ADModel.loadData { (model, error) -> Void in
            if model?.data?.img_url != nil {
                tmpSelf!.adViewController!.imageURL = model!.data!.img_url
                tmpSelf!.window?.rootViewController = self.adViewController
            }
        }
    }
}

