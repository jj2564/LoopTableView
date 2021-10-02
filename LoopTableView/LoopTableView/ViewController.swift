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
        navigationItem.title = "Hello VoiceTube"
        
        setupView()
    }
    
    private func setupView() {
        let btn1 = createButton(title: "One", action: #selector(toQuizOne))
        let btn2 = createButton(title: "Two", action: #selector(toQuizTwo))
        view.addSubview(btn1)
        view.addSubview(btn2)
        
        let views: ViewsDictionary = [
            "one": btn1,
            "two": btn2
        ]
        let vfls: VFLDictionary = [
            "H:|-(8)-[one]-(8)-|": [],
            "H:|-(8)-[two]-(8)-|": [],
            "V:|-(150)-[one(44)]-(50)-[two(44)]": .alignAllCenterX
        ]
        
        var constraints = [NSLayoutConstraint]()
        constraints += constraintsArrayVFL(vfls, views: views)
        NSLayoutConstraint.activate(constraints)
    }
    
    private func createButton( title: String, action: Selector) -> UIButton {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle( title, for: .normal)
        btn.addTarget( self, action: action, for: .touchUpInside)
        btn.setTitleColor( .systemBlue, for: .normal)
        
        return btn
    }
    
    @objc private func toQuizOne() {
        let vc = AppQuizListVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func toQuizTwo() {
        let vc = CountDownTimerVC()
        navigationController?.pushViewController(vc, animated: true)
    }

}
