//
//  PlentViewController.swift
//  TestDemo
//
//  Created by mike liu on 2023/6/15.
//

import UIKit
import RxCocoa
import RxSwift


class PlentViewController: UIViewController {
    
    private var plentSubject = BehaviorSubject<[PlentResponse]>(value: [])
    private var disposeBag = DisposeBag()
    
    private let plentTable: UITableView = {
        let table = UITableView()
        table.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.identifier)
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        title = "植物資料"
        
        view.addSubview(plentTable)
        
        configureNavbar()
        bindPlentTableView()
        fetchPlentData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        plentTable.frame = view.bounds // 把 plentTable 加入view裏面並符合view的邊界
    }
    
    //  RxSwift 以及 RxCocoa 的方法來設定 UITableView 的 delegate 和 datasource
    func bindPlentTableView() {
        // 使用RxSwift的setDelegate函數為mainTable設定委託，這樣就可以使用RxSwift的響應式編程風格處理表格視圖事件
        plentTable.rx.setDelegate(self).disposed(by: disposeBag)
        
        // 為mainTable的選擇事件添加一個訂閱。每當表格視圖的一個單元格被選中，都會發出一個新的site（SiteResponse類型）
        plentTable.rx.modelSelected(PlentResponse.self).subscribe(onNext: { [weak self] plent in
            
            // 確保self（SiteViewController）還存在並且表格視圖有一個選中的單元格。如果這兩者之一不存在，則不進行任何操作並返回
            guard let self = self, let selectedIndexPath = self.plentTable.indexPathForSelectedRow else { return }
            
            // 以動畫的形式取消選中該行
            self.plentTable.deselectRow(at: selectedIndexPath, animated: true)
            
            // 確保site有一個名稱。如果它沒有名稱，則不進行任何操作並返回
            guard plent.nameCh != nil else {return}
            
            // 創建一個SiteDetailViewController並為其配置PlentDetailViewModel
            let vc = PlentDetailViewController()
            vc.hidesBottomBarWhenPushed = true
            vc.plentConfigure(with: PlentDetailViewModel(
                pic01URL: plent.httpsPic01URL,
                nameCh: plent.nameCh,
                nameEn: plent.nameEn,
                alsoKnown: plent.alsoKnown,
                brief: plent.brief,
                feature: plent.feature,
                functionApplication: plent.functionApplication,
                update: plent.update ?? ""
            ))
            
            
            self.navigationController?.pushViewController(vc, animated: true)
        }).disposed(by: disposeBag) // 確保訂閱在SiteViewController釋放時被釋放，以防止記憶體泄漏
        
        // 使sitesSubject（BehaviorSubject）和表格視圖的單元格建立綁定。每當sitesSubject發出一個新的site列表，都會更新表格視圖的單元格
        plentSubject.bind(to: plentTable.rx.items(
                cellIdentifier: MainTableViewCell.identifier,
                cellType: MainTableViewCell.self)) { (row, plent, cell) in
                    // 為每一個單元格配置一個SiteViewModel
                    cell.configure(
                        with: nil,
                        with: PlentViewModel(
                            nameCh: plent.nameCh,
                            alsoKnown: plent.alsoKnown,
                            pic01URL: plent.httpsPic01URL)
                    )
                }.disposed(by: disposeBag) // 確保綁定在SiteViewController釋放時被釋放，以防止記憶體泄漏
    }
    
    private func configureNavbar() {
            let image = UIImage(named: "option")
            navigationController?.navigationBar.tintColor = UIColor.darkGray
            navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .done, target: self, action: nil)
            
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.backgroundColor = .systemBackground
            navigationController?.navigationBar.standardAppearance = navBarAppearance
            navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        }
    
    // 取得api
    private func fetchPlentData() {
        APICaller.shared.getPlentDataAPI()
            .subscribe(onNext: { [weak self] sites in
                self?.plentSubject.onNext(sites)
            }, onError: { error in
                print(error.localizedDescription)
            })
            .disposed(by: disposeBag)
    }
}


extension PlentViewController: UITableViewDelegate {
    // 設定行高
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}
