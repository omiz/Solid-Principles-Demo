//
//  Created by Omar Allaham on 8/17/22.
//

import Foundation

public protocol WorkPerforming {
    
    typealias Completion = (Result<[WorkDetail], Error>) -> Void
    
    func perform(completion: @escaping Completion)
}
