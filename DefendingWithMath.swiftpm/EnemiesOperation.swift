//
//  Untitled.swift
//  DefendingTheMath
//
//  Created by Sérgio César Lira Júnior on 29/01/25.

struct EnemiesOperation {
    
    public func generateAddOrSub() -> (String, Int) {
        if Int.random(in: 1...10) % 2  == 0 {
            return generateAddOperation()
        }
        return generateSubOperation()
    }
    
    public func generateMultOrDiv() -> (String, Int) {
        if Int.random(in: 1...10) % 2  == 0 {
            return generateMultOperation()
        }
        return generateDivOperation()
    }
    
    private func generateAddOperation() -> (String, Int) {

        let a = Int.random(in: 0...50)
        let b = Int.random(in: 0...50)
        return ("\(a) + \(b)", a + b)
    }
    
    private func generateSubOperation() -> (String, Int) {
        let a = Int.random(in: 1...100)
        let b = Int.random(in: 1...a)
        return ("\(a) - \(b)", a - b)
    }
    
    private func generateMultOperation() -> (String, Int) {
        let a = Int.random(in: 1...10)
        let b = Int.random(in: 1...10)
        return ("\(a) x \(b)", a * b)
    }
    
    private func generateDivOperation() -> (String, Int) {
        let a = Int.random(in: 1...10)
        let b = Int.random(in: 1...10)

        return ("\(a*b) ÷ \(b)",  a)
    }
}
