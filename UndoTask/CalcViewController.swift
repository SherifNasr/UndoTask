//
//  CalcViewController.swift
//  UndoTask
//
//  Created by Sherif Nasr on 10/20/18.
//  Copyright © 2018 Sherif Nasr. All rights reserved.
//

import UIKit

class CalcViewController: UIViewController {
    //MARK: Constants
    struct Constants {
       static let operandCell = "OperandCell"
    }

    // MARK: - Outlets
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var operandTextField: UITextField!
    @IBOutlet weak var equalBtn: UIButton!
    @IBOutlet weak var divideBtn: UIButton!
    @IBOutlet weak var multiplyBtn: UIButton!
    @IBOutlet weak var minusBtn: UIButton!
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var undoBtn: UIButton!
    @IBOutlet weak var redoBtn: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!

    // MARK: - Variables
    var operationBtns: [UIButton] =  []
    var displayItems: [Operand] = []
    let presenter = CalcPresenter()
    var result: Int = 0
    let reseultPrefix = "Result = "
    var currentOperation: OperatorSign? {
        didSet{
            if currentOperation == nil {
                operationBtns.forEach { (btn) in
                    btn.isEnabled = true
                }
            } else {
                operationBtns.forEach { (btn) in
                    btn.isEnabled = currentOperation!.rawValue == btn.titleLabel!.text
                }
            }
            updateUI()
        }
    }

    // MARK: - view controller methods
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        operationBtns = [divideBtn, multiplyBtn, addBtn, minusBtn]
        displayItems = [Operand(number: 2, operation: .add),
        Operand(number: 3, operation: .minus),
        Operand(number: 6, operation: .multipy),
        Operand(number: 6, operation: .multipy)]
        updateUI()
    }

    //MARK: - private functions
    fileprivate func updateUI() {
        redoBtn.isEnabled = presenter.canRedo()
        undoBtn.isEnabled = presenter.canUndo()
        equalBtn.isEnabled = currentOperation != nil && !operandTextField.text!.isEmpty
    }

    fileprivate func getResultString() -> String {
        guard let currentOperation = currentOperation,
            let newOperand = Int(operandTextField.text ?? "")  else {return reseultPrefix + "\(result)"}
        switch currentOperation {
        case .add:
            result = result + newOperand
        case .minus:
            result = result - newOperand
        case .multipy:
            result = result * newOperand
        case .division:
            result = result / newOperand
        }
        return reseultPrefix + "\(result)"
    }


    // MARK: - Actions
    @IBAction func redoButtonPressed(_ sender: UIButton) {
    }

    @IBAction func equalBtnPressed(_ sender: UIButton) {
        resultLabel.text = getResultString()
        currentOperation = nil
        operandTextField.text = ""
    }

    @IBAction func undoBtnPressed(_ sender: UIButton) {
    }

    @IBAction func operandBtnPressed(_ sender: UIButton) {
        switch sender.titleLabel?.text {
        case OperatorSign.add.rawValue:
            currentOperation = OperatorSign.add
        case OperatorSign.minus.rawValue:
            currentOperation = OperatorSign.minus
        case OperatorSign.multipy.rawValue:
            currentOperation = OperatorSign.multipy
        case OperatorSign.division.rawValue:
            currentOperation = OperatorSign.division
        default:
            break
        }
        updateUI()
    }

}

extension CalcViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return displayItems.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell: OperandCell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.operandCell, for: indexPath) as? OperandCell {
            let operand = displayItems[indexPath.row]
            cell.label.text = "\(operand.operation.rawValue) \(operand.number)"
            return cell
        }
        return UICollectionViewCell()
    }

}

extension CalcViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        displayItems.remove(at: indexPath.row)
        collectionView.reloadData()
    }
}

extension CalcViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSpacing  = CGFloat(5)
        let numberOfCellsInRow = CGFloat(4)
        let cellWidth = (collectionView.frame.width / numberOfCellsInRow) - (2 * cellSpacing)
        return CGSize(width:cellWidth, height: cellWidth)
    }
}

extension CalcViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == operandTextField {
            let isIntValue = Int(string) != nil
            textField.text = isIntValue ? (textField.text ?? "") + string : textField.text ?? ""
            updateUI()
            return false
        }
        return true
    }
}





