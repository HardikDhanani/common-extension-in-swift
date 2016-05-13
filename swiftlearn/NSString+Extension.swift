//
//  NSString+Extension.swift
//  swiftlearn
//
//  Created by mac-0008 on 4/4/16.
//  Copyright © 2016 com.demo. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    // MARK: Valid Email Address Check in Swift
    func isValidEmailAddress(emailID: String) -> Bool
    {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluateWithObject(emailID)
        return result
    }
    
    // MARK: Check Blank Space & New Line in Swift
    func isBlankValidationPassed() -> Bool
    {
        let check: NSString = self.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        if (check.length > 0) {
            return true
        }
        
        return false
    }
    
    
    // MARK: Replace String in Swift
    func replace(target: String, withString: String) -> String {
        return self.stringByReplacingOccurrencesOfString(target, withString: withString)
    }
    
    // MARK: Convert NSTime Interval to String in Swift
    func durationString(duration: String) -> String
    {
        let calender:NSCalendar = NSCalendar.currentCalendar()
        let unitFlag:NSCalendarUnit = [.Year, .Month, .Day, .Hour, .Minute]
        
        let Options:NSCalendarOptions = NSCalendarOptions()
        
        let fromDate:NSDate = NSDate()
        
        let dateComponents:NSDateComponents = calender.components(unitFlag, fromDate: fromDate, toDate: NSDate(timeIntervalSince1970: Double(duration)!), options: Options)
        
        let years:NSInteger = dateComponents.year
        let months:NSInteger = dateComponents.month
        let days:NSInteger = dateComponents.day
        let hours:NSInteger = dateComponents.hour
        let minutes:NSInteger = dateComponents.minute
        
        var durations:NSString = "Just Now"
        
        if (years > 0)
        {
            durations = "\(years) years ago"
        }
        else if (months > 0)
        {
            durations = "\(months) months ago"
        }
        else if (days > 0)
        {
            durations = "\(days) days ago"
        }
        else if (hours > 0)
        {
            durations = "\(hours) hrs ago"
        }
        else if (minutes > 0)
        {
            durations = "\(minutes) mins ago"
        }
        
        return durations as String;
    }
}


extension UIColor {
    
    // MARK: Convert Hexa to RGBA in Swift
    class func fromRgbHex(fromHex: Int) -> UIColor {
        
        let red =   CGFloat((fromHex & 0xFF0000) >> 16) / 0xFF
        let green = CGFloat((fromHex & 0x00FF00) >> 8) / 0xFF
        let blue =  CGFloat(fromHex & 0x0000FF) / 0xFF
        let alpha = CGFloat(1.0)
        
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    class func customGreenColor() -> UIColor {
        
        let darkGreen = 0x008110
        return UIColor.fromRgbHex(darkGreen)
    }
}


// MARK: All Keys of Handler
var ActionBlockKey: UInt8 = 0
var AlertBlockKey: UInt8 = 0
var SetPickerBlockKey: UInt8 = 0
var SetPickerDataBlockKey: UInt8 = 0

//var c1 : WeightWheelController!


// MARK: A type for our action block closure
typealias BlockButtonActionBlock = (sender: UIButton) -> Void
typealias BlockAlertBlock = (buttonIndexs: Int) -> Void
typealias PickerSelectRow = (text: String, row: NSInteger, component: NSInteger) -> Void

// MARK: Convert all action block closure to variable object
class ActionBlockWrapper : NSObject
{
    var block : BlockButtonActionBlock
    init(block: BlockButtonActionBlock)
    {
        self.block = block
    }
}

class AlertBlockWrapper : NSObject
{
    var block : BlockAlertBlock
    init(block: BlockAlertBlock)
    {
        self.block = block
    }
}

class SetpickerDelegate : NSObject
{
    var block : UIPickerView
    init(block: UIPickerView)
    {
        self.block = block
    }
}

class PickerBlockWrapper : NSObject {
    var block : PickerSelectRow
    var picker : UIPickerView = UIPickerView()
    
