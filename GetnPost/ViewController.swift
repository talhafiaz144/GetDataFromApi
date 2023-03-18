//
//  ViewController.swift
//  GetnPost
//
//  Created by Apple on 26/10/2022.
//

import UIKit
//import Alamofire

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var dataTableView: UITableView!
    var dataArray : [[String:Any]] = []
    override func viewDidLoad() {
        
        super.viewDidLoad()
        dataTableView.dataSource = self
        dataTableView.delegate = self
        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: nil)
        
        let dictionary : [String:Any] = dataArray[indexPath.row]
        let id:Int = dictionary["id"] as! Int
        let title:String = dictionary["title"] as! String
        let userId:Int = dictionary["userId"] as! Int
        let completed:Int = dictionary["completed"] as! Int
        
        
        cell.textLabel?.text = "ID - \(id),Title - \(title)"
        cell.detailTextLabel?.text = "UserID-\(userId),Completed - \(completed)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("didSelect ...")
        let alert = UIAlertController(title: "Alert", message: "Please Wait!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default))
        self.present(alert, animated: true)
        
        
        
        
//        self.performSegue(withIdentifier: "toAlert", sender: nil)
        
    }
    
    @IBAction func  downloadAction() -> Void{
        let strURL = "https://jsonplaceholder.typicode.com/todos"
        let myURL: URL? = URL(string: strURL)
        var request: URLRequest = URLRequest(url: myURL!)
        request.httpMethod = "GET"
        let session:URLSession = URLSession.shared
        
        let dataTask : URLSessionDataTask = session.dataTask(with: request, completionHandler: (downloadHandler(urlData:response:error:)))
        dataTask.resume()
    }
    
    func downloadHandler(urlData:Data? , response : URLResponse? , error:Error?) -> Void {
        if (urlData != nil && error == nil) {
            
            
                let swiftData : Any? = try!  JSONSerialization.jsonObject(with: urlData!, options: JSONSerialization.ReadingOptions.mutableLeaves)
                
                if (swiftData != nil) {
                    dataArray = swiftData as! [[String:Any]]
                    print("Downloaded--",dataArray)
                    
                    DispatchQueue.main.async(execute: {
                        self.dataTableView.reloadData()
                    } )
                    
                }
            
            
        }
    }
    
    
}
