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
    
    /// 隊伍資料源
    var dataAry = [TeamData]()
    
    /// 題庫資料源
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
        dataAry.append(tmp)
        
        tmp = TeamData()
        tmp.key = .marry
        dataAry.append(tmp)
        
        tmp = TeamData()
        tmp.key = .bear
        dataAry.append(tmp)
        
        tmp = TeamData()
        tmp.key = .tasker
        dataAry.append(tmp)
        
    }
    
    func getChanceData() -> SourceData.Chance {
        var chance = SourceData.Chance()
        if let data = dataSource.chance.randomElement() {
            print("機會還有：\(dataSource.chance.count) 題")
            dataSource.chance = dataSource.chance.filter { $0.question != data.question }
            print("刪除後，機會還有：\(dataSource.chance.count) 題")
            chance = data
            print("getChanceData: \(chance)")
        } else {
            print("題目沒了，重新讀取來源")
            getDataSource(type: .chance)
            chance = getChanceData()
        }
        return chance
    }
    
    func getFateData() -> SourceData.Fate {
        var chance = SourceData.Fate()
        if let data = dataSource.fate.randomElement() {
            print("命運還有：\(dataSource.fate.count) 題")
            dataSource.fate = dataSource.fate.filter { $0.description != data.description }
            print("刪除後，命運還有：\(dataSource.fate.count) 題")
            chance = data
        } else {
            print("題目沒了，重新讀取來源")
            getDataSource(type: .fate)
            chance = getFateData()
        }
        return chance
    }
    
    func getFunnyData() -> SourceData.Funny {
        var chance = SourceData.Funny()
        if let data = dataSource.funny.randomElement() {
            print("問號還有：\(dataSource.funny.count) 題")
            dataSource.funny = dataSource.funny.filter { $0.description != data.description }
            print("刪除後，問號還有：\(dataSource.funny.count) 題")
            chance = data
        } else {
            print("題目沒了，重新讀取來源")
            getDataSource(type: .mark)
            chance = getFunnyData()
        }
        return chance
    }
    
    
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
                                               description: f.description.str.uppercased(),
                                               score: f.score ?? 0)
                    dataSource.fate.append(data)
                }
            case .mark:
                dataSource.funny = []
                for f in decoder.funny ?? [] {
                    let data = SourceData.Funny(number: f.number.str,
                                                type: 0, description: f.description.str.uppercased(),
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
                                               description: f.description.str.uppercased(),
                                               score: f.score ?? 0)
                    dataSource.fate.append(data)
                }
                
                for f in decoder.funny ?? [] {
                    let data = SourceData.Funny(number: f.number.str,
                                                type: 0, description: f.description.str.uppercased(),
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

public protocol Card: Codable {
    var key: String { get set }
}

// MARK: - Data
struct SourceData: Codable {
    var chance: [Chance] = []
    var fate: [Fate] = []
    var funny: [Funny] = []
    
    struct Chance: Card {
        var key: String = ""
        
        var number: String = ""
        var type: Int = 0
        var question: String = ""
        var options: [String] = []
        var answer: String = ""
        var score: Int = 0
    }
    
    struct Fate: Card {
        var key: String = ""
        
        var number: String = ""
        var type = FateType.twoButton
        var image : String = ""
        var description = ""
        var score: Int = 0

    }
    
    struct Funny: Card {
        var key: String = ""
        
        var number: String = ""
        var type: Int?
        var description: String = ""
        var score: Int = 0
        var action: String = ""

    }
}

extension Array {
//    mutating func getData<T>(type: DataType) -> T {
//        print("getData self: \(self)")
//        if let data = self.randomElement() as? Card {
//            print("機會還有：\(self.count) 題")
//            self = self.filter({ element in
//                if let e = element as? Card {
//                    data.key != e.key
//                } else {
//                    return true
//                }
//            })
//            print("刪除後，機會還有：\(self.count) 題")
//            return data as! T
//        } else {
//            print("題目沒了，重新讀取來源")
//            share.getDataSource(type: type)
//            return self.getData(type: type)
//        }
//
//    }
}


// test
/*
 func getCardData<T: Card>(type: DataType) -> T {
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
     
     var ary = [Any]()
     switch type {
     case .chance:
         ary = dataSource.chance
     case .fate:
         ary = dataSource.fate
     case .mark:
         ary = dataSource.funny
     default:
         break
     }
     
     var chance: T?
     if let data = ary.randomElement() {
         print("機會還有：\(dataSource.chance.count) 題")
//            ary = ary.filter { $0 != data }
//            print("刪除後，機會還有：\(dataSource.chancecount) 題")
         
         chance = data as? T
         
//            ary = ary.filter({ any in
//                if let tmp = any as? T {
//                    return tmp != data as! T
//                } else {
//                    return true
//                }
//            })
         print("刪除後，機會還有：\(dataSource.chance.count) 題")
         
     } else {
         print("題目沒了，重新讀取來源")
//            getDataSource(type: .chance)
         chance = getCardData(type: type)
     }
     
     
     return chance!
 }
 */
