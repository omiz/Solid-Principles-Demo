//
//  Created by Omar Allaham on 8/17/22.
//

import Foundation

public final class WeakRef<T: AnyObject> {
    public weak var object: T?
    
    public init(_ object: T) {
        self.object = object
    }
}
