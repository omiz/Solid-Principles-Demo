//
//  File.swift
//  
//
//  Created by Omar Allaham on 8/17/22.
//

import Foundation

struct ProductionWorkPerformerFactory {
    
    public func makeWorkPerformer() -> WorkPerforming {
        ProductionRemoteWorkPerformer()
            .fallback(to: DataBaseWorkPerformer())
            .logToCrashlytic()
            .retry(count: 3)
            .completeOnMainQueue()
    }
    
    
}
