//
//  HomeService.swift
//  BlogClient
//
//  Created by Long on 2020/5/19.
//  Copyright © 2020 LongMac. All rights reserved.
//

import Foundation

class HomeService {
    // 首页博文列表
    static func getHomeBlogListInfo(pageSize: Int, pageIndex: Int, callBack: @escaping ServiceCompleteBlock) {
        let parameter = [API.rpk.pageIndex : pageIndex, API.rpk.pageSize : pageSize]
        NetworkTool.request(url: API.url.blogpostsSitehome, parameter: parameter) { (response) in
        
            switch response.result {
            case .success(let result):
                log("success")
                
                if let jsonArray = result as? [Any] {
                    let itemModels = jsonArray.kj.modelArray(type: BlogItem.self)
                    callBack(itemModels, .success)
                } else {
                    callBack([], .success)
                }
            case .failure(let error):
                log("fail")
                callBack(error, .failure)
            }
        }
    }
    
    // 首页博文内容
    static func getHomeBlogInfo(url: String, callBack: @escaping ServiceCompleteBlock) {
        NetworkTool.request(url: url, parameter: nil) { (response) in
            switch response.result {
            case .success(let result):
                callBack(result, .success)
            case .failure(let error):
                callBack(error, .failure)
            }
        }
    }
}
