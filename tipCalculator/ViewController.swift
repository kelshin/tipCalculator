//
//  ViewController.swift
//  tipCalculator
//
//  Created by Kelbin David on 2022-01-13.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var billAmountTextField: UITextField!
    @IBOutlet var tipAmountLabel: UILabel!
    @IBOutlet var tipPercentageTextField: UITextField!
    @IBOutlet var myScrollView: UIScrollView!
    @IBOutlet var adjustTipPercentage: UISlider!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        keyboardHasShown()
        adjustTipPercentage.minimumValue = 0
        adjustTipPercentage.maximumValue = 100
        adjustTipPercentage.value = 50
    }

    @IBAction func calculateTip(_ sender: UIButton) {
        calculate()
    }
    
    @IBAction func slideValueChanged(_ sender: UISlider) {
        tipPercentageTextField.text = String(format: "%.f", sender.value)
        guard validateIfTipHadBeenCalculated() else { return }
        calculate()
    }
    
    @IBAction func billTextFillChanged(_ sender: UITextField) {
        guard validateIfTipHadBeenCalculated() else { return }
        calculate()
    }
    
    @IBAction func tipPercentTextFieldChanged(_ sender: UITextField) {
        guard validateIfTipHadBeenCalculated() else { return }
        calculate()
    }
    
    func validateIfTipHadBeenCalculated() -> Bool {
        if tipAmountLabel.text != "" {
            return true
        } else {
            return false
        }
    }
    
    func calculate(){
        guard let amount = tipPercentageTextField.text, tipPercentageTextField.text != "" else { return }
        adjustTipPercentage.value = Float(amount)!
        if billAmountTextField.text != "" && tipPercentageTextField.text != "" {
            let amount = Double(billAmountTextField.text!)! * Double(tipPercentageTextField.text!)!
            tipAmountLabel.text = "$" + String(format: "%.f", amount / 100)
        }
    }
    
    func keyboardHasShown(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown(_:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasHidden(_:)), name: UIResponder.keyboardDidHideNotification, object: nil )
    }
    
    @objc func keyboardWasShown(_ notification: NSNotification){
        guard let info = notification.userInfo, let keyboardFrameValue = info[ UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue else { return }
        let keyboardFrame = keyboardFrameValue.cgRectValue
        let keyboardSize = keyboardFrame.size
        myScrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        myScrollView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
    }
    
    @objc func keyboardWasHidden(_ notification: NotificationCenter){
        myScrollView.contentInset = .zero
    }
}
