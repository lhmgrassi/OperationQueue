//
//  ViewController.swift
//  QueueSyncing
//
//  Created by Luis Henrique Mendonça Grassi on 02/05/17.
//  Copyright © 2017 Luis Henrique Mendonça Grassi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    
    var queue = OperationQueue()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func button2Tapped(_ sender: Any) {
        label.text = String(Int(arc4random_uniform(600) + 1))
    }
    
    @IBAction func buttonTapped(_ sender: Any) {
        
        queue = OperationQueue()
        let operation1 = BlockOperation()
        let operation4 = BlockOperation()
        operation4.qualityOfService = .background
        operation1.addDependency(operation4)
        
        operation1.addExecutionBlock {
            print("start 1")
        }
        
        operation1.completionBlock = {
            print("Operation 1 completed")
        }
        queue.addOperation(operation1)
        
        let operation2 = BlockOperation(block: {
            
        })
        
        operation2.completionBlock = {
            print("Operation 2 completed")
        }
        queue.addOperation(operation2)
        
        
        let operation3 = BlockOperation(block: {
            
        })
        
        operation3.completionBlock = {
            print("Operation 3 completed")
        }
        queue.addOperation(operation3)
        
        operation4.addExecutionBlock {
            print("start 4")
            for _ in 0...99999999999 {
                
            }
        }
        
        operation4.completionBlock = {
            print("Operation 4 completed")
        }
        queue.addOperation(operation4)
        queue.addObserver(self, forKeyPath: "operationCount", options: .new, context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if let operationCount = keyPath, operationCount == "operationCount" {
            if queue.operationCount == 0 {
                //not guaranteed it will run after operation's completions blocks
                print("FINISH ALL")
            }
        }
    }
    
}

