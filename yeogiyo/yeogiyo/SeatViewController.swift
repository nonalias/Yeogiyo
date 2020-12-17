//
//  SeatViewController.swift
//  yeogiyo
//
//  Created by Junhong Park on 2020/12/17.
//

import UIKit


class SeatViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

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
    
    // 셀 세로 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    // 셀 가로 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    // 셀 크기 정하기 (n분의 1)
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       // let width = collectionView.frame.width / 9 - 1 // 3등분하여 배치, 옆 간격이 1이므로 1을 빼줌
       // let size = CGSize(width: width, height: width)
        
        let height = collectionView.frame.height / 8 - 1 // n등분
        let size = CGSize(width: height, height: height)
        
        return size
    }
    
    // MARK : - UICollectionViewDetaSource protocol
    
    // tell the collection view how many cells to make
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        // get a reference to our storyboard cell
        let cell: MyCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MyCollectionViewCell
        
        // Use the outlet in our custom class to get a reference to the UILabel in the cel
        
        if (items[indexPath.item] == "1") {
            cell.backgroundColor = UIColor.systemGray //make cell more viseible in our example project
        } else if (items[indexPath.item] == "5"){
            cell.backgroundColor = UIColor.systemGreen
        } else if (items[indexPath.item] == "6"){
            cell.backgroundColor = UIColor.systemBlue
        } else {
            cell.backgroundColor = UIColor.systemGray3
        }
        
        //cell.myLabel.text = items[indexPath.row]
        //cell.myLabel.textColor = UIColor.white
        //cell.myLabel.backgroundColor = UIColor.systemIndigo
        
        //cell 모서리 라운드처리
        cell.layer.cornerRadius = 10
        
        return cell
    }
    
   
    
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print("You selected cell #\(indexPath.item)!")
        //click 했을 때 특정행동 수행.
        
        if (items[indexPath.item] == "6") {
//            print("find 6")
            if let url = URL(string: "http://tom7930.tistory.com") {
                UIApplication.shared.open(url, options: [:])
            }

        }
        collectionView.reloadData()
    }

    let reuseIdentifier = "cell" //
    
    
    
    var items = ["1", "2", "3", "4", "5", "6", "7", "8","9","10","11","12","13","14","15", "16", "17", "18", "19", "20", "6", "7", "8","9","10","11","12","13","14","15", "1", "2", "3", "4", "5", "6", "7", "8","9","10","11","12","13","14","15","1", "2", "3", "4", "5", "6", "7", "8","9","10","11","12","13","14","15","1", "2", "3"]
    
//    @IBOutlet var collectionView: UICollectionView!
    

}
