//
//  ViewController.swift
//  Request2
//
//  Created by Tatsuya Moriguchi on 1/5/22.
//  Copyright © 2022 Tatsuya Moriguchi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let url = "https://api.sunrise-sunset.org/json?date=2020-01-01&lat=-74.0060&lng=40.7128&formatted=0"
        
        getData(from: url)

    }
    
    private func getData(from url: String) {
        URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { data, response, error
            in
            guard let data = data, error == nil else {
                print("Something went wrong.")
                return }
            
            var result: Response?
            do {
                result = try JSONDecoder().decode(Response.self, from: data)
            } catch {
                print("Failed to convert \(error.localizedDescription)")
                
            }
            guard let json = result else { return }
            
            print(json.status)
            print(json.results.sunset)
            print(json.results.astronomical_twilight_begin)
            print(json.results.astronomical_twilight_end)
            print(json.results.civil_twilight_begin)
            print(json.results.civil_twilight_end)
            print(json.results.day_length)
            print(json.results.nautical_twilight_begin)
            print(json.results.nautical_twilight_end)
            print(json.results.solar_noon)
            print(json.results.sunrise)
            print(json.results.sunset)
            
            }).resume()
        
    }

    

}

struct Response: Codable {
    let results: MyResult
    let status: String
}

struct MyResult: Codable {
    let sunrise: String
    let sunset: String
    let solar_noon: String
    let day_length: Int
    let civil_twilight_begin: String
    let civil_twilight_end: String
    let nautical_twilight_begin: String
    let nautical_twilight_end: String
    let astronomical_twilight_begin: String
    let astronomical_twilight_end: String

}




/*
 {"results":
 
    {
     "sunrise":"6:00:36 AM",
     "sunset":"6:10:11 PM",
     "solar_noon":"12:05:23 PM",
     "day_length":"12:09:35",
     "civil_twilight_begin":"5:39:23 AM",
     "civil_twilight_end":"6:31:23 PM",
     "nautical_twilight_begin":"5:13:20 AM",
     "nautical_twilight_end":"6:57:27 PM",
     "astronomical_twilight_begin":"4:47:11 AM",
     "astronomical_twilight_end":"7:23:36 PM"
 
    },
 "status":"OK"
 }
 
 */

