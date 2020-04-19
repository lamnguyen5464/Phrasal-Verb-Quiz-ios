//
//  MyList.swift
//  Verb
//
//  Created by Lam Nguyen on 4/1/20.
//  Copyright © 2020 Lam Nguyen. All rights reserved.
//

import Foundation

class Node<T>{
    var value: T
    init(value: T, lefChild: Node?=nil, rightChild: Node?=nil) {
        self.value = value
        self.leftChild = lefChild
        self.rightChild = rightChild
    }
    var leftChild: Node?
    var rightChild: Node?
    var parent: Node?
}

public class MyList<T: Comparable>{ //Codable is to encode and decode when saving
    var root: Node<T>?
    var numOfNode: Int = 0
//    func isEmpty()->Bool{
//        return root == nil
//    }
//    func returnToRoot(){
//        while root.parent != nil{ //!= nil
//            root = root.parent!
//        }
//    }
    func append(newVal: T){
        self.numOfNode += 1
        if self.root == nil{
            self.root = Node(value: newVal)
        }else{
            insert(newVal: newVal, root: self.root!)
        }
        
    }
    private func insert(newVal: T, root: Node<T>){
        
        if newVal <= root.value {
            print("\(newVal) is on the left of \(root.value)")
            if let left = root.leftChild{
                insert(newVal: newVal, root: left)
            }else{
                root.leftChild = Node(value: newVal)
            }
        }
        else{
            print("\(newVal) is on the right of \(root.value)")
            if let right = root.rightChild{
                insert(newVal: newVal, root: right)
            }else{
                root.rightChild = Node(value: newVal)
            }
        }
        
    }
//    func getExistingList()->MyList{
//        var tmp = UserDefaults.standard.array(forKey: "myList")
//        if (tmp != nil) { // not nil
//            
//        }
//        return tmp
//    }
}
