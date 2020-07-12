import Algorithms
import Foundation

print(multiplication("3", "100"))
var url = URL(fileURLWithPath: "/Users/jiaheng/Downloads/g1.txt")
var g = Graph(fromURL: url, directed: true)
print("\(Date())")
var shortest = g.shortestOfShortestPaths()
print(shortest ?? "NULL")
print("\(Date())")

url = URL(fileURLWithPath: "/Users/jiaheng/Downloads/g2.txt")
g = Graph(fromURL: url, directed: true)
print("\(Date())")
shortest = g.shortestOfShortestPaths()
print(shortest ?? "NULL")
print("\(Date())")


url = URL(fileURLWithPath: "/Users/jiaheng/Downloads/g3.txt")
g = Graph(fromURL: url, directed: true)
print("\(Date())")
shortest = g.shortestOfShortestPaths()
print(shortest ?? "NULL")
print("\(Date())")
