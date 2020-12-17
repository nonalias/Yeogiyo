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

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        initializeCluster(c: &c1, clusterNumber: 1)
        initializeCluster(c: &c2, clusterNumber: 2)
        let tokenAny = get_token(uid: "75d762702766aa5f8c47960fa8937c272be7d6d0d3ada61307bfadc9a4f50e3f", secret: "9e264f41bfba1cf7d4daafb69abe3ebcc8ad510447f92ee4ea00f9534aeff92b")
        var myToken = tokenAny as? String
        var jsonCluster: [[String: Any]]?
        jsonCluster = getCluster(url: URL(string: "https://api.intra.42.fr/v2/campus/29/locations")!, token: myToken!)
        clusterProc(c: c1, jsonCluster: jsonCluster)
        clusterProc(c: c2, jsonCluster: jsonCluster)
    }
}
