//
//  AnswerViewController.swift
//  fake
//
//  Created by 今井将兵 on 2016/10/18.
//  Copyright © 2016年 yu_hi. All rights reserved.
//

import UIKit

class AnswerViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {

    var userlist = UserList()
    var selectedtitleid = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        //値の受け渡し
        let app:AppDelegate =
            (UIApplication.shared.delegate as! AppDelegate)
        userlist = app.userlist
        
        // 背景色をwhiteに設定する.
        self.view.backgroundColor = UIColor.white
        
        //ラベルの作成
        // ラベルのサイズを定義.
        let bWidth: CGFloat = 400
        let bHeight: CGFloat = 300
        let posX: CGFloat = self.view.bounds.width/2 - bWidth/2
        let posY: CGFloat = self.view.bounds.height/4 - bHeight/2
        let label: UITextView = UITextView(frame: CGRect(x: posX, y: posY, width: bWidth, height: bHeight))
        label.text = "エセ芸術家の"+userlist.votename+"\nさん今回のお題を\n答えてください"
        label.textAlignment = NSTextAlignment.center
        self.view.addSubview(label)
        
        var myUIPicker: UIPickerView = UIPickerView()
        myUIPicker.frame = CGRect(x:0,y:self.view.bounds.height/2,width:self.view.bounds.width, height:100)
        myUIPicker.delegate = self
        myUIPicker.dataSource = self
        self.view.addSubview(myUIPicker)
        
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
        if selectedtitleid == userlist.titleid {
            let NextViewController: UIViewController = FakeArtistWinViewController()
            //viewの遷移
            self.present(NextViewController, animated: false, completion: nil)
        }
        let NextViewController: UIViewController = ArtistWinViewController()
        //viewの遷移
        self.present(NextViewController, animated: false, completion: nil)
        
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    /*
     pickerに表示する行数を返すデータソースメソッド.
     (実装必須)
     */
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return userlist.title.count
    }
    
    /*
     pickerに表示する値を返すデリゲートメソッド.
     */
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return userlist.title[row] as? String
    }
    
    /*
     pickerが選択された際に呼ばれるデリゲートメソッド.
     */
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("row: \(row)")
        print("value: \(userlist.title[row])")
        selectedtitleid = row
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
