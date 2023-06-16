//
//  MainViewController.swift
//  TestDemo
//
//  Created by mike liu on 2023/6/14.
//

import UIKit

class SiteViewController: UIViewController {
    
    private var sites: [SiteResponse] = [SiteResponse]()
    
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
        mainTable.delegate = self
        mainTable.dataSource = self
        
        fetchData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        mainTable.frame = view.bounds // 最終把 upcomingTable 加入view裏面並符合view的邊界
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
                self?.sites = sites
                DispatchQueue.main.async {
                    self?.mainTable.reloadData()
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
  
}


extension SiteViewController: UITableViewDelegate, UITableViewDataSource {
    // numberOfRowsInSection
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sites.count
    }
    
    // cellForRowAt 主要繪製cell裡面的畫面配置
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifier, for: indexPath) as? MainTableViewCell else {
            return UITableViewCell()
        }
        
        let site = sites[indexPath.row]
        
        cell.configure(with: SiteViewModel(ePicUrl: site.httpsPicUrl ?? "", eName: site.eName ?? "", eInfo: site.eInfo ?? "", eMemo: site.eMemo ?? ""))
        

        return cell
    }
    
    // heightForRowAt
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
//     didSelectRowAt 處理cell被點選的事件
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true) // 以動畫的方式取消選中指定的cell。

        let site = sites[indexPath.row]

        guard site.eName != nil else {return}
        
        let vc = DetailViewController()
        vc.hidesBottomBarWhenPushed = true  // 在此設定
        vc.configure(with: SiteDetailViewModel(ePicUrl: site.httpsPicUrl, eName: site.eName, eInfo: site.eInfo, eMemo: site.eMemo, eCategory: site.eCategory))
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}
