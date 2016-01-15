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
    
    init(){
    
        persister = try! Realm()
    }
    

    func writeToDataBase( lyric : LyricsRealm){
    
       
        
        try! persister.write { () -> Void in
            persister.add(lyric)
        }
    
    }
    
    func getAllLyrics() {
    
        
        lyrics = persister.objects(LyricsRealm)
        
        
        lyricsAdapted = [Lyrics]()

        
        for lyric in lyrics{
        
            
            lyricsAdapted.append(convertToLyric(lyric.songDescription, tag: lyric.tag))
            
        }
        
    
    }
    
    func convertToLyric( description : String, tag : String ) -> Lyrics{
        
        var mood = Mood.Other
        
        if( tag == "Sad"){
            
            mood = Mood.Sad
            
        } else if (tag == "Other"){
            
            mood = Mood.Other
            
        } else if ( tag == "Happy"){
            
            mood = Mood.Happy
            
        } else if ( tag == "Love"){
            
            mood = Mood.Love
            
        }
        
        return Lyrics(description: description, tag: mood)
        
    }
    
    func removeLyric ( description : String, tag : String){
        
        let objectToDelete = persister.objects(LyricsRealm).filter("songDescription = '"+description+"' AND tag = '"+tag+"'")
        
        
        try! persister.write { () -> Void in
            persister.delete(objectToDelete)
        }
      
    
    }
    

}