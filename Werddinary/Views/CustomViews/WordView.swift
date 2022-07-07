//
// WordView.swift
// Werddinary
//


import UIKit

class WordView: UIView {

    // MARK: - Properties
    
    var completion: (() -> Void)?
    
    // MARK: - UI Properties
    
    let containerStackView = UIStackView()
    let horizontalStackView = UIStackView()
    let verticalStackView = UIStackView()
    let wordNameLabel = WDWordTitleLabel(textAlignment: .left)
    let partOfSpeechLabel = WDSecondaryWordLabel()
    let wordDefinitionLabel = WDBodyLabel(textAlignment: .left)
    
    lazy var randomWordButton: WDSymbolButton = {
        let button = WDSymbolButton { [weak self] in self?.completion?() }
        return button
    }()

    // MARK: - Initializers
    
    init(frame: CGRect = .zero, completion: (() -> Void)?) {
        self.completion = completion
        
        super.init(frame: frame)
        backgroundColor = .queenBlue
        
        configureItemsView()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Items Configuration Functions
    
    private func configureHorizontalStackView() {
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        horizontalStackView.addArrangedSubview(wordNameLabel)
        horizontalStackView.addArrangedSubview(partOfSpeechLabel)
       
        horizontalStackView.axis = .horizontal
        horizontalStackView.spacing = 8
        horizontalStackView.alignment = .firstBaseline
    }
    
    private func configureVerticalStackView() {
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        verticalStackView.addArrangedSubview(wordDefinitionLabel)
        
        verticalStackView.axis = .vertical
        verticalStackView.spacing = 8
        verticalStackView.distribution = .fillProportionally
    }
    
    private func configureContainerStackView() {
        containerStackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(containerStackView)
        containerStackView.addArrangedSubview(horizontalStackView)
        containerStackView.addArrangedSubview(verticalStackView)
        
        containerStackView.axis = .vertical
        containerStackView.distribution = .fillProportionally
        containerStackView.spacing = 8
        containerStackView.alignment = .leading
    }
    
    private func configureRandomButton() {
        randomWordButton.setButtonSymbol(systemName: "arrow.clockwise.circle")
        randomWordButton.setButtonSymbolConfiguration(pointSize: 20, weight: .medium, scale: .large)
    }
    
    private func configureItemsView() {
        wordDefinitionLabel.numberOfLines = 0
        wordNameLabel.font = UIFont(name: "Merriweather-Regular", size: 24)
        partOfSpeechLabel.font = UIFont(name: "Merriweather-LightItalic", size: 14)
        
        addSubview(randomWordButton)
        randomWordButton.translatesAutoresizingMaskIntoConstraints = false
        
        configureHorizontalStackView()
        configureVerticalStackView()
        configureContainerStackView()
        configureRandomButton()
        
        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalTo: topAnchor, constant: UIHelper.padding),
            containerStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UIHelper.padding),
            containerStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -UIHelper.padding),
            containerStackView.bottomAnchor.constraint(equalTo: randomWordButton.topAnchor, constant: -UIHelper.padding),
            
            randomWordButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -UIHelper.padding),
            randomWordButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -UIHelper.padding),
        ])
    }
}
