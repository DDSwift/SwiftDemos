//
//  ADModel.swift
//  LoadingADView
//
//  Created by SuperDanny on 16/3/7.
//  Copyright © 2016年 SuperDanny. All rights reserved.
//

import UIKit

class ADModel: NSObject {
    
    var code: Int = 0

    var data: Data?

    var reqid: String?

    var msg: String?
    
    class func loadData(completion:(model: ADModel?, error: NSError?) -> Void) {
        let path = NSBundle.mainBundle().pathForResource("AD", ofType: nil)
        let data = NSData(contentsOfFile: path!)
        if data != nil {
            let dict: NSDictionary = (try! NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)) as! NSDictionary
            let modelTool = DictModelManager.sharedManager
            let data = modelTool.objectWithDictionary(dict, cls: ADModel.self) as? ADModel
            completion(model: data!, error: nil)
        }
    }
    static func customClassMapping() -> [String : String]? {
        return ["data" : "\(Data.self)"]
    }
    
}

class Data: NSObject {

    var img_name: String?

    var starttime: String?

    var title: String?

    var endtime: String?

    var img_big_name: String?

    var img_url: String?

}

