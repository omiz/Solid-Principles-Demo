//
//  Created by Omar Allaham on 8/17/22.
//

import Foundation
import OSLog

@available(macOS 11.0, iOS 14.0, *)
final class LoggerWorkPerformer: WorkPerforming {
    
    let logger: Logger
    let performer: WorkPerforming
    
    init(performer: WorkPerforming, logger: Logger) {
        self.performer = performer
        self.logger = logger
    }
    
    func perform(completion: @escaping (Result<[WorkDetail], Error>) -> Void) {
        logger.log("Started Fetching")
        
        performer.perform { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(tasks):
                self.logger.log("successfully completed task fetching with \(tasks.count) tasks")
            case let .failure(error):
                self.logger.log("Failed to fetch tasks with error: \(error.localizedDescription)")
            }
            
            completion(result)
        }
    }
}


extension WorkPerforming {
    
    @available(macOS 11.0, iOS 14.0, *)
    public func log(on logger: Logger) -> WorkPerforming {
        LoggerWorkPerformer(performer: self, logger: logger)
    }
}
