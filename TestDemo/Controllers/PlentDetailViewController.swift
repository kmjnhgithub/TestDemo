//
//  PlentDetailViewController.swift
//  TestDemo
//
//  Created by mike liu on 2023/6/18.
//

import UIKit

class PlentDetailViewController: UIViewController {
    
    var plentNameTitle: String = ""
    
    private let plentDetailPosterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill // 讓圖片充滿並保持原始比例
        imageView.translatesAutoresizingMaskIntoConstraints = false // 啟用Auto Layout
        imageView.clipsToBounds = true // 讓超過邊界的內容被切掉
        return imageView
    }()
    
    private let nameChLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0 // 允許多行顯示
        label.font = .systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let alsoKnowLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let briefLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let featureLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let applicationLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let updateLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = plentNameTitle
        
        view.addSubview(plentDetailPosterImageView)
        view.addSubview(nameChLabel)
        view.addSubview(alsoKnowLabel)
        view.addSubview(briefLabel)
        view.addSubview(featureLabel)
        view.addSubview(applicationLabel)
        view.addSubview(updateLabel)
        
        configureConstraints()

    }
    
    private func configureConstraints() {
        
        let plentDetailPosterImageViewConstraints = [
            plentDetailPosterImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            plentDetailPosterImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            plentDetailPosterImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            plentDetailPosterImageView.heightAnchor.constraint(equalToConstant: 200)
        ]
        
        let nameChLabelViewConstraints = [
            nameChLabel.topAnchor.constraint(equalTo: plentDetailPosterImageView.bottomAnchor, constant: 20),
            nameChLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//            nameChLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ]
        
        let alsoKnowLabelViewConstraints = [
            alsoKnowLabel.topAnchor.constraint(equalTo: nameChLabel.bottomAnchor, constant: 20),
            alsoKnowLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            alsoKnowLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 20),
        ]
        
        let briefLabelViewConstraints = [
            briefLabel.topAnchor.constraint(equalTo: alsoKnowLabel.bottomAnchor, constant: 20),
            briefLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            briefLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 20)
        ]
        
        let featureLabelViewConstraints = [
            featureLabel.topAnchor.constraint(equalTo: briefLabel.bottomAnchor, constant: 20),
            featureLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            featureLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 20)
        ]
        
        let applicationLabelViewConstraints = [
            applicationLabel.topAnchor.constraint(equalTo: featureLabel.bottomAnchor, constant: 20),
            applicationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            applicationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 20)
        ]
        
        let updateLabelViewConstraints = [
            updateLabel.topAnchor.constraint(equalTo: applicationLabel.bottomAnchor, constant: 20),
            updateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            updateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 20)
        ]
        
        NSLayoutConstraint.activate(plentDetailPosterImageViewConstraints)
        NSLayoutConstraint.activate(nameChLabelViewConstraints)
        NSLayoutConstraint.activate(alsoKnowLabelViewConstraints)
        NSLayoutConstraint.activate(briefLabelViewConstraints)
        NSLayoutConstraint.activate(featureLabelViewConstraints)
        NSLayoutConstraint.activate(applicationLabelViewConstraints)
        NSLayoutConstraint.activate(updateLabelViewConstraints)
        
    }
    

    
    
    // 配置細節的畫面
   func plentConfigure(with model: PlentDetailViewModel) {
       guard let url = URL(string: "\(model.pic01URL ?? "")") else {
           return
       }
       
       plentDetailPosterImageView.sd_setImage(with: url, completed: nil)
       plentNameTitle = model.nameCh ?? ""
       nameChLabel.text = "\(model.nameCh ?? "")\n\(model.nameEn ?? "")"
       alsoKnowLabel.text = "別名\n\(model.alsoKnown ?? "")"
       briefLabel.text = "簡介\n\(model.brief ?? "")"
       featureLabel.text = "辨識方式\n\(model.feature ?? "")"
       applicationLabel.text = "功能性\n\(model.functionApplication ?? "")"
       updateLabel.text = "最後更新 : \(model.update)"

   }

}
