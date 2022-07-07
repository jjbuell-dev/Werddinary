//
// WDSymbolButton.swift
// Werddinary
//


import UIKit

class WDSymbolButton: UIButton {
   
    // MARK: - Completion Property
    
    var completion: (() -> Void)?
    
    // MARK: - Initializers
    
    init(completion: (() -> Void)?, frame: CGRect = .zero) {
        super.init(frame: frame)
        
        self.completion = completion
        configureButton()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureButton()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    
    @objc func buttonPressed() {
        completion?()
    }
    
    // MARK: - Button Configuration Button
    
    private func configureButton() {
        tintColor = .white
        // action target
        addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    }
    
    func setButtonSymbol(systemName: String) {
        setImage(UIImage(systemName: systemName), for: .normal)
    }
    
    func setButtonSymbolConfiguration(pointSize: CGFloat, weight: UIImage.SymbolWeight, scale: UIImage.SymbolScale) {
        let buttonConfiguration = UIImage.SymbolConfiguration(pointSize: pointSize, weight: weight, scale: scale)
        setPreferredSymbolConfiguration(buttonConfiguration, forImageIn: .normal)
    }
}
