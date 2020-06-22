//
//  File.swift
//  
//
//  Created by lujiaheng on 2020/6/22.
//

struct Job {
    let weight: Int
    let length: Int
}

// sum of weighted completion times
func schdule(jobs: [Job], strategy: (Job, Job) -> Bool) -> Int {
    let jobs = jobs.sorted(by: strategy)
    
    var completionTime = 0
    return jobs.reduce(0) { result, next in
        
        completionTime += next.length
        return result + next.weight*completionTime
    }
}
