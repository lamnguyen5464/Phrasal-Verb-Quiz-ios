//
//  SecondView.swift
//  Verb
//
//  Created by Lam Nguyen on 3/25/20.
//  Copyright © 2020 Lam Nguyen. All rights reserved.
//

import Foundation
import UIKit
class SecondView: UIViewController, UITableViewDataSource, UITableViewDelegate {
    let screenSize: CGRect = UIScreen.main.bounds
    var curVerb = String()
    var wrongPrep = String()
    var listOfPhrases = [Phrase]()
    var listOfPopingPhrases = [Int]()
    var checkedList: [Bool] = Data().getCheckedList()
     
    @IBOutlet weak var btBack: UIButton!
    @IBOutlet weak var btList: UIButton!
    @IBOutlet weak var backgroundTop: UIView!
    @IBOutlet weak var labelResult: UILabel!
    @IBAction func onClickBackButton(_ sender: UIButton) { 
        dismiss(animated: true, completion: nil)
    }
    @IBAction func onClickListButton(_ sender: UIButton) {
        performSegue(withIdentifier: "transToList", sender: self)
    } 
    //TableView Setup
    @IBOutlet weak var tbViewVerb: UITableView! 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfPopingPhrases.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 170
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CustomListAppearedCell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! CustomListAppearedCell
        cell.index = indexPath.row
        cell.selfController = self 
        //
        if indexPath.row != 0 {
            cell.backgroundCell.backgroundColor = #colorLiteral(red: 1, green: 0.7721788287, blue: 0.3725811243, alpha: 1)
        }else{
            cell.backgroundCell?.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        }
        if checkedList[listOfPopingPhrases[indexPath.row]]{
            cell.btMark.setImage(UIImage(named: "mark.png"), for: .normal)
        }else{
            cell.btMark.setImage(UIImage(named: "unmark.png"), for: .normal)
        }
        //set Value
        cell.labelPhrase.text = "\(listOfPopingPhrases.count-indexPath.row). \(listOfPhrases[listOfPopingPhrases[indexPath.row]].verb) \(listOfPhrases[listOfPopingPhrases[indexPath.row]].prep)"
        cell.labelExplanation.text = listOfPhrases[listOfPopingPhrases[indexPath.row]].explanation
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tbViewVerb.dataSource = self
        tbViewVerb.delegate = self
        tbViewVerb.frame = CGRect(
            origin: CGPoint(x: 0, y: Int(screenSize.height*2/5)),
            size: CGSize(width: Int(screenSize.width), height: Int(screenSize.height*3/5))
        )
        //UI
        //labelResult
        labelResult.numberOfLines = 0
        labelResult.text = "\(curVerb)...\n\(wrongPrep)??"
        labelResult.frame = CGRect(
            origin: CGPoint(x: 0, y: 0),
            size: CGSize(width: Int(screenSize.width*0.8), height: 120)
        )
        labelResult.center.x = self.view.center.x
        labelResult.center.y = screenSize.height/6
        //backgroundTop
        backgroundTop.frame = CGRect(
            origin: CGPoint(x: 0, y: 0),
            size: CGSize(width: Int(screenSize.width), height: Int(screenSize.height*2/5))
        )
        backgroundTop.layer.shadowColor = UIColor.black.cgColor
        backgroundTop.layer.shadowOpacity = 0.4
        backgroundTop.layer.shadowOffset = CGSize(width: 0, height: 3)
        backgroundTop.layer.shadowRadius = 10
        //btBack
        btBack.frame = CGRect(
            origin: CGPoint(x: Int(screenSize.width*0.1), y: 0),
            size: CGSize(width: Int(screenSize.height*0.07), height: Int(screenSize.height*0.07))
        ) 
        btBack.center.y = screenSize.height*0.35
        //btList
        btList.frame = CGRect(
            origin: CGPoint(x: 0, y: 0),
            size: CGSize(width: Int(screenSize.height*0.07), height: Int(screenSize.height*0.07))
        )
        btList.center.y = screenSize.height*0.35
        btList.center.x = screenSize.width/2
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextView: ListViewController = segue.destination as! ListViewController
        nextView.listOfPhrases = listOfPhrases
        nextView.checkedList = checkedList
    }
    
}
extension SecondView: ControlerClicking{
    func onClickBtMark(index: Int, bt: UIButton) {
        checkedList[listOfPopingPhrases[index]] = !checkedList[listOfPopingPhrases[index]]
        if checkedList[listOfPopingPhrases[index]]{
//            print("add \(listOfPhrases[listOfPopingPhrases[index]].verb)_\(listOfPhrases[listOfPopingPhrases[index]].prep) to your list")
            bt.setImage(UIImage(named: "mark.png"), for: .normal)
        }else{
//            print("remove \(listOfPhrases[listOfPopingPhrases[index]].verb)_\(listOfPhrases[listOfPopingPhrases[index]].prep) from your list")
            bt.setImage(UIImage(named: "unmark.png"), for: .normal)
        }
        Data().saveCheckedList(arrayBoolList: checkedList)
    }
}
