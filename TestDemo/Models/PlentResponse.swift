//
//  PlentResponse.swift
//  TestDemo
//
//  Created by mike liu on 2023/6/14.
//

import Foundation


struct APIPlentResponse: Codable {
    let result: PlentResult
}

struct PlentResult: Codable {
    let limit: Int
    let offset: Int
    let count: Int
    let sort: String
    let results: [PlentResponse]
}

struct PlentResponse: Codable {
    let nameCh: String?
    let summary: String?
    let alsoKnown: String?
    let nameEn: String?
    let brief: String?
    let feature: String?
    let functionApplication: String?
    let pic01URL: String?
    let update: String?

    enum CodingKeys: String, CodingKey {
        case nameCh = "F_Name_Ch"
        case summary = "F_Summary"
        case alsoKnown = "F_AlsoKnown"
        case nameEn = "F_Name_En"
        case brief = "F_Brief"
        case feature = "F_Feature"
        case functionApplication = "F_Function＆Application"
        case pic01URL = "F_Pic01_URL"
        case update = "F_Update"
    }
    
    var httpsPic01URL: String? {
        guard let pic01URL = pic01URL else {
            return nil
        }
        return pic01URL.replacingOccurrences(of: "http://", with: "https://")
    }
}



// F_Name_Ch": "九芎",

// F_Name_En": "Subcostate Crape Myrtle

// 別名- F_AlsoKnown": "苞飯花、拘那花、小果紫薇、南紫薇、猴不爬、怕癢樹、南紫薇、九荊、馬鈴花、蚊仔花",

// 簡介- F_Brief": "分布於中低海拔森林及長江以南的地區，為台灣的原生樹種。主要生長在潮濕的崩塌地，有吸水保持土壤之特性，所以是良好的水土保持樹種。

// F_Pic01_URL": "http://www.zoo.gov.tw/iTAP/04_Plant/Lythraceae/subcostata/subcostata_1.jpg

// 辨識方式- F_Feature":"紅褐色的樹皮剝落後呈灰白色，樹幹光滑堅硬。葉有極短的柄，長橢圓形或卵形，全綠，葉片兩端尖，秋冬轉紅。夏季6～8月開花，花冠白色，花數甚多而密生於枝端，花為圓錐花序頂生，花瓣有長柄，邊緣皺曲像衣裙的花邊花絲長短不一。果實為蒴果，橢圓形約6-8公厘，種子有翅。

// 功能性- F_Function＆Application": "1. 優良薪炭材：木質堅硬耐燒，是臺灣優良的薪炭材之一。\n2. 水土保持植栽：可栽植於河岸及邊坡供水土保持。\n3. 農具用材：木質堅硬，乾燥後不太會反翹，是做農具的用材。\n4. 食用性：花、根入藥，味淡微苦，敗毒散瘀，花蕾味苦有清香，可生食。葉子是長尾水青蛾幼蟲的食草。

// 最後更新- F_Update
