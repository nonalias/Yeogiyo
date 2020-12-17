//
//  APIConnectFunc.swift
//  yeogiyo
//
//  Created by taehkim on 2020/12/17.
//

import Foundation

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
        //print(json)
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
                var usrUrl : String? = "https://profile.intra.42.fr/users/" + usrLogin!
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

func getStatusByUsersProject(id: Int, code: Int, token: String) -> Int
{
    var status : Int
    status = 0
    var urlStr : String = "https://api.intra.42.fr/v2/users/" + String(id) + "/projects_users?filter[project_id]=" + String(code)
    
    var url = URL(string: urlStr)!
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
    if json?.count == 0
    {
        return 1
    }
    let compareStr : String? = json?[0]["status"] as? String
    if (compareStr == nil)
    {
        return 1
    }
    //print(compareStr!)
    let FINISH: String = "finished"
    let PROGRESS: String = "in_progress"
    if compareStr! == PROGRESS
    {
        status = 2
    }
    else if compareStr! == FINISH
    {
        status = 3
    }
    return status
}
func projectProc(c: [User], pCode: Int, token: String?) -> Void
{
    var i : Int = 1
    
    while i < c.count
    {
        if (c[i].id != nil)
        {
            print("hello")
            var status : Int = getStatusByUsersProject(id: c[i].id!, code: pCode, token: token!)
            print("pCode : \(pCode)")
            c[i].status = status
        }
        i += 1
    }
}
