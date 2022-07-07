//
// RoundedCornerView.swift
// Werddinary
//


import UIKit

class RoundedCornerView: UIView {
    
    // MARK: - Properties
   
    let verticalStackView = UIStackView()
    let descriptionStackView = UIStackView()
    
    let titleLabel = WDWordTitleLabel(textAlignment: .left)
    let partOfSpeechLabel = WDWordTitleLabel(textAlignment: .left)
    let descriptionLabel = WDBodyLabel(textAlignment: .left)
    
    // MARK: - Property Observers
    
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    var partOfSpeech: String? {
        didSet {
            partOfSpeechLabel.text = partOfSpeech
        }
    }
    
    var descriptionText: String? {
        didSet {
            descriptionLabel.text = descriptionText
        }
    }
  
    // MARK: - Initializers
    
    init(backgroundColor: UIColor? = .systemBackground) {
        super.init(frame: .zero)
        
        self.backgroundColor = backgroundColor
        setupView()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Setup Functions
    
    func setupView() {
        titleLabel.textColor = .white
        titleLabel.font = UIFont(name: "Merriweather-Bold", size: 16)
        
        partOfSpeechLabel.font = UIFont(name: "Merriweather-Regular", size: 14)
        partOfSpeechLabel.isHidden = true
        
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = UIFont(name: "Merriweather-Light", size: 12)
        
        layer.cornerRadius = 10
        
        addVerticalStackView()
        addDescriptionStackView()
    }
    
    func addVerticalStackView() {
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        verticalStackView.axis = .vertical
        verticalStackView.distribution = .fill
        verticalStackView.spacing = 12
        
        addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(descriptionStackView)
        verticalStackView.addArrangedSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            verticalStackView.topAnchor.constraint(equalTo: topAnchor, constant: UIHelper.padding),
            verticalStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UIHelper.padding),
            verticalStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -UIHelper.padding),
            verticalStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -UIHelper.padding),
        ])
    }
    
    func addDescriptionStackView() {
        descriptionStackView.translatesAutoresizingMaskIntoConstraints = false
        descriptionStackView.axis = .vertical
        descriptionStackView.distribution = .fillProportionally
        descriptionStackView.spacing = 12
        
        descriptionStackView.addArrangedSubview(partOfSpeechLabel)
        descriptionStackView.addArrangedSubview(descriptionLabel)
    }
    
    func showPartOfSpeech() {
        partOfSpeechLabel.isHidden = false
    }
}
