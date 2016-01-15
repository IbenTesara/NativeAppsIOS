


//Oorspronkelijk werd de Online database "Parse" gebruikt; maar deze retourneerde nooit objecten. Zelfs niet wanneer specifieke ID's gebruikt werden en de objecten wel degelijk bestonden







//
//  ParseHelper.swift
//  Waiata
//
//  Created by Admin on 2/01/16.
//  Copyright © 2016 Iben Van de Veire. All rights reserved.
//

/*import Foundation
import Parse
import Bolts

class ParseHelper{


    var lyrics = [Lyrics]()

    func saveToDataBase(lyrics : Lyrics){
    
        let parseObject = PFObject(className:"Lyrics")
        parseObject["description"] = lyrics.description
        parseObject["mood"] = lyrics.tag.rawValue
        
        parseObject.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if (success) {
                // The object has been saved.
            } else {
                // There was a problem, check error.description
            }
        }

        
        getAllLyrics()
    
    }
    
    func getAllLyrics(){
       
        
        let query: PFQuery = PFQuery(className: "Lyrics")
        
        query.findObjectsInBackgroundWithBlock { (result : [PFObject]?, error: NSError?) -> Void in
        
            self.lyrics = [Lyrics]()
            if(result != nil){
                
             for lyricObject in result! {
            
                let description : String = (lyricObject as PFObject)["description"] as! String
                let mood : String = (lyricObject as PFObject)["mood"] as! String
                self.lyrics.append(self.convertToLyric(description, tag: mood))
                
            }
           
            }
            
            print(self.lyrics)
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


}*/