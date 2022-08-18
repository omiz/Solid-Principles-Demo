//
//  Created by Omar Allaham on 8/17/22.
//

import Foundation
import SolidPrinciples
import OSLog

@available(macOS 11.0, iOS 14.0, *)
final class ClassicWorkPerformer: WorkPerforming {
    
    // The variables represent the added responsibilities and the managing the interactions between each others
    let logger: Logger = Logger(subsystem: "com.domain.example", category: "TaskFetching")
    let serverLoader: AnyObject? = nil
    let database: AnyObject? = nil
    let completionQueue: AnyObject? = nil
    let isLoggerEnabled = false
    
    func perform(completion: @escaping (Result<[WorkDetail], Error>) -> Void) {
        
        log("Started")
        
        connectToServerAndFetchResult { [self] result in
            
            self.log("Finished")
            
            self.store(result) { savingResult in
                // a hidden responsibility/complexity is added here to decide if the completion should succeed for a successful server connection but failing database storing
                switch savingResult {
                case .success:
                    
                    // Added complexity about the completion queue picking logic. this might be duplicated on the View or presentation side to insure updating the up is not triggered from the wrong thread
                    // a chaining of this function might cause unnecessary queue jumping
                    if Thread.isMainThread {
                        completion(result)
                        self.log("completion")
                    } else {
                        DispatchQueue.main.sync {
                            completion(result)
                            self.log("completion")
                        }
                    }
                case .failure:
                    //should we return an error or the loaded objects
                    break
                }
            }
        }
    }
    
    private func connectToServerAndFetchResult(completion: @escaping (Result<[WorkDetail], Error>) -> Void) {
        // server connection details might be added here to make a connection or to call and pass the required information to a responding object
        // might need to have knowledge about the how of picking the correct server. (Production/Testing/Staging or Region based server)
        doExpensiveWork { [self] in
            self.log("Finished")
            let result = WorkDetail.randomResult()
            completion(result)
        }
    }
    
    private func store(_ result: Result<[WorkDetail], Error>,
                       completion: @escaping (Result<Void, Error>) -> Void) {
        
        // perform some logic to save and update existing records
        // a responsibility is added here to directly store the data or to have a reference to some database action performer to do the actions on its behalf
        // this might contain some business logic or specific domain details about caching a how long an object can live in the database
        // Another responsibility might be choosing which queue to run and complete on
        // then after completion a result is returned
        
        completion(.success(()))
    }
    
    private func log(_ message: String) {
        
        //responsibility to choose if the logging should be performed for example on production or by storing an additional variable
        guard isLoggerEnabled else { return }
        logger.log(level: .default, "\(message)")
    }
}
