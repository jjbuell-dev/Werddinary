//
// HeaderView.swift
// Werddinary
//


import UIKit

class HeaderView: UIView {
    
    // MARK: - Properties
    
    let horizontalStackView = UIStackView()
    let appTitleLabel = WDWordTitleLabel(textAlignment: .left)
    let toFavoritesButton = WDSymbolButton()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .orangeYellow
        
        configureHeaderView()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Setup Functions
    
    private func configureStackView() {
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        horizontalStackView.axis = .horizontal
        horizontalStackView.distribution = .fillProportionally

        horizontalStackView.addArrangedSubview(appTitleLabel)
        horizontalStackView.addArrangedSubview(toFavoritesButton)
    }
    
    private func configureAppTitleLabel() {
        appTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        appTitleLabel.font = UIFont(name: "Merriweather-Bold", size: 34)
        appTitleLabel.text = "Werddinary."
    }
    
    func configureToFavoritesButton() {
        toFavoritesButton.translatesAutoresizingMaskIntoConstraints = false
        toFavoritesButton.setButtonSymbol(systemName: "heart.text.square")
        toFavoritesButton.tintColor = .begonia
        toFavoritesButton.setButtonSymbolConfiguration(pointSize: 34, weight: .medium, scale: .large)
    }
    
    private func configureHeaderView() {
        configureStackView()
        configureAppTitleLabel()
        configureToFavoritesButton()
        
        addSubview(horizontalStackView)
    
        NSLayoutConstraint.activate([
            horizontalStackView.topAnchor.constraint(equalTo: topAnchor, constant: UIHelper.padding),
            horizontalStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UIHelper.padding),
            horizontalStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -UIHelper.padding),
            horizontalStackView.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
}
