//
//  Created by Omar Allaham on 8/17/22.
//

import Foundation
import SolidPrinciples

// In the case of creating a new implementation many of the already written features might be missing or an inheritance from a base class must me.
// This would might add more complexity to perform a base implementation and the need to have the knowledge about how it differ from the base
// un-needed instances from base might be required and

@available(macOS 11.0, iOS 14.0, *)
final class AnotherClassicWorkPerformer: WorkPerforming {
    
    func perform(completion: @escaping (Result<[WorkDetail], Error>) -> Void) {
        
        completion(WorkDetail.randomResult())
    }
}
