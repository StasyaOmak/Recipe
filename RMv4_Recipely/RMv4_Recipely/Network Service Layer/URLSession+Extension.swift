// URLSession+Extension.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

extension NetworkError {
    init?(data: Data?, response: URLResponse?, error: Error?) {
        if let error = error {
            self = .transportError(error)
            return
        }

        if let response = response as? HTTPURLResponse,
           // swiftlint:disable opening_brace
           !(200 ... 299).contains(response.statusCode)
        {
            self = .serverError(statusCode: response.statusCode)
            // swiftlint:enable opening_brace
            return
        }

        if data == nil {
            self = .noData
        }

        return nil
    }
}

extension URLSession {
    func dataTask(with request: URLRequest, resultHandler: @escaping (DataResult) -> Void) -> URLSessionDataTask {
        dataTask(with: request) { data, response, error in

            if let networkError = NetworkError(data: data, response: response, error: error) {
                resultHandler(.failure(networkError))
                return
            }
            guard let data else { return }
            resultHandler(.success(data))
        }
    }
}
