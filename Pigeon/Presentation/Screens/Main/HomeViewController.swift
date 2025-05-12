//
//  HomeViewController.swift
//  Pigeon
//
//  Created by Muhammet Emre Kemancı on 3.05.2025.
//

import UIKit

class ViewController: UIViewController {
  override func viewDidLoad() {
      super.viewDidLoad()

      // Do any additional setup after loading the view, typically from a nib.

      let button = UIButton(type: .roundedRect)
      button.frame = CGRect(x: 20, y: 50, width: 100, height: 30)
      button.setTitle("Test Crash", for: [])
      button.addTarget(self, action: #selector(self.crashButtonTapped(_:)), for: .touchUpInside)
      view.addSubview(button)
  }

  @IBAction func crashButtonTapped(_ sender: AnyObject) {
      let numbers = [0]
      let _ = numbers[1]
  }
}
