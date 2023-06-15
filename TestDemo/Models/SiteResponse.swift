//
//  Site.swift
//  TestDemo
//
//  Created by mike liu on 2023/6/14.
//

import Foundation

struct APIResponse: Codable {
    let result: ResultData
}

struct ResultData: Codable {
    let results: [SiteResponse]
}


struct SiteResponse: Codable {
//    let id: Int?
    let importDate: ImportDate?
//    let eNo: String?
    let eCategory: String?
    let eName: String?
    let ePicUrl: String?
    let eInfo: String?
    let eMemo: String?
//    let eGeo: String?
    let eUrl: String?
    
    enum CodingKeys: String, CodingKey {
//        case id = "_id"
        case importDate = "_importdate"
//        case eNo = "e_no"
        case eCategory = "e_category"
        case eName = "e_name"
        case ePicUrl = "e_pic_url"
        case eInfo = "e_info"
        case eMemo = "e_memo"
//        case eGeo = "e_geo"
        case eUrl = "e_url"
    }
    
    var httpsPicUrl: String? {
        guard let ePicUrl = ePicUrl else {
            return nil
        }
        return ePicUrl.replacingOccurrences(of: "http://", with: "https://")
    }
}

struct ImportDate: Codable {
    let date: String?
}

