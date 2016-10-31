//
//  FindMyStoreViewController.swift
//  Fonts
//
// Created by Robert Herrera on 10/12/15.
//  Copyright (c) 2015 QuickShop All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


struct stores {
    var  name: String
    var  coordinates = [Double]()
    var  streetAddress : String
    var  zip : String
    var image: Bool = true
}


class FindMyStoreViewController: UIViewController,CLLocationManagerDelegate, MKMapViewDelegate,UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var StorePicker: UIPickerView!
    
    @IBOutlet weak var pickerLabel: UILabel!
    
    @IBOutlet weak var locationButton: UIButton!
    
    @IBOutlet weak var searchText: UITextField!
    
    @IBAction func userSearchText(sender: UITextField) {
        sender.resignFirstResponder()
        if(CLLocationManager.locationServicesEnabled()){
            
            self.locationManager.delegate = self
            self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
            

            sender.hidden = false
            self.mapView.hidden = false
            pickerLabel.hidden = false
            self.StorePicker.hidden = false
            
            // load surrouding stores
            var temp2 = " "
            
            if Int(sender.text!) != nil {
                
                temp2 = WalmartStoreLocatoreAPI.StoreLocatorAPIUsingZip(sender.text!)
                
            } else {
                
                temp2 =  WalmartStoreLocatoreAPI.StoreLocatorAPIUsingCity(sender.text!)
            }
            
            // UserInput = temp2
            
            DataManager.getUpdatedSearchURLwithQuery(temp2)
            DataManager.getSearchQueryDataFromWalMartWithSuccess { (ItemQueryData) -> Void in
                let json = JSON(data: ItemQueryData)
                
                
                
                if let searchItemCategories = json.array {
                    
                    
                    for searchItemInfo in searchItemCategories {
                        
                        
                        var tempData = [( " ", [0.000000, 0.000000], " ", " "), ( " ", [0.000000, 0.000000], " ", " "), ( " ", [0.000000, 0.000000], " ", " "),( " ", [0.000000, 0.000000], " ", " ")]
                        
                        var myVals = [0.00,0.00]
                        
                        if let itemName = searchItemInfo["name"].string {
                            tempData[0] = ( itemName, [0.000000, 0.000000], " ", " ")
                        }
                        if let coordinates = searchItemInfo["coordinates"].array {
                            var tempIndex = 0
                            for vals in coordinates {
                                
                                if let nums = vals.double {
                                    myVals[tempIndex] = nums
                                }
                                tempIndex++
                            }
                            tempData[1] = ( " ", myVals, " " , " ")
                            
                        }
                        if let city = searchItemInfo["streetAddress"].string {
                            tempData[2] = ( " ", [0.000000, 0.000000], city , " ")
                            
                        }
                        if let zip = searchItemInfo["zip"].string {
                            tempData[3] = ( " ", [0.000000, 0.000000], " " , zip)
                        }
                        
                        
                        LoadWalMartStoreAvailable.StoreArrayByTuple(tempData[0].0, Coordinates: tempData[1].1, StreetAddress:  tempData[2].2, Zip: tempData[3].3)
                        
                        PreferredStore.sharedInstance.currentStore.append(stores(name: tempData[0].0, coordinates: tempData[1].1, streetAddress: tempData[2].2, zip: tempData[3].3, image: false))
                        
                    }// end for loop
                    
                    
                }// end for in
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.StorePicker.reloadAllComponents()
                    self.StorePicker.reloadInputViews()
                })
                
                
                let currentLong =  PreferredStore.sharedInstance.currentStore[0].coordinates[0]
                
                
                let currLong =  Double(currentLong)
        
                let currentLat =   PreferredStore.sharedInstance.currentStore[0].coordinates[1]
                let currLat =  Double(currentLat)
                
                let LongitudeCll: CLLocationDegrees = currLong
                let LatitudeCll: CLLocationDegrees = currLat
                
                let dxLong : CLLocationDegrees = 0.03
                let dxLat : CLLocationDegrees = 0.03
                
                let span : MKCoordinateSpan = MKCoordinateSpanMake(dxLong, dxLat)
                
                let desiredLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(LatitudeCll, LongitudeCll)
                
                let displayedRegion : MKCoordinateRegion = MKCoordinateRegionMake(desiredLocation, span)
                
                self.mapView.setRegion(displayedRegion, animated: true)
                
            } // end dataManager
            
            //Get specific item query search from Wal-Mart and SwiftyJSON
            
        } else {
            
            let title = "Current Location"
            let message = "Location Services are not enabled."
            let okText = "OK"
            
            let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
            let okayButton = UIAlertAction(title: okText, style: .Cancel, handler: nil)
            alert.addAction(okayButton)
            presentViewController(alert, animated: true, completion: nil)
        } // end if
        
        
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.StorePicker.reloadAllComponents()
        })
    }
    
    @IBAction func backgroundTouched(sender: UIControl) {
        searchText.resignFirstResponder()
    }
    
    
    
    
    var newData = Array<(name: String, coordinates: Array<Double>, streetAddress: String,zip: String)>()
    
    
    var pickerData:[String] = [String]()
    
    
    @IBAction func UseMyLocation(sender: UIButton) {
        

        
        if(CLLocationManager.locationServicesEnabled()){
            sender.hidden = false
            self.mapView.hidden = false
            
            
            let location = locationManager.location
            
            if location == nil {
                let title = "Current Location not valid."
                let message = " "
                let okText = "OK"
                
                let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
                let okayButton = UIAlertAction(title: okText, style: .Cancel, handler: nil)
                alert.addAction(okayButton)
                presentViewController(alert, animated: true, completion: nil)
            }
            
            let currentLong =   location!.coordinate.longitude
            let currLong =  Double(currentLong)
            let Longitude = String(stringInterpolationSegment: currLong)
            
            
            print("\(Longitude)\n")
            
            let currentLat =   location!.coordinate.latitude
            let currLat =  Double(currentLat)
            let Latitude = String(stringInterpolationSegment: currLat)
            
            let LongitudeCll: CLLocationDegrees = currLong
            let LatitudeCll: CLLocationDegrees = currLat
            
            let dxLong : CLLocationDegrees = 0.03
            let dxLat : CLLocationDegrees = 0.03
            
            
            let span : MKCoordinateSpan = MKCoordinateSpanMake(dxLong, dxLat)
            
            let desiredLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(LatitudeCll, LongitudeCll)
            
            
            let displayedRegion : MKCoordinateRegion? = MKCoordinateRegionMake(desiredLocation, span)
            
            self.mapView.setRegion(displayedRegion!, animated: true)
            
            pickerLabel.hidden = false
            
            self.StorePicker.hidden = false
            
            // load surrouding stores
            let temp2 = WalmartStoreLocatoreAPI.StoreLocatorAPIUsingLatAndLong(Latitude, Longitude: Longitude)
            // UserInput = temp2
            print("1111\(temp2)")
            
            DataManager.getUpdatedSearchURLwithQuery(temp2)
            DataManager.getSearchQueryDataFromWalMartWithSuccess { (ItemQueryData) -> Void in
                let json = JSON(data: ItemQueryData)
                
                
                
                if let searchItemCategories = json.array {
                    
                    
                    for searchItemInfo in searchItemCategories {
                        
                        
                        var tempData = [( " ", [0.000000, 0.000000], " ", " "), ( " ", [0.000000, 0.000000], " ", " "), ( " ", [0.000000, 0.000000], " ", " "),( " ", [0.000000, 0.000000], " ", " ")]
                        
                        
                        
                        if let itemName = searchItemInfo["name"].string {
                            tempData[0] = ( itemName, [0.000000, 0.000000], " ", " ")
                        }
                        if let coordinates = searchItemInfo["coordinates"].double {
                            tempData[1] = ( " ", coordinates.description.propertyList() as! Array<Double>, " ", " ")
                        }
                        if let city = searchItemInfo["streetAddress"].string {
                            tempData[2] = ( " ", [0.000000, 0.000000], city , " ")
                            
                        }
                        if let zip = searchItemInfo["zip"].string {
                            tempData[3] = ( " ", [0.000000, 0.000000], " " , zip)
                        }
                        
                        LoadWalMartStoreAvailable.StoreArrayByTuple(tempData[0].0, Coordinates: tempData[1].1, StreetAddress:  tempData[2].2, Zip: tempData[3].3)
                        
                        
                    }// end for loop
                    
                    
                }// end for in
                print("\n\n **  \(LoadWalMartStoreAvailable.ReturnStoreItems().count)  ** \n\n")
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.StorePicker.reloadAllComponents()
                })
            } // end dataManager
            
            //Get specific item query search from Wal-Mart and SwiftyJSON
            
            
        } else {
            
            let title = "Current Location"
            let message = "Location Services are not enabled."
            let okText = "OK"
            
            let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
            let okayButton = UIAlertAction(title: okText, style: .Cancel, handler: nil)
            alert.addAction(okayButton)
            presentViewController(alert, animated: true, completion: nil)
        } // end if
        
        
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.StorePicker.reloadAllComponents()
        })
        
    }
    
    
    
    @IBAction func didFinish(sender: UIButton) {
        let temp = self.StorePicker.selectedRowInComponent(0)
        
        let title = "Preferred Store"
        let message = "\(LoadWalMartStoreAvailable.ReturnStoreItems()[temp].streetAddress) selected as preferred store."
        let okText = "OK"
        PreferredStore.sharedInstance.preferredStore.removeAll(keepCapacity: false)
        PreferredStore.sharedInstance.preferredStore.append(stores(name: LoadWalMartStoreAvailable.ReturnStoreItems()[temp].name, coordinates: LoadWalMartStoreAvailable.ReturnStoreItems()[temp].coordinates, streetAddress: LoadWalMartStoreAvailable.ReturnStoreItems()[temp].streetAddress, zip: LoadWalMartStoreAvailable.ReturnStoreItems()[temp].zip, image: false))
        
        
        if PreferredStore.sharedInstance.preferredStore[0].zip == imageGuideLibrary().imagesAvailable[0] {
            PreferredStore.sharedInstance.preferredStore[0].image = true
        } // if Map guide image exists
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let okayButton = UIAlertAction(title: okText, style: .Cancel, handler: nil)
        alert.addAction(okayButton)
        presentViewController(alert, animated: true, completion: nil)
    }
    
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.StorePicker.reloadAllComponents()
            self.StorePicker.reloadInputViews()
        })
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return LoadWalMartStoreAvailable.ReturnStoreItems().count
    }
    
    
    func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return CGFloat(70)
    }
    func pickerView(pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return CGFloat(320)
    }
    
    func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let main_string = LoadWalMartStoreAvailable.ReturnStoreItems()[row].streetAddress
        let string_to_color = LoadWalMartStoreAvailable.ReturnStoreItems()[row].streetAddress
        
        let range = (main_string as NSString).rangeOfString(string_to_color)
        let attributedString = NSMutableAttributedString(string:main_string)
        attributedString.addAttribute(NSForegroundColorAttributeName, value:UIColor(white: CGFloat(100), alpha: CGFloat(1)) , range: range)
        attributedString.addAttribute(NSFontAttributeName, value: UIFont(
            name: "Chalkduster",
            size: 20.0)!, range: NSMakeRange(0, attributedString.length))
        
        return attributedString
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapView.hidden = true
        //StorePicker.hidden = true
        pickerLabel.hidden = true
        self.StorePicker.delegate = self
        self.StorePicker.dataSource = self
        self.StorePicker.hidden = true
        // self.StorePicker.makeTextWritingDirectionLeftToRight(self)
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        
        self.locationManager.startUpdatingLocation()
        
        
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.StorePicker.reloadAllComponents()
            self.StorePicker.reloadInputViews()
        })
        // Do any additional setup after loading the view.
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        self.StorePicker.reloadInputViews()
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        CLGeocoder().reverseGeocodeLocation(manager.location!, completionHandler: { (placemarks,error)-> Void in
            
            
            if (error != nil) {
                print("Error: \(error!.localizedDescription)")
                return
            }
            
            if placemarks!.count > 0 {
                let pm  = placemarks![0] as CLPlacemark
                self.displayLocationInfo(pm)
                
            } else {
                print("error with data")
            }
            
        })
        
        
        
        
        
    }
    
    func displayLocationInfo(placemark: CLPlacemark) {
        
        self.locationManager.stopUpdatingLocation()
        
        print(placemark.locality)
        print(placemark.location!.description)
        print(placemark.postalCode)
        print(placemark.administrativeArea)
        print(placemark.country)
        
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("error: \(error.localizedDescription)")
    }
    
    
    
}
