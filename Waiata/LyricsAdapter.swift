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
        
        realmHelper = RealmHelper()
        realmHelper.getAllLyrics()
        
        var i = 0
        
        
        
        for tag in realmHelper.tags {
        
            tags.append(tag)
            result[i] = [Lyrics]()
            i++
        
        }
        
     
        
       
        
    }


    func passLyrics () -> Dictionary<Int,[Lyrics]> {
        
         realmHelper.getAllLyrics()
        lyrics = realmHelper.lyricsAdapted
        
        var i = 0
        
        tags = [String]()
        
        for tag in realmHelper.tags {
            
            tags.append(tag)
            result[i] = [Lyrics]()
            i++
            
        }
        
      
        for lyric in lyrics {
        
        let sort = tags.indexOf(lyric.tag)
            
            result[sort!]?.append(lyric)
        }
        
      
        
        
        return result
    }

    
    func addLyrics(description : String, tag : String){
    
        let lyric = LyricsRealm()
        
        lyric.tag = tag
        lyric.songDescription = description
        
        realmHelper.writeToDataBase(lyric)
        
    
    }
    
    func removeLyrics(section : Int, position : Int){
        let lyric = result[section]![position]
        realmHelper.removeLyric(lyric.description, tag: lyric.tag)
        
    }
    
    func updateLyrics(description : String, tag : String){
    
        realmHelper.update(description, tag: tag)
    
    }

}