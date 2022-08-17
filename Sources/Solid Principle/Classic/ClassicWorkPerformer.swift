//
//  File.swift
//  
//
//  Created by Omar Allaham on 8/17/22.
//

import Foundation
import OSLog

final class ClassicWorkPerformer: WorkPerforming {
    
    let logger: Logger = Logger(subsystem: "com.domain.example", category: "TaskFetching")
    let isLoggerEnabled = false
    
    func perform(completion: @escaping (Result<[WorkDetail], Error>) -> Void) {
        
        log("Started")
        
        doExpensiveWork { [self] in
            
            self.log("Finished")
            
            let result = WorkDetail.randomResult()
            
            if Thread.isMainThread {
                completion(result)
                self.log("completion")
            } else {
                DispatchQueue.main.sync {
                    completion(result)
                    self.log("completion")
                }
            }
        }
    }
    
    private func log(_ message: String) {
        guard isLoggerEnabled else { return }
        logger.log(level: .default, "\(message)")
    }
}
