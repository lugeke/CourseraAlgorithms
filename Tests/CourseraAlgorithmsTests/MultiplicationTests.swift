import XCTest
@testable import Algorithms

final class MultiplicationTests: XCTestCase {
    
    
    func testAdd() {
        XCTAssertEqual(Algorithms.add([0, 0, 0, 9], [9,9]), [1, 0 , 8])
        XCTAssertEqual(Algorithms.add([9,9], [9]), [1, 0 , 8])
        XCTAssertEqual(Algorithms.add([9,9], [9,9]), [1, 9 , 8])
        XCTAssertEqual(Algorithms.add([9,9, 9], [ 9]), [1, 0 ,0, 8])
    }
    
    
    func testMultiplication() {
        
        XCTAssertEqual(multiplication("33", "44"), "1452")
        
        XCTAssertEqual(multiplication("3", "4"), "12")
               
        XCTAssertEqual(multiplication("3", "400"), "1200")
               
        XCTAssertEqual(multiplication("33", "44"), "1452")
               
        XCTAssertEqual(multiplication("133", "144"), "19152")
               
        
        XCTAssertEqual(multiplication("3141592653589793238462643383279502884197169399375105820974944592", "2718281828459045235360287471352662497757247093699959574966967627"), "8539734222673567065463550869546574495034888535765114961879601127067743044893204848617875072216249073013374895871952806582723184")
    }
    

    static var allTests = [
        ("testMultiplication", testMultiplication),
        ("testAdd", testAdd),
    ]
}
