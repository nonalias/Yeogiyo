//
//  SeatViewController.swift
//  yeogiyo
//
//  Created by Junhong Park on 2020/12/17.
//

import UIKit


class SeatViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let projectDic:Dictionary = ["Libft" : 1314, "get_next_line" : 1327, "ft_printf" : 1316, "netwhat" : 1318, "ft_server" : 1328, "cub3d" : 1326, "miniRT" : 1315, "minishell" : 1331, "libasm" : 1330, "ft_services" : 1329, "CPP Module 00" : 1338, "CPP Module 01" : 1339, "CPP Module 02" : 1340, "CPP Module 03" : 1341, "CPP Module 04" : 1342, "CPP Module 05" : 1343, "CPP Module 06" : 1344, "CPP Module 07" : 1345, "CPP Module 08" : 1346, "Philosophers" : 1334, "ft_containers" : 1335, "webserv" : 1332, "ft_irc" : 1336, "ft_transcendence" : 1337]
    
    @IBOutlet var pageTitle:UINavigationItem!
    var project:String = ""
    var tocken: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageTitle.title = project
        let projectKey = projectDic[project]!
        projectProc(c: c1, pCode: projectKey, token: myToken)
        projectProc(c: c2, pCode: projectKey, token: myToken)
        var i : Int = 1
        while i < c1.count
        {
            if (c1[i].id != nil)
            {
                print(c1[i].login)
                print(c1[i].id)
                print(c1[i].status)
            }
            i += 1
        }
        
        //print(projectKey)
        
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
        return 35
    }
    
    // 셀 가로 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    // 셀 크기 정하기 (n분의 1)
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       // let width = collectionView.frame.width / 9 - 1 // 3등분하여 배치, 옆 간격이 1이므로 1을 빼줌
       // let size = CGSize(width: width, height: width)
        
        let height = collectionView.frame.height / 8 - 1 // n등분
        print(collectionView.frame.height)
        print(height)
        let size = CGSize(width: height, height: height)
        
        return size
    }
    
    // MARK : - UICollectionViewDetaSource protocol
    
    // tell the collection view how many cells to make
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return self.items.count
       return c1.count
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        // get a reference to our storyboard cell
        let cell: MyCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MyCollectionViewCell
        
        // Use the outlet in our custom class to get a reference to the UILabel in the cel
        if (c1[indexPath.item].status == 1) {
            cell.backgroundColor = UIColor.systemGray //make cell more viseible in our example project
        } else if (c1[indexPath.item].status == 2){
            cell.backgroundColor = UIColor.systemGreen
        } else if (c1[indexPath.item].status == 3){
            cell.backgroundColor = UIColor.systemBlue
        } else {
            cell.backgroundColor = UIColor.systemGray6
        }
        //print(indexPath.item)
        //cell.myLabel.text = items[indexPath.row]
        //cell.myLabel.textColor = UIColor.white
        //cell.myLabel.backgroundColor = UIColor.systemIndigo
        //print(indexPath)
        //print(type(of: indexPath))
        //cell 모서리 라운드처리
        cell.layer.cornerRadius = 10
        
        return cell
    }
    
   
    
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print("You selected cell #\(indexPath.item)!")
        //click 했을 때 특정행동 수행.
        
        if (c1[indexPath.item].url != nil) {
//            print("find 6")
            if let url = URL(string: c1[indexPath.item].url!) {
                UIApplication.shared.open(url, options: [:])
            }

        }
        collectionView.reloadData()
    }

    let reuseIdentifier = "cell" //
    
    
    //var index[]
    var items = ["1", "2", "3", "4", "5", "6", "7", "8","9","10","11","12","13","14","15", "16", "17", "18", "19", "20", "6", "7", "8","9"]//,"10","11","12","13","14","15", "1", "2", "3", "4", "5", "6", "7", "8","9","10","11","12","13","14","15","1", "2", "3", "4", "5", "6", "7", "8","9","10","11","12","13","14","15","1", "2", "3"]
    
//    @IBOutlet var collectionView: UICollectionView!
    

}
