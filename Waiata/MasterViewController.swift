//
//  MasterViewController.swift
//  Waiata
//
//  Created by Admin on 1/01/16.
//  Copyright © 2016 Iben Van de Veire. All rights reserved.
//

import UIKit

//Via http://www.raywenderlich.com/113772/uisearchcontroller-tutorial
extension MasterViewController: UISearchResultsUpdating {
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        filterLyrics(searchController.searchBar.text!, scope: scope)
    }
    }
//Via http://www.raywenderlich.com/113772/uisearchcontroller-tutorial
extension MasterViewController: UISearchBarDelegate {
    func searchBar(searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterLyrics(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
    }
}
class MasterViewController: UITableViewController {
    
    
    let lyricAdapter = LyricsAdapter()
    
    var lyrics = [Int:[Lyrics]]()
    var sections =  [String]()
    
    var filteredLyrics = [Lyrics]()
    let searchController = UISearchController(searchResultsController: nil)
    
    
    
    
    required init(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)!
        
        
        sections = lyricAdapter.tags
        lyrics = lyricAdapter.passLyrics()
        
    
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

         self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        
        //Via http://www.raywenderlich.com/113772/uisearchcontroller-tutorial
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchBar.scopeButtonTitles = ["Contains","Ends","Tag"]
        searchController.searchBar.delegate = self
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        if(searchController.active && searchController.searchBar.text != ""){
        
            return 1
        
        }
        
        return self.lyrics.keys.count
        
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        if(searchController.active && searchController.searchBar.text != ""){
        
            return filteredLyrics.count
        }
        
        return (self.lyrics[section]?.count)!
        
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell",forIndexPath: indexPath)
        

        // Configure the cell...
        
        let lyric: Lyrics
        
        if(searchController.active && searchController.searchBar.text != ""){
        
            lyric = filteredLyrics[indexPath.row]
        
        } else {
        
            let listArray = self.lyrics[indexPath.section]!
            lyric = listArray[indexPath.row]
        
        }
        
        cell.textLabel?.text = lyric.getDescription();
 
        
        return cell
    }
    
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if(searchController.active && searchController.searchBar.text != ""){
        
            return "Results"
            
        }
        return sections[section]
    }
   
    
   
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        lyricAdapter.removeLyrics(indexPath.section, position: indexPath.row)
        refreshData()
        
    }

    
    @IBAction func cancelAddingLyrics (segue : UIStoryboardSegue ){
    
    }
    
    @IBAction func addLyrics(segue : UIStoryboardSegue){
        
        let controller = segue.sourceViewController as! AddViewController ;
        
        var tag = "Other"
        
        if(!controller.tag.isEmpty){
        
            tag = controller.tag
        
        }
        
        lyricAdapter.addLyrics(controller.lyrics, tag: tag)
        
       refreshData()
    
    }
 
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        
        if(segue.identifier == "toLyrics" ){
        
        let controller = segue.destinationViewController as! DetailViewController
            
            let lyric : Lyrics
            
            if (self.searchController.active && self.searchController.searchBar.text != ""){
            
                lyric = filteredLyrics[tableView.indexPathForSelectedRow!.row]
            } else {
            
                let listArray = lyrics[tableView.indexPathForSelectedRow!.section]
             lyric = listArray![tableView.indexPathForSelectedRow!.row]
            
            }
            
            
            controller.lyricsDescription = lyric.getDescription()
        
        }
        
    }
    
    func filterLyrics( filter : String, scope : String = "All"){
        
        var lyricsToFilter = [Lyrics]()
        
        for lyric in self.lyrics.values{
        
            
            lyricsToFilter += lyric
        
        }
        
        self.filteredLyrics = lyricsToFilter.filter{ lyric in
            
            if(scope == "Ends"){
            
                let filterArray = lyric.getDescription().componentsSeparatedByString(" ")
                
                return (filterArray.last?.lowercaseString.containsString(filter.lowercaseString))!
                
            } else if (scope == "Tag"){
            
                return lyric.tag.lowercaseString == filter.lowercaseString
            
            }
            
            return lyric.getDescription().lowercaseString.containsString(filter.lowercaseString)
            
        }
        
        
        tableView.reloadData()
        
    }
    
    func refreshData(){
    
        lyricAdapter.passLyrics()
        
        lyrics = lyricAdapter.result
        sections = lyricAdapter.tags
        
        
        tableView.reloadData()
    
    }
    


}
