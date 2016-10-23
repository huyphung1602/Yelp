//
//  FilterViewController.swift
//  Yelp
//
//  Created by Quoc Huy on 10/18/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

@objc protocol FilterViewControllerDelegate {
    @objc optional func filterViewController(filterViewController: FilterViewController, didUpdateFilter filters: [String], didUpdateDeal deal: Bool, didUpdateSort sortMode: Int, didUpdateDistance distance: Int)
}

class FilterViewController: UIViewController {

    let categories: [Dictionary<String, String>] = [["name" : "Afghan", "code": "afghani"],
                                                    ["name" : "African", "code": "african"],
                                                    ["name" : "American, New", "code": "newamerican"],
                                                    ["name" : "American, Traditional", "code": "tradamerican"],
                                                    ["name" : "Arabian", "code": "arabian"],
                                                    ["name" : "Argentine", "code": "argentine"],
                                                    ["name" : "Armenian", "code": "armenian"],
                                                    ["name" : "Asian Fusion", "code": "asianfusion"],
                                                    ["name" : "Asturian", "code": "asturian"],
                                                    ["name" : "Australian", "code": "australian"],
                                                    ["name" : "Austrian", "code": "austrian"],
                                                    ["name" : "Baguettes", "code": "baguettes"],
                                                    ["name" : "Bangladeshi", "code": "bangladeshi"],
                                                    ["name" : "Barbeque", "code": "bbq"],
                                                    ["name" : "Basque", "code": "basque"],
                                                    ["name" : "Bavarian", "code": "bavarian"],
                                                    ["name" : "Beer Garden", "code": "beergarden"],
                                                    ["name" : "Beer Hall", "code": "beerhall"],
                                                    ["name" : "Beisl", "code": "beisl"],
                                                    ["name" : "Belgian", "code": "belgian"],
                                                    ["name" : "Bistros", "code": "bistros"],
                                                    ["name" : "Black Sea", "code": "blacksea"],
                                                    ["name" : "Brasseries", "code": "brasseries"],
                                                    ["name" : "Brazilian", "code": "brazilian"],
                                                    ["name" : "Breakfast & Brunch", "code": "breakfast_brunch"],
                                                    ["name" : "British", "code": "british"],
                                                    ["name" : "Buffets", "code": "buffets"],
                                                    ["name" : "Bulgarian", "code": "bulgarian"],
                                                    ["name" : "Burgers", "code": "burgers"],
                                                    ["name" : "Burmese", "code": "burmese"],
                                                    ["name" : "Cafes", "code": "cafes"],
                                                    ["name" : "Cafeteria", "code": "cafeteria"],
                                                    ["name" : "Cajun/Creole", "code": "cajun"],
                                                    ["name" : "Cambodian", "code": "cambodian"],
                                                    ["name" : "Canadian", "code": "New)"],
                                                    ["name" : "Canteen", "code": "canteen"],
                                                    ["name" : "Caribbean", "code": "caribbean"],
                                                    ["name" : "Catalan", "code": "catalan"],
                                                    ["name" : "Chech", "code": "chech"],
                                                    ["name" : "Cheesesteaks", "code": "cheesesteaks"],
                                                    ["name" : "Chicken Shop", "code": "chickenshop"],
                                                    ["name" : "Chicken Wings", "code": "chicken_wings"],
                                                    ["name" : "Chilean", "code": "chilean"],
                                                    ["name" : "Chinese", "code": "chinese"],
                                                    ["name" : "Comfort Food", "code": "comfortfood"],
                                                    ["name" : "Corsican", "code": "corsican"],
                                                    ["name" : "Creperies", "code": "creperies"],
                                                    ["name" : "Cuban", "code": "cuban"],
                                                    ["name" : "Curry Sausage", "code": "currysausage"],
                                                    ["name" : "Cypriot", "code": "cypriot"],
                                                    ["name" : "Czech", "code": "czech"],
                                                    ["name" : "Czech/Slovakian", "code": "czechslovakian"],
                                                    ["name" : "Danish", "code": "danish"],
                                                    ["name" : "Delis", "code": "delis"],
                                                    ["name" : "Diners", "code": "diners"],
                                                    ["name" : "Dumplings", "code": "dumplings"],
                                                    ["name" : "Eastern European", "code": "eastern_european"],
                                                    ["name" : "Ethiopian", "code": "ethiopian"],
                                                    ["name" : "Fast Food", "code": "hotdogs"],
                                                    ["name" : "Filipino", "code": "filipino"],
                                                    ["name" : "Fish & Chips", "code": "fishnchips"],
                                                    ["name" : "Fondue", "code": "fondue"],
                                                    ["name" : "Food Court", "code": "food_court"],
                                                    ["name" : "Food Stands", "code": "foodstands"],
                                                    ["name" : "French", "code": "french"],
                                                    ["name" : "French Southwest", "code": "sud_ouest"],
                                                    ["name" : "Galician", "code": "galician"],
                                                    ["name" : "Gastropubs", "code": "gastropubs"],
                                                    ["name" : "Georgian", "code": "georgian"],
                                                    ["name" : "German", "code": "german"],
                                                    ["name" : "Giblets", "code": "giblets"],
                                                    ["name" : "Gluten-Free", "code": "gluten_free"],
                                                    ["name" : "Greek", "code": "greek"],
                                                    ["name" : "Halal", "code": "halal"],
                                                    ["name" : "Hawaiian", "code": "hawaiian"],
                                                    ["name" : "Heuriger", "code": "heuriger"],
                                                    ["name" : "Himalayan/Nepalese", "code": "himalayan"],
                                                    ["name" : "Hong Kong Style Cafe", "code": "hkcafe"],
                                                    ["name" : "Hot Dogs", "code": "hotdog"],
                                                    ["name" : "Hot Pot", "code": "hotpot"],
                                                    ["name" : "Hungarian", "code": "hungarian"],
                                                    ["name" : "Iberian", "code": "iberian"],
                                                    ["name" : "Indian", "code": "indpak"],
                                                    ["name" : "Indonesian", "code": "indonesian"],
                                                    ["name" : "International", "code": "international"],
                                                    ["name" : "Irish", "code": "irish"],
                                                    ["name" : "Island Pub", "code": "island_pub"],
                                                    ["name" : "Israeli", "code": "israeli"],
                                                    ["name" : "Italian", "code": "italian"],
                                                    ["name" : "Japanese", "code": "japanese"],
                                                    ["name" : "Jewish", "code": "jewish"],
                                                    ["name" : "Kebab", "code": "kebab"],
                                                    ["name" : "Korean", "code": "korean"],
                                                    ["name" : "Kosher", "code": "kosher"],
                                                    ["name" : "Kurdish", "code": "kurdish"],
                                                    ["name" : "Laos", "code": "laos"],
                                                    ["name" : "Laotian", "code": "laotian"],
                                                    ["name" : "Latin American", "code": "latin"],
                                                    ["name" : "Live/Raw Food", "code": "raw_food"],
                                                    ["name" : "Lyonnais", "code": "lyonnais"],
                                                    ["name" : "Malaysian", "code": "malaysian"],
                                                    ["name" : "Meatballs", "code": "meatballs"],
                                                    ["name" : "Mediterranean", "code": "mediterranean"],
                                                    ["name" : "Mexican", "code": "mexican"],
                                                    ["name" : "Middle Eastern", "code": "mideastern"],
                                                    ["name" : "Milk Bars", "code": "milkbars"],
                                                    ["name" : "Modern Australian", "code": "modern_australian"],
                                                    ["name" : "Modern European", "code": "modern_european"],
                                                    ["name" : "Mongolian", "code": "mongolian"],
                                                    ["name" : "Moroccan", "code": "moroccan"],
                                                    ["name" : "New Zealand", "code": "newzealand"],
                                                    ["name" : "Night Food", "code": "nightfood"],
                                                    ["name" : "Norcinerie", "code": "norcinerie"],
                                                    ["name" : "Open Sandwiches", "code": "opensandwiches"],
                                                    ["name" : "Oriental", "code": "oriental"],
                                                    ["name" : "Pakistani", "code": "pakistani"],
                                                    ["name" : "Parent Cafes", "code": "eltern_cafes"],
                                                    ["name" : "Parma", "code": "parma"],
                                                    ["name" : "Persian/Iranian", "code": "persian"],
                                                    ["name" : "Peruvian", "code": "peruvian"],
                                                    ["name" : "Pita", "code": "pita"],
                                                    ["name" : "Pizza", "code": "pizza"],
                                                    ["name" : "Polish", "code": "polish"],
                                                    ["name" : "Portuguese", "code": "portuguese"],
                                                    ["name" : "Potatoes", "code": "potatoes"],
                                                    ["name" : "Poutineries", "code": "poutineries"],
                                                    ["name" : "Pub Food", "code": "pubfood"],
                                                    ["name" : "Rice", "code": "riceshop"],
                                                    ["name" : "Romanian", "code": "romanian"],
                                                    ["name" : "Rotisserie Chicken", "code": "rotisserie_chicken"],
                                                    ["name" : "Rumanian", "code": "rumanian"],
                                                    ["name" : "Russian", "code": "russian"],
                                                    ["name" : "Salad", "code": "salad"],
                                                    ["name" : "Sandwiches", "code": "sandwiches"],
                                                    ["name" : "Scandinavian", "code": "scandinavian"],
                                                    ["name" : "Scottish", "code": "scottish"],
                                                    ["name" : "Seafood", "code": "seafood"],
                                                    ["name" : "Serbo Croatian", "code": "serbocroatian"],
                                                    ["name" : "Signature Cuisine", "code": "signature_cuisine"],
                                                    ["name" : "Singaporean", "code": "singaporean"],
                                                    ["name" : "Slovakian", "code": "slovakian"],
                                                    ["name" : "Soul Food", "code": "soulfood"],
                                                    ["name" : "Soup", "code": "soup"],
                                                    ["name" : "Southern", "code": "southern"],
                                                    ["name" : "Spanish", "code": "spanish"],
                                                    ["name" : "Steakhouses", "code": "steak"],
                                                    ["name" : "Sushi Bars", "code": "sushi"],
                                                    ["name" : "Swabian", "code": "swabian"],
                                                    ["name" : "Swedish", "code": "swedish"],
                                                    ["name" : "Swiss Food", "code": "swissfood"],
                                                    ["name" : "Tabernas", "code": "tabernas"],
                                                    ["name" : "Taiwanese", "code": "taiwanese"],
                                                    ["name" : "Tapas Bars", "code": "tapas"],
                                                    ["name" : "Tapas/Small Plates", "code": "tapasmallplates"],
                                                    ["name" : "Tex-Mex", "code": "tex-mex"],
                                                    ["name" : "Thai", "code": "thai"],
                                                    ["name" : "Traditional Norwegian", "code": "norwegian"],
                                                    ["name" : "Traditional Swedish", "code": "traditional_swedish"],
                                                    ["name" : "Trattorie", "code": "trattorie"],
                                                    ["name" : "Turkish", "code": "turkish"],
                                                    ["name" : "Ukrainian", "code": "ukrainian"],
                                                    ["name" : "Uzbek", "code": "uzbek"],
                                                    ["name" : "Vegan", "code": "vegan"],
                                                    ["name" : "Vegetarian", "code": "vegetarian"],
                                                    ["name" : "Venison", "code": "venison"],
                                                    ["name" : "Vietnamese", "code": "vietnamese"],
                                                    ["name" : "Wok", "code": "wok"],
                                                    ["name" : "Wraps", "code": "wraps"],
                                                    ["name" : "Yugoslav", "code": "yugoslav"]]
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var showView: UIView!
    @IBOutlet weak var borderShowView: UIView!
    @IBOutlet weak var showButton: UIButton!
    @IBOutlet weak var showLabel: UILabel!
    
    
    // States of chosing sort filters
    var switchStates = [Int: Bool] ()
    var dealStates = false
    var sortStates = [Int: Bool] ()
    var distanceStates = [Int: Bool] ()

    
    // Variable to show list of categories
    var showStatus = false
    
