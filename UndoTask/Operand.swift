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
}
