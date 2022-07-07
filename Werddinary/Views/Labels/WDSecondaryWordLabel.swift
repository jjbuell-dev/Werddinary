//
// WDSecondaryWordLabel.swift
// Werddinary
//


import UIKit

class WDSecondaryWordLabel: UILabel {

    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureLabel()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup UI Functions
    
    private func configureLabel() {
        translatesAutoresizingMaskIntoConstraints = false
        textColor = .black
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.9
        lineBreakMode = .byTruncatingTail
    }
}