    // Variable to choose in sort list of categories
    var sortStatus = false
    var sortShowRow = 0
    
    // Variable to choose in distance list of categories
    var distanceStatus = false
    var distanceShowRow = 0
    
    weak var delegate: FilterViewControllerDelegate?
    
    // List of Section
    let sectionName = ["Deal", "Distance", "Sort by", "Category"]
    
    // List of items in Sort by
    let sortList = ["Best Match", "Distance", "Rating"]
    
    // List of items in Distance
    let distanceList = ["Auto", "2 miles", "5 miles", "10 miles", "15 miles"]
    let distanceValue = [40000, 3218, 8046, 16093, 24140]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        
        // Config the show/hide button
        showLabel.text = "Show All"
        showLabel.textColor = UIColor.blue
        
        showView.isHidden = true
        
        // Change the color of Navigation Bar
        navigationController?.navigationBar.barTintColor = UIColor(red: 221/255, green: 44/255, blue: 0/255, alpha: 1)
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
    }

    @IBAction func onBack(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onSearch(_ sender: UIBarButtonItem) {
        
        var filters = [String]()
        let deal = dealStates
        var sortMode = 0
        var distance = 40000
        
        for (row, isSeleted) in switchStates {
            if isSeleted {
                filters.append(categories[row]["code"]!)
            }
        }
        
        for (row, isSeleted) in distanceStates {
            if isSeleted {
                distance = distanceValue[row]
                print ("The distance is \(distance)")
            }
        }
        
        for (row, isSeleted) in sortStates {
            if isSeleted {
                sortMode = row
            }
        }
        
        if filters.count > 0 {
            delegate?.filterViewController!(filterViewController: self, didUpdateFilter: filters, didUpdateDeal: deal, didUpdateSort: sortMode, didUpdateDistance: distance)
        } else {
            filters = [""]
            delegate?.filterViewController!(filterViewController: self, didUpdateFilter: filters, didUpdateDeal: deal, didUpdateSort: sortMode, didUpdateDistance: distance)
        }
        
        
        dismiss(animated: true, completion: nil)
    }
    
    // Function to show/hide the Category cells (Add Show and Hide button)
    @IBAction func onShow(_ sender: AnyObject) {
        
        print ("Show/Hide button has been pressed")
        
        if showStatus {
            showStatus = false
            showLabel.text = "Show All"
            showLabel.textColor = UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1)
            showView.isHidden = true
        }
        else {
            showStatus = true
            showLabel.text = "Hide"
            showLabel.textColor = UIColor(red: 221/255, green: 44/255, blue: 0/255, alpha: 1)
            showView.isHidden = true
        }
        tableView.reloadData()
    }
    
    
}

