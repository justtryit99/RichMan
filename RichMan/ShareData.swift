//
//  MessageInfo.swift
//  Parttime
//
//  Created by JUMP on 2018/6/27.
//  Copyright © 2018年 Addcn. All rights reserved.
//

import UIKit



enum DataType {
    case chance
    case fate
    case mark
    case all
}

enum SourceType: String {
    case test = "TestSource"
    case formal = "FormalSource"
}

var sourceType = SourceType.test {
    didSet {
        share.resetData(type: sourceType)
        
    }
}

class ShareData: NSObject {
    static let instance = ShareData()
    
    var dataAry = [TeamData]()
    
    var dataSource = SourceData()
    
    override init() {
        super.init()
        
        getDataSource(type: .all)
    }
    
    func resetData(type: SourceType) {
        setData()
        getDataSource(type: .all)
    }
    
    func setData() {
        dataAry = []
        
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
        
    }
    
    func getChanceData() -> SourceData.Chance {
        var chance = SourceData.Chance()
        if let data = dataSource.chance.randomElement() {
            print("機會還有：\(dataSource.chance.count) 題")
            dataSource.chance = dataSource.chance.filter { $0.question != data.question }
            print("刪除後，機會還有：\(dataSource.chance.count) 題")
            chance = data
        } else {
            print("題目沒了，重新讀取來源")
            getDataSource(type: .chance)
            chance = getChanceData()
        }
        return chance
    }
//    func with<T: UIViewController>(id: StoryboardID) -> T {
//    func getCardData(type: DataType) {
//        var chance = SourceData.Chance()
//        if let data = dataSource.chance.randomElement() {
//            print("機會還有：\(dataSource.chance.count) 題")
//            dataSource.chance = dataSource.chance.filter { $0.question != data.question }
//            print("刪除後，機會還有：\(dataSource.chance.count) 題")
//            chance = data
//        } else {
//            print("題目沒了，重新讀取來源")
//            getDataSource(type: .chance)
//            chance = getChanceData()
//        }
//        return chance
//    }
    
    func getDataSource(type: DataType) {
        let path = Bundle.main.path(forResource: sourceType.rawValue, ofType: "json")
        if let data = try? Data(contentsOf: URL(fileURLWithPath: path!), options: .alwaysMapped), let decoder = try? JSONDecoder().decode(SourceCodable.self, from: data) {
            
            //print("decoder: \(decoder)")
            
            switch type {
            case .chance:
                dataSource.chance = []
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
                    dataSource.chance.append(data)
                }
            case .fate:
                dataSource.fate = []
                for f in decoder.fate ?? [] {
                    let data = SourceData.Fate(number: f.number.str,
                                               type: FateType(rawValue: f.type ?? 0) ?? .twoButton,
                                               image: f.image.str,
                                               description: f.description.str,
                                               score: f.score ?? 0)
                    dataSource.fate.append(data)
                }
            case .mark:
                dataSource.funny = []
                for f in decoder.funny ?? [] {
                    let data = SourceData.Funny(number: f.number.str,
                                                type: 0, description: f.description.str,
                                                score: f.score ?? 0,
                                                action: f.action.str)
                    dataSource.funny.append(data)
                }
            case .all:
                dataSource = .init()
                
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
                    dataSource.chance.append(data)
                }
                
                for f in decoder.fate ?? [] {
                    let data = SourceData.Fate(number: f.number.str,
                                               type: FateType(rawValue: f.type ?? 0) ?? .twoButton,
                                               image: f.image.str,
                                               description: f.description.str,
                                               score: f.score ?? 0)
                    dataSource.fate.append(data)
                }
                
                for f in decoder.funny ?? [] {
                    let data = SourceData.Funny(number: f.number.str,
                                                type: 0, description: f.description.str,
                                                score: f.score ?? 0,
                                                action: f.action.str)
                    dataSource.funny.append(data)
                }
            }
            
            
            

//            dump(testSource)
            
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
        var score: Int = 0
        var action: String = ""

    }
}
