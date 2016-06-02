//
//  ViewController.swift
//  swiftlearn
//
//  Created by mac-0008 on 3/21/16.
//  Copyright © 2016 com.demo. All rights reserved.
//

import UIKit
import CoreLocation

class HomeController: UIViewController, UICollisionBehaviorDelegate {
    var animator: UIDynamicAnimator!
    var gravity: UIGravityBehavior!
    var collision: UICollisionBehavior!
    
    @IBOutlet var buttont: UIButton!
    @IBOutlet var touc: UIButton!
    
    @IBOutlet var txtDateDropDown: UITextField!
    @IBOutlet var txtDropdown: UITextField!
    @IBOutlet var txtDropdown2: UITextField!
    @IBOutlet var but: OnOffButton!
    
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
        
        
        
        //view.backgroundColor = UIColor.fromRgbHex(585752)
        
        var cheDate:String = "1461569062"
        cheDate = cheDate.durationString("1461569062")
        print("\(cheDate)")
        
//        let alert:UIAlertView = UIAlertView()
//        alert.title = "Alert"
//        alert.message = "Hi, r u there!"
//        alert.addButtonWithTitle("Ok")
//        alert.addButtonWithTitle("Cancel")
//        alert.show { (buttonIndexs) in
//            
//        }
        
        NSLog("%@", NSLocalizedString("HelloKey", comment: "sdfdsfdf"))
        
        touc.touchUpInsideClicked({ (sender) in
            
        }); 
        
        buttont.touchUpInsideClicked({ (sender) in
            
        });
        
        but.touchUpInsideClicked({ (sender) in
            self.but.checked = !self.but.checked
        });
        
        let pickerDataSource: NSArray = ["White", "Red", "Green", "Blue"]
        let pickerDataSource2: NSArray = ["1", "2", "3", "4"]
        
        txtDropdown.setPickerData(pickerDataSource) { (text, row, component) in
        }
        
        txtDropdown2.setPickerData(pickerDataSource2) { (text, row, component) in
        }
        
        
        
        txtDateDropDown.setDatePickerWithDateFormat("dd MMM yyyy", date: NSDate()) { (date) in
            
        }
        
        txtDateDropDown.setDatePickerMode(UIDatePickerMode.Date)
        
        self.getContacts { (contacts, error) in
            for contact in contacts {
                let Temp: HDContact = HDContact(contact: contact)
                print(Temp.displayName())
            }
        }
        
    
        LocationManager.shared.observeLocations(.Block, frequency: .Continuous , onSuccess: { location in
            // location contain your CLLocation object
            
            print(location)
            NSLog("location %@", location)
            
        }) { error in
            // Something went wrong. error will tell you what
        }
        
        
        LocationManager.shared.locateByIPAddress(onSuccess: { placemark in
            // placemark is a valid CLPlacemark object
            print(placemark)
            NSLog("placemark %@", placemark)
            
        }) { error in
            // something wrong has occurred; error will tell you what
        }
        
        
        LocationManager.shared.observeHeading(onSuccess: { heading in
            // a valid CLHeading object is returned
            
            NSLog("Heading %@", heading)
            
        }) { error in
            // something wrong has occurred
        }
        
        
        let address = "1 Infinite Loop, Cupertino (USA)"
        LocationManager.shared.reverseAddress(address: address, onSuccess: { foundPlacemark in
            // foundPlacemark is a CLPlacemark object
            
            NSLog("foundPlacemark %@", foundPlacemark)
            
        }) { error in
            // failed to reverse geocoding due to an error
        }
        
        let coordinates = CLLocationCoordinate2DMake(41.890198, 12.492204)
        // Use Google service to obtain placemark
        LocationManager.shared.reverseLocation(service: .Google, coordinates: coordinates, onSuccess: { foundPlacemark in
            // foundPlacemark is a CLPlacemark object
            
            NSLog("foundPlacemark1 %@", foundPlacemark)
            
        }) { error in
            // failed to reverse geocoding
        }
        
        LocationManager.shared.observeInterestingPlaces { newVisit in
            // a new CLVisit object is returned
            
            NSLog("newVisit %@", newVisit)
            
        }
    }
    
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


