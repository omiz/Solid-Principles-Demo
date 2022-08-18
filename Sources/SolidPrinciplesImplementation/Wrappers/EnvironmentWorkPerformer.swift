//
//  Created by Omar Allaham on 8/18/22.
//

import Foundation
import SolidPrinciples

public var externalIsEnvironmentProduction = false

// The WorkPerformer is responsible for holding the logic of deciding which performer to use based on the appropriate environment.
// the logic of doing the job can be in the passed work performer (production/staging) to allow complete logic separation.
final class EnvironmentWorkPerformer: WorkPerforming {
    
    private let production: WorkPerforming
    private let staging: WorkPerforming
    
    public init(production: WorkPerforming, staging: WorkPerforming) {
        self.production = production
        self.staging = staging
    }
    
    public func perform(completion: @escaping Completion) {
        if isProduction() {
            production.perform(completion: completion)
        } else {
            staging.perform(completion: completion)
        }
    }
    
    private func isProduction() -> Bool {
        return externalIsEnvironmentProduction
    }
}
