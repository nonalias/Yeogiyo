//
//  ViewController.swift
//  yeogiyo
//
//  Created by Junhong Park on 2020/12/16.
//

import UIKit
let session: URLSession = URLSession.shared

func get_token(uid: String, secret: String) -> Any
{
    let urlStr : String = "https://api.intra.42.fr/oauth/token"
    let url = URL(string: urlStr)
    let sem = DispatchSemaphore.init(value: 0)
    var request: URLRequest = URLRequest(url: url!)
    request.httpMethod = "POST"
    let bodyData = "grant_type=client_credentials&client_id=" + uid + "&client_secret=" + secret
    //print(bodyData)
    request.httpBody = bodyData.data(using: String.Encoding.utf8)
    var token : Any?
    session.dataTask(with: request, completionHandler: { (data, response, error) in
        defer { sem.signal() }
        guard let data = data else { print("nothing");return }

        let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String:Any]
        print(json)
        token = json?["access_token"]
    }).resume()
    sem.wait()
    return token
}

func getCluster(url: URL, token: String) -> [[String: Any]]? {
    var request: URLRequest = URLRequest(url: url)
    request.httpMethod = "GET"
    let sem = DispatchSemaphore.init(value: 0)
    let appMessage = " Bearer " + token
    request.setValue(appMessage, forHTTPHeaderField: "Authorization")
    request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
    var json: [[String: Any]]?
    session.dataTask(with: request, completionHandler: { (data, response, error) in
        defer { sem.signal() }
        guard let data = data else { print("nothing");return }
        json = try? JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]]
    }).resume()
    sem.wait()
    return json
}

func clusterProc(c: [User], jsonCluster: [[String: Any]]?)
{
    var i : Int
    var j : Int
    
    var jsonCount : Int
    jsonCount = (jsonCluster?.count)!
    i = 1
    while i < c.count
    {
        j = 0
        while j < jsonCount - 1
        {
            var host : String? = jsonCluster?[j]["host"] as? String
            var end_at : String? = jsonCluster?[j]["end_at"] as? String
            if (c[i].compareSeats(host: host!) && end_at == nil)
            {
                var usrDic: NSDictionary? = (jsonCluster?[j]["user"])! as? NSDictionary
                var usrId : Int? = usrDic?["id"] as? Int
                var usrLogin : String? = usrDic?["login"] as? String
                var usrUrl : String? = usrDic?["url"] as? String
                c[i].setValidUser(id: usrId!, host: host!, url: usrUrl!, login: usrLogin!)
                c[i].showAll()
            }
            j += 1
        }
        i += 1
    }
}

func getClusterIndexByHost(c: [User], host: String) -> Int {
    var ret = 1
    while ret < c.count
    {
        if (c[ret].compareSeats(host: host))
        {
            return ret
        }
        ret += 1
    }
    return (-1)
}

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

func initializeCluster(c : inout [User], clusterNumber: Int)
{
    var i : Int = 1
    var j : Int = 1
    
    if (clusterNumber % 2 == 1)
    {
        i = 1
        while i < 10 {
            j = 1
            while j < 8 {
                c.append(User(c: clusterNumber, r: i, s: j))
                j += 1
            }
            i += 1
        }
    }
    else
    {
        i = 1
        while i < 11 {
            j = 1
            while j < 9 {
                c.append(User(c: clusterNumber, r: i, s: j))
                j += 1
            }
            i += 1
        }
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
