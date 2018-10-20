//
//  Operand.swift
//  UndoTask
//
//  Created by Sherif Nasr on 10/20/18.
//  Copyright © 2018 Sherif Nasr. All rights reserved.
//

import Foundation

enum OperatorSign: String {
    case minus = "-"
    case add = "+"
    case division =  "/"
    case multipy = "*"
}

struct Operand {
    var number: Int
    var operation: OperatorSign
    var isRemoved: Bool

    init(number: Int, operation: OperatorSign, isRemoved: Bool = false) {
        self.number = number
        self.operation = operation
        self.isRemoved = isRemoved
    }

    mutating func revrse() {
        switch operation {
        case .add:
            operation = .minus
        case .minus:
            operation = .add
        case .division:
            operation = .multipy
        case .multipy:
            operation = .division
        }
        isRemoved = !isRemoved
    }
}
