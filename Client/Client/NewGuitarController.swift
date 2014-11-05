//
//  NewGuitarController.swift
//  Client
//
//  Created by Dalton Cherry on 11/4/14.
//  Copyright (c) 2014 vluxe. All rights reserved.
//

import UIKit

protocol NewDelegate {
    func didCreateGuitar(guitar: Guitar)
}
class NewGuitarController: UIViewController {
    
    var delegate: NewDelegate?
    let colors = ["Black", "Red", "Blue", "Green", "White"]
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var brandTextField: UITextField!
    @IBOutlet weak var yearTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var pickerWheel: UIPickerView!
    
    //cancel creating a new guitar
    @IBAction func CloseModal(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    //save the guitar
    @IBAction func Save(sender: UIBarButtonItem) {
        let color = colors[pickerWheel.selectedRowInComponent(0)]
        var price = 200
        if let p = priceTextField.text.toInt() {
            price = p
        }
        let guitar = Guitar(name: nameTextField.text, brand: brandTextField.text, year: yearTextField.text, price: price, color: color, imageUrl: "")
        self.delegate?.didCreateGuitar(guitar)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //MARK - Picker Wheel Delegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if textField.tag != 3 {
            let tag = textField.tag+1
            let txtField = self.view.viewWithTag(tag) as? UITextField
            if let field = txtField {
                field.becomeFirstResponder()
                saveButton.enabled = true
            }
        }
        return true
    }
    
    //MARK - Picker Wheel Delegate
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return colors.count
    }
    
    func pickerView(pickerView: UIPickerView,rowHeightForComponent component: Int) -> CGFloat {
        return 30
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return colors[row]
    }
    
}
