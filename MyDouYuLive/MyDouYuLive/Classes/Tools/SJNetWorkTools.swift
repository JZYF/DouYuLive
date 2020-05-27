//
//  SJNetWorkTools.swift
//  MyDouYuLive
//
//  Created by song jian on 2020/5/27.
//  Copyright © 2020 song jian. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType {
    case GET
    case POST
}

class SJNetWorkTools {
    
    
    /// 网络请求方法
    /// - Parameters:
    ///   - methodType: 请求类型
    ///   - urlString: 请求地址
    ///   - params: 参数，可不传
    ///   - finishCallback: 回调，结果为json
    /// - Returns: 
    class func requestData(methodType: MethodType,
                           urlString: String,
                           params: [String: String]? = nil,
                           finishCallback: @escaping (_ result: Data) -> ()) -> () {
        let method = methodType == .GET ? HTTPMethod.get : HTTPMethod.post
        AF.request(urlString,
                   method:method,
                   parameters: params,
                   encoding: JSONEncoding.prettyPrinted).responseJSON { (response) in
                    print("Method:\(method)请求 \nURL: \(urlString) \n请求参数parameters:")
                    if params != nil{
                        print(params ?? String())
                    }
                    // 判断是否有返回数据
                    guard let res = response.value else {
                        print(response.error ?? "请求错误") // 打印错误信息
                        return
                    }
                    // 转为字典类型
                    guard let resDict = res as? [String: Any] else {
                        return
                    }
                    
                    // 返回Json数据
                    let resJson = try? JSONSerialization.data(withJSONObject: resDict, options: .prettyPrinted)
                    if resJson != nil {
                        finishCallback(resJson!)
                        return
                    }
                    
        }
    }
}
