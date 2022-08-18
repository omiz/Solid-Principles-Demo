//
//  Created by Omar Allaham on 8/17/22.
//

import Foundation
import SolidPrinciples

final class RemoteWorkPerformer: WorkPerforming {
    
    ///do some work on remote location
    func perform(completion: @escaping (Result<[WorkDetail], Error>) -> Void) {
        completion(WorkDetail.randomResult())
    }
}
