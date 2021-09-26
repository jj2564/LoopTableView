//
//  ViewController.swift
//  LoopTableView
//
//  Created by IrvingHuang on 2021/9/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        fetchData()
    }
    
    public func fetchData() {
        let req = GetAppQuiz()
        ApiManager.fetch(from: req) { [weak self] result in
            guard let _ = self else { return }
            switch result {
            case .success(let data):
                print(data)
            case .failure(let error):
                print(error.message)
            }
        }
    }


}

struct GetAppQuiz: ApiRequest {
    typealias Response = AppQuiz
    
    let parameters: JSONDictionary? = [
        "username": "VoiceTube",
        "password": "interview"
    ]
    let urlString: String = "https://us-central1-lithe-window-713.cloudfunctions.net/appQuiz"
    let methoid: HTTPMethod = .POST
    let contentType: ContentType = .json
}
