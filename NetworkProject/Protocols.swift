//
//  Protocols.swift
//  NetworkProject
//
//  Created by Youngjun Kim on 7/23/25.
//

import UIKit

protocol Configurable {
    associatedtype Data
    func configure(from data: Data)
}
