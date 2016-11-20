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
    var currentid:Int = 0 //現在進行中ユーザーのid
    var stagenum:Int = 0 //identificationviewにてどの遷移にすべきかをステージ化
    var vote : Int = 0 //票を入れられた側のid
    var votename : String = ""
    let title: [String] = ["Apple","Bear","Cat","Dog","Elephant","Firefly","Gandum","House","Italy","Jellyfish","Kazuma","Lion","Monkey","NorthKorean","Octopas","PPAP","Queen","Rabbit","Sneak","Titech","USA","Vampire","Weapon","X'mas","Yesterday","Zebra"]
    var titleid =  0
    let ColorList : [UIColor] = [UIColor.black,UIColor.red ,UIColor.green ,UIColor.blue ,UIColor.cyan ,UIColor.yellow ,UIColor.magenta ,UIColor.orange ,UIColor.purple ,UIColor.brown,UIColor.darkGray ,UIColor.lightGray ,UIColor.white ,UIColor.gray]
    var Image = UIImage()
    
    func addUser(name:String,id:Int) {
        let newuser = User()
        newuser.name = name
        newuser.id = id
        newuser.color = ColorList[id]
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
    //エセ芸術家とお題をランダムに決め,ベースの絵を作成するメソッド
    func preparefakeartist(width:CGFloat,height:CGFloat) {
        randUserid()
        let idx = Int(arc4random()) % userlist.count
        userlist[idx].fakeartist = true
        titleid =  Int(arc4random()) % title.count
        print(userlist[idx].name)
        print(titleid)
        let CanvasRect = CGRect(x: 0,y: 0,width: width,height: height/2)
        UIGraphicsBeginImageContextWithOptions(CGSize(width: width,height: height/2), false, 0.0)
        var firstCanvasImage = UIImage()                                            //キャンバス用UIImage(まだ空っぽ)
        UIColor.white.setFill()                                              //白色塗りつぶし作業1
        UIRectFill(CanvasRect)                                                      //白色塗りつぶし作業2
        firstCanvasImage.draw(in: CanvasRect)                                     //firstCanvasImageの内容を描く(真っ白)
        firstCanvasImage = UIGraphicsGetImageFromCurrentImageContext()!              //何も描かれてないUIImageを取得
        //CanvasView.contentMode = .scaleAspectFit                                    //contentModeの設定
        Image = firstCanvasImage                                         //画面の表示を更新
        UIGraphicsEndImageContext()//コンテキストを閉じる
        
    }
    //現手番のユーザーがエセ芸術家かどうか(trueはエセ芸術家である)
    func isFake() -> Bool {
     return userlist[currentid].fakeartist
    }
    
    //投票数の加算
    func VoteAdd(num: Int) {
        vote = num
    }
    
    //投票の確定
    func votecom() {
        userlist[vote].votenum += 1
    }
    //投票結果とエセ芸術家の照合 trueが正解
    func compVoteFake()->Bool {
        var maxnum = 0
        var maxid = 0
        for i in 0..<userlist.count {
            if maxnum < userlist[i].votenum {
                maxnum = userlist[i].votenum
                maxid = i
            }
        }
        votename = userlist[maxid].name
        return userlist[maxid].fakeartist
    }
    //画像の入れ替え
    func getImage()-> UIImage {
        return Image
    }
}
