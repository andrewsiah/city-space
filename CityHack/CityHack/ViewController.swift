//
//  ViewController.swift
//  CityHack
//
//  Created by Xavier Y on 26/1/2019.
//  Copyright © 2019 Xavier Y. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    @IBOutlet weak var AreaA: UIButton!
    
    var peopleAreaA = 0

    
    func AreaAColorChange() {
        //update from main thread
        DispatchQueue.main.async {
            if self.peopleAreaA == 0 {
                self.AreaA.backgroundColor = UIColor.green
            }
            else if self.peopleAreaA == 1 {
                self.AreaA.backgroundColor = UIColor.yellow
            }
            else if self.peopleAreaA > 1 {
                self.AreaA.backgroundColor = UIColor.red
            }
        }
    }
    
   @objc  func updateCapacities() {
        //local url value for API call
        let url = URL(string: "http://127.0.0.1:5000/")!
    
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            //guard against nil
            guard let temp = data else { return }
            //set to string
            let myString: String = String(data: temp, encoding: .utf8)!
            //remove \n from string
            let dataString: String = String(myString.filter { !" \n".contains($0) })
            
            //update capacity
            self.peopleAreaA = Int(dataString)!
            
            //update colors
            self.AreaAColorChange()
            print("Capacity is \(self.peopleAreaA)")
        }
        
        task.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //call API on timer
        let timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(self.updateCapacities), userInfo: nil, repeats: true)
        }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

