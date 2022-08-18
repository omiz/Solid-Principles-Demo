//
//  EnvironmentWorkPerformerTests.swift
//  
//
//  Created by Omar Allaham on 8/18/22.
//

import XCTest
import SolidPrinciplesImplementation

final class EnvironmentWorkPerformerTests: XCTestCase {

    func test_environmentBasedPerformer_executeProductionWhenSetToProduction() {
        
        let production = SpyWorkPerformer()
        let staging = SpyWorkPerformer()
        
        externalIsEnvironmentProduction = true
        
        let sut = EnvironmentWorkPerformer(production: production, staging: staging)
        
        let completionExp = expectation(description: "Performer should complete")
        let proExp = expectation(description: "Should complete on production")
        let stagingExp = expectation(description: "Should not complete on staging")
        stagingExp.isInverted = true
        
        sut.perform { _ in
            completionExp.fulfill()
        }
        
        production.onComplete = {
            proExp.fulfill()
        }
        
        staging.onComplete = {
            stagingExp.fulfill()
        }
        
        production.complete(with: .failure(anyNSError()))
                
        wait(for: [completionExp, proExp, stagingExp], timeout: 0.1)
    }
}
