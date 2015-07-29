//: Playground - noun: a place where people can play

import UIKit

class Numbers {
    let numberOne:Int
    let numberTwo:Int
    let calcWanted:String
    
    init(numberOne:Int,numberTwo:Int,calcWanted:String) {
        self.numberOne = numberOne
        self.numberTwo = numberTwo
        self.calcWanted = calcWanted
    }
    
    
}

protocol Chain {
    func setNextChain(nextChain:Chain)
    func calculate(numbers:Numbers)
}

class AddNumbers: Chain {
    
    var chain:Chain?
    
    func setNextChain(nextChain: Chain) {
        self.chain = nextChain
    }
    
    func calculate(numbers: Numbers) {
        if numbers.calcWanted == "add" {
            println("\(numbers.numberOne) + \(numbers.numberTwo) = \(numbers.numberOne + numbers.numberTwo)")
        } else {
            self.chain?.calculate(numbers)
        }
    }
}

class SubNumbers: Chain {
    
    var chain:Chain?
    
    func setNextChain(nextChain: Chain) {
        self.chain = nextChain
    }
    
    func calculate(numbers: Numbers) {
        if numbers.calcWanted == "sub" {
            println("\(numbers.numberOne) - \(numbers.numberTwo) = \(numbers.numberOne - numbers.numberTwo)")
        } else {
            println("supports add and sub only")
        }
    }
}



    let chain1 = AddNumbers()
    let chain2 = SubNumbers()
    let numbers = Numbers(numberOne: 3, numberTwo: 6, calcWanted: "sub")
    

    
    chain1.setNextChain(chain2)
    chain1.calculate(numbers)
    
    
