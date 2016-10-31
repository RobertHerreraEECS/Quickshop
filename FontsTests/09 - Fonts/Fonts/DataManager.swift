    //
    //  DataManager.swift
    //  TopApps
    //
    //  Created by Robert Herrera on 10/6/15.
    //  Copyright (c) 2015 NMSU. All rights reserved.
    //
    
    import Foundation
    
    //private let apiKey: String = "x9f4hry2s9b5hw743cub4xk3"
    
    //var searchQuery: String = "The iron man"
    //
    //var urlCompatibleString = searchQuery.stringByReplacingOccurrencesOfString(" ", withString: "+", options: NSStringCompareOptions.LiteralSearch, range: nil)
    
    
    
    var WalMartSearchForProduct = "http://api.walmartlabs.com/v1/search?query=apple&format=json&apiKey=x9f4hry2s9b5hw743cub4xk3"
    
    var Aisle411SearchForLocalProduct = "http://crater.aisle411.com/webservices2/getstoreswithproduct.php?device_token=51d8001769aa2d97b23cbe61900b3f92fdccac72&latitude=38.6537065&longitude=-90.2477908&term=cereal&distance=10&max_stores=10&partner_id=47&auth=f945e100a1a46f620cfb814fcff634d1"
    
    class DataManager {
        
        class func getUpdatedSearchURLwithQuery(url: String){
            WalMartSearchForProduct = url
        }
        
        
        class func getSearchQueryDataFromWalMartWithSuccess(success: ((WalMartData: NSData!) -> Void)) {
            //1
            
            
            loadDataFromURL(NSURL(string: WalMartSearchForProduct)!, completion:{(data, error) -> Void in
                //2
                if let urlData = data {
                    //3
                    success(WalMartData: urlData)
                }
            })
        }
        
        class func getSearchQueryDataAisle411WithSuccess(success: ((Aisle411: NSData!) -> Void)) {
            //1
            
            
            loadDataFromURL(NSURL(string: Aisle411SearchForLocalProduct)!, completion:{(data, error) -> Void in
                //2
                if let AisleurlData = data {
                    //3
                    success(Aisle411: AisleurlData)
                }
            })
        }
        
        
        
        class func getTopAppsDataFromFileWithSuccess(success: ((data: NSData) -> Void)) {
            //1
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
                //2
                let filePath = NSBundle.mainBundle().pathForResource("WalMartItemScope",ofType:"json")
                
                var readError:NSError?
                if let data = NSData(contentsOfFile:filePath!,
                    options: NSDataReadingOptions.DataReadingUncached,
                    error:&readError) {
                        success(data: data)
                }
            })
        }
        
        
        
        class func loadDataFromURL(url: NSURL, completion:(data: NSData?, error: NSError?) -> Void) {
            var session = NSURLSession.sharedSession()
            
            
            // Use NSURLSession to get data from an NSURL
            let loadDataTask = session.dataTaskWithURL(url, completionHandler: { (data: NSData!, response: NSURLResponse!, error: NSError!) -> Void in
                if let responseError = error {
                    completion(data: nil, error: responseError)
                } else if let httpResponse = response as? NSHTTPURLResponse {
                    if httpResponse.statusCode != 200 {
                        var statusError = NSError(domain:"com.robert", code:httpResponse.statusCode, userInfo:[NSLocalizedDescriptionKey : "HTTP status code has unexpected value."])
                        completion(data: nil, error: statusError)
                    } else {
                        completion(data: data, error: nil)
                    }
                }
            })
            
            loadDataTask.resume()
        }
    }