    var textfiled : UITextField = UITextField()
    init(block: PickerSelectRow) {
        self.block = block
    }
}


extension UIAlertView
{
    func show(clicked: BlockAlertBlock) -> Void
    {
        self.show()
        objc_setAssociatedObject(self, &AlertBlockKey, AlertBlockWrapper(block: clicked), objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        self.delegate = self
    }
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int)
    {
        let wrapper = objc_getAssociatedObject(self, &AlertBlockKey) as! AlertBlockWrapper
        wrapper.block(buttonIndexs: buttonIndex)
    }
}

extension UIButton
{
    func touchUpInsideClicked(block: BlockButtonActionBlock)
    {
        objc_setAssociatedObject(self, &ActionBlockKey, ActionBlockWrapper(block: block), objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        addTarget(self, action: #selector(UIButton.block_handleAction(_:)), forControlEvents: .TouchUpInside)
    }
    
    func block_handleAction(sender: UIButton)
    {
        let wrapper = objc_getAssociatedObject(self, &ActionBlockKey) as! ActionBlockWrapper
        wrapper.block(sender: sender)
    }
}

@objc protocol MyTextFieldDelegateProtocol: UITextFieldDelegate {}

extension MyTextFieldDelegateProtocol
{
    func textFieldDidBeginEditing(textField: UITextField)
    {
        print("shouldChangeCharactersInRange called")
    }
}

extension UITextField: UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource {
    
    /// The `UIPickerView` for the text field. Set this to configure the `inputView` and `inputAccessoryView` for the text field.
    public var pickerView: UIPickerView?
    {
        get
        {
            return self.inputView as? UIPickerView
        }
        set
        {
            setInputViewToPicker(newValue)
        }
    }
    
    /// The `UIDatePicker` for the text field. Set this to configure the `inputView` and `inputAccessoryView` for the text field.
    public var datePicker: UIDatePicker?
    {
        get
        {
            return self.inputView as? UIDatePicker
        }
        set
        {
            setInputViewToPicker(newValue)
        }
    }
    
    private func setInputViewToPicker(picker: UIView?) {
        self.inputView = picker
        self.inputAccessoryView = picker != nil ? pickerToolbar() : nil
    }
    
    private func pickerToolbar() -> UIToolbar
    {
        let toolbar = UIToolbar(frame: CGRectMake(0, 0, 320, 44))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: "didPressPickerDoneButton:")
        toolbar.items = [flexibleSpace, doneButton]
        return toolbar
    }
    
    /// The formatting string to use to set the text field's `text` when using the `datePicker`.
    /// See `NSDateFormatter` for more information
    /// Defaults to "M/d/yy"
    public var dateFormat: String
    {
        get
        {
            return objc_getAssociatedObject(self, &AssociatedKeys.DateFormat) as? String ?? "M/d/yy"
        }
        set
        {
            objc_setAssociatedObject(self, &AssociatedKeys.DateFormat, newValue as NSString, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    private struct AssociatedKeys {
        static var DateFormat = "am_DateFormat"
    }
    
//    /**
//     This method is called when the "Done" button on the `inputAccessoryView` toolbar is pressed.
//     
//     :discussion: This method will set the text field's text with the title for the selected row in the `pickerView` in component `0` from the `pickerView`'s `delegate.
//     
//     - parameter sender: The "Done" button sending the action.
//     */
    public func didPressPickerDoneButton(sender: AnyObject) {
        guard pickerView != nil || datePicker != nil else { return }
        
        if pickerView != nil {
            setTextFromPickerView()
            
        } else if datePicker != nil {
            setTextFromDatePicker()
        }
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.sendActionsForControlEvents(.EditingChanged)
        })
        resignFirstResponder()
    }
//
    private func setTextFromPickerView() {
        if let selectedRow = pickerView?.selectedRowInComponent(0),
            title = pickerView?.delegate?.pickerView?(pickerView!, titleForRow: selectedRow, forComponent: 0) {
            self.text = title
        }
    }
//
    private func setTextFromDatePicker() {
        if let date = datePicker?.date {
            let formatter = NSDateFormatter()
            formatter.dateFormat = dateFormat
            self.text = formatter.stringFromDate(date)
        }
    }

    
    func setPickerData(pickedData: AnyObject, block: PickerSelectRow) -> Void {
        objc_setAssociatedObject(self, &SetPickerBlockKey, PickerBlockWrapper(block: block), objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        self.setPickerData(pickedData)
    }
    
    func setPickerData(pickedData: AnyObject) -> Void {
        objc_setAssociatedObject(self, &SetPickerDataBlockKey, pickedData, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        
        self.delegate = self
        self.inputView = self.textFieldPicker()
//        self.valueForKey("textInputTraits")?.setValue([UIColor .clearColor()], forKey: "insertionPointColor")
    
        if self.isFirstResponder()
        {
//            pickerView!.reloadAllComponents()
            self.setInitialSelectedRow()
        }
    }
    
    func setInitialSelectedRow() -> Void
    {
        if self.pickerArray().containsObject(self.text!)
        {
            let index: Int = self.pickerArray().indexOfObject(self.text!)
            pickerView!.selectRow(index, inComponent: 0, animated: false)
            self.text = self.pickerArray().objectAtIndex(index) as? String
        }
//        else if self.pickerArray().count > 0
//        {
//            pickerView!.selectRow(0, inComponent: 0, animated: false)
//            self.text = self.pickerArray().objectAtIndex(0) as? String
//        }
    }
    
    func pickerArray() -> NSArray
    {
        let data = objc_getAssociatedObject(self, &SetPickerDataBlockKey) as! NSArray
        
        if data.isKindOfClass(NSArray)
        {
            return data
        }
        return data
    }
    
    func textFieldPicker() -> UIPickerView
    {
        self.pickerView = UIPickerView()
//        c1 = WeightWheelController(pickerInterval: self.pickerArray(), txtField:self,picker: self.pickerView!)
        self.pickerView!.dataSource = self
        self.pickerView!.delegate = self
//        c1.pickerViewData.reloadAllComponents()
        return self.pickerView!
    }
    
    public func textFieldDidBeginEditing(textField: UITextField)
    {
        if ((textField.inputView?.isKindOfClass(UIPickerView)) != nil)
        {
            print(pickerView)
//            let vc = WeightWheelController(pickerInterval: self.pickerArray(), txtField:textField,picker: self.pickerView!)
            self.pickerView!.reloadAllComponents()
            self.setInitialSelectedRow()
        }
    }
    
//    let ElementCount: NSArray!
//    let txtDta:UITextField!
//    let pickerViewData:UIPickerView!
//    
//    init(pickerInterval: NSArray, txtField: UITextField, picker: UIPickerView)
//    {
//        ElementCount = pickerInterval
//        txtDta = txtField
//        pickerViewData = picker
//    }
    
    public func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    public func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return pickerArray().count
    }
    
    public func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return pickerArray()[row] as? String
    }
    
    public func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        let wrapper = objc_getAssociatedObject(self, &SetPickerBlockKey) as! PickerBlockWrapper
        wrapper.block(text: pickerArray()[row] as! String, row: row, component: component)
        self.text = pickerArray()[row] as? String
    }
}

func setDatePickerWithDateFormate(formate: String) -> Void
{
    
}

func setDatePickerWithDateFormate(formate: String, defaultDate:NSDate) -> Void {
    
}

//class WeightWheelController: NSObject, UIPickerViewDelegate, UIPickerViewDataSource
//{
//    let ElementCount: NSArray!
//    let txtDta:UITextField!
//    let pickerViewData:UIPickerView!
//    
//    init(pickerInterval: NSArray, txtField: UITextField, picker: UIPickerView)
//    {
//        ElementCount = pickerInterval
//        txtDta = txtField
//        pickerViewData = picker
//    }
//    
//    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int
//    {
//        return 1
//    }
//    
//    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
//    {
//        return ElementCount.count
//    }
//    
//    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
//    {
//        return ElementCount[row] as? String
//    }
//    
//    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
//    {
//        let wrapper = objc_getAssociatedObject(txtDta, &SetPickerBlockKey) as! PickerBlockWrapper
//        wrapper.block(text: ElementCount[row] as! String, row: row, component: component)
//        txtDta.text = ElementCount[row] as? String
//    }
//}
