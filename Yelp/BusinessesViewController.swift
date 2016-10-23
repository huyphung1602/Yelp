//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var businesses: [Business]!
    var filteredBusiness: [Business]!
    
    let searchBar = UISearchBar()
    var shouldShowSearchResults = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        // Automatic change the height of row to fit the context
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 125
        
        createSearchBar()
        
        // Change the color of Navigation Bar
        navigationController?.navigationBar.barTintColor = UIColor(red: 221/255, green: 44/255, blue: 0/255, alpha: 1)
        navigationController?.navigationBar.tintColor = UIColor.white

        
        Business.searchWithTerm("Pizza", completion: { (businesses: [Business]?, error: Error?) -> Void in
            if let businesses = businesses {
                self.businesses = businesses
                
                self.tableView.reloadData()
                
            }
        })

/* Example of Yelp search with more search options specified
        Business.searchWithTerm("Restaurants", sort: .Distance, categories: ["asianfusion", "burgers"], deals: true) { (businesses: [Business]!, error: NSError!) -> Void in
            self.businesses = businesses
            
            for business in businesses {
                print(business.name!)
                print(business.address!)
            }
        }
*/
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // For filter view
        if (segue.identifier == "filterSegue") {
            let navController = segue.destination as! UINavigationController
            let filterVC = navController.topViewController as! FilterViewController
            
            filterVC.delegate = self
        }
            
        // For detail view
        else {
            let ip = tableView.indexPathForSelectedRow
            let detailVC = segue.destination as! DetailViewController
            detailVC.business = self.businesses[(ip?.row)!]
            
        }
    }

}


// Table view data source and delegate
extension BusinessesViewController: UITableViewDelegate, UITableViewDataSource, FilterViewControllerDelegate {
    
    // Function used to set the number of row
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if shouldShowSearchResults {
            if filteredBusiness != nil {
                return filteredBusiness.count
            } else {
                return 0
            }
        } else {
            if businesses != nil {
                return businesses.count
            } else {
            return 0
            }
        }

    }
    
    // Function used to cast the business cell from API or search
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BusinessCell") as! BusinessCell
        
        if shouldShowSearchResults {
            cell.business = filteredBusiness[indexPath.row]
            self.businesses = filteredBusiness
        } else {
            cell.business = businesses[indexPath.row]
        }
        
        return cell
        
    }
    
    // Delegate used to catch the signal from filter view
    func filterViewController(filterViewController: FilterViewController, didUpdateFilter filters: [String], didUpdateDeal deal: Bool, didUpdateSort sortMode: Int, didUpdateDistance distance: Int) {
        
        print("I got new filters from filterVC")
        
        Business.searchWithTerm("", sort: YelpSortMode(rawValue: sortMode) , categories: filters, deals: deal, distance: distance) { (businesses: [Business]?, error: Error?) in
            if let businesses = businesses {
                self.businesses = businesses
                self.tableView.reloadData()
            }
            
        }
    }
    
    // Function used to deselect the selected row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}


// Search bar
extension BusinessesViewController: UISearchBarDelegate {
    // Function to create the search bar
    func createSearchBar () {
        
        searchBar.showsCancelButton = false
        searchBar.placeholder = "Restaurants"
        searchBar.delegate = self
        
        self.navigationItem.titleView = searchBar
        
    }

    // Function for adding search
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        Business.searchWithTerm(searchText, completion: { (businesses: [Business]?, error: Error?) -> Void in
            if let businesses = businesses {
                self.filteredBusiness = businesses
                
                self.tableView.reloadData()
            }
            
        })

        if searchText != "" {
            shouldShowSearchResults = true
            //self.tableView.reloadData()
        } else {
            shouldShowSearchResults = false
            //self.tableView.reloadData()
        }
        
    }

    // End function for adding search

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar.endEditing(true)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        shouldShowSearchResults = true
        searchBar.endEditing(true)
        self.tableView.reloadData()
    }

}
