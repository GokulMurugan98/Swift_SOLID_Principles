//
//  NetworkManager.swift
//  SOLIDprinciples
//
//  Created by Gokul Murugan on 26/04/24.
//

import Foundation

//MARK: SOLID Principles

enum NetworkManagerError:Error{
    case UnableToParseURL
    case UnableToDecodeJSON
    case UnableToFetchData
    case UnknownError
    case UnableToLoadFromLocale
}
//In this code the Network Manager is doing 4 Tasks:
// 1. Sending data to closuer to pass around
// 2. Sending Request
// 3. Fetching Data
// We can modify this to


//MARK: Basic Code to fetch Data
//class NetworkManager{
//    func fetchAPI(urlString:String, completion: @escaping (Result<ModelClass,NetworkManagerError>) -> Void){
//        guard let url = URL(string: urlString) else {return}
//        let task = URLSession.shared.dataTask(with: url) { Dt, Response, Er in
//            if Er != nil {
//                completion(.failure(.UnableToParseURL))
//            }
//            guard let dataToParse =  Dt else{
//                completion(.failure(.UnableToFetchData))
//                return
//            }
//            
//            do {
//                let fetchedData = try JSONDecoder().decode(ModelClass.self, from: dataToParse)
//                completion(.success(fetchedData))
//            } catch{
//                completion(.failure(.UnableToDecodeJSON))
//            }
//        }
//        task.resume()
//    }
//}

//MARK: Single Responsibility Principle - a class has to have only one responsibility or action.
//For example this class NetworkManager should only have responsibility to process the calls and everything to do with Network calls and stuff.
//class NetworkManager{
//    let request = RequestHandler()
//    let decodeData = DataDecoder()
//    func fetchAPI(urlString:String, completion: @escaping (Result<[User],NetworkManagerError>) -> Void){
//        request.sendRequest(with: urlString) {[weak self] result in
//            switch result{
//            case .success(let requestData):
//                self?.decodeData.handleData(data: requestData, completion: { request in
//                    switch request{
//                    case .success(let userData):
//                        completion(.success(userData))
//                    case .failure(let error):
//                        completion(.failure(error))
//                    }
//                })
//            case .failure(let error):
//                completion(.failure(error))
//            }
//        }
//       
//    }
//}
//
//class RequestHandler{
//    func sendRequest(with urlString:String, completion:@escaping (Result<Data, NetworkManagerError>) -> Void){
//        guard let url = URL(string: urlString) else {return}
//        URLSession.shared.dataTask(with: url) { Dt, Response, Er in
//            if Er != nil {
//                completion(.failure(.UnableToParseURL))
//            }
//            guard let dataToParse =  Dt else{
//                completion(.failure(.UnableToFetchData))
//                return
//            }
//            completion(.success(dataToParse))
//        }.resume()
//    }
//}
//
//class DataDecoder{
//    let decoder = JSONDecoder()
//    func handleData(data:Data, completion:@escaping (Result<[User], NetworkManagerError>) -> Void){
//        do {
//            let decodedData = try decoder.decode(ModelClass.self, from: data)
//            completion(.success(decodedData.data))
//        } catch {
//            completion(.failure(.UnableToDecodeJSON))
//        }
//    }
//    
//}


