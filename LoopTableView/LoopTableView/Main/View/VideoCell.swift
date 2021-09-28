//
//  VideoCell.swift
//  LoopTableView
//
//  Created by IrvingHuang on 2021/9/28.
//

import UIKit
import Kingfisher

class VideoCell: UITableViewCell {
    static let cellIdentifier = "VideoCell"
    
    let view = VideoView()
    var data: Video?
    
    public func updateData(data: Video) {
        self.data = data
        view.imageView.kf.indicatorType = .activity
        view.imageView.kf.setImage(
            with: data.imageURL,
            placeholder: UIImage(named: "image_default"),
            options: [
                .cacheOriginalImage,
                .scaleFactor(UIScreen.main.scale)
            ])
        {
            [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(_):
                UIView.performWithoutAnimation {
                    self.tableView?.beginUpdates()
//                    self.layoutIfNeeded()
                    self.tableView?.endUpdates()
                }
            case .failure(_):
                self.view.imageView.image = UIImage(named: "image_failed")
            }
        }
        view.titleLabel.text = data.title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    private func setupLayout() {
        contentView.addSubview(view)
        view.edgeWithSuperView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        view.imageView.kf.cancelDownloadTask()
        view.imageView.kf.setImage(with: URL(string: ""))
        view.imageView.image = nil
        view.titleLabel.text = ""
    }
}

class VideoView: UIView {
    
    lazy var imageView = UIImageView()
    lazy var titleLabel = UILabel()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        setupViews()
        setupLayout()
    }
    
    private func setupViews() {
        titleLabel.textColor = .darkText
        titleLabel.font = .systemFont(ofSize: 24, weight: .heavy)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.numberOfLines = 0
        titleLabel.setContentHuggingPriority( .init(rawValue: 252), for: .vertical)
        addSubview(titleLabel)
        
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
    }
    
    private func setupLayout() {
        let views: ViewsDictionary = [
            "text": titleLabel,
            "img": imageView
        ]
        
        let vfls: VFLDictionary = [
            "H:|-(8)-[text]-(8)-|": [],
            "H:|-(0)-[img]-(0)-|": [],
            "V:|-(5)-[text]-(8)-[img]-(8)-|": []
        ]
        
        var constraints = [NSLayoutConstraint]()
        constraints += constraintsArrayVFL(vfls, views: views)
        NSLayoutConstraint.activate(constraints)
    }
}

extension UITableViewCell {
    var tableView: UITableView? {
        var view = superview
        while let v = view, v.isKind(of: UITableView.self) == false {
            view = v.superview
        }
        return view as? UITableView
    }
}
