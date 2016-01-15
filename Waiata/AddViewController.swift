//
//  AddViewController.swift
//  Waiata
//
//  Created by Admin on 1/01/16.
//  Copyright © 2016 Iben Van de Veire. All rights reserved.
//

import UIKit

class
AddViewController: UIViewController{

   
    
    @IBOutlet weak var lyricsText: UITextField!

    
    @IBOutlet weak var lyricsTag: UITextField!
    
    var lyrics : String = ""
    var tag : String = ""
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
   
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "addLyrics") {
            
            lyrics = lyricsText.text!
            tag = lyricsTag.text!
            
        }
    }

}
