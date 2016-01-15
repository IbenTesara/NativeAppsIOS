//
//  Lyrics.swift
//  Waiata
//
//  Created by Admin on 1/01/16.
//  Copyright © 2016 Iben Van de Veire. All rights reserved.
//

import Foundation

class Lyrics {


    var description : String
    let tag : Mood
    

    
    init(description: String, tag : Mood){
    
        self.description = description
        self.tag = tag
    
    }
    
    func getDescription() -> String {
    
        return self.description
    
    }

}