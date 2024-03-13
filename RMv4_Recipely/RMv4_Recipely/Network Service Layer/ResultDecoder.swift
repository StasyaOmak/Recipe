// ResultDecoder.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Псевоним типа для использования в ResultDecoder<T>
typealias DataResult = Result<Data, NetworkError>

/// Пользовательские ошибки сети
enum NetworkError: Error {
    case transportError(Error)
    case serverError(statusCode: Int)
    case noData
    case decodingError(Error)
    case encodingError(Error)
}

/// Generic для декодирования data в любой тип, используется в NetworkService
struct ResultDecoder<T> {
    private let transform: (Data) throws -> T

    init(_ transform: @escaping (Data) throws -> T) {
        self.transform = transform
    }

    func decode(_ result: DataResult) -> Result<T, NetworkError> {
        result.flatMap { data -> Result<T, NetworkError> in
            Result { try transform(data) }.mapError { NetworkError.decodingError($0) }
        }
    }
}
