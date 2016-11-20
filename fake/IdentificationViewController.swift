//
//  IdentificationViewController.swift
//  fake
//
//  Created by 今井将兵 on 2016/10/18.
//  Copyright © 2016年 yu_hi. All rights reserved.
//

import UIKit

class IdentificationViewController: UIViewController {
    var userlist = UserList()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        //値の受け渡し
        let app:AppDelegate =
            (UIApplication.shared.delegate as! AppDelegate)
        userlist = app.userlist
        //ユーザーデータ格納
        let user:User = userlist.getUser(num: userlist.currentid)
        //ラベルの作成
        // ラベルのサイズを定義.
        let bWidth: CGFloat = 500
        let bHeight: CGFloat = 50
        let posX: CGFloat = self.view.bounds.width/2 - bWidth/2
        let posY: CGFloat = self.view.bounds.height/2 - bHeight/2
        let label: UITextView = UITextView(frame: CGRect(x: posX, y: posY, width: bWidth, height: bHeight))
        label.text = "あなたは\n"+user.name + "\nですか？"
        label.textAlignment = NSTextAlignment.center
        self.view.addSubview(label)

        //USER追加ボタンを生成する
        let userButton: UIButton = UIButton(frame: CGRect(x: 0,y: 0, width: 120, height: 30))
        userButton.backgroundColor = UIColor.red
        userButton.layer.masksToBounds = true
        userButton.setTitle("はい", for: .normal)
        userButton.layer.cornerRadius = 20.0
        userButton.layer.position = CGPoint(x: self.view.bounds.width/2 , y:self.view.bounds.height-120)
        userButton.addTarget(self, action: #selector(YesMyButton(sender:)), for: .touchUpInside)
        //////////////////////////////////////////////
        
        // GAMESTARTボタンを生成する.
        let nextButton: UIButton = UIButton(frame: CGRect(x: 0,y: 0, width: 120, height: 50))
        nextButton.backgroundColor = UIColor.red
        nextButton.layer.masksToBounds = true
        nextButton.setTitle("いいえ", for: .normal)
        nextButton.layer.cornerRadius = 20.0
        nextButton.layer.position = CGPoint(x: self.view.bounds.width/2 , y:self.view.bounds.height-50)
        nextButton.addTarget(self, action: #selector(NoButton(sender:)), for: .touchUpInside)
        //////////////////////////////////////////////
        
        // ボタンを追加する.
        self.view.addSubview(nextButton);
        self.view.addSubview(userButton);

        

        // Do any additional setup after loading the view.
    }
    //はいのボタンを押した時
    internal func YesMyButton(sender: UIButton) {
        //stagenum = 1の時、投票の出番なので投票の画面へ遷移。　ただし現在は絵を描く実装がないのですぐに投票へ飛ぶ
        if userlist.stagenum == 1 {
            // 遷移するViewを定義する.
            let NextViewController: UIViewController = VoteViewController()
            self.present(NextViewController, animated: false, completion: nil)
        }
        // 遷移するViewを定義する.
        let NextViewController: UIViewController = ArtistViewController()
        self.present(NextViewController, animated: false, completion: nil)
    }
    //いいえのボタンを押した時
    internal func NoButton(sender: UIButton) {
            // 遷移するViewを定義する.
        let NextViewController: UIViewController = UserAddViewController()
            //viewの遷移
        self.present(NextViewController, animated: false, completion: nil)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
