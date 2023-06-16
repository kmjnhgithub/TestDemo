//
//  MainViewController.swift
//  TestDemo
//
//  Created by mike liu on 2023/6/14.
//

import UIKit
import RxCocoa
import RxSwift

class SiteViewController: UIViewController {
    
    private var sitesSubject = BehaviorSubject<[SiteResponse]>(value: [])
    private var disposeBag = DisposeBag()
    
    private let mainTable: UITableView = {
        let table = UITableView()
        table.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.identifier)
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        // 調用configureNavbar方法來配置導覽列。
        configureNavbar()
        
        title = "台北市立動物園"
        
        view.addSubview(mainTable)

        
        fetchData()
        bindTableView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        mainTable.frame = view.bounds // 最終把 upcomingTable 加入view裏面並符合view的邊界
    }
    
    //  RxSwift 以及 RxCocoa 的方法來設定 UITableView 的 delegate 和 datasource
    func bindTableView() {
        mainTable.rx.setDelegate(self).disposed(by: disposeBag)
        
        // 為 mainTable 的選擇事件添加了一個訂閱
        mainTable.rx.modelSelected(SiteResponse.self).subscribe(onNext: { [weak self] site in
            guard site.eName != nil else {return}
            
            let vc = DetailViewController()
            vc.hidesBottomBarWhenPushed = true  // 在此設定
            vc.configure(with: SiteDetailViewModel(ePicUrl: site.httpsPicUrl, eName: site.eName, eInfo: site.eInfo, eMemo: site.eMemo, eCategory: site.eCategory))
            self?.navigationController?.pushViewController(vc, animated: true)
        }).disposed(by: disposeBag)
        
        // 
        sitesSubject.bind(to: mainTable.rx.items(cellIdentifier: MainTableViewCell.identifier, cellType: MainTableViewCell.self)) { (row, site, cell) in
            cell.configure(with: SiteViewModel(ePicUrl: site.httpsPicUrl ?? "", eName: site.eName ?? "", eInfo: site.eInfo ?? "", eMemo: site.eMemo ?? ""))
        }.disposed(by: disposeBag)
    }
    

    private func configureNavbar() {
        
        
        // 創建一個圖像，並設定該圖像為導覽項目的左邊按鈕。
        let image = UIImage(named: "option")
        
        // 將所有 UIBarButtonItem 的顏色設定為同一個顏色
        navigationController?.navigationBar.tintColor = UIColor.darkGray
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .done, target: self, action: nil)
        
        
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.backgroundColor = .systemBackground
        
        // navigation bar 在不滾動的時候的外觀
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        // 滾動到邊緣時的外觀
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
  
    }
    
    // 取得api
    private func fetchData() {
        APICaller.shared.getZooDataAPI{ [weak self] result in
            switch result {
            case .success(let sites):
                self?.sitesSubject.onNext(sites)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
  
}


extension SiteViewController: UITableViewDelegate {
    // 設定行高
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}
