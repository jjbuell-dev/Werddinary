//
// WDBodyLabel.swift
// Werddinary
//


import UIKit

class WDBodyLabel: UILabel {

    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureLabel()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(textAlignment: NSTextAlignment) {
        self.init(frame: .zero)
        
        self.textAlignment = textAlignment
    }
    
    // MARK: - Setup UI Functions
    
    private func configureLabel() {
        translatesAutoresizingMaskIntoConstraints = false
        textColor = .black
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.75
        lineBreakMode = .byWordWrapping
    }
}
