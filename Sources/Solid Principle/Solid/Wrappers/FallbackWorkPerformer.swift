//
//  Created by Omar Allaham on 8/17/22.
//

import Foundation

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
    
    public func retry(count: Int) -> WorkPerforming {
        (0...count).reduce(self, { partialResult, _ in
            partialResult.fallback(to: self)
        })
    }
}
