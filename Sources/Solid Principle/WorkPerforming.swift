//
//  File.swift
//  
//
//  Created by Omar Allaham on 8/17/22.
//

import Foundation

protocol WorkPerforming {
    func perform(completion: @escaping (Result<[WorkDetail], Error>) -> Void)
}
