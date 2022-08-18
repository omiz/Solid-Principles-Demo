//
//  Created by Omar Allaham on 8/18/22.
//

import SolidPrinciples

final class SpyWorkPerformer: WorkPerforming {
    
    private var completion: ((Result<[WorkDetail], Error>) -> ())?
    var onComplete: (() -> ())?
    
    init() {}
    
    func perform(completion: @escaping Completion) {
        self.completion = completion
    }
    
    func complete(with result: Result<[WorkDetail], Error>) {
        completion?(result)
        onComplete?()
    }
}

final class StubWorkPerformer: WorkPerforming {
    
    let result: Result<[WorkDetail], Error>
    
    init(result: Result<[WorkDetail], Error>) {
        self.result = result
    }
    
    func perform(completion: @escaping Completion) {
        completion(result)
    }
}
