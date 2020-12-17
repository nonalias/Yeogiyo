//
//  ViewController.swift
//  yeogiyo
//
//  Created by Junhong Park on 2020/12/16.
//

import UIKit


class ViewController: UIViewController, UISearchBarDelegate, UITableViewDataSource {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    
    let data = ["libft", "GNL", "printf", "netwhat", "ft_server"]
    var filteredData: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        searchBar?.delegate = self
        filteredData = data
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as UITableViewCell
           cell.textLabel?.text = filteredData[indexPath.row]
           return cell
       }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return filteredData.count
    }
    // This method updates filteredData based on the text in the Search Box
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // When there is no text, filteredData is the same as the original data
        // When user has entered text into the search box
        // Use the filter method to iterate over all items in the data array
        // For each item, return true if the item should be included and false if the
        // item should NOT be included
        filteredData = searchText.isEmpty ? data : data.filter { (item: String) -> Bool in
            // If dataItem matches the searchText, return true to include it
            return item.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        
        tableView.reloadData()
    }
    
//    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
//            self.searchBar.showsCancelButton = true
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSeat"
        {
            if let indexPath = tableView.indexPathForSelectedRow
            {
                var text: String?
                text = tableView.cellForRow(at: indexPath)?.textLabel?.text
                let destinationController = segue.destination as! SeatViewController
                destinationController.project = text!
            }
        }
    }
}

