//
//  ViewController.swift
//  SampleXib
//
//  Created by 지원 on 2021/08/11.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var myTableView: UITableView!
    
    var arr = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTableView.delegate = self
        myTableView.dataSource = self
        
        let nibName = UINib(nibName: "MyTableViewCell", bundle: nil) // file name
        myTableView.register(nibName, forCellReuseIdentifier: "myCell") // identifier
    }

}

extension ViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        
        return cell
        
    }
    
    
}

