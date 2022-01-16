//
//  MessageInfo.swift
//  Parttime
//
//  Created by JUMP on 2018/6/27.
//  Copyright © 2018年 Addcn. All rights reserved.
//

import UIKit

class ShareData: NSObject {
    static let instance = ShareData()
    
    var dataAry = [TeamData]()
    var oldDataAry = [TeamData]()
    
    var testSource = SourceData()
    
    override init() {
        super.init()
        
        getTestSource()
    }
    
    
    
    
    func setData() {
        var tmp = TeamData()
        tmp.key = .chick
        tmp.color = .main
        dataAry.append(tmp)
        
        tmp = TeamData()
        tmp.key = .marry
        tmp.color = .marry
        dataAry.append(tmp)
        
        tmp = TeamData()
        tmp.key = .bear
        tmp.color = .bear
        dataAry.append(tmp)
        
        tmp = TeamData()
        tmp.key = .tasker
        tmp.color = .tasker
        dataAry.append(tmp)
        
        oldDataAry = dataAry
    }
    
    func getTestSource() {
        let path = Bundle.main.path(forResource: "TestSource", ofType: "json")
        if let data = try? Data(contentsOf: URL(fileURLWithPath: path!), options: .alwaysMapped), let decoder = try? JSONDecoder().decode(SourceCodable.self, from: data) {
            
            //print("decoder: \(decoder)")
            for c in decoder.chance ?? [] {
                var options = [String]()
                for opt in c.options ?? [] {
                    options.append(opt.uppercased())
                }
                let data = SourceData.Chance(number: c.number.str,
                                             type: 0, question: c.question.str.uppercased(),
                                             options: options,
                                             answer: c.answer.str.uppercased(),
                                             score: c.score ?? 0)
                testSource.chance.append(data)
            }
            
            for f in decoder.fate ?? [] {
                let data = SourceData.Fate(number: f.number.str,
                                           type: FateType(rawValue: f.type ?? 0) ?? .twoButton,
                                           image: f.image.str,
                                           description: f.description.str,
                                           score: f.score ?? 0)
                testSource.fate.append(data)
            }
            
            for f in decoder.funny ?? [] {
                let data = SourceData.Funny(number: f.number.str,
                                            type: 0, description: f.description.str,
                                            score: f.score ?? 0,
                                            action: f.action.str)
                testSource.funny.append(data)
            }

            dump(testSource)
            
        } else {
            print("** getTestSource 解析失敗 ** ")
            print("** getTestSource 解析失敗 ** ")
            print("** getTestSource 解析失敗 ** ")
        }
    }
    
    
    
}

func getTeamRow(key: TeamKey) -> Int {
    for (i, cellData) in share.dataAry.enumerated() {
        if cellData.key == key {
            return i
        }
    }
    print("** 找不到team row **")
    return 0
}





// MARK: - Enum



// MARK: - Codable
struct SourceCodable: Codable {
    let chance: [Chance]?
    let fate: [Fate]?
    let funny: [Funny]?
    
    struct Chance: Codable {
        let number: String?
        let type: Int?
        let question: String?
        let options: [String]?
        let answer: String?
        let score: Int?
    }
    
    struct Fate: Codable {
        let number: String?
        let type: Int?
        let image, description: String?
        let score: Int?

        enum CodingKeys: String, CodingKey {
            case number, type, image
            case description
            case score
        }
    }
    
    struct Funny: Codable {
        let number: String?
        let type: Int?
        let description: String?
        let score: Int?
        let action: String?

        enum CodingKeys: String, CodingKey {
            case number, type
            case description
            case score, action
        }
    }
}

// MARK: - Data
struct SourceData {
    var chance: [Chance] = []
    var fate: [Fate] = []
    var funny: [Funny] = []
    
    struct Chance {
        var number: String = ""
        var type: Int = 0
        var question: String = ""
        var options: [String] = []
        var answer: String = ""
        var score: Int = 0
    }
    
    struct Fate {
        var number: String = ""
        var type = FateType.twoButton
        var image : String = ""
        var description = ""
        var score: Int = 0

    }
    
    struct Funny {
        var number: String = ""
        var type: Int?
        var description: String = ""
        var score: Int?
        var action: String = ""

    }
}
