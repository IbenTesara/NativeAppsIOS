//
//  DetailViewController.swift
//  Waiata
//
//  Created by Admin on 1/01/16.
//  Copyright © 2016 Iben Van de Veire. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    var lyricsAdapter : LyricsAdapter!
    var lyricsDescription : String = "Welcome !"
    
    
  


    override func viewDidLoad() {
        super.viewDidLoad()
        
        descriptionLabel.text = self.lyricsDescription

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }

    

  

}
