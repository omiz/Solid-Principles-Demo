//
//  File.swift
//  
//
//  Created by Omar Allaham on 8/17/22.
//

import Foundation

final class StagingRemoteWorkPerformer: WorkPerforming {
    
    ///Connect to staging and do some work
    func perform(completion: @escaping (Result<[WorkDetail], Error>) -> Void) {
        completion(WorkDetail.randomResult())
    }
}