//MARK: Open and Close Principle - Every function and class should be open for implemetation and Adaptation and Closed for Modification. This basically means the classes should do their set tasks regardless of the data types changes. We can achieve this easily by Generics.
//class NetworkManager{
//    let request = RequestHandler()
//    let decodeData = DataDecoder()
//    func fetchAPI<T:Codable>(type: T.Type,urlString:String, completion: @escaping (Result<T,NetworkManagerError>) -> Void){
//        request.sendRequest(with: urlString) {[weak self] result in
//            switch result{
//            case .success(let requestData):
//                self?.decodeData.handleData(type: type, data: requestData, completion: { result in
//                    switch result {
//                    case .success(let decodedData):
//                        completion(.success(decodedData))
//                    case .failure(let error):
//                        completion(.failure(error))
//                    }
//                })
//            case .failure(let error):
//                completion(.failure(error))
//            }
//        }
//       
//    }
//}
//
//class RequestHandler{
//    func sendRequest(with urlString:String, completion:@escaping (Result<Data, NetworkManagerError>) -> Void){
//        guard let url = URL(string: urlString) else {return}
//        URLSession.shared.dataTask(with: url) { Dt, Response, Er in
//            if Er != nil {
//                completion(.failure(.UnableToParseURL))
//            }
//            guard let dataToParse =  Dt else{
//                completion(.failure(.UnableToFetchData))
//                return
//            }
//            completion(.success(dataToParse))
//        }.resume()
//    }
//}
//
//class DataDecoder{
//    let decoder = JSONDecoder()
//    func handleData<T:Codable>(type: T.Type, data:Data, completion:@escaping (Result<T, NetworkManagerError>) -> Void){
//        do {
//            let decodedData = try decoder.decode(type.self, from: data)
//            completion(.success(decodedData))
//        } catch {
//            completion(.failure(.UnableToDecodeJSON))
//        }
//    }
//    
//}

//MARK: Liskov Substitution Principle - We should not break the defult implementation of a Super class but we can overrise it. It simply means we have to use the super class (Protocol) methods to do its specfied tasks only.
//
//MARK:Super Class for Both NetworkManager and LocalFileManager
//protocol DataHandlerDelegate{
//    func fetchAPI<T:Codable>(type: T.Type,urlString:String, completion: @escaping (Result<T,NetworkManagerError>)->Void)
//}
//
// Both the classes are confirming to it and adding the methode in the scope. They both are only doing the tasks that are supposed to be done. They do not do any other tasks that they are not supposed to do and Thus it follows Liskov's Substitution Principle. We can modify the code like instead fetch API  checking for data to retrive it can do some other tasks like frtching and filtering data.
//class NetworkManager:DataHandlerDelegate{
//    let request = RequestHandler()
//    let decodeData = DataDecoder()
//    func fetchAPI<T:Codable>(type: T.Type,urlString:String, completion: @escaping (Result<T,NetworkManagerError>) -> Void){
//        request.sendRequest(with: urlString) {[weak self] result in
//            switch result{
//            case .success(let requestData):
//                self?.decodeData.handleData(type: type, data: requestData, completion: { result in
//                    switch result {
//                    case .success(let decodedData):
//                        completion(.success(decodedData))
//                    case .failure(let error):
//                        completion(.failure(error))
//                    }
//                })
//            case .failure(let error):
//                completion(.failure(error))
//            }
//        }
//       
//    }
//}
// Both the classes are confirming to it and adding the methode in the scope. They both are only doing the tasks that are supposed to be done. They do not do any other tasks that they are not supposed to do and Thus it follows Liskov's Substitution Principle. We can modify the code like instead fetch API checking for data to retrive it can do some other tasks like frtching and filtering data.
//class LocalFileManager:DataHandlerDelegate{
//    let decodeData = DataDecoder()
//    func fetchAPI<T:Codable>(type: T.Type,urlString:String, completion: @escaping (Result<T,NetworkManagerError>) -> Void){
//        guard
//            let url = Bundle.main.url(forResource: "Employee", withExtension: "json"),
//            let data = try? Data(contentsOf: url) else {
//            completion(.failure(.UnableToLoadFromLocale))
//            return
//        }
//        decodeData.handleData(type: type, data: data, completion: { result in
//            switch result {
//            case .success(let decodedData):
//                completion(.success(decodedData))
//            case .failure(let error):
//                completion(.failure(error))
//            }
//        })
//        
//    }
//}
//
//class RequestHandler{
//    func sendRequest(with urlString:String, completion:@escaping (Result<Data, NetworkManagerError>) -> Void){
//        guard let url = URL(string: urlString) else {return}
//        URLSession.shared.dataTask(with: url) { Dt, Response, Er in
//            if Er != nil {
//                completion(.failure(.UnableToParseURL))
//            }
//            guard let dataToParse =  Dt else{
//                completion(.failure(.UnableToFetchData))
//                return
//            }
//            completion(.success(dataToParse))
//        }.resume()
//    }
//}
//
//class DataDecoder{
//    let decoder = JSONDecoder()
//    func handleData<T:Codable>(type: T.Type, data:Data, completion:@escaping (Result<T, NetworkManagerError>) -> Void){
//        do {
//            let decodedData = try decoder.decode(type.self, from: data)
//            completion(.success(decodedData))
//        } catch {
//            completion(.failure(.UnableToDecodeJSON))
//        }
//    }
//    
//}


