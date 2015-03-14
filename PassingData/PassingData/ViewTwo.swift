//
//  ViewTwo.swift
//  PassingData
//
//  Created by Alexis Saint-Jean on 3/12/15.
//  Copyright (c) 2015 Alexis Saint-Jean. All rights reserved.
//

import UIKit

class ViewTwo: ViewController {

    @IBOutlet weak var Label: UILabel!
    
    var LabelText = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.Label.text = self.LabelText
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
