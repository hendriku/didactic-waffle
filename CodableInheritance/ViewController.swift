//
//  ViewController.swift
//  CodableInheritance
//
//  Created by Hendrik Ulbrich on 15.02.20.
//  Copyright © 2020 Hendrik Ulbrich. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let evil = EvilRealisation() // TODO: try to decode encode the whole palette afterwards
        let evilColor = evil.brand01!
        
        do {
            let data = try JSONEncoder().encode(evilColor)
            print(String(data: data, encoding: .utf8)!)
            
            let good = try JSONDecoder().decode(MyCustomColor.self, from: data)
            print(good)
        } catch {
            print(error)
        }

    }


}

