//
//  DetailViewController.swift
//  TestDemo
//
//  Created by mike liu on 2023/6/15.
//
import UIKit

class SiteDetailViewController: UIViewController {
    
    var siteNameTitle: String = ""
    var videoURL = ""
    
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
    
    private lazy var videoButton: UIButton = {
        let button = UIButton()
        button.setTitle("在網頁開啟", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .bold)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // categoryLabel / videoButton 水平平行放在這個stack裡
    private lazy var stackView: UIStackView = {
        let spacer = UIView() // 建立一個空視圖來作為彈性空間
        spacer.setContentHuggingPriority(.defaultLow, for: .horizontal) // 讓彈性空間有最低的擠壓優先權，以盡可能的擴展寬度
        
        let stackView = UIStackView(arrangedSubviews: [categoryLabel, spacer, videoButton]) // 將彈性空間插入到 categoryLabel 和 videoButton 之間
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
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
        contentView.addSubview(stackView)
        
        configureConstraints()
        
        // 將返回按鈕的標題設為空
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        title = siteNameTitle
    }
    
    @objc func buttonTapped() {
        guard let url = URL(string: videoURL), UIApplication.shared.canOpenURL(url) else {
                print("Invalid URL.")
                return
            }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    
    private func configureConstraints() {
        
        // 定義 scrollView 的約束，讓它充滿整個 view
        let scrollViewConstraints = [
            scrollView.topAnchor.constraint(equalTo: view.topAnchor), // scrollView 的頂部與 view 的頂部對齊
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor), // scrollView 的底部與 view 的底部對齊
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor), // scrollView 的左側與 view 的左側對齊
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor) // scrollView 的右側與 view 的右側對齊
        ]
        
        // 定義 contentView 的約束，讓它充滿整個 scrollView，並與 scrollView 有同樣的寬度
        let contentViewConstraints = [
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor), // contentView 的頂部與 scrollView 的頂部對齊
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor), // contentView 的底部與 scrollView 的底部對齊
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor), // contentView 的左側與 scrollView 的左側對齊
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor), // contentView 的右側與 scrollView 的右側對齊
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor) // contentView 的寬度等於 scrollView 的寬度
        ]
        
        // 定義 siteDetailPosterUIImageView 的約束，讓它佔滿 contentView 的寬度，並有固定的高度
        let siteDetailImageViewConstraints = [
            siteDetailPosterUIImageView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor), // siteDetailPosterUIImageView 的頂部與 contentView 的安全區域頂部對齊
            siteDetailPosterUIImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor), // siteDetailPosterUIImageView 的左側與 contentView 的左側對齊
            siteDetailPosterUIImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor), // siteDetailPosterUIImageView 的右側與 contentView 的右側對齊
            siteDetailPosterUIImageView.heightAnchor.constraint(equalToConstant: 200) // siteDetailPosterUIImageView 的高度為200
        ]
        
        // 定義 infoLabel 的約束，讓它在 siteDetailPosterUIImageView 下方，並佔滿 contentView 的寬度（但留有邊距）
        let infoLabelViewConstraints = [
            infoLabel.topAnchor.constraint(equalTo: siteDetailPosterUIImageView.bottomAnchor, constant: 10), // infoLabel 的頂部位於 siteDetailPosterUIImageView 的底部，並有10的間隔
            infoLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20), // infoLabel 的左側與 contentView 的左側對齊，並有20的間隔
            infoLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20), // infoLabel 的右側與 contentView 的右側對齊，並有20的間隔
        ]
        
        // 定義 memoLabel 的約束，讓它在 infoLabel 下方，並佔滿 contentView 的寬度（但留有邊距）
        let memoLabelViewConstraints = [
            memoLabel.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 20), // memoLabel 的頂部位於 infoLabel 的底部，並有20的間隔
            memoLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20), // memoLabel 的左側與 contentView 的左側對齊，並有20的間隔
            memoLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20), // memoLabel 的右側與 contentView 的右側對齊，並有20的間隔
        ]
        
        // 定義 stackView 的約束，讓它在 memoLabel 下方，並佔滿 contentView 的寬度（但留有邊距），而且它的底部是 contentView 的底部（這讓滾動視圖知道內容的高度）
        let stackViewConstraints = [
            stackView.topAnchor.constraint(equalTo: memoLabel.bottomAnchor, constant: 5), // stackView 的頂部位於 memoLabel 的底部，並有5的間隔
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20), // stackView 的左側與 contentView 的左側對齊，並有20的間隔
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20), // stackView 的右側與 contentView 的右側對齊，並有20的間隔
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20) // stackView 的底部位於 contentView 的底部，並有20的間隔（這讓滾動視圖知道內容的高度）
        ]
        
        // 啟用約束
        NSLayoutConstraint.activate(scrollViewConstraints)
        NSLayoutConstraint.activate(contentViewConstraints)
        NSLayoutConstraint.activate(siteDetailImageViewConstraints)
        NSLayoutConstraint.activate(infoLabelViewConstraints)
        NSLayoutConstraint.activate(memoLabelViewConstraints)
        NSLayoutConstraint.activate(stackViewConstraints)
        
    }
    
    

     // 配置細節的畫面
    func siteConfigure(with model: SiteDetailViewModel) {
        guard let url = URL(string: "\(model.ePicUrl ?? "")") else {
            return
        }
        
        siteDetailPosterUIImageView.sd_setImage(with: url, completed: nil)
        videoURL = model.eUrl ?? ""
        siteNameTitle = model.eName ?? ""
        infoLabel.text = model.eInfo ?? ""
        memoLabel.text = model.eMemo ?? ""
        categoryLabel.text = model.eCategory ?? ""
//        titleLabel.text = model.title
//        overviewLabel.text = model.titleOverview

    }

}
