//
//  ViewController.swift
//  yeogiyo
//
//  Created by Junhong Park on 2020/12/16.
//

import UIKit

class User {
    var id : Int?
    var c : Int
    var r : Int
    var s : Int
    var host: String?
    var url : String?
    var login : String?
    var level : Int?
    init(c: Int, r: Int, s: Int)
    {
        self.c = c
        self.r = r
        self.s = s
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
    /*
    init(id: Int, host: String, url: String, login: String)
    {
        self.id = id
        self.host = host
        self.url = url
        self.login = login
        //self.hostParsing(host: self.host!)
    }
 */
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

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //var u1 :User = User(id: 12345, host: "c2r10s6", url: "intra.42.fr", login: "taehkim")
        var c1 : [User] = []
        var i : Int = 1
        var j : Int = 1
        while i < 10 {
            j = 1
            while j < 8 {
                c1.append(User(c: 1, r: i, s: j))
                j += 1
            }
            i += 1
        }
        //c1[53].showSeats()
        i = 1
        while i < c1.count
        {
            if (c1[i].compareSeats(host: "c1r2s7"))
            {
                print("\(i)번째 인덱스에서 찾았습니다")
                c1[i].showSeats()
            }
            i += 1
        }
        let session: URLSession = URLSession.shared
        /*
        func get_token(uid: String, secret: String, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> String
        {
            let urlStr : String = "https://api.intra.42.fr/oauth/token"
            let url = URL(string: urlStr)
            var request: URLRequest = URLRequest(url: url!)
            request.httpMethod = "POST"
            let bodyData = "grant_type=client_credentials&client_id=" + uid + "&client_secret=" + secret
            print(bodyData)
            request.httpBody = bodyData.data(using: String.Encoding.utf8)
            session.dataTask(with: request, completionHandler: completionHandler).resume()
            let token = "1234234"
            return token
        }
 */
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
            //print(appMessage);
            //request.addValue("Authorization", forHTTPHeaderField: appMessage)
            request.setValue(appMessage, forHTTPHeaderField: "Authorization")
            //request.addValue("Content-Type", forHTTPHeaderField: "application/json; charset=utf-8")
            request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            var json: [[String: Any]]?
            session.dataTask(with: request, completionHandler: { (data, response, error) in
                defer { sem.signal() }
                guard let data = data else { print("nothing");return }
                json = try? JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]]
            }).resume()
            sem.wait()
            //print(json?[0]["host"])
            return json
        }
        let uri = URL(string: "https://api.intra.42.fr/v2/campus/29/locations")
        // Do any additional setup after loading the view.
        /*
        getCluster(url: uri!, completionHandler: { (data, response, error) in
            print("hello");
            guard let data = data else { print("nothing");return }

            print("data exist");
            guard let json = try? JSONSerialization.jsonObject(with: data, options: []) else {
                    print("json to Any Error")
                    return
            }
            print(json);
        })
 */
        let tokenAny = get_token(uid: "75d762702766aa5f8c47960fa8937c272be7d6d0d3ada61307bfadc9a4f50e3f", secret: "9e264f41bfba1cf7d4daafb69abe3ebcc8ad510447f92ee4ea00f9534aeff92b")
        var myToken = tokenAny as? String
        //print("token : " + myToken!)
                //print(String(data: data!, encoding: .utf8)!)
        
        var json: [[String: Any]]?
        json = getCluster(url: URL(string: "https://api.intra.42.fr/v2/campus/29/locations")!, token: myToken!)
        
        //print(json?[0]["user"]! as Any)
        /*
        func userParsing(usrObj: Any?) -> Void
        {
            var json : [String: Any]?
            //var usrStr : String? = usrObj as? String
            //print(usrStr)
            //var arr = usrStr.components(separatedBy: ["{", "}", ";"])
            //print(arr)
        }
 */
        /*
        func userParsing(usrStr: String?) -> [String: Any]
        {
            var arr = usrStr?.components(separatedBy: ["{", "}", ";"])
            print(arr)
        }
 */
        let jsonCount : Int
        jsonCount = (json?.count)!
        i = 1
        while i < c1.count
        {
            j = 0
            while j < jsonCount - 1
            {
                var host : String? = json?[j]["host"] as? String
                var end_at : String? = json?[j]["end_at"] as? String
                //var user : [String: Any] = userParsing(usrStr: json?[j]["user"] as? String)
                //print(json?[j]["user"])
                if (c1[i].compareSeats(host: host!) && end_at == nil)
                {
                    //print(json?[j]["user"])
                    var usrDic: NSDictionary? = (json?[j]["user"])! as? NSDictionary
                    //id, url, login
                    var usrId : Int? = usrDic?["id"] as? Int
                    var usrLogin : String? = usrDic?["login"] as? String
                    var usrUrl : String? = usrDic?["url"] as? String
                    //userParsing(usrObj: usrObj)
                    c1[i].setValidUser(id: usrId!, host: host!, url: usrUrl!, login: usrLogin!)
                    c1[i].showAll()
                }
                j += 1
            }
            i += 1
        }
    }
}
