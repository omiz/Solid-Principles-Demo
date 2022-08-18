//
//  Created by Omar Allaham on 8/18/22.
//

import Foundation
import SolidPrinciples

public struct EnvironmentBasedWorkPerformerFactory {
    
    public init() {}
    
    public func makeWorkPerformer() -> WorkPerforming {
        EnvironmentWorkPerformer(
            production: ProductionRemoteWorkPerformer(),
            staging: StagingRemoteWorkPerformer()
        )
        .fallback(to: DataBaseWorkPerformer())
        .logToCrashlytic()
        .retry(count: 3)
        .completeOnMainQueue()
    }
}
