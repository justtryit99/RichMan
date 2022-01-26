//
//  PublicFunc.swift
//  RichMan
//
//  Created by 莊文博 on 2022/1/22.
//

import Foundation




// MARK: - Public Func
func getTeamRow(key: TeamKey) -> Int {
    for (i, cellData) in share.dataAry.enumerated() {
        if cellData.key == key {
            return i
        }
    }
    print("** 找不到team row **")
    return 0
}

func logEvent(row: Int, score: Int, msg: String) {
    let data = share.dataAry[row]
    let text = "\(msg)\n\(data.score) 增加 \(score) 積分為 \(data.score+score)"
    share.dataAry[row].log.append(text)
}

func saveToDefaults() {
    Defaults[.sourceType] = sourceType.rawValue
    Defaults[.dataSource] = try? PropertyListEncoder().encode(share.dataSource)
    
    Defaults[.dataAry] = []
    for teamData in share.dataAry {
        let encodeData = try? PropertyListEncoder().encode(teamData)
        if let encodeData = encodeData {
            Defaults[.dataAry]?.append(encodeData)
        }
    }
    
    //print("Defaults[.dataAry]: \(Defaults[.dataAry])")
}

func getDefaults() {
    if let defaultsSource = Defaults[.dataSource] {
        if let dataSource = try? PropertyListDecoder().decode(SourceData.self, from: defaultsSource) {
            share.dataSource = dataSource
        }
    }
    
    if let defaultsAry = Defaults[.dataAry] {
        share.dataAry = []
        for dataTmp in defaultsAry {
            if let teamTmp = try? PropertyListDecoder().decode(TeamData.self, from: dataTmp) {
                share.dataAry.append(teamTmp)
            }
        }
    }
    
}

/// 驗證資料源是否有問題
func testSource() {
    for data in share.dataSource.chance {
        if data.options.contains(data.answer) {
            //print("No.\(data.number) 正確")
        } else {
            print("No.\(data.number) 找不到解答")
            print("No.\(data.number) 找不到解答")
            print("No.\(data.number) 找不到解答")
        }
    }
}
