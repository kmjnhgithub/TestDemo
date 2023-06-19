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
    let importDate: ImportDate?
    let eCategory: String?
    let eName: String?
    let ePicUrl: String?
    let eInfo: String?
    let eMemo: String?
    let eUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case importDate = "_importdate"
        case eCategory = "e_category"
        case eName = "e_name"
        case ePicUrl = "e_pic_url"
        case eInfo = "e_info"
        case eMemo = "e_memo"
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

