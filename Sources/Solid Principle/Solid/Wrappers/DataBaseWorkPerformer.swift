//
//  File.swift
//  
//
//  Created by Omar Allaham on 8/17/22.
//

import Foundation

final class DataBaseWorkPerformer: WorkPerforming {
    
    let performer: WorkPerforming
    
    func perform(completion: @escaping (Result<[WorkDetail], Error>) -> Void) {
        
        performer.perform { result in
            
            //update data base then call completion
         
            completion(result)
        }
    }
}
