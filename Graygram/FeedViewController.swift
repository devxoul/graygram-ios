//
//  FeedViewController.swift
//  Graygram
//
//  Created by Suyeol Jeon on 05/02/2017.
//  Copyright © 2017 Suyeol Jeon. All rights reserved.
//

import UIKit
import Alamofire

class FeedViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.

    Alamofire.request("https://api.graygram.com/feed").responseJSON { response in
      print(response)
    }
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

