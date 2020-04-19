//
//  ListViewController.swift
//  Verb
//
//  Created by Lam Nguyen on 4/1/20.
//  Copyright © 2020 Lam Nguyen. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    let screenSize: CGRect = UIScreen.main.bounds
    var listOfPhrases = [Phrase]()
    var checkedList = [Bool]()
    var myList: [Int] = Data().getMyList()
    var myFilterList = [Int](); 
    @IBOutlet weak var searchBar: UITextField!
    @IBOutlet weak var btBack: UIButton!
    @IBAction func onClickBtBack(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var tbViewMyList: UITableView!
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            myFilterList.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
         return 170
     }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell: CustomListAppearedCell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! CustomListAppearedCell
         cell.index = indexPath.row
         cell.selfController = self
        
        if checkedList[myFilterList[indexPath.row]]{
            cell.btMark.setImage(UIImage(named: "mark.png"), for: .normal)
        }else{ 
            cell.btMark.setImage(UIImage(named: "unmark.png"), for: .normal)
        }
        //set Value
        cell.labelPhrase.text = "\(listOfPhrases[myFilterList[indexPath.row]].verb) \(listOfPhrases[myFilterList[indexPath.row]].prep)"
        cell.labelExplanation.text = listOfPhrases[myFilterList[indexPath.row]].explanation
        return cell
    }
    //Search bar
    @objc func textFieldDidChange(_ textField: UITextField) {
        let searchText = textField.text ?? ""
        if (searchText == ""){
            myFilterList = myList
        }else{
            myFilterList = myList.filter({number -> Bool in
                let tmp = "\(listOfPhrases[number].verb) \(listOfPhrases[number].prep)"
                return tmp.lowercased().contains(searchText.lowercased())
            })
        }
        tbViewMyList.reloadData()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        myFilterList = myList
        tbViewMyList.dataSource = self
        tbViewMyList.delegate = self
        searchBar.addTarget(self, action: #selector(ListViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        tbViewMyList.frame = CGRect(
            origin: CGPoint(x: 0, y: Int(screenSize.height*1/8)),
            size: CGSize(width: Int(screenSize.width), height: Int(screenSize.height*7/8))
        )
//        searchBar.layer.cornerRadius = 20 

        
        // Do any additional setup after loading the view.
    }
}
extension ListViewController: ControlerClicking{
    func onClickBtMark(index: Int, bt: UIButton) {
        checkedList[myFilterList[index]] = !checkedList[myFilterList[index]]
                if checkedList[myFilterList[index]]{
                    bt.setImage(UIImage(named: "mark.png"), for: .normal)
                }else{
                    bt.setImage(UIImage(named: "unmark.png"), for: .normal)
                }
        Data().saveCheckedList(arrayBoolList: checkedList)
    }
}

