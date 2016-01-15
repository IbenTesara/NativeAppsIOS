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
        
        //Ophalen van sections en lyrics uit LyricAdapter
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
        
        //Indien de search-functie geactiveerd is, hebben we maar één sectie nodig
        if(searchController.active && searchController.searchBar.text != ""){
        
            return 1
        
        }
        
        
        //Indien de search-functie niet geactiveerd is of nog leeg is, dan hebben we evenveel sections nodig als er tags zijn
        return self.lyrics.keys.count
        
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //Indien search geactiveerd, gebruiken we count van de gefilterede resultaten
        if(searchController.active && searchController.searchBar.text != ""){
        
            return filteredLyrics.count
        }
        
        //Search is niet geactiveerd, of is nog leeg; we gebruiken dus het aantal lyrics die iedere array heeft
        return (self.lyrics[section]?.count)!
        
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell",forIndexPath: indexPath)
        

        //Opstellen van Cel
       
        
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
        
        //Indien de search geactiveerd is, geven we "Results" ipv de tags als sectie
        if(searchController.active && searchController.searchBar.text != ""){
        
            return "Results"
            
        }
        return sections[section]
    }
   
    
   
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        //verwijderen van lyrics ( nog steeds fout wanneer er een '-teken in de string staat; fout bij Realm )
        lyricAdapter.removeLyrics(indexPath.section, position: indexPath.row)
        
        //Refreshen data
        refreshData()
        
    }

    
    @IBAction func cancelAddingLyrics (segue : UIStoryboardSegue ){
    
    }
    
    
    @IBAction func addLyrics(segue : UIStoryboardSegue){
        
        //Opvragen van source
        let controller = segue.sourceViewController as! AddViewController ;
        
        //We stellen tag reeds in als Other, indien de tag leeg is dan gebruiken we default Other
        var tag = "Other"
        
        //Setten van tag indien niet leeg is
        if(!controller.tag.isEmpty){
        
            tag = controller.tag
        
        }
        
        //Toevoegen van lyrics
        lyricAdapter.addLyrics(controller.lyrics, tag: tag)
        
        //Refreshen data
       refreshData()
    
    }
 
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        //Indien we naar de lyrics gaan
        if(segue.identifier == "toLyrics" ){
        
            //Destinatiecontroller setten
        let controller = segue.destinationViewController as! DetailViewController
            
            let lyric : Lyrics
            
            //Indien we de lyric uit een filtered list moeten halen
            if (self.searchController.active && self.searchController.searchBar.text != ""){
            
                lyric = filteredLyrics[tableView.indexPathForSelectedRow!.row]
            } else {
            //Indien we de lyric uit de normale list moeten halen, moeten we eerst nog de section-array ophalen
                let listArray = lyrics[tableView.indexPathForSelectedRow!.section]
             lyric = listArray![tableView.indexPathForSelectedRow!.row]
            
            }
            
            
            controller.lyricsDescription = lyric.getDescription()
        
        }
        
    }
    
    
    func filterLyrics( filter : String, scope : String = "All"){
        
        //Instellen van te filterarray
        var lyricsToFilter = [Lyrics]()
        
        //Toevoegen van alle lyrics uit alle sections aan filter
        for lyric in self.lyrics.values{
        
            
            lyricsToFilter += lyric
        
        }
        
        
        self.filteredLyrics = lyricsToFilter.filter{ lyric in
            
            //Indien de knop "Ends" is ingeduwd, dan gaan we enkel kijken naar het laatste woord van de lyric ( dit indien we bij het schrijven willen rijmen )
            if(scope == "Ends"){
            
                //Splitsen van te filteren lyric in een array, dit op spatie
                let filterArray = lyric.getDescription().componentsSeparatedByString(" ")
                
                //Indien het match met het laatste woord, dan true, wordt toegevoegd aan de filtered array
                return (filterArray.last?.lowercaseString.containsString(filter.lowercaseString))!
                
            } else if (scope == "Tag"){
            
                //Hier zoeken we enkel op Tag, dit omdat er over langere tijd veel meer lyrics-items kunnnen worden toegevoegd
                return lyric.tag.lowercaseString == filter.lowercaseString
            
            }
            
            //Indien we All kiezen, zoeken we over alle lijsten en kijken we enkel of een gegeven woord voorkomt in de lyric
            return lyric.getDescription().lowercaseString.containsString(filter.lowercaseString)
            
        }
        
        //Reloaden van tableview, ditmaal met filtered data
        tableView.reloadData()
        
    }
    
    func refreshData(){
    
        //Ophalen van nieuwe lyrics uit database
        lyricAdapter.passLyrics()
        
        //Ophalen van lyrics en sections
        lyrics = lyricAdapter.result
        sections = lyricAdapter.tags
        
        //Reloaden met geupdate data
        tableView.reloadData()
    
    }
    


}
