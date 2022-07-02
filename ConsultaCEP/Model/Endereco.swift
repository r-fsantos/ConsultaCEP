//
//  Endereco.swift
//  ConsultaCEP
//
//  Created by Renato F. dos Santos Jr on 24/05/22.
//

import Foundation

// MARK: - Endereco
struct Endereco: Codable {
    let cep, logradouro, complemento, bairro: String?
    let localidade, uf, ibge, gia: String?
    let ddd, siafi: String?
}
