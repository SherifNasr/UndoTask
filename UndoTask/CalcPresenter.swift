//
//  CalcPresenter.swift
//  UndoTask
//
//  Created by Sherif Nasr on 10/20/18.
//  Copyright © 2018 Sherif Nasr. All rights reserved.
//

import Foundation

class CalcPresenter: NSObject {

    //MARK: - Variables
    var displayItems: [Operand] = []
    var operationHistory: [Operand] = []
    var currentPointer: Int = -1
    var result: Int = 0
    var redoCount = 0

    //MARK: - Methods
    override init() {
        super.init()
    }

    func canRedo() -> Bool {
        return currentPointer < operationHistory.count - 1 && redoCount > 0
    }

    func canUndo() -> Bool {
        return currentPointer > -1
    }

    func undo() {
        if canUndo() {
            redoCount += 1
            var operand = operationHistory[currentPointer]
            operand.revrse()
            operationHistory.append(operand)
            calculateFinalResult(operand: operand)
            if !displayItems.isEmpty && !operationHistory[currentPointer].isRemoved {
                displayItems.remove(at: displayItems.count - 1)
            } else if operationHistory[currentPointer].isRemoved {
                var displayedOperand = operationHistory[currentPointer]
                displayedOperand.revrse()
                displayItems.append(displayedOperand)
            }
            currentPointer = currentPointer - 1
        }
    }

    func redo() {
        if canRedo() {
            redoCount -= 1
            currentPointer = currentPointer + 1
            let operand = operationHistory[currentPointer]
            operationHistory.append(operand)
            calculateFinalResult(operand: operand)
            displayItems.append(operand)
        }
    }

    func doNewOperation(operand: Operand) {
        operationHistory.append(operand)
        currentPointer = operationHistory.count - 1
        calculateFinalResult(operand: operand)
        displayItems.append(operationHistory[currentPointer])
    }

    func calculateFinalResult(operand: Operand) {
        switch operand.operation {
        case .add:
            result = result + operand.number
        case .minus:
            result = result - operand.number
        case .multipy:
            result = result * operand.number
        case .division:
            result = result / operand.number
        }
    }

    func getResultString() -> String {
        return "\(result)"
    }
    
}
