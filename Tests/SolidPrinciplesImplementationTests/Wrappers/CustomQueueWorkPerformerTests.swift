//
//  CustomQueueWorkPerformerTests.swift
//  
//
//  Created by Omar Allaham on 8/18/22.
//

import XCTest
import SolidPrinciples
import SolidPrinciplesImplementation

class CustomQueueWorkPerformerTests: XCTestCase {

    func test_sutWithGlobalQueue_shouldCompleteOnPassedQueue() {
        let queue = DispatchQueue.global(qos: .utility)
        let expectedResult: Result<[WorkDetail], Error> = .success([])
        let sut = makeSUT(queue: queue, result: expectedResult)
        
        let exp = expectation(description: "completion should be called")
        
        sut.perform(completion: { result in
            XCTAssertTrue(!Thread.isMainThread)
            exp.fulfill()
        })
        
        wait(for: [exp], timeout: 0.1)
    }
    
    func test_sutWithMainQueue_shouldCompleteOnMainQueue() {
        let queue = DispatchQueue.main
        let expectedResult: Result<[WorkDetail], Error> = .success([])
        let sut = makeSUT(queue: queue, result: expectedResult)
        
        let exp = expectation(description: "completion should be called")
        
        sut.perform(completion: { result in
            XCTAssertTrue(Thread.isMainThread)
            exp.fulfill()
        })
        
        wait(for: [exp], timeout: 0.1)
    }
    
    func test_sutWithSuccessfulResult_shouldCompleteWithSuccess() {
        let queue = DispatchQueue.main
        let expectedDetails = [WorkDetail(title: "t", subtitle: "S")]
        let expectedResult: Result<[WorkDetail], Error>
        expectedResult = .success(expectedDetails)
        let sut = makeSUT(queue: queue, result: expectedResult)
        
        let exp = expectation(description: "completion should be called")
        
        sut.perform(completion: { result in
            
            do {
                let details = try result.get()
                XCTAssertEqual(details.count, expectedDetails.count)
                
                for (index, expected) in expectedDetails.enumerated() {
                    let found = details[index]
                
                    XCTAssertEqual(found.title, expected.title)
                    XCTAssertEqual(found.subtitle, expected.subtitle)
                }
                
                exp.fulfill()
            } catch {
                XCTFail(error.localizedDescription)
            }
        })
        
        wait(for: [exp], timeout: 0.1)
    }
    
    func test_sutWithFailure_shouldCompleteWithFailure() {
        let queue = DispatchQueue.main
        let expectedError = anyNSError()
        let expectedResult: Result<[WorkDetail], Error>
        expectedResult = .failure(expectedError)
        let sut = makeSUT(queue: queue, result: expectedResult)
        
        let exp = expectation(description: "completion should be called")
        
        sut.perform(completion: { result in
            
            if case let .failure(error) = result {
                XCTAssertEqual(error as NSError, expectedError)
                exp.fulfill()
            } else {
                XCTFail("Expected the result to fail but succeeded with \(result)")
            }
        })
        
        wait(for: [exp], timeout: 0.1)
    }
    
    private func makeSUT(queue: DispatchQueue,
                         result: Result<[WorkDetail], Error>) -> WorkPerforming {
        let stub = StubWorkPerformer(result: result)
        let sut = stub.complete(on: queue)
        trackForMemoryLeaks(stub)
        return sut
    }
}
