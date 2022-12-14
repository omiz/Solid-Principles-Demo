//
//  Created by Omar Allaham on 8/17/22.
//

import Foundation
import SolidPrinciples

// A complete logging to crashlytics can be obtained with the ability to have a full control over the import and the dependency in the project.
final class CrashlyticWorkPerformer: WorkPerforming {
    
    let crashlytic: Crashlytic
    let performer: WorkPerforming
    
    init(performer: WorkPerforming, crashlytic: Crashlytic) {
        self.performer = performer
        self.crashlytic = crashlytic
    }
    
    func perform(completion: @escaping (Result<[WorkDetail], Error>) -> Void) {
        crashlytic.log("Started Fetching")
        
        performer.perform { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(tasks):
                self.crashlytic.log("successfully completed task fetching with \(tasks.count) tasks")
            case let .failure(error):
                self.crashlytic.log("Failed to fetch tasks with error: \(error.localizedDescription)")
            }
            
            completion(result)
        }
    }
}

extension WorkPerforming {
    
    public func logToCrashlytic(instance: Crashlytic = Crashlytic()) -> WorkPerforming {
        CrashlyticWorkPerformer(performer: self, crashlytic: instance)
    }
}

public struct Crashlytic {
    
    public init() {}
    
    func log(_ message: String) {
        
    }
}
