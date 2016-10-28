//
//  VoteCustomCell.swift
//  fake
//
//  Created by 大谷勇陽 on 2016/10/26.
//  Copyright © 2016年 yu_hi. All rights reserved.
//

import UIKit

class VoteCustomCell: UITableViewCell {
    var voteButton=UIButton()
    var contentLabel = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    internal func voteButton(sender:UIButton) {
        
    }
    func setCell(name:String) {
        let cellWidth: CGFloat = self.frame.width
        let cellHeight: CGFloat = self.frame.height
        let voteButton: UIButton = UIButton(frame: CGRect(x: (cellWidth - 50),y: cellHeight/2, width: 50, height: 15))
        voteButton.backgroundColor = UIColor.red
        voteButton.layer.masksToBounds = true
        voteButton.setTitle("vote", for: .normal)
        //voteButton.layer.cornerRadius = 20.0
        voteButton.addTarget(self, action: #selector(voteButton(sender:)), for: .touchUpInside)
        //self.addSubview(voteButton);
        contentLabel = UILabel(frame: CGRect(x:10, y:20, width:300, height:15));
        contentLabel.text = name;
        contentLabel.font = UIFont.systemFont(ofSize: 22)
        self.addSubview(contentLabel);
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
