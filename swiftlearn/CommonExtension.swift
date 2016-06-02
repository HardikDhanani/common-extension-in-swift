//
//  NSString+Extension.swift
//  swiftlearn
//
//  Created by mac-0008 on 4/4/16.
//  Copyright © 2016 com.demo. All rights reserved.
//

import Foundation
import UIKit
import Contacts

// MARK: String

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
    
    
    func bundlePath() -> NSString {
        return NSBundle.mainBundle().pathForResource(self, ofType: nil)!
    }
    
    func bundleURLForImage() -> NSURL
    {
        let strbundke = self.bundlePath() as String
        return strbundke.urlForString()
    }
    
    func isServerURL() -> Bool
    {
        if (self.indexOf("http:") == NSNotFound && self.indexOf("https:") == NSNotFound) {
            return false
        }else {
            return true
        }
    }
    
    func indexOf(target: String) -> Int
    {
        return (self as NSString).rangeOfString(target).location
    }
    
    func isLocalURL() -> Bool
    {
        if self.isServerURL() {
            return false
        }else {
            return true
        }
    }
    
    func urlForString() -> NSURL
    {
        if  self.isServerURL() {
            return NSURL.init(string: self)!
        }else{
            return NSURL.fileURLWithPath(self)
        }
    }

    func deleteFileFromPath() -> Void {
        do
        {
            try NSFileManager.defaultManager().removeItemAtPath(self)
        } catch {
            print("nil")
        }
    }
    
    func containsAlphabets() -> Bool {
        //Checks if all the characters inside the string are alphabets
        let set = NSCharacterSet.letterCharacterSet()
        return self.utf16.contains( { return set.characterIsMember($0)  } )
    }
    
    subscript(r: Range<Int>) -> String? {
        get {
            let stringCount = self.characters.count as Int
            if (stringCount < r.endIndex) || (stringCount < r.startIndex) {
                return nil
            }
            let startIndex = self.startIndex.advancedBy(r.startIndex)
            let endIndex = self.startIndex.advancedBy(r.endIndex - r.startIndex)
            return self[(startIndex ..< endIndex)]
        }
    }
}

// MARK: UIColor

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
var datePickerBlock: UInt8 = 0
var dateformat: UInt8 = 0
var datePickerMode: UInt8 = 0
var defaultValue: UInt8 = 0
var minuteInterval: UInt8 = 0
var minimumDate: UInt8 = 0
var maximumDate: UInt8 = 0
var countdownPickerBlock: UInt8 = 0

// MARK: A type for our action block closure

typealias BlockButtonActionBlock = (sender: UIButton) -> Void
typealias BlockAlertBlock = (buttonIndexs: Int) -> Void
typealias PickerSelectRow = (text: String, row: NSInteger, component: NSInteger) -> Void
typealias DatePickerValueChanged = (date: NSDate) -> Void
typealias CountDownPickerValueChanged = (interval: NSTimeInterval) -> Void

typealias ContactsHandler = (contacts : [CNContact] , error : NSError?) -> Void

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
    init(block: PickerSelectRow) {
        self.block = block
    }
}

class DatePickerBlockWrapper : NSObject {
    var block : DatePickerValueChanged
    init(block: DatePickerValueChanged) {
        self.block = block
    }
}

class CountDownPickerBlockWrapper : NSObject {
    var block : CountDownPickerValueChanged
    init(block: CountDownPickerValueChanged) {
        self.block = block
    }
}

// MARK: UIAlertView

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
    
    class func showErrorMessage(message: String) -> Void {
        let alert: UIAlertView = UIAlertView()
        alert.delegate=self
        alert.title = ""
        alert.message = message
        alert.addButtonWithTitle("OK")
        alert.show()
    }
}

// MARK: UIButton

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

var textFieldDatePickerDateFormatter: NSDateFormatter? = nil

// MARK: UITextfield

extension UITextField: UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
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
    
    // Set Toolbar in UITextFiled
    private func pickerToolbar() -> UIToolbar
    {
        let toolbar = UIToolbar(frame: CGRectMake(0, 0, 320, 44))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: #selector(UITextField.didPressPickerDoneButton(_:)))
        toolbar.items = [flexibleSpace, doneButton]
        return toolbar
    }
    
    // Toolbar Ok action
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

    private func setTextFromPickerView() {
        if let selectedRow = pickerView?.selectedRowInComponent(0),
            title = pickerView?.delegate?.pickerView?(pickerView!, titleForRow: selectedRow, forComponent: 0) {
            self.text = title
            let wrapper = objc_getAssociatedObject(self, &SetPickerBlockKey) as! PickerBlockWrapper
            wrapper.block(text: pickerArray()[selectedRow] as! String, row: selectedRow, component: 0)
        }
    }
