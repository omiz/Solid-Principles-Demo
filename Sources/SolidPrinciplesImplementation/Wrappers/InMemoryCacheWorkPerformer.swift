//
//  Created by Omar Allaham on 8/17/22.
//

import Foundation
import SolidPrinciples

// The in memory is interacting the performing of the work and store a value in memory to return it on the next unsuccessful completion.
// The logic is provided as an example but a more complex logic can be provided about the cache
final class InMemoryCacheWorkPerformer: WorkPerforming {
    
    private let performer: WorkPerforming
    private var details: [WorkDetail]? = nil
    
    init(performer: WorkPerforming) {
        self.performer = performer
    }
    
    func perform(completion: @escaping (Result<[WorkDetail], Error>) -> Void) {
        
        performer.perform { [weak self] result in
            guard let self = self else { return }
            
            do {
                let details = try result.get()
                self.details = details
                completion(.success(details))
            } catch {
                if let details = self.details {
                    completion(.success(details))
                } else {
                    completion(.failure(error))
                }
            }
        }
    }
}

extension WorkPerforming {
    
    // The implementation itself if hidden and can changed at anytime since the original implementation class is not visible from outside the target can can lead to better freedom updating the code and playing around
    public func fallbackToInMemoryCache() -> WorkPerforming {
        InMemoryCacheWorkPerformer(performer: self)
    }
}
