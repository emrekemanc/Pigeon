//
//  CoordinatorProtocol.swift
//  Pigeon
//
//  Created by Muhammet Emre Kemancı on 9.05.2025.
//

import UIKit

protocol CoordinatorProtocol: AnyObject{
    var navigationController: UINavigationController {get set}
    func start()
}
