//
//  ViewController.swift
//  TestProgressBar
//
//  Created by Mauro De Vito on 03/02/2021.
//  Copyright © 2021 Mauro De Vito. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var progressBar: ProgressBar!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var txtSeconds: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        let timeAtPress = Date()
        var seconds: Double = 5
        if let txt = self.txtSeconds.text {
            seconds = Double(txt)!
        }
        
        
        progressBar.color = UIColor.brown
        DispatchQueue.main.async {
            self.progressBar.start(secondsForFilling: seconds) { (response) in
                let elapsed = Date().timeIntervalSince(timeAtPress)
                self.label.text = "Intervallo: <\(elapsed)>"
                self.progressBar.progress = 0
            }

        }
    }
}

