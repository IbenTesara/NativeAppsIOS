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
    
     var moods = [String]()
    
    var realmHelper : RealmHelper
    
    
    
    init(){
        
        
        moods.append("Other")
        moods.append("Sad")
        moods.append("Happy")
        moods.append("Love")
        
     
        realmHelper = RealmHelper()
       
        
    }


    func passLyrics () -> Dictionary<Int,[Lyrics]> {
        
        result = [Int:[Lyrics]]()
        
         realmHelper.getAllLyrics()
        lyrics = realmHelper.lyricsAdapted
        
        other = [Lyrics]()
        sad = [Lyrics]()
        happy = [Lyrics]()
        love = [Lyrics]()
        
        for lyric in lyrics{
        
            if(lyric.tag == Mood.Other ){
            
            
                other.append(lyric)
                
            } else if (lyric.tag == Mood.Sad){
            
                sad.append(lyric)
                
            } else if (lyric.tag == Mood.Happy){
            
            
                happy.append(lyric)
                
            } else if(lyric.tag == Mood.Love){
            
                love.append(lyric)
            
            }
        
        }
        
        result[0] = other
        result[1] = sad
        result[2] = happy
        result[3] = love
        
        return result
    }

    
    func addLyrics(description : String, tag : Mood){
    
        let lyric = LyricsRealm()
        
        lyric.tag = tag.rawValue
        lyric.songDescription = description
        
        realmHelper.writeToDataBase(lyric)
        
    
    }
    
    func removeLyrics(section : Int, position : Int){
        let lyric = result[section]![position]
      
        
        realmHelper.removeLyric(lyric.description, tag: lyric.tag.rawValue)
        
    }

}