//
//  SeatViewController.swift
//  yeogiyo
//
//  Created by Junhong Park on 2020/12/17.
//

import UIKit


class SeatViewController: UIViewController {

    @IBOutlet var pageTitle:UINavigationItem!
    var project:String = ""
    var tocken: String = ""
    
    func get_project_tag(uid: String, secret: String)->Any {
        let urlStr : String = "https://api.intra.42.fr/oauth/token"
        let url = URL(string: urlStr)
        let sem = DispatchSemaphore.init(value: 0)
        let session: URLSession = URLSession.shared
        var request: URLRequest = URLRequest(url: url!)
        request.httpMethod = "POST"
        let bodyData = "grant_type=client_credentials&client_id=" + uid + "&client_secret=" + secret
        request.httpBody = bodyData.data(using: String.Encoding.utf8)
        var token : Any?
        session.dataTask(with: request, completionHandler: { (data, response, error) in
            defer { sem.signal() }
            guard let data = data else { print("nothing");return }
            let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String:Any]
            token = json?["access_token"]
        }).resume()
        sem.wait()
        return token!
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageTitle.title = project
        tocken = get_project_tag(uid: "3c57e9f2a600143b5562861a4d9b544c9d7aba224c7ac375bb41d109eb1077d1", secret: "7bbe762ed4fb047ff83ee5b2732df34f5c2074750451a27fa576e3821cfec306") as! String
        // Do any additional setup after loading the view.
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
