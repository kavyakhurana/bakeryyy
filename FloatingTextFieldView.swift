//
//  BakeryTextField.swift
//  bakeryyy
//
//  Created by Kavya Khurana on 19/02/24.
//

import UIKit

class FloatingTextFieldView: UIView {
    
    private let bgView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.setContentHuggingPriority(UILayoutPriority(1000), for: .vertical)
        view.setContentCompressionResistancePriority(UILayoutPriority(1000), for: .vertical)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let textFieldContainerView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.cornerRadius = 10
        view.setContentHuggingPriority(UILayoutPriority(1000), for: .vertical)
        view.setContentCompressionResistancePriority(UILayoutPriority(1000), for: .vertical)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let titleLabelView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.backgroundColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 10)
        label.setContentHuggingPriority(UILayoutPriority(rawValue: 1000), for: .vertical)
        label.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 1000), for: .vertical)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let textField: UITextField = {
        let textField = UITextField()
        textField.autocorrectionType = .no
        textField.setContentHuggingPriority(UILayoutPriority(rawValue: 1000), for: .vertical)
        textField.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 1000), for: .vertical)
        textField.font = UIFont.systemFont(ofSize: 15)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let errorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let errorIcon: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    
    private let errorLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.red
        label.font = UIFont.systemFont(ofSize: 10)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var titleText: String = ""
    private var isEmailTextField = false
    private var validationTimer: Timer?
    
    init(titleText: String) {
        super.init(frame: .zero)
        self.titleText = titleText
        setupUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setAsEmailTextField() {
        textField.autocapitalizationType = .none
        isEmailTextField = true
    }
    
    func setAsPasswordTextField() {
        textField.isSecureTextEntry = true
    }
    
    
}

extension BakeryTextFieldView {
    
    func setupUI() {
        self.addSubview(bgView)
        bgView.addSubview(textFieldContainerView)
        bgView.addSubview(titleLabelView)
        titleLabelView.addSubview(titleLabel)
        textFieldContainerView.addSubview(textField)
        bgView.addSubview(errorView)
        errorView.addSubview(errorIcon)
        errorView.addSubview(errorLabel)
        setupConstraints()
        setupTextField()
        setupErrorView()
        titleLabel.text = titleText
        titleLabelView.isHidden = true
    }
    
    func setupTextField() {
        textField.placeholder = titleText
        textField.delegate = self
        textField.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
    }
    
    func setupErrorView() {
//        add your error icon here!
//        errorIcon.image = UIImage(named: Constants.Assets.error)
        errorLabel.text = "Enter valid email ID"
        errorView.isHidden = true
    }
    
    func setupConstraints() {
        let constraints = [
            bgView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            bgView.topAnchor.constraint(equalTo: self.topAnchor),
            bgView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            bgView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            textFieldContainerView.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: 2),
            textFieldContainerView.topAnchor.constraint(equalTo: bgView.topAnchor, constant: 10),
            textFieldContainerView.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: -2),
            
            titleLabelView.leadingAnchor.constraint(equalTo: textFieldContainerView.leadingAnchor, constant: 10),
            titleLabelView.topAnchor.constraint(equalTo: textFieldContainerView.topAnchor, constant: 0),
            
            titleLabel.leadingAnchor.constraint(equalTo: titleLabelView.leadingAnchor, constant: 5),
            titleLabel.topAnchor.constraint(equalTo: titleLabelView.topAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: titleLabelView.trailingAnchor, constant: -5),
            titleLabel.bottomAnchor.constraint(equalTo: titleLabelView.bottomAnchor),
            
            textField.leadingAnchor.constraint(equalTo: textFieldContainerView.leadingAnchor, constant: 12),
            textField.topAnchor.constraint(equalTo: textFieldContainerView.topAnchor, constant: 12),
            textField.trailingAnchor.constraint(equalTo: textFieldContainerView.trailingAnchor, constant: -12),
            textField.bottomAnchor.constraint(equalTo: textFieldContainerView.bottomAnchor, constant: -12),
            
            errorView.leadingAnchor.constraint(equalTo: textFieldContainerView.leadingAnchor, constant: 2),
            errorView.topAnchor.constraint(equalTo: textFieldContainerView.bottomAnchor, constant: 10),
            errorView.trailingAnchor.constraint(equalTo: textFieldContainerView.trailingAnchor, constant: -2),
            errorView.bottomAnchor.constraint(equalTo: bgView.bottomAnchor, constant: -2),
            
            errorIcon.leadingAnchor.constraint(equalTo: errorView.leadingAnchor),
            errorIcon.centerYAnchor.constraint(equalTo: errorView.centerYAnchor),
            errorIcon.heightAnchor.constraint(equalToConstant: 10),
            errorIcon.widthAnchor.constraint(equalTo: errorIcon.heightAnchor),
            
            errorLabel.leadingAnchor.constraint(equalTo: errorIcon.trailingAnchor, constant: 5),
            errorLabel.centerYAnchor.constraint(equalTo: errorView.centerYAnchor),
            errorLabel.trailingAnchor.constraint(equalTo: errorView.trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
}

//MARK: - Text Field Functions

extension BakeryTextFieldView {
    
    @objc private func textFieldEditingChanged() {
        if textField.text?.isEmpty == false {
            UIView.animate(withDuration: 0.2) { [weak self] in
                guard let self = self else { return }
                self.titleLabelView.isHidden = false
                self.titleLabelView.transform = CGAffineTransform(translationX: 0, y: -6)
            }
        } else {
            UIView.animate(withDuration: 0.4) { [weak self] in
                guard let self = self else { return }
                self.titleLabelView.isHidden = true
                self.titleLabelView.transform = .identity
            }
        }
    }
    
    private func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
}

//MARK: - Text Field Delegates

extension BakeryTextFieldView: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        errorView.isHidden = true
        textFieldContainerView.layer.borderColor = UIColor.black.cgColor
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    
        validationTimer?.invalidate()
        self.errorView.isHidden = true
        self.textFieldContainerView.layer.borderColor = UIColor.black.cgColor
        
        validationTimer = Timer.scheduledTimer(withTimeInterval: 0.7, repeats: false) { [weak self] timer in
            guard let self = self else { return }
            self.validateEmail()
        }
        
        return true
    }
    
    func validateEmail() {
        if self.isEmailTextField && !self.isValidEmail(email: self.textField.text ?? "") {
            self.errorView.isHidden = false
            self.textFieldContainerView.layer.borderColor = UIColor.red.cgColor
        } else {
            self.errorView.isHidden = true
            self.textFieldContainerView.layer.borderColor = UIColor.black.cgColor
        }
    }
    
}



