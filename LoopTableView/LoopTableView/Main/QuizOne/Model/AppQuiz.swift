//
//  AppQuiz.swift
//  LoopTableView
//
//  Created by IrvingHuang on 2021/9/26.
//

import Foundation

struct AppQuiz: Decodable {
    var status: String = ""
    var videos: [Video] = []
    
    enum CodingKeys: String, CodingKey {
        case status
        case videos
    }
    
    init() {}
}


struct Video: Decodable {
    var title: String = ""
    var imageURL: URL?
    
    enum CodingKeys: String, CodingKey {
        case title
        case img
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decodeIfPresent(String.self, forKey: .title) ?? ""
        var imgURL = try container.decodeIfPresent(String.self, forKey: .img) ?? ""
        imgURL = imgURL.replacingOccurrences(of: "http", with: "https")
        imageURL = URL(string: imgURL)
    }
    
    init() {}
}
