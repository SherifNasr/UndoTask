//
//  CalcPresenter.swift
//  UndoTask
//
//  Created by Sherif Nasr on 10/20/18.
//  Copyright © 2018 Sherif Nasr. All rights reserved.
//

import Foundation

class CalcPresenter: NSObject {
    
    override init() {
        super.init()
    }
    
    func canRedo() -> Bool {
        return true
    }
    
    func canUndo() -> Bool {
        return true
    }
    
}
