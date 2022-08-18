//
//  Created by Omar Allaham on 8/17/22.
//

import Foundation
import SolidPrinciples

// The logic of choosing the correct completion queue is separated from the logic of actually doing the work and can help make the decision on creation time of the WorkPerformer.
final class CustomQueueWorkPerformer: WorkPerforming {
    
    private let queue: DispatchQueue
    private let performer: WorkPerforming
    
    init(performer: WorkPerforming, queue: DispatchQueue) {
        self.performer = performer
        self.queue = queue
    }
    
    func perform(completion: @escaping (Result<[WorkDetail], Error>) -> Void) {
        performer.perform { result in
            self.queue.async { [weak self] in
                guard let self = self else { return }
                
                completion(result)
            }
        }
    }
}

extension WorkPerforming {
    
    public func complete(on queue: DispatchQueue) -> WorkPerforming {
        CustomQueueWorkPerformer(performer: self, queue: queue)
    }
    
    public func completeOnMainQueue() -> WorkPerforming {
        complete(on: .main)
    }
}