extension FilterViewController: UITableViewDataSource, UITableViewDelegate, SwitchCellDelegate, DealCellDelegate, SortCellDelegate, DistanceCellDelegate {
    
    // Function to set number of row for each section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        else if section == 1 {
            return distanceList.count
        }
        else if section == 2 {
            return sortList.count
        }
        else {
            return categories.count
        }
    }
    
    // Function to set the detail for cells in each section
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Deal section cell
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DealCell") as! DealCell
            
            cell.switchButton.isOn = dealStates
            cell.delegate = self
            
            return cell
        }
            
        // Distance section cell
        else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DistanceCell") as! DistanceCell
            cell.distanceLabel.text = distanceList[indexPath.row]
            
            if distanceStatus {
                cell.distanceImage.image = #imageLiteral(resourceName: "unchecked")
            }
            else {
                cell.distanceImage.image = #imageLiteral(resourceName: "checked")
            }
            
            cell.delegate = self
            
            return cell
        }
            
        // Sort section cell
        else if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SortCell") as! SortCell
            cell.sortLabel.text = sortList[indexPath.row]
            
            if sortStatus {
                cell.sortImage.image = #imageLiteral(resourceName: "unchecked")
            }
            else {
                cell.sortImage.image = #imageLiteral(resourceName: "checked")
            }
            
            cell.delegate = self
            
            return cell
        }
            
        // Categories section cell
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SwitchCell") as! SwitchCell
            
            cell.categoryLabel.text = categories[indexPath.row]["name"]
            cell.switchButton.isOn = switchStates[indexPath.row] ?? false
            
            cell.delegate = self
            
            if showStatus {
                if indexPath.row == 2 {
                    showView.isHidden = false
                }
            }
            else {
                if indexPath.row == (categories.count - 1) {
                    showView.isHidden = false
                }
            }
            
            return cell
        }
        
    }
    
    // Function to set the heigh for header view
    // Section 0 shall return 10 because there is no title for section 0
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 10
        }
        return 40
    }
    
    // Function to set the header view + title for each section
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section != 0 {
            let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50))
            
            let titleLabel = UILabel(frame: CGRect(x: 15, y: 10, width: 200, height: 30))
            
            headerView.backgroundColor = tableView.backgroundColor
            
            titleLabel.text = sectionName[section]
            titleLabel.textColor = UIColor(red: 221/255, green: 44/255, blue: 0/255, alpha: 1)
            headerView.addSubview(titleLabel)
            
            return headerView
        }
        else {
            let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 10))
            headerView.backgroundColor = tableView.backgroundColor
            return headerView
        }
        
    }
    
    // Function for number of sectio
    func numberOfSections(in tableView: UITableView) -> Int {
         return self.sectionName.count
    }
    
    // Function to show/hide row in sections
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        // For distance section
        if indexPath.section == 1 {
            if indexPath.row != distanceShowRow {
                if distanceStatus {
                    return 44
                }
                else {
                    return 0
                }
            } else {
                return 44
            }
        }
        
        // For sort section
        if indexPath.section == 2 {
            if indexPath.row != sortShowRow {
                if sortStatus {
                    return 44
                }
                else {
                    return 0
                }
            } else {
                return 44
            }
        }
            
        // For categories section
        else if indexPath.section == 3 {
            if indexPath.row > 2 {
                if showStatus {
                    return 44
                }
                else {
                    return 0
                }
            } else {
                return 44
            }
        }
            
        // For deal section
        else {
            return 44
        }
        
    }
    
    func switchCell(switchCell: SwitchCell, didChangeValue value: Bool) {
        let ip = tableView.indexPath(for: switchCell)
        switchStates[ip!.row] = value
        print("filterVC got signal from switch cell")
    }
    
    func dealCell(dealCell: DealCell, didChangeValue value: Bool) {
        dealStates = value
        print("filterVC got signal from deal cell")
    }
    
    func sortCell(sortCell: SortCell, didChangeValue value: Bool) {
        let ip = tableView.indexPath(for: sortCell)
        // Set all the sort bool value -> false
        for (row, _) in sortStates {
            sortStates[row] = false
        }
        // If true -> enalbe select mode, if false -> disable select mode
        if sortStatus {
            // Row which is selected shall be showed
            sortShowRow = ip!.row
            sortStates[ip!.row] = value
            sortStatus = false
        }
        else {
            sortStatus = true
        }
        
        print("filterVC got signal from sort cell")
        
        tableView.reloadData()
    }
    
    func distanceCell(distanceCell: DistanceCell, didChangeValue value: Bool) {
        let ip = tableView.indexPath(for: distanceCell)
        // Set all the distance bool value -> false
        for (row, _) in distanceStates {
            distanceStates[row] = false
        }
        // If true -> enalbe select mode, if false -> disable select mode
        if distanceStatus {
            // Row which is selected shall be showed
            distanceShowRow = ip!.row
            distanceStates[ip!.row] = value
            distanceStatus = false
        }
        else {
            distanceStatus = true
        }
        
        print("filterVC got signal from sort cell")
        
        tableView.reloadData()
    }
    
}
