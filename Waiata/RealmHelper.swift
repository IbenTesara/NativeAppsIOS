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
    
        //Openen van database
        persister = try! Realm()
    }
    

    func writeToDataBase( lyric : LyricsRealm){
    
       
        //Schrijven naar database
        try! persister.write { () -> Void in
            persister.add(lyric)
        }
    
    }
    
    func getAllLyrics() {
        
        //Opstellen van nieuwe set voor tags ( set, aangezien we ze gaan sorteren op tag dus we mogen de tag maar één keer hebben)
        tags = Set<String>()
        
        //Opvragen van alle LyricsRealm-objects uit de database
        lyrics = persister.objects(LyricsRealm)
        
        //Opstellen van nieuwe lyricsAdapted lisst
        lyricsAdapted = [Lyrics]()

        //Omvormen van LyricsRealm naar Lyric + toevoegen van tag aan set
        for lyric in lyrics{
        
            
            lyricsAdapted.append(convertToLyric(lyric.songDescription, tag: lyric.tag))
            tags.insert(lyric.tag)
            
        }
        
        
        
    
    }
    
    //Converten naar Lyrics
    func convertToLyric( description : String, tag : String ) -> Lyrics{
        
        return Lyrics(description: description, tag: tag)
        
    }
    
    //Verwijderen van lyrics
    func removeLyric ( description : String, tag : String){
        
        let objectToDelete = persister.objects(LyricsRealm).filter("songDescription = '"+description+"' AND tag = '"+tag+"'")
        
        
        try! persister.write { () -> Void in
            persister.delete(objectToDelete)
        }
      
    
    }
    
    //Niet gebruikt
    func update( description : String, tag : String){
    
        let lyric = LyricsRealm()
        
        lyric.songDescription = description
        lyric.tag = tag
        
        try! persister.write{
            
            persister.add(lyric, update: true)
        
        }
        
    
    }
    

}