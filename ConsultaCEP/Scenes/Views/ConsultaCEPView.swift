//
//  ConsultaCEPView.swift
//  ConsultaCEP
//
//  Created by Renato F. dos Santos Jr on 24/05/22.
//

import Foundation
import UIKit

protocol ViewCodeProtocol {
    func configureUI()
    func buildHierarchy()
    func setupConstraints()
    func setupViewCode()
}

extension ViewCodeProtocol {
    func setupViewCode() {
        configureUI()
        buildHierarchy()
        setupConstraints()
    }
}

protocol BaseViewProtocol: UIView {
    func configureView()
}

class ConsultaCEPView: UIView, BaseViewProtocol {

    private enum Constants {
        static let title: String = "Consulta CEP"
        static let textFieldPlaceholder: String = "Digite o CEP apenas com dígitos"
        static let baseFontColor: UIColor = .black
        static let baseFontSize: CGFloat = 20.0
        static let textFieldBackgroundColor: UIColor = .lightGray
        static let submitButtonType: UIButton.ButtonType = .system
        static let submitButtonTitle: String = "Consultar"
        static let spacing: CGFloat = 5.0
        static let baseHeight: CGFloat = 50.0
        static let viewBackgroundColor: UIColor = .white
        static let stackViewBackgroundColor: UIColor = .lightGray
        static let stackViewFillRate: CGFloat = 0.8
    }

    private let service = GetEnderecoService()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.contentMode = .scaleToFill
        stackView.spacing = Constants.spacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var textField: UITextField = {
        AppTheme.buildTextField(placeholder: Constants.textFieldPlaceholder,
                                fontColor: Constants.baseFontColor,
                                fontSize: Constants.baseFontSize)
    }()

    private lazy var submitButton: UIButton = {
        AppTheme.buildButton(with: Constants.submitButtonType,
                             title: Constants.submitButtonTitle,
                             fontSize: Constants.baseFontSize,
                             fontColor: Constants.baseFontColor)
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // TODO: Clarify
    /// Method 'configureView()' must be declared internal because it matches a requirement in internal protocol 'ConsultaCEPViewProtocol'
    internal func configureView() {
        configureSubmitButtonTarget()
        setupViewCode()
    }
    
    private func configureSubmitButtonTarget() {
        submitButton.addTarget(self,
                               action: #selector(self.onTapSubmitButton(sender:)),
                               for: .touchUpInside)
    }
    
    @objc private func onTapSubmitButton(sender: UIButton) {
        if !textField.hasText {
            // bad path
        }
        let cep: String = textField.text ?? ""
        
        service.fetchEndereco(cep: cep) { [weak self] (result) in
            switch result {
            case .success(let success):
                print(success)
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension ConsultaCEPView: ViewCodeProtocol {
    func configureUI() {
        backgroundColor = Constants.viewBackgroundColor
        textField.backgroundColor = Constants.textFieldBackgroundColor
    }
    
    func buildHierarchy() {
        addSubview(stackView)
        stackView.addArrangedSubview(textField)
        stackView.addArrangedSubview(submitButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            stackView.widthAnchor.constraint(equalToConstant: frame.size.width * Constants.stackViewFillRate),
        ])
    }
}
