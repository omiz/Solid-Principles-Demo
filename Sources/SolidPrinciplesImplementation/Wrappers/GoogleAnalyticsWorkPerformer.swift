//
//  Created by Omar Allaham on 8/17/22.
//

import Foundation
import SolidPrinciples

final class GoogleAnalyticsWorkPerformer: WorkPerforming {
    
    let analytics: GoogleAnalytics
    let performer: WorkPerforming
    
    init(performer: WorkPerforming, analytics: GoogleAnalytics) {
        self.performer = performer
        self.analytics = analytics
    }
    
    func perform(completion: @escaping (Result<[WorkDetail], Error>) -> Void) {
        analytics.log("Started Fetching")
        
        performer.perform { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(tasks):
                self.analytics.log("successfully completed task fetching with \(tasks.count) tasks")
            case let .failure(error):
                self.analytics.log("Failed to fetch tasks with error: \(error.localizedDescription)")
            }
            
            completion(result)
        }
    }
}

extension WorkPerforming {
    
    public func logToGoogleAnalytics() -> WorkPerforming {
        GoogleAnalyticsWorkPerformer(performer: self, analytics: GoogleAnalytics())
    }
}



struct GoogleAnalytics {
    func log(_ message: String) {
        
    }
}