//MARK: Interface Segrigation Principle - The class should confirm to protocols that are absolutely necessary for the class else it should not confirm to it.
//If the Super Class has 2 methods. Network Manager requires both the function in order to run properly but the LocalFileManager Class doesn't need Check for internet function because it has no purpose in it. so we have to create a protocol for every method that associates the function.

//From
//protocol DataHandlerDelegate{
//    func fetchAPI<T:Codable>(type: T.Type,urlString:String, completion: @escaping (Result<T,NetworkManagerError>)->Void)
//    func checkForInternet()
//}

////To
//protocol APIHandlerDelegate{
//    func fetchAPI<T:Codable>(type: T.Type,urlString:URL, completion: @escaping (Result<T,NetworkManagerError>)->Void)
//}
//
//protocol InternetCheckDelegate{
//    func checkForInternet()
//}
//
//// Here the class Network handler has to check for internet in order to make an API call so the method is absolutely necessary for this class
//// After changing the protocol it will look something like
////MARK: class NetworkManager:DataHandlerDelegate{
//// To
//class NetworkManager:APIHandlerDelegate,InternetCheckDelegate{
//    let request = RequestHandler()
//    let decodeData = DataDecoder()
//    var internet:Bool = false
//    init(){
//        checkForInternet()
//    }
//    func fetchAPI<T:Codable>(type: T.Type,urlString:URL, completion: @escaping (Result<T,NetworkManagerError>) -> Void){
//        request.sendRequest(with: urlString) {[weak self] result in
//            switch result{
//            case .success(let requestData):
//                self?.decodeData.handleData(type: type, data: requestData, completion: { result in
//                    switch result {
//                    case .success(let decodedData):
//                        completion(.success(decodedData))
//                    case .failure(let error):
//                        completion(.failure(error))
//                    }
//                })
//            case .failure(let error):
//                completion(.failure(error))
//            }
//        }
//    }
//    
//    func checkForInternet(){
//        self.internet = true
//    }
//    
//}
//// In Local File Manager the function CheckForInternet is not needed so if we apply Interface Segregation Principle the we have to create something from
//// MARK: class LocalFileManager:DataHandlerDelegate{
////To
//
//class LocalFileManager:APIHandlerDelegate{
//    let decodeData = DataDecoder()
//    func fetchAPI<T:Codable>(type: T.Type,urlString:URL, completion: @escaping (Result<T,NetworkManagerError>) -> Void){
//        guard
//            let url = Bundle.main.url(forResource: "Employee", withExtension: "json"),
//            let data = try? Data(contentsOf: url) else {
//            completion(.failure(.UnableToLoadFromLocale))
//            return
//        }
//        decodeData.handleData(type: type, data: data, completion: { result in
//            switch result {
//            case .success(let decodedData):
//                completion(.success(decodedData))
//            case .failure(let error):
//                completion(.failure(error))
//            }
//        })
//        
//    }
//}
//
//class RequestHandler{
//    func sendRequest(with urlString:URL, completion:@escaping (Result<Data, NetworkManagerError>) -> Void){
//        URLSession.shared.dataTask(with: urlString) { Dt, Response, Er in
//            if Er != nil {
//                completion(.failure(.UnableToParseURL))
//            }
//            guard let dataToParse =  Dt else{
//                completion(.failure(.UnableToFetchData))
//                return
//            }
//            completion(.success(dataToParse))
//        }.resume()
//    }
//}
//
//class DataDecoder{
//    let decoder = JSONDecoder()
//    func handleData<T:Codable>(type: T.Type, data:Data, completion:@escaping (Result<T, NetworkManagerError>) -> Void){
//        do {
//            let decodedData = try decoder.decode(type.self, from: data)
//            completion(.success(decodedData))
//        } catch {
//            completion(.failure(.UnableToDecodeJSON))
//        }
//    }
//    
//}


