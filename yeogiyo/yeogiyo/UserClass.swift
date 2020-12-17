//
//  UserClass.swift
//  yeogiyo
//
//  Created by taehkim on 2020/12/17.
//

import Foundation

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
