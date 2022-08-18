//
//  Created by Omar Allaham on 8/17/22.
//

import Foundation

struct StagingWorkPerformerFactory {
    
    public func makeWorkPerformer() -> WorkPerforming {
        StagingRemoteWorkPerformer()
            .fallback(to: DemoWorkPerformer())
            .fallback(to: DataBaseWorkPerformer())
            .logToCrashlytic()
            .logToGoogleAnalytics()
            .retry(count: 3)
            .completeOnMainQueue()
    }
}