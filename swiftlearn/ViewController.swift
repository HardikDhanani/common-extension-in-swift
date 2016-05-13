//
//  ViewController.swift
//  swiftlearn
//
//  Created by mac-0008 on 3/21/16.
//  Copyright © 2016 com.demo. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UICollisionBehaviorDelegate {
    var animator: UIDynamicAnimator!
    var gravity: UIGravityBehavior!
    var collision: UICollisionBehavior!
    
    @IBOutlet var buttont: UIButton!
    @IBOutlet var touc: UIButton!
    
    @IBOutlet var txtDateDropDown: UITextField!
    @IBOutlet var txtDropdown: UITextField!
    @IBOutlet var txtDropdown2: UITextField!
    @IBOutlet var but: UIButton!
    
    var square: UIView!
    var snap: UISnapBehavior!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        let MyString = "Hardik2014.mi@gmail."
        let chkemail = MyString.isValidEmailAddress(MyString)
        
        if(chkemail == false)
        {
            
        }
        
        print(MyString)
        
        typealias Feet = Int
        let distance: Feet = 100
        print(distance)
        
        let varA = 42
        print(varA)
        
        var varB:Float64
        varB = 3.14159
        print(varB)
        
        
        let varAB = "Godzilla"
        let varBC = 1000.00
        
        print("Value of \(varAB) is more than \(varBC) millions")
        
        var myString:String? = nil
        
        myString = "Hello, Swift!"
        
        if myString != nil {
            print(myString!)
        }else{
            print("myString has nil value")
        }
        

        if let yourString = myString {
            print("Your string has - \(yourString)")
        }else{
            print("Your string does not have a value")
        }
        
        //var arrData = [Int](count: 3, repeatedValue: 0)
        var arrData = [Int]()
        
        arrData.append(1)
        arrData.append(2)
        arrData.append(3)

    
        struct MarksStruct {
            var mark: Int
            
            init(mark: Int) {
                self.mark = mark
            }
        }
        let aStruct = MarksStruct(mark: 98)
        var bStruct = aStruct // aStruct and bStruct are two structs with the same value!
        bStruct.mark = 97
        print(aStruct.mark) // 98
        print(bStruct.mark) // 97
        
        
        
        view.backgroundColor = UIColor.fromRgbHex(585752)
        
        var cheDate:String = "1461569062"
        cheDate = cheDate.durationString("1461569062")
        print("\(cheDate)")
        
        let alert:UIAlertView = UIAlertView()
        alert.title = "Alert"
        alert.message = "Hi, r u there!"
        alert.addButtonWithTitle("Ok")
        alert.addButtonWithTitle("Cancel")
        alert.show { (buttonIndexs) in
            
        }
        
        NSLog("%@", NSLocalizedString("HelloKey", comment: "sdfdsfdf"))
        
        touc.touchUpInsideClicked({ (sender) in
            
        }); 
        
        buttont.touchUpInsideClicked({ (sender) in
            
        });
        
        but.touchUpInsideClicked({ (sender) in
            
        });
        
        let pickerDataSource: NSArray = ["White", "Red", "Green", "Blue"]
        let pickerDataSource2: NSArray = ["1", "2", "3", "4"]
        
        txtDateDropDown.set
        
        txtDropdown.setPickerData(pickerDataSource) { (text, row, component) in
        }
        
        txtDropdown2.setPickerData(pickerDataSource2) { (text, row, component) in
        }
        
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


