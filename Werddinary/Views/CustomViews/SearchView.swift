//
// SearchView.swift
// Werddinary
//


import UIKit

    protocol SearchWordDefinitionDelegate: AnyObject {
        func searchWordDefinitions(_ word: String?)
    }

    class SearchView: UIView {

        // MARK: - Properties
        
        weak var searchWordDefinitionDelegate: SearchWordDefinitionDelegate?
        
        let horizontalStackView = UIStackView()
        var searchTextField = UITextField()
        let searchActionButton = UIButton()
        
        // MARK: - Initializers
        
        init(searchWordDefinitionDelegate: SearchWordDefinitionDelegate?) {
            super.init(frame: .zero)
            backgroundColor = .queenBlue
            layer.cornerRadius = UIHelper.cornerRadius
            
            self.searchWordDefinitionDelegate = searchWordDefinitionDelegate
            setupView()
        }
        
        required init(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        // MARK: - Actions
        
        @objc func searchButtonPressed() {
            print("Search Button Pressed")
            searchWordDefinitionDelegate?.searchWordDefinitions(searchTextField.text)
            searchTextField.returnKeyType = .done
            searchTextField.resignFirstResponder()
        }
        
        // MARK: - UI Setup Functions
        
        private func setupView() {
            configureStackView()
            configureTextField()
            configureSearchActionButton()
        }
        
        private func configureStackView() {
            horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
            horizontalStackView.axis = .horizontal
            horizontalStackView.spacing = 4
            
            addSubview(horizontalStackView)
            horizontalStackView.addArrangedSubview(searchTextField)
            horizontalStackView.addArrangedSubview(searchActionButton)
            
            NSLayoutConstraint.activate([
                horizontalStackView.topAnchor.constraint(equalTo: topAnchor, constant: UIHelper.padding),
                horizontalStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UIHelper.padding),
                horizontalStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -UIHelper.padding),
                horizontalStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -UIHelper.padding),
            ])
        }
        
        private func configureTextField() {
            searchTextField.translatesAutoresizingMaskIntoConstraints = false
            searchTextField.backgroundColor = .systemGray2
            searchTextField.layer.cornerRadius = UIHelper.cornerRadius
            searchTextField.layer.borderColor = UIColor.systemGray5.cgColor
            searchTextField.layer.borderWidth = 2
            
            searchTextField.font = UIFont.preferredFont(forTextStyle: .title2)
            searchTextField.minimumFontSize = 12
            searchTextField.autocapitalizationType = .none
            
            searchTextField.clearButtonMode = .whileEditing
            searchTextField.placeholder = "Find a word..."
            
            let image = UIImage(systemName: "magnifyingglass")
            let imageView = UIImageView(image: image)
            
            let imageContainerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 24, height: 20))
            imageContainerView.addSubview(imageView)
            
            searchTextField.leftView = imageContainerView
            searchTextField.leftViewMode = .always
            
        }
        
        private func configureSearchActionButton() {
            searchActionButton.translatesAutoresizingMaskIntoConstraints = false
            searchActionButton.configuration = .filled()
            searchActionButton.configuration?.baseBackgroundColor = .begonia
            searchActionButton.configuration?.baseForegroundColor = .white
            searchActionButton.setTitle("Search", for: .normal)

            searchActionButton.addTarget(self, action: #selector(searchButtonPressed), for: .touchUpInside)
        }
    }
