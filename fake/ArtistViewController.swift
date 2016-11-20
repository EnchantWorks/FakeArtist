//
//  ArtistViewController.swift
//  fake
//
//  Created by 今井将兵 on 2016/10/18.
//  Copyright © 2016年 yu_hi. All rights reserved.
//

import UIKit

class ArtistViewController: UIViewController {
    var userlist = UserList()
    var lastPoint: CGPoint?
    var CanvasView: UIImageView!
    var lineWidth: CGFloat?                 //描画用の線の太さの保存用
    var drawColor = UIColor()               //描画色の保存用
    var bezierPath = UIBezierPath()         //お絵描きに使用
    let defaultLineWidth: CGFloat = 5.0    //デフォルトの線の太さ
    var drawcount:Bool = true
    var saveImage:UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.yellow
        //値の受け渡し
        let app:AppDelegate =
            (UIApplication.shared.delegate as! AppDelegate)
        userlist = app.userlist
        drawColor = userlist.userlist[userlist.currentid].color
        // ラベルのサイズを定義.
        let bWidth: CGFloat = self.view.bounds.width
        let bHeight: CGFloat = 60
        let posX: CGFloat = 0
        let posY: CGFloat = 10
        let label: UITextView = UITextView(frame: CGRect(x: posX, y: posY, width: bWidth, height: bHeight))
        if userlist.isFake() {
            label.text = "あなたはエセ芸術家です\nお題を予想して描きましょう。"
        } else {

            label.text = "今回のお題は\n「"+userlist.title[userlist.titleid]+"」です。"
        }
        label.textAlignment = NSTextAlignment.center
        self.view.addSubview(label)
        
        //実際のお絵描きで言う描く手段(色えんぴつ？クレヨン？絵の具？など)の準備
        let myDraw = UIPanGestureRecognizer(target: self, action: #selector(drawGesture(sender:)))
        myDraw.maximumNumberOfTouches = 1
        self.view.addGestureRecognizer(myDraw)
        //実際のお絵描きで言うキャンバスの準備 (=何も描かれていないUIImageの作成)
        CanvasView = UIImageView(frame: CGRect(x: 0,y: 100,width: self.view.bounds.width,height: self.view.bounds.height/2))
        let newimage = userlist.getImage()
        CanvasView.image = newimage
        self.view.addSubview(CanvasView);
        
        //書き直すボタンを生成する
        let reButton: UIButton = UIButton(frame: CGRect(x: 0,y: 0, width: 120, height: 30))
        reButton.backgroundColor = UIColor.black
        reButton.layer.masksToBounds = true
        reButton.setTitle("書き直す", for: .normal)
        reButton.setTitleColor(UIColor.blue, for: .normal)
        reButton.layer.cornerRadius = 20.0
        reButton.layer.position = CGPoint(x: self.view.bounds.width/2 , y:self.view.bounds.height-60)
        reButton.addTarget(self, action: #selector(reButton(sender:)), for: .touchUpInside)
        //////////////////////////////////////////////
        
        // 完了ボタンを生成する.
        let finButton: UIButton = UIButton(frame: CGRect(x: 0,y: 0, width: 120, height: 30))
        finButton.backgroundColor = UIColor.green
        finButton.layer.masksToBounds = true
        finButton.setTitle("完了", for: .normal)
        finButton.layer.cornerRadius = 20.0
        finButton.layer.position = CGPoint(x: self.view.bounds.width/2 , y:self.view.bounds.height-20)
        finButton.addTarget(self, action: #selector(finButton(sender:)), for: .touchUpInside)
        //////////////////////////////////////////////
        
        // ボタンを追加する.
        self.view.addSubview(reButton);
        self.view.addSubview(finButton);
        
        // Do any additional setup after loading the view.
    }
    //書き直しボタンを押した時
    internal func reButton(sender: UIButton) {
        //let newimage = userlist.getImage()
        self.CanvasView.image = saveImage
        bezierPath.removeAllPoints()
        drawcount = true
    
    }
    //完了ボタンを押した時
    internal func finButton(sender: UIButton) {
        userlist.Image = CanvasView.image!
        userlist.phase()
        // 遷移するViewを定義する.
        let NextViewController: UIViewController = IdentificationViewController()
        //viewの遷移
        self.present(NextViewController, animated: false, completion: nil)
    }

    /**
     draw動作
     */
    func drawGesture(sender: AnyObject) {
        if drawcount {
        guard let drawGesture = sender as? UIPanGestureRecognizer else {
            print("drawGesture Error happened.")
            return
        }
        guard let canvas = CanvasView.image else {
            fatalError("self.pictureView.image not found")
        }
        lineWidth = defaultLineWidth                                    //描画用の線の太さを決定する
        let touchPoint = drawGesture.location(in: CanvasView)         //タッチ座標を取得
        
        switch drawGesture.state {
        case .began:
            saveImage = CanvasView.image
            lastPoint = touchPoint                  //タッチ座標をlastTouchPointとして保存する
            bezierPath.lineCapStyle = .round                            //描画線の設定 端を丸くする
            bezierPath.lineWidth = defaultLineWidth
            bezierPath.move(to: lastPoint!)
        case .changed:
            let newPoint = touchPoint                          //タッチポイントを最新として保存
            //Draw実行
            let imageAfterDraw = drawGestureAtChanged(canvas: canvas, lastPoint: lastPoint!, newPoint: newPoint, bezierPath: bezierPath)
            CanvasView.image = imageAfterDraw
            lastPoint = newPoint
        //Point保存
        case .ended:
            print("Finish dragging")
            drawcount = false
        default:
            ()
        }
        }
        
    }
    /**
     UIGestureRecognizerのStatusが.Changedの時に実行するDraw動作
     
     - parameter canvas : キャンバス
     - parameter lastPoint : 最新のタッチから直前に保存した座標
     - parameter newPoint : 最新のタッチの座標座標
     - parameter bezierPath : 線の設定などが保管されたインスタンス
     */
    func drawGestureAtChanged(canvas: UIImage, lastPoint: CGPoint, newPoint: CGPoint, bezierPath: UIBezierPath) -> UIImage{
        
        //最新のtouchPointとlastPointからmiddlePointを算出
        let middlePoint = CGPoint(x: (lastPoint.x + newPoint.x) / 2,y: (lastPoint.y + newPoint.y) / 2)
        bezierPath.addQuadCurve(to: middlePoint, controlPoint: lastPoint)  //曲線を描く
        UIGraphicsBeginImageContext(canvas.size)                 //コンテキストを作成
        let canvasRect = CGRect(x:0, y:0, width:canvas.size.width, height:canvas.size.height)        //コンテキストのRect
        CanvasView.image?.draw(in: canvasRect)                                   //既存のCanvasを準備
        drawColor.setStroke()                                                           //drawをセット
        bezierPath.stroke()                                                             //draw実行
        let imageAfterDraw = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();                                                    //コンテキストを閉じる
        //UIGraphicsGetCurrentContext()!.clear(canvasRect)
        return imageAfterDraw!
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
