//
//  UsedAddViewController.swift
//  fake
//
//  Created by 今井将兵 on 2016/10/18.
//  Copyright © 2016年 yu_hi. All rights reserved.
//

import UIKit

class UserAddViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let myItems: NSMutableArray = []
    var myTableView: UITableView!
    private var count = 0 //ユーザー数のカウント用
    var userlist = UserList() //ユーザーデータ格納
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.title = "ユーザー追加"
        
        //////////////////////////////////////
        // Status Barの高さを取得する.
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        
        // TableView用の高さと幅を設定.
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        
        // TableViewの生成(Status barの高さをずらして表示).
        myTableView = UITableView(frame: CGRect(x: 0, y: barHeight/2, width: displayWidth, height: displayHeight-150))
        
        // Cell名の登録をおこなう.
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        
        // DataSourceを自身に設定する.
        myTableView.dataSource = self
        
        // Delegateを自身に設定する.
        myTableView.delegate = self
        
        // Viewに追加する.
        self.view.addSubview(myTableView)
        ///////////////////////////////////////////////
        
        //USER追加ボタンを生成する
        let userButton: UIButton = UIButton(frame: CGRect(x: 0,y: 0, width: 120, height: 30))
        userButton.backgroundColor = UIColor.red
        userButton.layer.masksToBounds = true
        userButton.setTitle("ユーザー追加", for: .normal)
        userButton.layer.cornerRadius = 20.0
        userButton.layer.position = CGPoint(x: self.view.bounds.width/2 , y:self.view.bounds.height-120)
        userButton.addTarget(self, action: #selector(addUserButton(sender:)), for: .touchUpInside)
        //////////////////////////////////////////////

        // GAMESTARTボタンを生成する.
        let nextButton: UIButton = UIButton(frame: CGRect(x: 0,y: 0, width: 120, height: 50))
        nextButton.backgroundColor = UIColor.red
        nextButton.layer.masksToBounds = true
        nextButton.setTitle("GAME START", for: .normal)
        nextButton.layer.cornerRadius = 20.0
        nextButton.layer.position = CGPoint(x: self.view.bounds.width/2 , y:self.view.bounds.height-50)
        nextButton.addTarget(self, action: #selector(StartButton(sender:)), for: .touchUpInside)
        //////////////////////////////////////////////
        
        // ボタンを追加する.
        self.view.addSubview(nextButton);
        self.view.addSubview(userButton);
        
        // Do any additional setup after loading the view.
    }
    
    //ユーザー追加ボタンを押した時
    internal func addUserButton(sender: UIButton) {
            let newname = "ユーザー" + String(count)
            myItems.add(newname)
            myTableView.reloadData()
            userlist.addUser(name: newname, id: count)
            count += 1
    }
    //ゲームスタートボタンを押した時
    internal func StartButton(sender: UIButton) {
        if userlist.emptyuser() {
            //ユーザーの順番をランダムに変更する。
            //userlist.randUserid()
            //エセ芸術家をランダムに決める
            userlist.preparefakeartist(width:self.view.bounds.width,height:self.view.bounds.height)
            //値の受け渡し
            let app:AppDelegate =
                (UIApplication.shared.delegate as! AppDelegate)
            app.userlist = userlist
            // 遷移するViewを定義する.
            let NextViewController: UIViewController = IdentificationViewController()
            //viewの遷移
            self.present(NextViewController, animated: false, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 再利用するCellを取得する.
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath)
        
        // Cellに値を設定する.
        cell.textLabel!.text = "\(myItems[indexPath.row])"
        
        return cell
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
