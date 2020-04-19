//
//  ViewController.swift
//  vocab
//
//  Created by Lam Nguyen on 3/15/20.
//  Copyright © 2020 Lam Nguyen. All rights reserved.
//

import UIKit
import Foundation
class ViewController: UIViewController {
    var listOfPhrases: [Phrase] = Data().getData()
    var listPhrasesDidAppear = [Int]()
    var numOfPhrases = Int()
    let screenSize: CGRect = UIScreen.main.bounds
    var deltaY: Int = 0
    var timer : Timer?
    var dir: Int = 1
    var initHeight: Int = 0
    var score = 0
    var choice = 0
    let EXTRA_PREP = 4
    var tmpArrayPrep = [String]()
    var pickPhrase = 0
    let TIME: CGFloat = 15
    var listPrep: [String] = ["on", "off", "in", "up", "down", "over", "to", "at", "out", "through", "into", "about", "across", "up to", "down on", "out of", "up with", "around"]
    @IBOutlet weak var labelVerb: UILabel!
    @IBOutlet weak var labelPrep: UILabel!
    @IBOutlet weak var labelExpl: UILabel!
    @IBOutlet weak var labelScore: UILabel!
    @IBOutlet weak var btPick: UIButton!
    @IBOutlet weak var btSwitch: UIButton!
    @IBAction func onClickBtPick(_ sender: Any) {
        timer?.invalidate()
        if tmpArrayPrep[choice] == listOfPhrases[pickPhrase].prep{
            pass()
        }else{
            lost()
        }
    }

