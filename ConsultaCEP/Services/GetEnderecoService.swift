//
//  ConsultaCEP.swift
//  ConsultaCEP
//
//  Created by Renato F. dos Santos Jr on 24/05/22.
//

import Foundation


protocol GetEnderecoProtocol {
    func fetchEndereco(cep: String,
                       completion: @escaping(Result<Endereco, Error>) -> Void )
}

final class GetEnderecoService: GetEnderecoProtocol {

    private enum Constants {
        static let baseUrl: String = "https://viacep.com.br/ws"
        static let dataFormat: String = "json"
        static let method: HTTPMethod = HTTPMethod.get
    }

    private let session: URLSession
    private let decoder: JSONDecoder

    // TODO: Inject NetworkingLayer
    init(session: URLSession = URLSession.shared,
         decoder: JSONDecoder = JSONDecoder()) {
        self.session = session
        self.decoder = decoder
    }

    func fetchEndereco(cep: String,
                       completion: @escaping(Result<Endereco, Error>) -> Void ) {
        let endpoint = "\(Constants.baseUrl)/\(cep)/\(Constants.dataFormat)"
        guard let request : URLRequest = requestBuilder(endpoint: endpoint,
                                                        method: Constants.method) else { return }

        session.dataTask(with: request) { data, response, error in
            do {
                guard let jsonData = data else { return }
                let endereco = try self.decoder.decode(Endereco.self, from: jsonData)
                
                completion(.success(endereco))
                
                if error != nil {
                    print(error as Any)
                    completion(.failure(error as! Error))
                }
                
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

    func requestBuilder(endpoint: String,
                        method: HTTPMethod) -> URLRequest? {
        guard let url = URL(string: endpoint) else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = method.name
        return request
    }

}


final class NetworkManagerService {
    
}
