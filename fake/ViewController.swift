//
//  ViewController.swift
//  fake
//
//  Created by 今井将兵 on 2016/10/18.
//  Copyright © 2016年 yu_hi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 背景色をwhiteに設定する.
        self.view.backgroundColor = UIColor.white
        self.title = "start"
        //ラベルの作成
        // ラベルのサイズを定義.
        let bWidth: CGFloat = 200
        let bHeight: CGFloat = 50
        let posX: CGFloat = self.view.bounds.width/2 - bWidth/2
        let posY: CGFloat = self.view.bounds.height/2 - bHeight/2
        let label: UILabel = UILabel(frame: CGRect(x: posX, y: posY, width: bWidth, height: bHeight))
        label.text = "エセ芸術家"
        label.textAlignment = NSTextAlignment.center
        self.view.addSubview(label)
        
        // ボタンを生成する.
        let nextButton: UIButton = UIButton(frame: CGRect(x: 0,y: 0, width: 120, height: 50))
        nextButton.backgroundColor = UIColor.red
        nextButton.layer.masksToBounds = true
        nextButton.setTitle("START", for: .normal)
        nextButton.layer.cornerRadius = 20.0
        nextButton.layer.position = CGPoint(x: self.view.bounds.width/2 , y:self.view.bounds.height-50)
        nextButton.addTarget(self, action: #selector(onClickMyButton(sender:)), for: .touchUpInside)
        
        // ボタンを追加する.
        self.view.addSubview(nextButton);
        // Do any additional setup after loading the view.
        // toruko
    }
    
    internal func onClickMyButton(sender: UIButton) {
        // 遷移するViewを定義する.
        let NextViewController: UIViewController = UserAddViewController()
        //viewの遷移
        self.navigationController?.pushViewController(NextViewController, animated: false)
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

