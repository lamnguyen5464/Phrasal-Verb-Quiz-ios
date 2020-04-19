//
//  CustomListAppearedCell.swift
//  Verb
//
//  Created by Lam Nguyen on 3/30/20.
//  Copyright © 2020 Lam Nguyen. All rights reserved.
//

import UIKit
import Foundation
protocol ControlerClicking{
    func onClickBtMark(index: Int, bt: UIButton)
}
class CustomListAppearedCell: UITableViewCell {
    let screenSize: CGRect = UIScreen.main.bounds
    @IBOutlet weak var btMark: UIButton!
    @IBOutlet weak var backgroundCell: UIView!
    @IBOutlet weak var labelPhrase: UILabel!
    @IBOutlet weak var labelExplanation: UILabel!
    var index: Int = 0
    var selfController: ControlerClicking?
    @IBAction func onClickBtMarkOfCell(_ sender: UIButton) {
//        print(index)
        selfController?.onClickBtMark(index: index, bt: sender)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        btMark?.frame = CGRect(
            origin: CGPoint(x: Int(screenSize.width*0.94) - 40, y: 10),
            size: CGSize(width: 30, height: 30)
        )
        labelPhrase?.frame = CGRect(
            origin: CGPoint(x: Int(screenSize.width*0.03), y: 5),
            size: CGSize(width: Int(screenSize.width*0.84), height: 40)
        )
        labelPhrase?.numberOfLines = 0
        //  labelPhrase.layer.borderWidth = 1
        labelExplanation?.frame = CGRect(
            origin: CGPoint(x: Int(screenSize.width*0.03), y: 40),
            size: CGSize(width: Int(screenSize.width*0.84), height: 120)
        )
        labelExplanation?.numberOfLines = 0
       
        backgroundCell?.frame = CGRect(
            origin: CGPoint(x: Int(screenSize.width*0.03), y: 0),
            size: CGSize(width: Int(screenSize.width*0.94), height: 160)
        )
        backgroundCell?.layer.cornerRadius = 15
        backgroundCell?.layer.shadowColor = UIColor.black.cgColor
        backgroundCell?.layer.shadowOpacity = 0.4
        backgroundCell?.layer.shadowOffset = CGSize(width: 0, height: 3)
        backgroundCell?.layer.shadowRadius = 10
        
    }

}
