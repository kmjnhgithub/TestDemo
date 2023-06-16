//
//  DetailViewController.swift
//  TestDemo
//
//  Created by mike liu on 2023/6/15.
//
import UIKit

class DetailViewController: UIViewController {
    
    var siteNameTitle: String = ""
    
    // add a scrollView
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // 場館圖片
    private let siteDetailPosterUIImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill // 讓圖片充滿並保持原始比例
        imageView.translatesAutoresizingMaskIntoConstraints = false // 啟用Auto Layout
        imageView.clipsToBounds = true // 讓超過邊界的內容被切掉
        return imageView
    }()
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0 // 允許多行顯示
        label.font = .systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false // 啟用Auto Layout
        return label
    }()
    
    private let memoLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0 // 允許多行顯示
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false // 啟用Auto Layout
//
        
        return label
    }()
    
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0 // 允許多行顯示
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false // 啟用Auto Layout
        return label
    }()
    
    private let videoButton: UIButton = {
        let button = UIButton()
        button.setTitle("在網頁開啟", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .bold)
        button.addTarget(DetailViewController.self, action: #selector(buttonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        // add the scrollView and contentView to the view hierarchy
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        // add all your subviews to the contentView instead of the view
        contentView.addSubview(siteDetailPosterUIImageView)
        contentView.addSubview(infoLabel)
        contentView.addSubview(memoLabel)
        contentView.addSubview(categoryLabel)
        contentView.addSubview(videoButton)
        
        configureConstraints()
        
        // 將返回按鈕的標題設為空
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        title = siteNameTitle
    }
    
    @objc func buttonTapped() {
        print("Button tapped!")
    }
    
    
    func configureConstraints() {
        
        let scrollViewConstraints = [
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        
        let contentViewConstraints = [
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ]
        
        let siteDetailImageViewConstraints = [
            siteDetailPosterUIImageView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            siteDetailPosterUIImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            siteDetailPosterUIImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            siteDetailPosterUIImageView.heightAnchor.constraint(equalToConstant: 200)
        ]

        let infoLabelViewConstraints = [
            infoLabel.topAnchor.constraint(equalTo: siteDetailPosterUIImageView.bottomAnchor, constant: 10),
            infoLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            infoLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
        ]

        let memoLabelViewConstraints = [
            memoLabel.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 20),
            memoLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            memoLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
        ]

        let categoryLabelViewConstraints = [
            categoryLabel.topAnchor.constraint(equalTo: memoLabel.bottomAnchor, constant: 5),
            categoryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            categoryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ]

        let videoButtonViewConstraints = [
            videoButton.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 20),
            videoButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            videoButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20) // 讓滾動視圖知道內容的高度
        ]
        
        NSLayoutConstraint.activate(scrollViewConstraints)
        NSLayoutConstraint.activate(contentViewConstraints)
        NSLayoutConstraint.activate(siteDetailImageViewConstraints)
        NSLayoutConstraint.activate(infoLabelViewConstraints)
        NSLayoutConstraint.activate(memoLabelViewConstraints)
        NSLayoutConstraint.activate(categoryLabelViewConstraints)
        NSLayoutConstraint.activate(videoButtonViewConstraints)
        
    }
    
    

     // 配置細節的畫面
    func configure(with model: SiteDetailViewModel) {
        guard let url = URL(string: "\(model.ePicUrl ?? "")") else {
            return
        }
        
        siteDetailPosterUIImageView.sd_setImage(with: url, completed: nil)
        siteNameTitle = model.eName ?? ""
        infoLabel.text = model.eInfo ?? ""
        memoLabel.text = model.eMemo ?? ""
        categoryLabel.text = model.eCategory ?? ""
//        titleLabel.text = model.title
//        overviewLabel.text = model.titleOverview

    }

}
