//
//  File.swift
//  
//
//  Created by Omar Allaham on 8/18/22.
//

import Foundation
import SolidPrinciples

public struct PredefinedWorkPerformerFactory {
    
    private let performer: WorkPerforming
    
    public init(performer: WorkPerforming) {
        self.performer = performer
    }
    
    public func makeWorkPerformer() -> WorkPerforming {
        
        return performer
        
        //Another way can be by provided the performer with a predefined wrappers as in the example below
//        return performer
//            .fallback(to: DataBaseWorkPerformer())
//            .logToCrashlytic()
//            .retry(count: 3)
//            .completeOnMainQueue()
    }
}
