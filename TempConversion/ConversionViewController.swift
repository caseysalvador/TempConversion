//
//  ConversionViewController.swift
//  TempConversion
//
//  Created by Casey Chad Salvador on 3/2/17.
//  Copyright © 2017 Casey Chad Salvador. All rights reserved.
//

import UIKit


class ConversionViewControll: UIViewController, UITextFieldDelegate {
    
    override func viewDidLoad() { //override viewDidLoad to load "???" for Celsius
        super.viewDidLoad()
        
        updateCelsiusLabel()
    }
    
    @IBOutlet var celsiusLabel: UILabel! // assign UILabel to celsiusLabel
    @IBOutlet var textField: UITextField! // assign UITextField to textField
    
    var fahrenheitValue: Measurement<UnitTemperature>? { // optional measurement for temperature
        didSet { //property observer gets called after property value has changed.
            updateCelsiusLabel()
        }
    }
    
    
    let numberFormatter: NumberFormatter = { // format number to display no more than one fractional digit
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.maximumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf
    }() // using a closure to instantiate the number formatter
    
    
    var celsiusValue: Measurement<UnitTemperature>? { // F to Celsius Conversion
        if let fahrenheitValue = fahrenheitValue {
            return fahrenheitValue.converted(to: .celsius)
        } else {
            return nil
        }
    }
    
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        print("Current text: \(textField.text)")
        print("Replacement text: \(string)")
        
        return true
    }
    
    
    func updateCelsiusLabel() { //
        if let celsiusValue = celsiusValue {
            //celsiusLabel.text = "\(celsiusValue.value)" // we re-format celsiusLabel to use numberFormatter
            celsiusLabel.text = numberFormatter.string(from: NSNumber(value: celsiusValue.value))
        } else {
            celsiusLabel.text = "???"
        }
    }
    
    
    @IBAction func fahrenheitFieldEditingChanged(_ textField: UITextField) {
//        celsiusLabel.text = textField.text // set celsiusLabel = to text in UITextField of fahrenheit
        
        // if text field has text and is not empty let celsiusLabel = to UITextField, if empty return ???
//        if let text = textField.text, !text.isEmpty {
//            celsiusLabel.text = text
//        } else {
//            celsiusLabel.text = "???"
//        }
        
        if let text = textField.text, let value = Double(text) {
            fahrenheitValue = Measurement(value: value, unit: .fahrenheit)
        } else {
            fahrenheitValue = nil
        }
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        textField.resignFirstResponder() // this function will dismiss the keyboard when tapping the screen
    }
    
}