//
    private func setTextFromDatePicker() {
        self.textFieldDidBeginEditing(self)
        
//        if let date = datePicker?.date {
//            self.text = self.DatePickerDateFormatter().stringFromDate(date)
//        }
    }
    
    // MARK: UIPickerView Method for Drop Down in Text Field
    
    func setPickerData(pickedData: AnyObject, block: PickerSelectRow) -> Void {
        objc_setAssociatedObject(self, &SetPickerBlockKey, PickerBlockWrapper(block: block), objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        self.setPickerData(pickedData, reload: false)
    }
    
    func setPickerDataReloadComponents(pickedData: AnyObject, reload: Bool , block: PickerSelectRow) -> Void {
        objc_setAssociatedObject(self, &SetPickerBlockKey, PickerBlockWrapper(block: block), objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        self.setPickerData(pickedData, reload: reload)
    }
    
    func setPickerData(pickedData: AnyObject, reload: Bool) -> Void {
        objc_setAssociatedObject(self, &SetPickerDataBlockKey, pickedData, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        
        self.delegate = self
        self.inputView = self.textFieldPicker()
        
        print(pickedData)
        
        // App crash below line
        
        //        self.valueForKey("textInputTraits")?.setValue([UIColor .clearColor()], forKey: "insertionPointColor")
        
        if self.isFirstResponder()
        {
            pickerView!.reloadAllComponents()
            self.setInitialSelectedRow()
        }
        
        if reload == true {
            pickerView!.reloadAllComponents()
            self.setInitialSelectedRow()
        }
    }
    
    // Set First Row when textfield is blank
    func setInitialSelectedRow() -> Void
    {
        if self.pickerArray().containsObject(self.text!)
        {
            let index: Int = self.pickerArray().indexOfObject(self.text!)
            pickerView!.selectRow(index, inComponent: 0, animated: false)
            self.text = self.pickerArray().objectAtIndex(index) as? String
        }
    }
    
    // Get Picker Data for perticular text field
    func pickerArray() -> NSArray
    {
        let data = objc_getAssociatedObject(self, &SetPickerDataBlockKey) as! NSArray
        
        if data.isKindOfClass(NSArray)
        {
            return data
        }
        return data
    }
    
    // Return Picker View
    func textFieldPicker() -> UIPickerView
    {
        var onceToken: dispatch_once_t = 0
        dispatch_once(&onceToken, {() -> Void in
            self.pickerView = UIPickerView()
        })
        
        self.pickerView!.dataSource = self
        self.pickerView!.delegate = self
        return self.pickerView!
    }
    
    // MARK: UIDatePicker Countdown Method for Time Interval
    
    func setCountdownPicker(block: CountDownPickerValueChanged) -> Void {
        self.setCountdownPicker(self.textFieldDatePicker().countDownDuration, block: block)
    }
    
    func setCountdownPicker(interval: NSTimeInterval, block: CountDownPickerValueChanged) -> Void {
        
        self.setDatePickerMode(UIDatePickerMode.CountDownTimer)
        
        objc_setAssociatedObject(self, &countdownPickerBlock, CountDownPickerBlockWrapper(block: block) , objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        
        self.delegate = self
        
        self.inputView = self.textFieldDatePicker()
        
        self.setCountDownDuration(interval)
        
    }
    
    // MARK: UIDatePicker Method for Drop Down in Text Field
    
    func setDatePickerWithDateFormat(format : NSString) -> Void {
        self.setDatePickerWithDateFormat(format, date: NSDate())
    }
    
    func setDatePickerWithDateFormat(format: NSString, date: NSDate) -> Void {
        self.setDatePickerWithDateFormat(format, date: date, block: objc_getAssociatedObject(self, &datePickerBlock) as!  DatePickerValueChanged)
    }
    
    func setDatePickerWithDateFormat(format: NSString, date: NSDate, block: DatePickerValueChanged) -> Void
    {
        self.setDatePickerMode(UIDatePickerMode.DateAndTime)
        
        objc_setAssociatedObject(self, &dateformat, format, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        objc_setAssociatedObject(self, &datePickerBlock, DatePickerBlockWrapper(block: block), objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        
        self.delegate = self
        self.inputView = self.textFieldDatePicker()
        
        self.setDate(date)
    }
    
    // MARK: - UIDatePicker Properties
    
    func setMinuteInterval(interval: NSInteger)
    {
        objc_setAssociatedObject(self, &minuteInterval, interval, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
    
        if self.isFirstResponder()
        {
            self.datePicker?.minuteInterval = objc_getAssociatedObject(self, &minuteInterval) as! NSInteger
        }
    }
    
    func setMinimumDate(date: NSDate) -> Void {
    
        objc_setAssociatedObject(self, &minimumDate, date, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
    
        if self.isFirstResponder()
        {
            self.datePicker?.minimumDate = objc_getAssociatedObject(self, &minimumDate) as? NSDate
        }
    }
    
    func setMaximumDate(date: NSDate) -> Void {
        objc_setAssociatedObject(self, &maximumDate, date, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
    
        if self.isFirstResponder()
        {
            self.datePicker?.maximumDate = objc_getAssociatedObject(self, &maximumDate) as? NSDate
        }
    }
    
    func setDatePickerMode(mode: UIDatePickerMode) -> Void {
        
        objc_setAssociatedObject(self, &datePickerMode, mode.hashValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        
        //if self.isFirstResponder() {
            let hasVa : NSInteger = objc_getAssociatedObject(self, &datePickerMode) as! NSInteger
            
            switch hasVa
            {
            case 0:
                self.datePicker?.datePickerMode = UIDatePickerMode.Time
                break
            case 1:
                self.datePicker?.datePickerMode = UIDatePickerMode.Date
                break
            case 2:
                self.datePicker?.datePickerMode = UIDatePickerMode.DateAndTime
                break
            default:
                self.datePicker?.datePickerMode = UIDatePickerMode.CountDownTimer
                break
            }
        //}
    }
    
    func setDate(date: NSDate) -> Void {
        
        objc_setAssociatedObject(self, &defaultValue, date, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        self.text = self.DatePickerDateFormatter().stringFromDate(date)
        
        let wrapper = objc_getAssociatedObject(self, &datePickerBlock) as! DatePickerBlockWrapper
        wrapper.block(date: date)
        
        if self.isFirstResponder() {
            self.datePicker?.date = date
        }
    }
    
    func setCountDownDuration(interval: NSTimeInterval) -> Void {
        
        objc_setAssociatedObject(self, &defaultValue, interval, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        
        let wrapper = objc_getAssociatedObject(self, &countdownPickerBlock) as! CountDownPickerBlockWrapper
        wrapper.block(interval: interval)
        
        if self.isFirstResponder() {
            self.textFieldDatePicker().countDownDuration = interval
        }
    }
    
    func date() -> NSDate {
       return  objc_getAssociatedObject(self, &defaultValue) as! NSDate
    }
    
    func countDownDuration() -> NSTimeInterval {
        return  objc_getAssociatedObject(self, &defaultValue) as! Double
    }
    
    // MARK: UIDatePicker Delegate
    
    func DatePickerDateFormatter() -> NSDateFormatter
    {
        var onceToken: dispatch_once_t = 0
        dispatch_once(&onceToken, {() -> Void in
            textFieldDatePickerDateFormatter = NSDateFormatter()
        })
        
        textFieldDatePickerDateFormatter!.dateFormat = objc_getAssociatedObject(self, &dateformat) as! String
        
        return textFieldDatePickerDateFormatter!
    }
    
    func textFieldDatePicker() -> UIDatePicker {
        
        var onceToken: dispatch_once_t = 0
        dispatch_once(&onceToken , {() -> Void in
            self.datePicker = UIDatePicker()
            self.datePicker!.addTarget(self, action: #selector(UITextField.datePickerValueChanged(_:)), forControlEvents: UIControlEvents.ValueChanged)
            //self.datePicker?.datePickerMode = UIDatePickerMode.Date
        })

        self.datePicker?.timeZone = NSTimeZone.defaultTimeZone()
        
        return self.datePicker!
    }
    
    func datePickerValueChanged(datepicker: UIDatePicker) -> Void {
        
        switch datepicker.datePickerMode
        {
            case UIDatePickerMode.Time:
                    self.setblockforDate(datepicker)
                break
            case UIDatePickerMode.Date:
                    self.setblockforDate(datepicker)
                break
            case UIDatePickerMode.DateAndTime:
                    self.setblockforDate(datepicker)
                break
        default:
            break
        }
        
    }
    
    func setblockforDate(datepicker: UIDatePicker) -> Void {
        objc_setAssociatedObject(self, &defaultValue, datepicker.date, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        self.text = self.DatePickerDateFormatter().stringFromDate(datepicker.date)
        
        let wrapper = objc_getAssociatedObject(self, &datePickerBlock) as! DatePickerBlockWrapper
        wrapper.block(date: datepicker.date)
    }
    
    // Delegate Method for UITextField
    
    public func textFieldDidBeginEditing(textField: UITextField)
    {
        let getClass = textField.inputView
        
        if getClass!.isKindOfClass(UIPickerView)
        {
            print(pickerView)
            self.pickerView!.reloadAllComponents()
            self.setInitialSelectedRow()
        }else if getClass!.isKindOfClass(UIDatePicker)
        {
//           self.textFieldDatePicker().removeTarget(self, action: nil, forControlEvents: UIControlEvents.ValueChanged)
//           self.textFieldDatePicker().addTarget(self, action: #selector(UITextField.datePickerValueChanged(_:)), forControlEvents: UIControlEvents.ValueChanged)
            
           print(objc_getAssociatedObject(self, &datePickerMode))
            
           let hasVa : NSInteger = objc_getAssociatedObject(self, &datePickerMode) as! NSInteger
            
           switch hasVa
           {
                case 0:
                    self.datePicker?.datePickerMode = UIDatePickerMode.Time
                    break
                case 1:
                    self.datePicker?.datePickerMode = UIDatePickerMode.Date
                    break
                case 2:
                    self.datePicker?.datePickerMode = UIDatePickerMode.DateAndTime
                    break
                default:
                    self.datePicker?.datePickerMode = UIDatePickerMode.CountDownTimer
                    break
           }
            
            
//           self.datePicker?.datePickerMode = objc_getAssociatedObject(self, &datePickerMode) as! UIDatePickerMode
            
            switch self.datePicker!.datePickerMode
            {
                case UIDatePickerMode.Time:
                    self.setDatePickerData()
                    break
                case UIDatePickerMode.Date:
                    self.setDatePickerData()
                    break
                case UIDatePickerMode.DateAndTime:
                    self.setDatePickerData()
                    break
                case UIDatePickerMode.CountDownTimer:
                    
                    self.textFieldDatePicker().countDownDuration = self.countDownDuration()
                    
                    break
            }
        }
    }
    
    func setDatePickerData() -> Void {
        
        if (objc_getAssociatedObject(self, &minuteInterval) != nil) {
            self.textFieldDatePicker().minuteInterval = objc_getAssociatedObject(self, &minuteInterval) as! NSInteger
        }
        
        if ((objc_getAssociatedObject(self, &maximumDate) as? NSDate) != nil) {
           self.textFieldDatePicker().maximumDate = objc_getAssociatedObject(self, &maximumDate) as? NSDate
        }
        
        if ((objc_getAssociatedObject(self, &minimumDate) as? NSDate) != nil) {
            self.textFieldDatePicker().minimumDate = objc_getAssociatedObject(self, &minimumDate) as? NSDate
        }
        
        if (objc_getAssociatedObject(self, &defaultValue) != nil) {
            self.textFieldDatePicker().date = (objc_getAssociatedObject(self, &defaultValue) as? NSDate)!
        }else {
            if NSDate().compare((datePicker?.maximumDate)!) == NSComparisonResult.OrderedDescending {
                self.setDate((datePicker?.maximumDate)!)
            }else if NSDate().compare((datePicker?.minimumDate)!) == NSComparisonResult.OrderedAscending {
                self.setDate((datePicker?.minimumDate)!)
            }else{
                self.setDate(NSDate())
            }
            
            self.textFieldDatePicker().date = (objc_getAssociatedObject(self, &defaultValue) as? NSDate)!
        }
    }
    
    // Delagate & DataSource Method for UIPickerView
    
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

// MARK: UIDate 

extension NSDate
{
    var dateFormatter: NSDateFormatter?
        {
        get
        {
            return self.dateFormatter
        }
        set (newValue)
        {
            
        }
    }
    
    class func currentTimestamp() -> NSNumber {
        return NSNumber(double: NSDate().timeIntervalSince1970)
    }
    
    class func currentTimestampString() -> NSString {
        return NSString(format: "%f", NSDate().timeIntervalSince1970)
    }
    
    class func currentTimestampInteger() -> NSInteger {
        return NSDate().timeIntervalSince1970.hashValue
    }
    
    func isFutureDate() -> Bool
    {
        if self.startTimestamp() > NSDate.currentTimestamp().doubleValue {
            return true
        }else {
            return false
        }
    }
    
    func startTimestamp() -> Double
    {
        return self.timestampForStart(true)
    }
    
    func endTimestamp() -> Double
    {
        return self.timestampForStart(false)
    }
    
    func timestampForStart(start: Bool) -> Double
    {
        var onceToken: dispatch_once_t = 0
        dispatch_once(&onceToken , {() -> Void in
            self.dateFormatter = NSDateFormatter()
        })
        
        dateFormatter!.locale = NSLocale(localeIdentifier: "en")
        
        dateFormatter!.timeZone = NSTimeZone(name: "GMT")
        
        dateFormatter!.dateFormat = "yyyy-MM-dd"
        
        let dateString: NSString = dateFormatter!.stringFromDate(self)
        
        dateFormatter!.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let startDate: NSDate
        
        if start {
            startDate = dateFormatter!.dateFromString(dateString.stringByAppendingString(" 00:00:00"))!
        }else {
            startDate = dateFormatter!.dateFromString(dateString.stringByAppendingString(" 23:59:59"))!
        }
        
        return startDate.timeIntervalSince1970
    }
    
    func dateByAddingDay(day: NSInteger) -> NSDate {
        
        let offsetComponents: NSDateComponents = NSDateComponents()
        offsetComponents.day = offsetComponents.day + day
        
        return NSCalendar.currentCalendar().dateByAddingComponents(offsetComponents, toDate: self, options: NSCalendarOptions.init(rawValue: 0))!
    
    }
    
    func dateByAddingMonth(month: NSInteger) -> NSDate {
        
        let offsetComponents: NSDateComponents = NSDateComponents()
        offsetComponents.day = offsetComponents.month + month
        
        return NSCalendar.currentCalendar().dateByAddingComponents(offsetComponents, toDate: self, options: NSCalendarOptions.init(rawValue: 0))!
        
    }
    
    func dateByAddingYear(year: NSInteger) -> NSDate {
        
        let offsetComponents: NSDateComponents = NSDateComponents()
        offsetComponents.day = offsetComponents.year + year
        
        return NSCalendar.currentCalendar().dateByAddingComponents(offsetComponents, toDate: self, options: NSCalendarOptions.init(rawValue: 0))!
        
    }
    
}


// MARK: UIView

extension UIView
{
   class func loadOrInitializeView() -> AnyObject
   {
      var view : AnyObject = self.viewFromXib()
    
      if let b: AnyObject = view {
        view = self.init()
      }

      return view
   }
    
   class func viewFromXib() -> AnyObject
   {
        var bundle: NSArray = NSArray()
    
        if (NSBundle.mainBundle().pathForResource(NSStringFromClass(self), ofType: "nib") != nil) {
            bundle = NSBundle.mainBundle().loadNibNamed(NSStringFromClass(self), owner: nil, options: nil)
        }
    
        if bundle.count > 0
        {
            var view : UIView = bundle.objectAtIndex(0) as! UIView
            if view.isKindOfClass(self) {
                view = UIView(frame: view.frame)
                
                return view
            }
        }
    
        return bundle
   }
    
   class func viewWithNibName(nibName: NSString) -> AnyObject
   {
        let bundle: NSArray = NSBundle.mainBundle().loadNibNamed(nibName as String, owner: nil, options: nil)
        if bundle.count > 0
        {
            var view : UIView = bundle.objectAtIndex(0) as! UIView
            if view.isKindOfClass(self)
            {
                view = UIView(frame: view.frame)
            
                return view
            }
        }
    
        return bundle
   }
}

// MARK: NSDictionary

extension NSDictionary
{
    
   func valueForJSON(key: NSString) -> AnyObject
   {
      let value: AnyObject = self.valueForKey(key as String)!
      return value
   }
    
    func stringValueForJSON(key: NSString) -> NSString
    {
        let value: NSString = self.valueForKey(key as String)! as! NSString
        return value
    }
    
    func numberForJson(key: NSString) -> NSNumber
    {
        return NSNumber(integer: self.stringValueForJSON(key).integerValue)
    }
    
}

// MARK: UIViewController

var contactsStore: CNContactStore?
var orderedContacts = [String: [CNContact]]()
var sortedContactKeys = [String]()

extension UIViewController
{
    // MARK: Get all contacts from address book
    
    func getContacts(completion:  ContactsHandler)
    {
        if contactsStore == nil {
            //ContactStore is control for accessing the Contacts
            contactsStore = CNContactStore()
        }
        let error = NSError(domain: "EPContactPickerErrorDomain", code: 1, userInfo: [NSLocalizedDescriptionKey: "No Contacts Access"])
        
        switch CNContactStore.authorizationStatusForEntityType(CNEntityType.Contacts) {
        case CNAuthorizationStatus.Denied, CNAuthorizationStatus.Restricted:
            //User has denied the current app to access the contacts.
            
            let productName = NSBundle.mainBundle().infoDictionary!["CFBundleName"]!
            
            let alert = UIAlertController(title: "Unable to access contacts", message: "\(productName) does not have access to contacts. Kindly enable it in privacy settings ", preferredStyle: UIAlertControllerStyle.Alert)
            let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: {  action in
                //self.contactDelegate?.epContactPicker!(self, didContactFetchFailed: error)
                completion(contacts: [], error: error)
                self.dismissViewControllerAnimated(true, completion: nil)
            })
            alert.addAction(okAction)
            self.presentViewController(alert, animated: true, completion: nil)
            
        case CNAuthorizationStatus.NotDetermined:
            //This case means the user is prompted for the first time for allowing contacts
            contactsStore?.requestAccessForEntityType(CNEntityType.Contacts, completionHandler: { (granted, error) -> Void in
                //At this point an alert is provided to the user to provide access to contacts. This will get invoked if a user responds to the alert
                if  (!granted ){
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        completion(contacts: [], error: error!)
                    })
                }
                else{
                    self.getContacts(completion)
                }
            })
            
        case  CNAuthorizationStatus.Authorized:
            //Authorization granted by user for this app.
            var contactsArray = [CNContact]()
            
            let contactFetchRequest = CNContactFetchRequest(keysToFetch: allowedContactKeys())
            
            do {
                try contactsStore?.enumerateContactsWithFetchRequest(contactFetchRequest, usingBlock: { (contact, stop) -> Void in
                    //Ordering contacts based on alphabets in firstname
                    contactsArray.append(contact)
                    var key: String = "#"
                    if let firstLetter = contact.givenName[0..<1] where firstLetter.containsAlphabets() {
                        key = firstLetter.uppercaseString
                    }
                    var contacts = [CNContact]()
                    
                    if let segregatedContact = orderedContacts[key] {
                        contacts = segregatedContact
                    }
                    contacts.append(contact)
                    orderedContacts[key] = contacts

                })
                sortedContactKeys = Array(orderedContacts.keys).sort(<)
                if sortedContactKeys.first == "#" {
                    sortedContactKeys.removeFirst()
                    sortedContactKeys.append("#")
                }
                completion(contacts: contactsArray, error: nil)
            }
            //Catching exception as enumerateContactsWithFetchRequest can throw errors
            catch let error as NSError {
                print(error.localizedDescription)
            }
            
        }
    }
    
    func allowedContactKeys() -> [CNKeyDescriptor]{
        // reducing the keys, u can access the faster.
        return [CNContactNamePrefixKey,
                CNContactGivenNameKey,
                CNContactFamilyNameKey,
                CNContactOrganizationNameKey,
                CNContactBirthdayKey,
                CNContactImageDataKey,
                CNContactThumbnailImageDataKey,
                CNContactImageDataAvailableKey,
                CNContactPhoneNumbersKey,
                CNContactEmailAddressesKey,
        ]
    }
}

public class HDContact: NSObject {
   
    public var birthday: NSDate?
    public var birthdayString: String?
    public var contactId: String?
    public var phoneNumbers = [(phoneNumber: String, phoneLabel: String)]()
    public var emails = [(email: String, emailLabel: String )]()
    public var firstName: NSString!
    public var lastName: NSString!
    public var company: NSString!
    public var thumbnailProfileImage: UIImage?
    public var profileImage: UIImage?
    
    override init() {
        super.init()
    }
    
    public func displayName() -> String {
        return "\(firstName) \(lastName)"
    }
    
    public func contactInitials() -> String {
        var initials = String()
        if firstName.length > 0 {
            initials.appendContentsOf(firstName.substringToIndex(1))
        }
        if lastName.length > 0 {
            initials.appendContentsOf(lastName.substringToIndex(1))
        }
        return initials
    }
    
    public init (contact: CNContact)
    {
        super.init()
        
        firstName = contact.givenName
        lastName = contact.familyName
        company = contact.organizationName
        contactId = contact.identifier
        
        if let thumbnailImageData = contact.thumbnailImageData {
            thumbnailProfileImage = UIImage(data:thumbnailImageData)
        }
        
        if let imageData = contact.imageData {
            profileImage = UIImage(data:imageData)
        }
        
        if let birthdayDate = contact.birthday {
            
            birthday = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)?.dateFromComponents(birthdayDate)
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "MMM d"
            birthdayString = dateFormatter.stringFromDate(birthday!)
        }
        
        for phoneNumber in contact.phoneNumbers {
            let phone = phoneNumber.value as! CNPhoneNumber
            phoneNumbers.append((phone.stringValue,phoneNumber.label))
        }
        
        for emailAddress in contact.emailAddresses {
            let email = emailAddress.value as! String
            emails.append((email,emailAddress.label))
        }
    }
    
}


// MARK: Check & Uncheck Button

@IBDesignable
public class OnOffButton: UIButton {
    
    // MARK: Inspectables
    
    @IBInspectable public var lineWidth: CGFloat = 1 {
        didSet {
            updateProperties()
        }
    }
    
    @IBInspectable public var strokeColor: UIColor = UIColor.whiteColor() {
        didSet {
            updateProperties()
        }
    }
    
    @IBInspectable public var ringAlpha: CGFloat = 0.5 {
        didSet {
            updateProperties()
        }
    }
    
    // MARK: Variables
    
    public var checked: Bool = true {
        didSet {
            var strokeStart = CABasicAnimation()
            var strokeEnd = CABasicAnimation()
            if checked {
                let animations = checkedAnimation()
                strokeStart    = animations.strokeStart
                strokeEnd      = animations.strokeEnd
            }
            else {
                let animations = unchekedAnimation()
                strokeStart    = animations.strokeStart
                strokeEnd      = animations.strokeEnd
            }
            onOffLayer.applyAnimation(strokeStart)
            onOffLayer.applyAnimation(strokeEnd)
        }
    }
    
    private var onOffLayer: CAShapeLayer!
    private var ringLayer: CAShapeLayer!
    private let onStrokeStart: CGFloat  = 0.025
    private let onStrokeEnd : CGFloat   = 0.20
    private let offStrokeStart: CGFloat = 0.268
    private let offStrokeEnd: CGFloat   = 1.0
    private let miterLimit: CGFloat     = 10
    
    // MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        updateProperties()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        updateProperties()
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        updateProperties()
    }
    
    // MARK: Layout
    
    private func updateProperties() {
        // using init() will raise CGPostError, lets prevent it
        if bounds == CGRectZero { return }
        
        createLayersIfNeeded()
        if onOffLayer != nil {
            onOffLayer.lineWidth   = lineWidth
            onOffLayer.strokeColor = strokeColor.CGColor
        }
        
        if ringLayer != nil {
            ringLayer.lineWidth   = lineWidth
            ringLayer.strokeColor = ringColorWithAlpha()
        }
    }
    
    // MARK: Layer Set Up
    
    private func createLayersIfNeeded() {
        if onOffLayer == nil {
            onOffLayer = createOnOffLayer()
            layer.addSublayer(onOffLayer)
        }
        
        if ringLayer == nil {
            ringLayer = createRingLayer()
            layer.addSublayer(ringLayer)
        }
    }
    
    private func createOnOffLayer() -> CAShapeLayer {
        let onOffLayer = CAShapeLayer()
        onOffLayer.path = CGPath.rescaleForFrame(OnOff.innerPath, frame: self.bounds)
        
        let strokingPath       = CGPathCreateCopyByStrokingPath(onOffLayer.path, nil, lineWidth, .Round, .Miter, miterLimit)
        onOffLayer.bounds      = CGPathGetPathBoundingBox(strokingPath)
        onOffLayer.position    = CGPoint(x: CGRectGetMidX(onOffLayer.bounds), y: CGRectGetMidY(onOffLayer.bounds))
        onOffLayer.strokeStart = onStrokeStart
        onOffLayer.strokeEnd   = onStrokeEnd
        onOffLayer.strokeColor = strokeColor.CGColor
        setUpShapeLayer(onOffLayer)
        
        return onOffLayer
    }
    
    private func createRingLayer() -> CAShapeLayer {
        let ringLayer = CAShapeLayer()
        let boundsWithInsets  = CGRectInset(onOffLayer.bounds, lineWidth/2, lineWidth/2)
        let ovalPath          = OnOff.ringPathForFrame(boundsWithInsets)
        ringLayer.path        = ovalPath
        ringLayer.bounds      = onOffLayer.bounds
        ringLayer.position    = onOffLayer.position
        ringLayer.strokeColor = ringColorWithAlpha()
        setUpShapeLayer(ringLayer)
        
        return ringLayer
    }
    
    private func setUpShapeLayer(shapeLayer: CAShapeLayer) {
        shapeLayer.fillColor = nil
        shapeLayer.lineWidth = lineWidth
        shapeLayer.miterLimit = miterLimit
        shapeLayer.lineCap = kCALineCapRound
        shapeLayer.masksToBounds = false
    }
    
    private func ringColorWithAlpha() -> CGColor {
        return strokeColor.colorWithAlphaComponent(ringAlpha).CGColor
    }
    
    // MARK: Animations
    
    private func checkedAnimation() -> (strokeStart: CABasicAnimation, strokeEnd: CABasicAnimation) {
        let strokeStart            = CABasicAnimation(keyPath: "strokeStart")
        strokeStart.toValue        = onStrokeStart
        strokeStart.duration       = 0.6
        strokeStart.timingFunction = CAMediaTimingFunction(controlPoints: 0.75, 0.1, 0.50, 1.38)
        
        let strokeEnd            = CABasicAnimation(keyPath: "strokeEnd")
        strokeEnd.toValue        = onStrokeEnd
        strokeEnd.duration       = 0.6
        strokeEnd.timingFunction = CAMediaTimingFunction(controlPoints: 0.75, 0.1, 0.50, 1.38)
        
        return (strokeStart, strokeEnd)
    }
    
    private func unchekedAnimation() -> (strokeStart: CABasicAnimation, strokeEnd: CABasicAnimation) {
        let strokeStart            = CABasicAnimation(keyPath: "strokeStart")
        strokeStart.toValue        = offStrokeStart
        strokeStart.duration       = 0.6
        strokeStart.timingFunction = CAMediaTimingFunction(controlPoints: 0.45, -0.2, 0.8, 0.65)
        
        let strokeEnd            = CABasicAnimation(keyPath: "strokeEnd")
        strokeEnd.toValue        = offStrokeEnd
        strokeEnd.duration       = 0.6
        strokeEnd.timingFunction = CAMediaTimingFunction(controlPoints: 0.45, -0.2, 0.8, 0.65)
        
        return (strokeStart, strokeEnd)
    }
}

// MARK: Path

struct OnOff {
    static var innerPath: CGPath {
        let path = CGPathCreateMutable()
        CGPathMoveToPoint(path, nil, 60.48, 17.5)
        CGPathAddLineToPoint(path, nil, 31.63, 46.34)
        CGPathAddLineToPoint(path, nil, 5.05, 19.76)
        CGPathAddCurveToPoint(path, nil, 13.84, 2.51, 34.92, -4.33, 52.15, 4.44)
        CGPathAddCurveToPoint(path, nil, 69.37, 13.22, 76.22, 34.3, 67.44, 51.53)
        CGPathAddCurveToPoint(path, nil, 58.67, 68.75, 37.59, 75.6, 20.36, 66.82)
        CGPathAddCurveToPoint(path, nil, 3.14, 58.05, -3.71, 36.97, 5.07, 19.74)
        return path
    }
    
    static func ringPathForFrame(frame: CGRect) -> CGPath {
        let outerPath = UIBezierPath(ovalInRect: frame)
        return outerPath.CGPath
    }
}

// MARK: Extensions

extension CALayer {
    func applyAnimation(animation: CABasicAnimation) {
        let copy = animation.copy() as? CABasicAnimation ?? CABasicAnimation()
        if  copy.fromValue == nil,
            let presentationLayer = presentationLayer() {
            copy.fromValue = presentationLayer.valueForKeyPath(copy.keyPath ?? "")
        }
        addAnimation(copy, forKey: copy.keyPath)
        performWithoutAnimation {
            self.setValue(copy.toValue, forKeyPath:copy.keyPath ??  "")
        }
    }
    
    func performWithoutAnimation(closure: Void -> Void) {
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        closure()
        CATransaction.commit()
    }
}

extension CGPath {
    //scaling :http://www.google.com/url?q=http%3A%2F%2Fstackoverflow.com%2Fquestions%2F15643626%2Fscale-cgpath-to-fit-uiview&sa=D&sntz=1&usg=AFQjCNGKPDZfy0-_lkrj3IfWrTGp96QIFQ
    //nice answer from David Rönnqvist!
    class func rescaleForFrame(path: CGPath, frame: CGRect) -> CGPath {
        let boundingBox            = CGPathGetBoundingBox(path)
        let boundingBoxAspectRatio = CGRectGetWidth(boundingBox)/CGRectGetHeight(boundingBox)
        let viewAspectRatio        = CGRectGetWidth(frame)/CGRectGetHeight(frame)
        
        var scaleFactor: CGFloat = 1.0
        if (boundingBoxAspectRatio > viewAspectRatio) {
            scaleFactor = CGRectGetWidth(frame)/CGRectGetWidth(boundingBox)
        } else {
            scaleFactor = CGRectGetHeight(frame)/CGRectGetHeight(boundingBox)
        }
        
        var scaleTransform = CGAffineTransformIdentity
        scaleTransform     = CGAffineTransformScale(scaleTransform, scaleFactor, scaleFactor)
        scaleTransform     = CGAffineTransformTranslate(scaleTransform, -CGRectGetMinX(boundingBox), -CGRectGetMinY(boundingBox))
        let scaledSize     = CGSizeApplyAffineTransform(boundingBox.size, CGAffineTransformMakeScale(scaleFactor, scaleFactor))
        let centerOffset   = CGSizeMake((CGRectGetWidth(frame)-scaledSize.width)/(scaleFactor*2.0), (CGRectGetHeight(frame)-scaledSize.height)/(scaleFactor*2.0))
        scaleTransform     = CGAffineTransformTranslate(scaleTransform, centerOffset.width, centerOffset.height)
        
        if let resultPath = CGPathCreateCopyByTransformingPath(path, &scaleTransform) {
            return resultPath
        }
        
        return path
    }
}