    @IBAction func onClickBtSwitch(_ sender: UIButton) {
        choice = (choice + 1) % (EXTRA_PREP+1)
        labelPrep.text = tmpArrayPrep[choice]
    }
    @objc func updateProgress(){
        deltaY += dir
        myView.frame = CGRect(x: 0, y: 0, width: (Int(screenSize.width)),
        height:initHeight + deltaY)
        if initHeight + deltaY > Int(screenSize.height){
            timer?.invalidate()
            onClickBtPick(self)
        }
    }
    func pass(){
        score += 1
        labelScore.text = "\(score)"
        initializeNewQuestion()
        timer = Timer.scheduledTimer(timeInterval: TimeInterval(TIME/(screenSize.height/3)), target: self, selector: #selector(updateProgress), userInfo: nil, repeats: true)
    }
    func lost(){
        score = 0
        performSegue(withIdentifier: "trans1", sender: self)
        labelScore.text = "\(score)"
        deltaY = 0; 
        myView.frame = CGRect(x: 0, y: 0, width: Int(screenSize.width),
        height:initHeight + deltaY)
    }
    func initializeNewQuestion(){
        pickPhrase = Int.random(in: 0 ... numOfPhrases-1)
        labelVerb.text = listOfPhrases[pickPhrase].verb
        labelExpl.text = listOfPhrases[pickPhrase].explanation
        
        listPhrasesDidAppear.append(pickPhrase)
        //print(listPhrasesDidAppear.count)
         
        //create array choices of preps
        tmpArrayPrep = [String]()   //erase
        var numOfChoices = listPrep.count - 1
        for _ in 1...EXTRA_PREP + 1 {
            let tmpPrep = Int.random(in: 0 ... numOfChoices)
            tmpArrayPrep.append(listPrep[tmpPrep])
            //swap tmpPrep vs the last element of listPrep to avoid coincidence
            let tmp = listPrep[tmpPrep]
            listPrep[tmpPrep] = listPrep[numOfChoices]
            listPrep[numOfChoices] = tmp
            numOfChoices -= 1
        }
        tmpArrayPrep[Int.random(in: 0 ... EXTRA_PREP)] = listOfPhrases[pickPhrase].prep
        labelPrep.text = tmpArrayPrep[0]
        choice = 0
        deltaY = 0
        print("\(listOfPhrases[pickPhrase].verb) \(listOfPhrases[pickPhrase].prep)")

    }
    @IBOutlet weak var myView: UIView!
    override func viewDidDisappear(_ animated: Bool) {
        listPhrasesDidAppear = [Int]()
        listPhrasesDidAppear.append(pickPhrase)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //init size 
        initHeight = Int(screenSize.height*2/3)
        print(screenSize.height) 
        //IU
        //set border to test
//        labelExpl.layer.borderWidth = 1
//        labelVerb.layer.borderWidth = 1
//        labelPrep.layer.borderWidth = 1
//        labelScore.layer.borderWidth = 1
        //labelScore
        labelScore.frame = CGRect(x: 20, y: 20, width: 50, height: 50)
        //labelVerb
        labelVerb.frame = CGRect(x: Int(screenSize.width*0.2), y: Int(screenSize.height/7), width: Int(screenSize.width*0.6), height: 50)
        labelVerb.layer.cornerRadius = 15
        labelVerb.layer.shadowColor = UIColor.black.cgColor
        labelVerb.layer.shadowOpacity = 0.3
        labelVerb.layer.shadowOffset = CGSize(width: 0, height: 3)
        labelVerb.layer.shadowRadius = 10

        //labelPrep
        labelPrep.frame = CGRect(
            origin: CGPoint(x: Int(screenSize.width*0.1), y: Int(screenSize.height/7) + 70),
            size: ( CGSize(width: Int(screenSize.width*0.8), height: 50))
        )
        labelPrep.adjustsFontSizeToFitWidth = true
        labelPrep.center.x = self.view.center.x
        labelPrep.layer.cornerRadius = 5
        labelPrep.layer.shadowColor = UIColor.black.cgColor
        labelPrep.layer.shadowOpacity = 0.2
        labelPrep.layer.shadowOffset = CGSize(width: -1, height: 2)
        labelPrep.layer.shadowRadius = 5
        
        //labelExpl
        labelExpl.frame = CGRect(x: Int(screenSize.width*0.1), y: Int(screenSize.height/3 + 10), width: Int(screenSize.width*0.8), height: 100)
        labelExpl.numberOfLines = 0
        labelPrep.adjustsFontSizeToFitWidth = true
        //myView
        myView.frame = CGRect(x: 0, y: 0, width: Int(screenSize.width), height: initHeight)
        myView.layer.shadowColor = UIColor.black.cgColor
        myView.layer.shadowOpacity = 0.4
        myView.layer.shadowOffset = CGSize(width: 0, height: 3)
        myView.layer.shadowRadius = 10
//        myView.layer.shadowPath = UIBezierPath(rect: myView.bounds).cgPath
      //  myView.layer.shouldRasterize = true
        myView.layer.rasterizationScale = UIScreen.main.scale
        
        //btSwitch
        btSwitch.frame = CGRect(x: 0, y: Int(screenSize.height*2/3), width: Int(screenSize.width*0.5), height:  Int(screenSize.height/3)+1)
        btSwitch.layer.shadowColor = UIColor.black.cgColor
        btSwitch.layer.shadowOpacity = 0.7
        btSwitch.layer.shadowOffset = CGSize(width: 3, height: 2)
        btSwitch.layer.shadowRadius = 10
       // btSwitch.layer.cornerRadius = 10
        // btPick
        btPick.frame = CGRect(x: Int(screenSize.width/2), y: Int(screenSize.height*2/3), width: Int(screenSize.width*0.5), height:  Int(screenSize.height/3)+1)
        btPick.layer.shadowColor = UIColor.black.cgColor
        btPick.layer.shadowOpacity = 0.2
        btPick.layer.shadowOffset = CGSize(width: 2, height: 2)
        btPick.layer.shadowRadius = 10
        //btPick.layer.cornerRadius = 10
        //
        numOfPhrases = listOfPhrases.count
                
        initializeNewQuestion()
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextView: SecondView = segue.destination as! SecondView
        nextView.curVerb = labelVerb.text ?? ""
        nextView.wrongPrep = labelPrep.text ?? ""
        nextView.listOfPhrases = listOfPhrases
//        nextView.listPhrases = listPhrasesDidAppear
        for index in 0...listPhrasesDidAppear.count-1{
            nextView.listOfPopingPhrases.append(listPhrasesDidAppear[listPhrasesDidAppear.count-1-index])
        } //reverse
//        nextView.listOfPopingPhrases.append(listOfPhrases.count-3) //debug
    }

}

