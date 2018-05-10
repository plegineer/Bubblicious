//
//  ContentModel.swift
//  Bubblicious
//
//  Created by Yoshiki Agatsuma on 2018/05/10.
//  Copyright © 2018年 Plegineer Inc. All rights reserved.
//

import Foundation

class ContentModel {
    
    fileprivate(set) var contents: [ContentData] = []
    fileprivate(set) var extraContents: [ContentData] = []
    var isAppendedExtra: Bool = false
    
    func getContents(_ params:[String: Int], callback: @escaping (_ error: Error?) -> Void) {
        // 本来: APIを叩き、表示するデータを取得する
        // 今回: 固定のデータ30件を利用し、プログラム内で配列を2つに分け、表示を出し分けしている
        
        let tempData: [[String]] = [
            ["https://xxxx/yyyy/hoge.png", "タイトル", ""],
            ["https://xxxx/yyyy/hoge.png", "タイトル", ""],
            ["https://xxxx/yyyy/hoge.png", "タイトル", ""],
            ["https://xxxx/yyyy/hoge.png", "タイトル", ""],
            ["", "タイトル", ""],
            ["", "タイトル", ""],
            ["", "タイトル", ""],
            ["", "タイトル", "カスタムセルの内容カスタムセルの内容カスタムセルの内容カスタムセルの内容カスタムセルの内容"],
            ["", "タイトル", "カスタムセルの内容カスタムセルの内容カスタムセルの内容カスタムセルの内容カスタムセルの内容カスタムセルの内容カスタムセルの内容カスタムセルの内容カスタムセルの内容"],
            ["", "タイトル", "カスタムセルの内容カスタムセルの内容カスタムセルの内容カスタムセルの内容カスタムセルの内容カスタムセルの内容カスタムセルの内容カスタムセルの内容カスタムセルの内容カスタムセルの内容カスタムセルの内容カスタムセルの内容"],
            ["https://xxxx/yyyy/hoge.png", "タイトル", ""],
            ["https://xxxx/yyyy/hoge.png", "タイトル", ""],
            ["https://xxxx/yyyy/hoge.png", "タイトル", ""],
            ["https://xxxx/yyyy/hoge.png", "タイトル", ""],
            ["", "タイトル", ""],
            ["", "タイトル", ""],
            ["", "タイトル", ""],
            ["", "タイトル", "カスタムセルの内容カスタムセルの内容カスタムセルの内容カスタムセルの内容カスタムセルの内容"],
            ["", "タイトル", "カスタムセルの内容カスタムセルの内容カスタムセルの内容カスタムセルの内容カスタムセルの内容カスタムセルの内容カスタムセルの内容カスタムセルの内容カスタムセルの内容"],
            ["", "タイトル", "カスタムセルの内容カスタムセルの内容カスタムセルの内容カスタムセルの内容カスタムセルの内容カスタムセルの内容カスタムセルの内容カスタムセルの内容カスタムセルの内容カスタムセルの内容カスタムセルの内容カスタムセルの内容"],
            ["", "(追加読み込み分)タイトル", ""],
            ["", "(追加読み込み分)タイトル", ""],
            ["", "(追加読み込み分)タイトル", "カスタムセルの内容"],
            ["https://xxxx/yyyy/hoge.png", "(追加読み込み分)タイトル", ""],
            ["https://xxxx/yyyy/hoge.png", "(追加読み込み分)タイトル", ""],
            ["", "(追加読み込み分)タイトル", ""],
            ["", "(追加読み込み分)タイトル", ""],
            ["", "(追加読み込み分)タイトル", "カスタムセルの内容"],
            ["https://xxxx/yyyy/hoge.png", "(追加読み込み分)タイトル", ""],
            ["https://xxxx/yyyy/hoge.png", "(追加読み込み分)タイトル", ""]
        ]
        
        self.contents.removeAll()
        self.extraContents.removeAll()
        
        for (index, datum) in tempData.enumerated() {
            let title = datum[1] + String(index+1)
            let param = self.createTempContentParam(imageUrl: datum[0], title: title, description: datum[2])
            if index < 20 {
                // 初期表示分の配列
                self.contents.append(ContentData(data: param))
            } else {
                // 追加読み込み分の配列
                self.extraContents.append(ContentData(data: param))
            }
        }
        
        // 視覚的にわかりやすいよう、故意に1秒待つ処理を入れている
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            callback(nil)
        }
    }
    
    func getMoreContents(_ params:[String: Int], callback: @escaping (_ error: Error?) -> Void) {
        // 本来: APIを叩き、追加の情報を取得する
        // 今回: あらかじめ分けておいた配列を合わせる処理のみを実行

        // 視覚的にわかりやすいよう、故意に1秒待つ処理を入れている
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.contents.append(contentsOf: self.extraContents)
            callback(nil)
        }
    }
    
    private func createTempContentParam(imageUrl: String, title: String, description: String) -> [String: String] {
        var param: [String: String] = [:]
        param[ContentData.ParamKey.imageUrl] = imageUrl
        param[ContentData.ParamKey.title] = title
        param[ContentData.ParamKey.description] = description
        return param
    }
}
