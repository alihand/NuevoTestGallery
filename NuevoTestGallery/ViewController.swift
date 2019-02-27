//
//  ViewController.swift
//  NuevoTestGallery
//
//  Created by Alihan Demir on 26.02.2019.
//  Copyright © 2019 Alihan Demir. All rights reserved.
//

import UIKit
import ImageLoader
import SwiftyJSON


class ViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{

    var titles = [String]()
    var images = [String]()
    var ids = [Int]()
    var num = Int()

    
    @IBOutlet weak var myTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let filePath = Bundle.main.path(forResource: "JSONData", ofType: "json")
        let content = NSData.init(contentsOfFile: filePath!)
        do{
            let dict = try? JSONSerialization.jsonObject(with: content! as Data, options: .mutableContainers)
            
            print("content = ",content!)
            print("dict = ",dict!)
            let json = try JSON(data: content! as Data)
            print("json = ",json)
            
            let jsonArr = json["albums"].array
            num = (jsonArr?.count)!
            
            for i in 0..<num {
                
                let titles1 = json["albums"][i]["title"].stringValue
                print("title",titles1)
                self.titles.append(titles1)
                
                let id = json["albums"][i]["id"].intValue
                print("id",id)
                self.ids.append(id)
                
                let flag = json["albums"][i]["url"].stringValue
                print("url",flag)
                self.images.append(flag)
            }
        }
        catch{
            print(error)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myTable.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "showdetail", sender: self)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailViewController {
            destination.titleArray = [titles[(myTable.indexPathForSelectedRow?.row)!]]
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return num
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : AlbumTableViewCell = myTable.dequeueReusableCell(withIdentifier: "album") as! AlbumTableViewCell
        
        let url = images[indexPath.row]
        
        cell.titleSet.text! = titles[indexPath.row]
        cell.imageURL.load.request(with: url, onCompletion: { image, error, operation in
            
            if operation == .network {
                let transition = CATransition()
                transition.duration = 0.5
                cell.imageURL.layer.add(transition, forKey: nil)
                cell.imageURL.image = image
            }
        })
        return cell
    }
}
