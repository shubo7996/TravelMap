//
//  FirstViewController.swift
//  Travel Map II
//
//  Created by Subhamoy Paul on 12/29/17.
//  Copyright © 2017 Subhamoy Paul. All rights reserved.
//

import UIKit
import CoreData

class FirstViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var titleArray = [String]()
    var subtitleArray = [String]()
    var latitudeArray = [Double]()
    var longitudeArray = [Double]()

    @IBOutlet weak var MapTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        MapTableView.delegate = self
        MapTableView.dataSource = self
        fetchData()
    }
    
    func fetchData(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Location")
        request.returnsObjectsAsFaults = false
        
        do{
            let results = try context.fetch(request)
            
            if results.count > 0 {
                self.titleArray.removeAll(keepingCapacity: false)
                self.subtitleArray.removeAll(keepingCapacity: false)
                self.latitudeArray.removeAll(keepingCapacity: false)
                self.longitudeArray.removeAll(keepingCapacity: false)
                for result in results as! [NSManagedObject] {
                    if let title = result.value(forKey: "title") as? String {
                        self.titleArray.append(title)
                    }
                    if let subtitle = result.value(forKey: "subtitle") as? String {
                        self.subtitleArray.append(subtitle)
                    }
                    if let latitude = result.value(forKey: "latitude") as? Double {
                        self.latitudeArray.append(latitude)
                    }
                    if let longitude = result.value(forKey: "longitude") as? Double {
                        self.longitudeArray.append(longitude)
                    }
                    self.MapTableView.reloadData()
                }
            }
            
        } catch {
            print("error")
            
        }
        
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MapTableView.dequeueReusableCell(withIdentifier: "mapCell")
        cell?.textLabel?.text = titleArray[indexPath.row]
        return cell!
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
