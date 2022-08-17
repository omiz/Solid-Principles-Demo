//
//  File.swift
//  
//
//  Created by Omar Allaham on 8/17/22.
//

import Foundation

func doExpensiveWork(_ completion: @escaping () -> Void) {
    DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + 2) {
        completion()
    }
}