//MARK: Dependency Inversion Principle - The Parent should should not depend on any of the child class for execution.

protocol APIHandlerDelegate{
    func fetchAPI<T:Codable>(type: T.Type,urlString:URL, completion: @escaping (Result<T,NetworkManagerError>)->Void)
}

protocol InternetCheckDelegate{
    func checkForInternet()
}
class NetworkManager:APIHandlerDelegate,InternetCheckDelegate{
    // Here the NetworkManager class is dependent on both RequestHandler and DataDecoder classes. This can cause problem while testing.
//    let request = RequestHandler()
//    let decodeData = DataDecoder()
//      We can change like the below to follow the principle
    
    let request:RequestHandlerDelegate = RequestHandler()
    let decodeData:DataDecoderDelegate = DataDecoder()
    var internet:Bool = false
    init(){
        checkForInternet()
    }
    func fetchAPI<T:Codable>(type: T.Type,urlString:URL, completion: @escaping (Result<T,NetworkManagerError>) -> Void){
        request.sendRequest(with: urlString) {[weak self] result in
            switch result{
            case .success(let requestData):
                self?.decodeData.handleData(type: type, data: requestData, completion: { result in
                    switch result {
                    case .success(let decodedData):
                        completion(.success(decodedData))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                })
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func checkForInternet(){
        self.internet = true
    }
    
}
// In Local File Manager the function CheckForInternet is not needed so if we apply Interface Segregation Principle the we have to create something from
// MARK: class LocalFileManager:DataHandlerDelegate{
//To

class LocalFileManager:APIHandlerDelegate{
    let decodeData:DataDecoderDelegate = DataDecoder()
    func fetchAPI<T:Codable>(type: T.Type,urlString:URL, completion: @escaping (Result<T,NetworkManagerError>) -> Void){
        guard
            let url = Bundle.main.url(forResource: "Employee", withExtension: "json"),
            let data = try? Data(contentsOf: url) else {
            completion(.failure(.UnableToLoadFromLocale))
            return
        }
        decodeData.handleData(type: type, data: data, completion: { result in
            switch result {
            case .success(let decodedData):
                completion(.success(decodedData))
            case .failure(let error):
                completion(.failure(error))
            }
        })
        
    }
}

//We can create a delegate and ask the Request Handler class to confirm to the delegate so that the parent class can create a object of this delegate and use all of the classes that confirms to this delegate instead of depending on the RequestHandler class itself.
protocol RequestHandlerDelegate{
    func sendRequest(with urlString:URL, completion:@escaping (Result<Data, NetworkManagerError>) -> Void)
}

class RequestHandler:RequestHandlerDelegate{
    func sendRequest(with urlString:URL, completion:@escaping (Result<Data, NetworkManagerError>) -> Void){
        URLSession.shared.dataTask(with: urlString) { Dt, Response, Er in
            if Er != nil {
                completion(.failure(.UnableToParseURL))
            }
            guard let dataToParse =  Dt else{
                completion(.failure(.UnableToFetchData))
                return
            }
            completion(.success(dataToParse))
        }.resume()
    }
}
//Same instructions apply for this class as well.

protocol DataDecoderDelegate{
    func handleData<T:Codable>(type: T.Type, data:Data, completion:@escaping (Result<T, NetworkManagerError>) -> Void)
}

class DataDecoder:DataDecoderDelegate{
    let decoder = JSONDecoder()
    func handleData<T:Codable>(type: T.Type, data:Data, completion:@escaping (Result<T, NetworkManagerError>) -> Void){
        do {
            let decodedData = try decoder.decode(type.self, from: data)
            completion(.success(decodedData))
        } catch {
            completion(.failure(.UnableToDecodeJSON))
        }
    }
    
}

/*
 //MARK: Thus our code follows all the S.O.L.I.D principles.
 */
