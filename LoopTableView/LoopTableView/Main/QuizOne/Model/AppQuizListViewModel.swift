//
//  AppQuizListViewModel.swift
//  LoopTableView
//
//  Created by IrvingHuang on 2021/9/27.
//

import Foundation

class AppQuizListViewModel {
    init() {}
    
    public var datas: [Video] = []
    public var reloadHandler: (() -> Void)?
    
    public func fetchData() {
        let req = GetAppQuiz()
        ApiManager.fetch(from: req) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                if data.status == "success" {
                    self.configureModel(list: data.videos)
                }
            case .failure(let error):
                print(error.message)
            }
        }
    }
    
    private func configureModel(list: [Video]) {
        datas = list
        reloadHandler?()
    }
}

fileprivate struct GetAppQuiz: ApiRequest {
    typealias Response = AppQuiz
    
    let parameters: JSONDictionary? = [
        "username": "VoiceTube",
        "password": "interview"
    ]
    let urlString: String = "https://us-central1-lithe-window-713.cloudfunctions.net/appQuiz"
    let methoid: HTTPMethod = .POST
    let contentType: ContentType = .json
}
