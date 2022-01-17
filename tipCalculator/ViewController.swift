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
    @IBOutlet var tipTextFieldAndSliderContainer: UIStackView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        keyboardHasShown()
        adjustTipPercentage.minimumValue = 0
        adjustTipPercentage.maximumValue = 100
        adjustTipPercentage.value = 50
        tipTextFieldAndSliderContainer.isHidden = true
    }

    @IBAction func calculateTip(_ sender: UIButton) {
        calculate()
    }
    
    @IBAction func slideValueChanged(_ sender: UISlider) {
        tipPercentageTextField.text = String(format: "%.f", sender.value) + "%"
        calculate()
    }
    
    @IBAction func billTextFillChanged(_ sender: UITextField) {
        guard tipAmountLabel.text != "" else { return }
        calculate()
    }
    
    @IBAction func tipPercentTextFieldChanged(_ sender: UITextField) {
        guard tipPercentageTextField.text != "" else { return }
        adjustTipPercentage.value = Float(tipPercentageTextField.text!.replacingOccurrences(of: "%", with: ""))!
        calculate()
    }
    
    func calculate(){
        guard let bill = billAmountTextField.text, billAmountTextField.text != "" else { return }
        guard var percent = tipPercentageTextField.text, tipPercentageTextField.text != "" else {
            let defaultTip = Float(bill)! * 0.15
            tipAmountLabel.text = "$" + String(format: "%.f",defaultTip)
            tipTextFieldAndSliderContainer.isHidden = false
            tipPercentageTextField.text = "15%"
            adjustTipPercentage.value = 15
            return
        }
        percent = percent.replacingOccurrences(of: "%", with: "")
        tipAmountLabel.text = "$" + String(format: "%.f", Float(bill)! * (Float(percent)! / 100))
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
