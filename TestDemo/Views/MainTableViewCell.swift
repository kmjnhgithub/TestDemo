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
    
    private let labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10 // Set the space between labels
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false // Enable Auto Layout
        return stackView
    }()
    
    // 場館
    private let siteLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0 // 允許多行顯示
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false // 啟用Auto Layout
        return label
    }()
    
    // 資訊
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2 // 允許多行顯示
        label.lineBreakMode = .byTruncatingTail // 在單詞邊界處自動換行，末尾會以「…」來代替被裁掉的文字
        label.font = .systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false // 啟用Auto Layout
        return label
    }()
    
    // 休館時間
    private let memoLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1 // 允許多行顯示
        label.lineBreakMode = .byWordWrapping // 在單詞邊界處自動換行
        label.font = .systemFont(ofSize: 13, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false // 啟用Auto Layout
        label.heightAnchor.constraint(equalToConstant: 20).isActive = true // 添加高度約束，假如沒資料的話還是要留一個空間出來，讓整體能夠一致
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
        contentView.addSubview(labelStackView)
        contentView.addSubview(arrowButton)
        
        labelStackView.addArrangedSubview(siteLabel)
        labelStackView.addArrangedSubview(infoLabel)
        labelStackView.addArrangedSubview(memoLabel)
        
        applyConstraints()
    }
    
    private func applyConstraints() {
        
        // 圖片視圖設定約束
        let sitePosterUIImageViewConstraints = [
            sitePosterUIImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10), //  左邊距離contentView 10單位
            sitePosterUIImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10), // 距離 contentView 頂部 10 單位
            sitePosterUIImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10), // 距離 contentView 底部 10 單位
            sitePosterUIImageView.widthAnchor.constraint(equalToConstant: 120) // 寬度固定為 100 單位
        ]
        
        // Set constraints for the stack view
        let labelStackViewConstraints = [
            labelStackView.leadingAnchor.constraint(equalTo: sitePosterUIImageView.trailingAnchor, constant: 10), // attach to the right of titlesPosterUIImageView, spacing 20 units
            labelStackView.trailingAnchor.constraint(equalTo: arrowButton.leadingAnchor, constant: -10), // ensure titleLabel does not overlap with playTitleButton
            labelStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor), // vertically center in contentView
        ]
        
        // 按鈕視圖設定約束
        let arrowButtonConstraints = [
//            arrowButton.widthAnchor.constraint(equalToConstant: 50),
            arrowButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20), // 緊貼在 contentView 右邊，間隔 -20 單位
            arrowButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor) // 垂直置中於 contentView
        ]
        
        // 啟用佈局約束
        NSLayoutConstraint.activate(sitePosterUIImageViewConstraints)
        NSLayoutConstraint.activate(labelStackViewConstraints)
        NSLayoutConstraint.activate(arrowButtonConstraints)
    }
    
    public func configure(with model: SiteViewModel) {

        guard let url = URL(string: "\(model.ePicUrl ?? "")") else {
            return
        }
        sitePosterUIImageView.sd_setImage(with: url, completed: nil) // 使用SDWebImage庫來非同步加載圖片
        siteLabel.text = model.eName
        infoLabel.text = model.eInfo
        memoLabel.text = model.eMemo
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}
