//
//  RealmHelper.swift
//  Waiata
//
//  Created by Admin on 3/01/16.
//  Copyright © 2016 Iben Van de Veire. All rights reserved.
//

import Foundation
import RealmSwift
class RealmHelper{


    var persister : Realm
    
    var lyrics : Results<LyricsRealm>!
    var lyricsAdapted = [Lyrics]()
    var tags = Set<String>()
    
    init(){
    
        persister = try! Realm()
    }
    

    func writeToDataBase( lyric : LyricsRealm){
    
       
        
        try! persister.write { () -> Void in
            persister.add(lyric)
        }
    
    }
    
    func getAllLyrics() {
    
        tags = Set<String>()
        
        lyrics = persister.objects(LyricsRealm)
        
        
        lyricsAdapted = [Lyrics]()

        
        for lyric in lyrics{
        
            
            lyricsAdapted.append(convertToLyric(lyric.songDescription, tag: lyric.tag))
            tags.insert(lyric.tag)
            
        }
        
        
        
    
    }
    
    func convertToLyric( description : String, tag : String ) -> Lyrics{
        
        return Lyrics(description: description, tag: tag)
        
    }
    
    func removeLyric ( description : String, tag : String){
        
        let objectToDelete = persister.objects(LyricsRealm).filter("songDescription = '"+description+"' AND tag = '"+tag+"'")
        
        
        try! persister.write { () -> Void in
            persister.delete(objectToDelete)
        }
      
    
    }
    
    func update( description : String, tag : String){
    
        let lyric = LyricsRealm()
        
        lyric.songDescription = description
        lyric.tag = tag
        
        try! persister.write{
            
            persister.add(lyric, update: true)
        
        }
        
    
    }
    

}