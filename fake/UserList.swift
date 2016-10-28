//
//  UserList.swift
//  fake
//
//  Created by 大谷勇陽 on 2016/10/24.
//  Copyright © 2016年 yu_hi. All rights reserved.
//

import UIKit

class UserList{
    var userlist: [User] = []
    var currentid:Int = 0
    var stagenum:Int = 0
    
    func addUser(name:String,id:Int) {
        let newuser = User()
        newuser.name = name
        newuser.id = id
        userlist.append(newuser)
    }
    
    func remUser(user:User) {
        userlist.remove(at: user.id)
    }
    
    //ユーザー情報の引き出し
    func getUser(num:Int) -> User {
        return userlist[num]
    }
    
    //次の出番のユーザーへの移行
    func phase() {
        if currentid == (userlist.count - 1) {
            currentid = 0
            stagenum += 1
            return
        }
        currentid += 1
    }
    //ユーザーidを順に入れ替えるメソッド
    func order() {
        let count = userlist.count
        for i in 0..<count {
            if i != userlist[i].id {
                for_j: for j in i+1..<count {
                    if j == userlist[j].id {
                        let pivot = userlist[i]
                        userlist[i] = userlist[j]
                        userlist[j] = pivot
                        break for_j
                    }
                }
            }
        }
    }
    
    //ユーザーidのランダム入れ替え
    func randUserid() {
        let count = userlist.count
        var idlist : [Int] = []
        for i in 0..<count {
            idlist.append(userlist[i].id)
        }
        
        for i in 0..<count {
            let idx = Int(arc4random()) % idlist.count
            userlist[idlist[idx]].id = i
            idlist.remove(at: idx)
        }
        order()
    }
    
    //ユーザー登録がない場合falseを返すメソッド
    func emptyuser() -> Bool {
        if userlist.isEmpty {
            return false
        }
        return true
    }
    //エセ芸術家をランダムに決めるメソッド
    func randfakeartist() {
        let idx = Int(arc4random()) % userlist.count
        userlist[idx].fakeartist = true
    }
    //現手番のユーザーがエセ芸術家かどうか(trueはエセ芸術家である)
    func isFake() -> Bool {
     return userlist[currentid].fakeartist
    }
    
}
