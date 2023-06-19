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
        mainTable.frame = view.bounds // 最終把 mainTable 加入view裏面並符合view的邊界
    }
    
    //  RxSwift 以及 RxCocoa 的方法來設定 UITableView 的 delegate 和 datasource
    func bindTableView() {
        // 使用RxSwift的setDelegate函數為mainTable設定委託，這樣就可以使用RxSwift的響應式編程風格處理表格視圖事件
        mainTable.rx.setDelegate(self).disposed(by: disposeBag)
        
        // 為mainTable的選擇事件添加一個訂閱。每當表格視圖的一個單元格被選中，都會發出一個新的site（SiteResponse類型）
        mainTable.rx.modelSelected(SiteResponse.self).subscribe(onNext: { [weak self] site in
            
            // 確保self（SiteViewController）還存在並且表格視圖有一個選中的單元格。如果這兩者之一不存在，則不進行任何操作並返回
            guard let self = self, let selectedIndexPath = self.mainTable.indexPathForSelectedRow else { return }
            
            // 以動畫的形式取消選中該行
            self.mainTable.deselectRow(at: selectedIndexPath, animated: true)
            
            // 確保site有一個名稱。如果它沒有名稱，則不進行任何操作並返回
            guard site.eName != nil else {return}
            
            // 創建一個SiteDetailViewController並為其配置SiteDetailViewModel
            let vc = SiteDetailViewController()
            vc.hidesBottomBarWhenPushed = true
            vc.siteConfigure(with: SiteDetailViewModel(ePicUrl: site.httpsPicUrl, eName: site.eName, eInfo: site.eInfo, eMemo: site.eMemo, eCategory: site.eCategory))
            
            
            self.navigationController?.pushViewController(vc, animated: true)
        }).disposed(by: disposeBag) // 確保訂閱在SiteViewController釋放時被釋放，以防止記憶體泄漏
        
        // 使sitesSubject（BehaviorSubject）和表格視圖的單元格建立綁定。每當sitesSubject發出一個新的site列表，都會更新表格視圖的單元格
        sitesSubject.bind(to: mainTable.rx.items(cellIdentifier: MainTableViewCell.identifier, cellType: MainTableViewCell.self)) { (row, site, cell) in
            // 為每一個單元格配置一個SiteViewModel
            cell.configure(with: SiteViewModel(ePicUrl: site.httpsPicUrl ?? "", eName: site.eName ?? "", eInfo: site.eInfo ?? "", eMemo: site.eMemo ?? ""), with: nil)
        }.disposed(by: disposeBag) // 確保綁定在SiteViewController釋放時被釋放，以防止記憶體泄漏
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
        APICaller.shared.getZooDataAPI()
            .subscribe(onNext: { [weak self] sites in
                self?.sitesSubject.onNext(sites)
            }, onError: { error in
                print(error.localizedDescription)
            })
            .disposed(by: disposeBag)
    }
  
}


extension SiteViewController: UITableViewDelegate {
    // 設定行高
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}
