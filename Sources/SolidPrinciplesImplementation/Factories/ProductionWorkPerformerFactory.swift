//
//  Created by Omar Allaham on 8/17/22.
//

import Foundation
import SolidPrinciples

public struct ProductionWorkPerformerFactory {
    
    public init() {}
    
    public func makeWorkPerformer() -> WorkPerforming {
        ProductionRemoteWorkPerformer()
            .fallback(to: DataBaseWorkPerformer())
            .logToCrashlytic()
            .retry(count: 3)
            .completeOnMainQueue()
    } 
}
