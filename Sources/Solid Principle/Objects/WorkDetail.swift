//
//  File.swift
//  
//
//  Created by Omar Allaham on 8/17/22.
//

import Foundation

public struct WorkDetail {
    
}


extension WorkDetail {
    
    static func randomWorkDetailArray(count: Int = 10) -> [WorkDetail] {
        Array(repeating: WorkDetail(), count: Int.random(in: 0...count))
    }
    
    static func randomResult() -> Result<[WorkDetail], Error> {
        let isSuccess = Bool.random()
        let tasks = WorkDetail.randomWorkDetailArray()
        let anyError = NSError(domain: "AnyDomain", code: 0)
        let result: Result<[WorkDetail], Error>
        
        result = isSuccess ? .success(tasks) : .failure(anyError)
        
        return result
    }
}
