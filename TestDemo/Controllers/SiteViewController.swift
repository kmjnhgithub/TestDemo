//
//  MainViewController.swift
//  TestDemo
//
//  Created by mike liu on 2023/6/14.
//

import UIKit

class SiteViewController: UIViewController {
    
//    private var sites: [SiteResponse] = [SiteResponse(importDate: ImportDate(date: "2022-05-09"), eCategory: "戶外區", eName: "臺灣動物區", ePicUrl: "https://www.zoo.gov.tw/iTAP/05_Exhibit/01_FormosanAnimal.jpg", eInfo: "臺灣位於北半球，北迴歸線橫越南部，造成亞熱帶溫和多雨的氣候。又因高山急流、起伏多樣的地形，因而在這蕞爾小島上，形成了多樣性的生態系，孕育了多種不同生態習性的動、植物，豐富的生物物種共存共榮於此，也使臺灣博得美麗之島「福爾摩沙」的美名。臺灣動物區以臺灣原生動物與棲息環境為展示重點，佈置模擬動物原生棲地之生態環境，讓動物表現如野外般自然的生活習性，引導民眾更正確地認識本土野生動物，為園區環境教育的重要據點。藉由提供動物寬廣且具隱蔽的生態環境，讓動物避開人為過度的干擾，並展現如野外般自然的生活習性和行為。展示區以多種臺灣的保育類野生動物貫連成保育廊道，包括臺灣黑熊、穿山甲、歐亞水獺、白鼻心、石虎、山羌等。唯有認識、瞭解本土野生動物，才能愛護、保育牠們，並進而珍惜我們共同生存的這塊土地！", eMemo: "String", eUrl: ""), SiteResponse(importDate: ImportDate(date: "2022-05-09"), eCategory: "戶外區", eName: "兒童動物區", ePicUrl: "https://www.zoo.gov.tw/iTAP/05_Exhibit/02_ChildrenZoo.jpg", eInfo: "String", eMemo: "String", eUrl: "")]
    
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
        print(sites.count)
        return sites.count
    }
    
    // cellForRowAt 主要繪製cell裡面的畫面配置
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifier, for: indexPath) as? MainTableViewCell else {
            return UITableViewCell()
        }
        
        let site = sites[indexPath.row]
        
        cell.configure(with: SiteViewModel(ePicUrl: site.httpsPicUrl ?? "", eName: site.eName ?? "", eInfo: site.eInfo ?? ""))
        
//        cell.configure(with: Site(titleName: title.original_title ?? title.original_name ?? "Unknow", posterURL: title.poster_path ?? ""))
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

        guard let titleName = site.eName else {return}

        DispatchQueue.main.async {
            let vc = DetailViewController()
//            vc.configure(with: SiteDetailViewModel())
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
