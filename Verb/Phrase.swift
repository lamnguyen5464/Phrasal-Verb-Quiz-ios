//
//  Phrase.swift
//  Verb
//
//  Created by Lam Nguyen on 3/23/20.
//  Copyright © 2020 Lam Nguyen. All rights reserved.
//

import Foundation
class Phrase{
    var verb: String = ""
    var prep: String = ""
    var explanation: String = ""
//    var inList: Bool = false
    init(v: String, p: String, e: String) {
        self.verb = v
        self.prep = p
        self.explanation = e
    }
    func setPhrase(v: String, p: String, e: String){
        self.verb = v
        self.prep = p
        self.explanation = e
    }
} 
