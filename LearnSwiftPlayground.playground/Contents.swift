//: Playground - noun: a place where people can play

import UIKit
import XCPlayground

XCPlaygroundPage.currentPage.needsIndefiniteExecution = true

let userId = "3a4a932f-693c-49f1-bc22-3701ff7189ab"
let session = NSURLSession.sharedSession()
let baseURL = "http://10.16.0.194:8883/v1/"

func register() {
    
    if let url = NSURL(string: "\(baseURL)register?userName=SwiftUser") {
        
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        
        session.dataTaskWithRequest(request, completionHandler: { (data, response, error) in
            
            guard error == nil else {
                
                print("Error: \(error)")
                return
            }
            
            print("response = \(response)")
            print("data = \(data)")
            
            guard let data = data else {
                
                print("Error: data was nil")
                return
            }
            
            var json: AnyObject?
            
            do {
                json = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
                
                print("json: \(json)")
                
            }
            catch {
                // JSON Parsing error
                print("Error parsing data: \(error)")
                
            }
            
        }).resume()
    }
    else {
        
        print("url was nil")
    }
}

//register()

func excavate(userId: String, completionHandler: (bucketID: String?) -> Void) {
    
    if let url = NSURL(string: "\(baseURL)excavate") {
        
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        
        session.dataTaskWithRequest(request, completionHandler: { (data, response, error) in
            
            
            guard error == nil else {
                
                print("Error: \(error)")
                completionHandler(bucketID: nil)
                return
            }
            
            print("response = \(response)")
            print("data = \(data)")
            
            guard let data = data else {
                
                print("Error: data was nil")
                completionHandler(bucketID: nil)
                return
            }
            
            var json: AnyObject?
            
            do {
                json = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
                
                print("json: \(json)")
                
                let bucketID = json?["bucketId"] as? String
                
                completionHandler(bucketID: bucketID)
                
            }
            catch {
                // JSON Parsing error
                print("Error parsing data: \(error)")
                completionHandler(bucketID: nil)
            }
        }).resume()
    }
}

func store(userID: String, bucketID: String) {

    if let url = NSURL(string: "\(baseURL)store?userId=\(userId)&bucketId=\(bucketID)") {
        
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        
        session.dataTaskWithRequest(request, completionHandler: { (data, response, error) in
            
            
            guard error == nil else {
                
                print("Error: \(error)")
                return
            }
            
            print("response = \(response)")
            print("data = \(data)")
            
            guard let data = data else {
                
                print("Error: data was nil")
                return
            }
            
            print("\(NSString.init(data: data, encoding: NSUTF8StringEncoding))")
            
        }).resume()
    }
}

excavate(userId) { (bucketID) in

    guard let bucketID = bucketID else {

        print("Error: bucketID was nil")
        return
    }

    print("BucketID = \(bucketID)")

    store(userId, bucketID: bucketID)
}




