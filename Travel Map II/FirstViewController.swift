//
//  FirstViewController.swift
//  Travel Map II
//
//  Created by Subhamoy Paul on 12/29/17.
//  Copyright © 2017 Subhamoy Paul. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    

    @IBOutlet weak var MapTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        MapTableView.delegate = self
        MapTableView.dataSource = self
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MapTableView.dequeueReusableCell(withIdentifier: "mapCell")
        cell?.textLabel?.text = "Hello"
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
