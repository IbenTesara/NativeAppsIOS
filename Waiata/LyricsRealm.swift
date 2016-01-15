//
//  LyricsRealm.swift
//  Waiata
//
//  Created by Admin on 3/01/16.
//  Copyright © 2016 Iben Van de Veire. All rights reserved.
//

import Foundation
import RealmSwift

class LyricsRealm: Object {
    
    dynamic var songDescription = ""
    dynamic var tag = ""
    

    
    
// Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
}
