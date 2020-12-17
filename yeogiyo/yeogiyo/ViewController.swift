//
//  ViewController.swift
//  yeogiyo
//
//  Created by Junhong Park on 2020/12/16.
//

import UIKit
let session: URLSession = URLSession.shared

var c1 : [User] = []
var c2 : [User] = []
var myToken : String?


class ViewController: UIViewController, UISearchBarDelegate, UITableViewDataSource {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    
    let data = ["Libft", "get_next_line", "ft_printf", "netwhat", "ft_server", "cub3d", "miniRT", "minishell", "libasm", "ft_services", "CPP Module 00", "CPP Module 01", "CPP Module 02", "CPP Module 03", "CPP Module 04", "CPP Module 05", "CPP Module 06", "CPP Module 07", "CPP Module 08", "Philosophers", "ft_containers", "webserv", "ft_irc", "ft_transcendence"]
    var filteredData: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        c1.removeAll()
        c2.removeAll()
        print(c1.count)
        print(c2.count)
        initializeCluster(c: &c1, clusterNumber: 1)
        initializeCluster(c: &c2, clusterNumber: 2)
        let tokenAny = get_token(uid: "75d762702766aa5f8c47960fa8937c272be7d6d0d3ada61307bfadc9a4f50e3f", secret: "9e264f41bfba1cf7d4daafb69abe3ebcc8ad510447f92ee4ea00f9534aeff92b")
        myToken = tokenAny as? String
        var jsonCluster: [[String: Any]]?
        jsonCluster = getCluster(url: URL(string: "https://api.intra.42.fr/v2/campus/29/locations")!, token: myToken!)
        clusterProc(c: c1, jsonCluster: jsonCluster)
        clusterProc(c: c2, jsonCluster: jsonCluster)

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
