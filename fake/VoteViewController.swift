//
//  VoteViewController.swift
//  fake
//
//  Created by 今井将兵 on 2016/10/18.
//  Copyright © 2016年 yu_hi. All rights reserved.
//

import UIKit

class VoteViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    let myItems: NSMutableArray = []
    var myTableView: UITableView!
    var userlist = UserList()
    var votecheck:Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 背景色をwhiteに設定する.
        self.view.backgroundColor = UIColor.white
        //値の受け渡し
        let app:AppDelegate =
            (UIApplication.shared.delegate as! AppDelegate)
        userlist = app.userlist
        for i in 0..<userlist.userlist.count {
            myItems.add(userlist.userlist[i].name)
        }
        //////////////////////////////////////
        // Status Barの高さを取得する.
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        
        // TableView用の高さと幅を設定.
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        
        // TableViewの生成(Status barの高さをずらして表示).
        myTableView = UITableView(frame: CGRect(x: 0, y: barHeight/2, width: displayWidth, height: displayHeight-150))
        
        // Cell名の登録をおこなう.
        myTableView.register(VoteCustomCell.self, forCellReuseIdentifier: "MyCell")
        
        // DataSourceを自身に設定する.
        myTableView.dataSource = self
        
        // Delegateを自身に設定する.
        myTableView.delegate = self
        
        // Viewに追加する.
        self.view.addSubview(myTableView)
        ///////////////////////////////////////////////
        

        //ラベルの作成
        // ラベルのサイズを定義.
        let bWidth: CGFloat = 200
        let bHeight: CGFloat = 50
        let posX: CGFloat = self.view.bounds.width/2 - bWidth/2
        let posY: CGFloat = self.view.bounds.height
        let label: UILabel = UILabel(frame: CGRect(x: posX, y: posY, width: bWidth, height: bHeight))
        label.text = "誰がエセ芸術家かな？"
        label.textAlignment = NSTextAlignment.center
        self.view.addSubview(label)
        
        // ボタンを生成する.
        let nextButton: UIButton = UIButton(frame: CGRect(x: 0,y: 0, width: 120, height: 50))
        nextButton.backgroundColor = UIColor.red
        nextButton.layer.masksToBounds = true
        nextButton.setTitle("投票完了", for: .normal)
        nextButton.layer.cornerRadius = 20.0
        nextButton.layer.position = CGPoint(x: self.view.bounds.width/2 , y:self.view.bounds.height-50)
        nextButton.addTarget(self, action: #selector(onClickMyButton(sender:)), for: .touchUpInside)
        
        // ボタンを追加する.
        self.view.addSubview(nextButton);
        // Do any additional setup after loading the view.
        // toruko
    }
    internal func voteButton(sender: UIButton) {
        
    }
    internal func onClickMyButton(sender: UIButton) {
        // 遷移するViewを定義する.
        //let NextViewController: UIViewController = IdentificationViewController()
        //viewの遷移
        let app:AppDelegate =
            (UIApplication.shared.delegate as! AppDelegate)
        app.userlist.phase()
        let NextViewController: UIViewController = IdentificationViewController()
        //viewの遷移
        self.present(NextViewController, animated: false, completion: nil)

    }

        // Do any additional setup after loading the view.


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 再利用するCellを取得する.
        let cell:VoteCustomCell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath) as! VoteCustomCell
        // Cellに値を設定する.
        cell.setCell(name: "\(myItems[indexPath.row])")
        
        return cell
    }
    // Cell が選択された場合
    func tableView(_ tableView: UITableView,didSelectRowAt indexPath: IndexPath) {
        let cell:VoteCustomCell = tableView.cellForRow(at: indexPath) as! VoteCustomCell
        //let cell:VoteCustomCell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath) as! VoteCustomCell
            cell.setCell(name: "\(myItems[indexPath.row])")
        if cell.accessoryType == UITableViewCellAccessoryType.none && votecheck  {
            cell.accessoryType = UITableViewCellAccessoryType.checkmark
            votecheck = false
        } else if cell.accessoryType == UITableViewCellAccessoryType.checkmark {
            cell.accessoryType = UITableViewCellAccessoryType.none
            votecheck = true
        }
        myTableView.reloadData()

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myItems.count
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
