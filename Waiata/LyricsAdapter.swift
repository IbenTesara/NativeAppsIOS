//
//  LyricsAdapter.swift
//  Waiata
//
//  Created by Admin on 1/01/16.
//  Copyright © 2016 Iben Van de Veire. All rights reserved.
//

import Foundation


class LyricsAdapter{

    var lyrics = [Lyrics]()
    
    var other = [Lyrics]()
    var sad = [Lyrics]()
    var happy = [Lyrics]()
    var love = [Lyrics]()
    
    var result = [Int:[Lyrics]]()
    
     var tags = [String]()
    
    var realmHelper : RealmHelper
    
    
    
    required init(){
        
        //Ophalen van realmHelper
        realmHelper = RealmHelper()
        
        //Ophalen van all lyrics-items uit database
        realmHelper.getAllLyrics()
        
        //Update tags
        updateTags()
        
     
        
       
        
    }

    
    //Ophalen lyrics dictionary
    func passLyrics () -> Dictionary<Int,[Lyrics]> {
        
        //Ophalen van alle lyrics-items uit database
         realmHelper.getAllLyrics()
        
        //We halen de naar lyrics-omgezette object op
        lyrics = realmHelper.lyricsAdapted
        
        
        
        //Update tags
        
        updateTags()
        
      
        //We overlopen alle lyrics-items, en voegen die aan de bijhorende arrays in de dictionary toe
        for lyric in lyrics {
        
        let sort = tags.indexOf(lyric.tag)
            
            result[sort!]?.append(lyric)
        }
        
      
        
        //Returnen van dictionary
        return result
    }

    
    func addLyrics(description : String, tag : String){
    
        //Opstellen van nieuw Lyrics object dat kan geschreven worden naar de database
        let lyric = LyricsRealm()
        
        //Toekennen van informatie aan lyricsobject
        lyric.tag = tag
        lyric.songDescription = description
        
        //Wegschrijven naar database
        realmHelper.writeToDataBase(lyric)
        
    
    }
    
    
    func removeLyrics(section : Int, position : Int){
        
        //Opvragen van lyric item die we zullen verwijderen
        let lyric = result[section]![position]
        
        //Meegeven van data aan verwijdermethode
        realmHelper.removeLyric(lyric.description, tag: lyric.tag)
        
    }
    
    //Ongebruikt; mogelijk updaten in de toekomst
    func updateLyrics(description : String, tag : String){
    
        realmHelper.update(description, tag: tag)
    
    }
    
    func updateTags(){
        
        //We doorlopen alle tags van lyrics-items en voegen die toe aan de tags-array ( die we gebruiken voor de titels van de sections ) en voor iedere tag die we hebben, maken we een array aan in de dictionairy.
        var i = 0
        
        tags = [String]()
        
        for tag in realmHelper.tags {
            
            tags.append(tag)
            result[i] = [Lyrics]()
            i++
            
        }
    }

}