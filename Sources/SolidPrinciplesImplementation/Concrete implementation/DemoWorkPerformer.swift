//
//  Created by Omar Allaham on 8/17/22.
//

import Foundation
import SolidPrinciples

final class DemoWorkPerformer: WorkPerforming {
    
    func perform(completion: @escaping (Result<[WorkDetail], Error>) -> Void) {
        completion(WorkDetail.randomResult())
    }
}
