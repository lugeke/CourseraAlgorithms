import XCTest
@testable import CourseraAlgorithms
@testable import Algorithms

final class CourseraAlgorithmsTests: XCTestCase {
    
    
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
    
    
    func testSmallGraph() {
        
         var g = Graph(adjList: .init(repeating: [], count: 10))
           g.addEdge(4, 2)
           g.addEdge(2, 3)
           g.addEdge(3, 4)
           g.addEdge(4,5)
           g.addEdge(5,6)
           g.addEdge(6,1)
           g.addEdge(1,5)
           g.addEdge(6,9)
           g.addEdge(9,7)
           g.addEdge(7,8)
           g.addEdge(8,9)

           

           print(g.dfsFinishTime())
        
           XCTAssertEqual(g.SCC(), [3, 3, 3])

    }
    
    func testBigGraph() {
        
        let sccURL = URL(fileURLWithPath: #file)
            .deletingLastPathComponent()
            .appendingPathComponent("SCC.txt")
        
        // the graph contains 875714 vertices
        var h = Graph(adjList: .init(repeating: [], count: 875715))
        let lines = try! String(contentsOf: sccURL).split(separator: "\n")
        
        
        measure {
            for line in lines {
                let vertices = line.split(separator: " ")
                //    print(vertices)
                h.addEdge(Int(vertices[0])!, Int(vertices[1])!)
            }
            print(h.SCC()
                .sorted(by: >)
                .prefix(5)
            )
        }
    }
    
    
    func testInversions() {
        XCTAssertEqual(inversions([1,2,3]), 0)
        XCTAssertEqual(inversions([3,2,1]), 3)
        XCTAssertEqual(inversions([3]), 0)
        XCTAssertEqual(inversions([1,3,5,2,4,6]), 3)
        
        let url = URL(fileURLWithPath: #file)
            .deletingLastPathComponent()
            .appendingPathComponent("IntegerArray.txt")
        
        let lines = try! String(contentsOf: url).split(separator: "\r\n")
        
        var ary: [Int] = []
        ary.reserveCapacity(100000)
        for line in lines {
            ary.append(Int(line)!)
        }
        print(inversions(ary))
    }
    

    static var allTests = [
        ("testMultiplication", testMultiplication),
        ("testAdd", testAdd),
        ("testSmallGraph", testSmallGraph),
        ("testBigGraph", testBigGraph)
    ]
}
