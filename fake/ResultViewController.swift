//
//  ResultViewController.swift
//  fake
//
//  Created by 今井将兵 on 2016/10/18.
//  Copyright © 2016年 yu_hi. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    var userlist = UserList()
    var fakeart : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //値の受け渡し
        let app:AppDelegate =
            (UIApplication.shared.delegate as! AppDelegate)
        userlist = app.userlist
        fakeart = userlist.compVoteFake()
        // 背景色をwhiteに設定する.
        self.view.backgroundColor = UIColor.white

        //ラベルの作成
        // ラベルのサイズを定義.
        let bWidth: CGFloat = 200
        let bHeight: CGFloat = 100
        let posX: CGFloat = self.view.bounds.width/2 - bWidth/2
        let posY: CGFloat = self.view.bounds.height/4 - bHeight/2
        let label: UITextView = UITextView(frame: CGRect(x: posX, y: posY, width: bWidth, height: bHeight))
        label.text = "投票の結果"+userlist.votename+"\nさんがエセ芸術家に\n選ばれました"
        label.textAlignment = NSTextAlignment.center
        self.view.addSubview(label)
        
        // ボタンを生成する.
        let nextButton: UIButton = UIButton(frame: CGRect(x: 0,y: 0, width: 120, height: 50))
        nextButton.backgroundColor = UIColor.red
        nextButton.layer.masksToBounds = true
        nextButton.setTitle("次へ", for: .normal)
        nextButton.layer.cornerRadius = 20.0
        nextButton.layer.position = CGPoint(x: self.view.bounds.width/2 , y:self.view.bounds.height-50)
        nextButton.addTarget(self, action: #selector(onClickMyButton(sender:)), for: .touchUpInside)
        
        // ボタンを追加する.
        self.view.addSubview(nextButton);

        // Do any additional setup after loading the view.
    }
    internal func onClickMyButton(sender: UIButton) {
        if fakeart {
            let NextViewController: UIViewController = AnswerViewController()
            //viewの遷移
            self.present(NextViewController, animated: false, completion: nil)
        }
        let NextViewController: UIViewController = FakeArtistWinViewController()
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
