//
//  ViewController.swift
//  yeogiyo
//
//  Created by Junhong Park on 2020/12/16.
//

import UIKit
let session: URLSession = URLSession.shared

class User {
    var id : Int?
    var c : Int
    var r : Int
    var s : Int
    var host: String?
    var url : String?
    var login : String?
    var status : Int  // 0 -> ㅂ비ㄴ자리 1 -> 늦은사람 2-> 진행중 3-> ㅅ성공
    init(c: Int, r: Int, s: Int)
    {
        self.c = c
        self.r = r
        self.s = s
        self.status = 0
    }
    func setValidUser(id: Int, host: String, url: String, login: String)
    {
        self.id = id
        self.host = host
        self.url = url
        self.login = login
    }
    func compareSeats(host: String) -> Bool {
        var arr = hostParsing(host: host)
        if self.c == Int(arr[1]) && self.r == Int(arr[2]) && self.s == Int(arr[3])
        {
            return true
        }
        return false
    }
    func hostParsing(host: String) -> [String]
    {
        var arr = host.components(separatedBy: ["c", "r", "s"])
        return arr
    }
    func showSeats() -> Void {
        print("c" + "\(self.c)" + "r" + "\(self.r)" + "s" + "\(self.s)")
    }
    func showAll() -> Void {
        print("==show===")
        print(self.login)
        print(self.url)
        print(self.id)
        print(self.host)
        print("==end===")
    }
}

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
