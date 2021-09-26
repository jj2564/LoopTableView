//
//  ApiEnum.swift
//  LoopTableView
//
//  Created by IrvingHuang on 2021/9/23.
//

import Foundation

enum ApiError: Error {
    
    case networkError
    
    case invalidUrl
    
    case nilData
    
    case jsonError
    
    var message: String {
        switch self {
        case .networkError: return "網路連線錯誤"
        case .invalidUrl: return "網址錯誤"
        case .nilData: return "無資料"
        case .jsonError: return "JSON解析錯誤"
        }
    }
}

enum HTTPMethod: String {
    case GET
    case POST
}

enum ContentType: String {
    case json = "application/json; charset=utf-8"
}
