//
//  WeakRefTests.swift
//  
//
//  Created by Omar Allaham on 8/17/22.
//

import XCTest
import SolidPrinciples

final class WeakRefTests: XCTestCase {

    func testWeakRefHoldsAReferenceToTheGivenObject() {
        let anObject = MockObject()
        
        let sut = WeakRef(anObject)
        
        XCTAssertEqual(ObjectIdentifier(sut.object!), ObjectIdentifier(anObject))
    }
    
    func testWeakRefHoldsAWeakReferenceToTheGivenObject() {
        var anObject: MockObject? = MockObject() // anObject retain count = 1
        
        let sut = WeakRef(anObject!)
        
        anObject = nil // anObject retain count = 0 (memory should be freed now)
        
        XCTAssertNil(sut.object, "Object reference should be nil after the object has been freed")
    }
    
    private class MockObject {}
}
