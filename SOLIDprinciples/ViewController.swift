//
//  ViewController.swift
//  SOLIDprinciples
//
//  Created by Gokul Murugan on 26/04/24.
//

import UIKit

class ViewController: UIViewController {
    
    let service = NetworkManager()
    let locale = LocalFileManager()
    //https://dummy.restapiexample.com/api/v1/employee/1
    override func viewDidLoad() {
        super.viewDidLoad()
        makeAPICall(url: "https://dummy.restapiexample.com/api/v1/employee/1")
    }
    
    private func makeAPICall(url:String){
        guard let url = Bundle.main.url(forResource: "Employee", withExtension: "json") else {return}
        locale.fetchAPI(type: ModelClass.self, urlString: url, completion: { result in
            switch result{
            case .success(let data):
//                print(data.data.employee_name)
//                print(data.data.employee_age)
                
                for d in data.data{
                    print(d.employee_name)
                }
            case .failure(let er):
                print(er)
                
            }
        })
    }
}

