//
//  Created by Omar Allaham on 8/17/22.
//

import Foundation
import SolidPrinciples

// The idea is to extract the log of falling back to another implementation from being nested inside the actual implementation or any business logic to allow or limit the fallback behavior.
// the Fallback implementation can be specific to allow more logic into the implementation as needed and can how multiple implementation depending on the business case.
final class FallbackWorkPerformer: WorkPerforming {
    
    let main: WorkPerforming
    let fallback: WorkPerforming
    var shouldReportOriginalError: Bool = true
    
    init(main: WorkPerforming, fallback: WorkPerforming) {
        self.main = main
        self.fallback = fallback
    }
    
    func perform(completion: @escaping (Result<[WorkDetail], Error>) -> Void) {
        main.perform { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case let .success(tasks):
                completion(.success(tasks))
            case let .failure(originalError):
                self.fallback.perform { [weak self] fallbackResult in
                    guard let self = self else { return }
                    switch fallbackResult {
                    case let .failure(error):
                        completion(.failure(self.shouldReportOriginalError ? originalError : error))
                    case let .success(tasks):
                        completion(.success(tasks))
                    }
                }
            }
        }
    }
}


extension WorkPerforming {
    
    public func fallback(to another: WorkPerforming) -> WorkPerforming {
        FallbackWorkPerformer(main: self, fallback: another)
    }
    
    //since retry can be expressed as fallingback to self to redo the same action again this can use the same fallback implementation but does not have to.
    public func retry(count: Int) -> WorkPerforming {
        (0...count).reduce(self, { partialResult, _ in
            partialResult.fallback(to: self)
        })
    }
}
