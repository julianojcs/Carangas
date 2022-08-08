//
//  CarAPI.swift
//  Carangas
//
//  Created by Juliano Costa Silva on 08/08/22.
//

import Foundation

enum APIError: Error {
    case badURL
    case taskError
    case noResponse
    case invalidStatusCode(Int)
    case noData
    case decodeError
}

class CarAPI {
    let basePath = "https://carangas.herokuapp.com/cars"
    let configuration: URLSessionConfiguration = {
        let configuration = URLSessionConfiguration.default
        configuration.allowsCellularAccess = true
        configuration.timeoutIntervalForRequest = 60
        configuration.httpAdditionalHeaders = ["Content-type": "application/json"]
        configuration.httpMaximumConnectionsPerHost = 5
        
        return configuration
    }()
    lazy var session = URLSession(configuration: configuration)
    
    func loadCars(onComplete: @escaping (Result<[Car], APIError>) -> Void) {
        guard let url = URL(string: basePath) else {
            onComplete(.failure(.badURL))
            return
        }
        let task = session.dataTask(with: url) { data, response, error in
            if error != nil{
                onComplete(.failure(.taskError))
                return
            }
            guard let response = response as? HTTPURLResponse else {
                onComplete(.failure(.noResponse))
                return
            }
            if response.statusCode != 200 {
                onComplete(.failure(.invalidStatusCode(response.statusCode)))
                return
            }
            guard let data = data else {
                onComplete(.failure(.noData))
                return
            }
            do {
                let cars = try JSONDecoder().decode([Car].self, from: data)
                onComplete(.success(cars))
            } catch {
                onComplete(.failure(.decodeError))
            }
        }
        task.resume()
    }
    
    func createCar(_ car: Car, onComplete: @escaping (Result<Void, APIError>) -> Void ) {
        request("POST", car: car, onComplete: onComplete)
    }
    
    func updateCar(_ car: Car, onComplete: @escaping (Result<Void, APIError>) -> Void ) {
        request("PUT", car: car, onComplete: onComplete)
    }
    
    func deleteCar(_ car: Car, onComplete: @escaping (Result<Void, APIError>) -> Void ) {
        request("DELETE", car: car, onComplete: onComplete)
    }
    
    func request(_ httpMethod: String, car: Car, onComplete: @escaping (Result<Void, APIError>) -> Void ) {
        let urlString = basePath + "/" + (car._id ?? "")

        guard let url = URL(string: urlString) else {
            onComplete(.failure(.badURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        request.httpBody = try? JSONEncoder().encode(car)
        
        session.dataTask(with: request) { data, response, error in
            if error != nil{
                onComplete(.failure(.taskError))
                return
            }
            guard let response = response as? HTTPURLResponse else {
                onComplete(.failure(.noResponse))
                return
            }
            if response.statusCode != 200 {
                onComplete(.failure(.invalidStatusCode(response.statusCode)))
                return
            }
            if data == nil {
                onComplete(.failure(.taskError))
            } else {
                onComplete(.success(()))
            }
        }.resume()
    }
}
