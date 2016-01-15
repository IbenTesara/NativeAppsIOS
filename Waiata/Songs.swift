//
//  Songs.swift
//  Waiata
//
//  Created by Admin on 2/01/16.
//  Copyright © 2016 Iben Van de Veire. All rights reserved.
//

import Foundation

class Songs : Lyrics{


 var songTitle = String!()
 var verses = [Lyrics]()

    init(songTitle : String){
    
        super.init(description: "", tag: Mood.Song)
        self.songTitle = songTitle
    }
    
    
    override func getDescription() ->String {
    
        for lyric in verses{
        
            super.description += lyric.description + "\r\n"
        
        }
        
        return super.description
    
    }
    
    func addLyrics(lyrics : Lyrics ){
    
        verses.append(lyrics)
    
    }


}