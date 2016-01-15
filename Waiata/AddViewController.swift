//
//  AddViewController.swift
//  Waiata
//
//  Created by Admin on 1/01/16.
//  Copyright © 2016 Iben Van de Veire. All rights reserved.
//

import UIKit

class
AddViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var lyricsDescription: UITextField!
    
    @IBOutlet weak var moodPicker: UIPickerView!
    
    var lyricsText : String = ""
    var tag : Mood!
    var adapter = LyricsAdapter!()
    
    //Via CodeWithChris.com
    var pickerData: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Via CodeWithChris.com
        self.moodPicker.delegate = self
        self.moodPicker.dataSource = self
        
        pickerData = adapter.moods

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //Via CodeWithChris.com
    // The number of columns of data
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    //Via CodeWithChris.com
    // The number of rows of data
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    //ViaCodeWithChris.com
    // The data to return for the row and component (column) that's being passed in
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if(pickerData[row] == "Sad"){
        
            tag = Mood.Sad
        
        } else if (pickerData[row] == "Happy"){
        
            tag = Mood.Happy
            
        
        } else if (pickerData[row] == "Love"){
        
        
            tag = Mood.Love
        
        } else if (pickerData[row] == "Other"){
        
        tag = Mood.Other
        
        }
        
    }

   
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "addLyrics") {
            
            lyricsText = lyricsDescription.text!
            
            
        }
    }

}
