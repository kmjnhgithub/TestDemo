//
//  MainTableViewCell.swift
//  TestDemo
//
//  Created by mike liu on 2023/6/14.
//

import UIKit
import SDWebImage

class MainTableViewCell: UITableViewCell {
    
    static let identifier = "MainTableViewCell"
    
    // 播放按鈕
    private let arrowButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "chevron.right", withConfiguration: UIImage.SymbolConfiguration(pointSize: 15, weight: .bold)) // 自定義系統圖片大小，使用大小為30的圖片配置
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false // 啟用Auto Layout
        button.tintColor = .black
        return button
    }()
    
    // 場館
    private let siteLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0 // 允許多行顯示
        label.lineBreakMode = .byWordWrapping // 在單詞邊界處自動換行
        label.translatesAutoresizingMaskIntoConstraints = false // 啟用Auto Layout
        return label
    }()
    
    // 資訊
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0 // 允許多行顯示
        label.lineBreakMode = .byWordWrapping // 在單詞邊界處自動換行
        label.translatesAutoresizingMaskIntoConstraints = false // 啟用Auto Layout
        return label
    }()
    
    // 場館圖片
    private let sitePosterUIImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill // 讓圖片充滿並保持原始比例
        imageView.translatesAutoresizingMaskIntoConstraints = false // 啟用Auto Layout
        imageView.clipsToBounds = true // 讓超過邊界的內容被切掉
        
        return imageView
    }()
    
    // 初始化
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier) // 呼叫父類別的初始化方法
        
        // 將創建好的視圖添加到內容視圖中
        contentView.addSubview(sitePosterUIImageView)
        contentView.addSubview(siteLabel)
//        contentView.addSubview(infoLabel)
        contentView.addSubview(arrowButton)
        
        applyConstraints()
    }
    
    private func applyConstraints() {
        
        // 圖片視圖設定約束
        let sitePosterUIImageViewConstraints = [
            sitePosterUIImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10), //  左邊距離contentView 10單位
            sitePosterUIImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10), // 距離 contentView 頂部 10 單位
            sitePosterUIImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10), // 距離 contentView 底部 10 單位
            sitePosterUIImageView.widthAnchor.constraint(equalToConstant: 100) // 寬度固定為 100 單位
        ]
        
        // 名稱視圖設定約束
        let siteLabelConstraints = [

            siteLabel.leadingAnchor.constraint(equalTo: sitePosterUIImageView.trailingAnchor, constant: 20), // 緊貼在 titlesPosterUIImageView 右邊，間隔 20 單位
            siteLabel.trailingAnchor.constraint(equalTo: arrowButton.leadingAnchor, constant: -10), // 確保titleLabel不會與playTitleButton重疊
            siteLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor), // 垂直置中於 contentView
        ]
        
        // 按鈕視圖設定約束
        let arrowButtonConstraints = [
            arrowButton.widthAnchor.constraint(equalToConstant: 50),
            arrowButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20), // 緊貼在 contentView 右邊，間隔 -20 單位
            arrowButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor) // 垂直置中於 contentView
        ]
        
        // 啟用佈局約束
        NSLayoutConstraint.activate(sitePosterUIImageViewConstraints)
        NSLayoutConstraint.activate(siteLabelConstraints)
        NSLayoutConstraint.activate(arrowButtonConstraints)
    }
    
    public func configure(with model: SiteViewModel) {

        guard let url = URL(string: "\(model.ePicUrl)") else {
            return
        }
        sitePosterUIImageView.sd_setImage(with: url, completed: nil) // 使用SDWebImage庫來非同步加載圖片
        siteLabel.text = model.eName
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}
