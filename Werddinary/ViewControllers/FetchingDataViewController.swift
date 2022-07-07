//
// FetchingDataViewController.swift
// Werddinary
//


import UIKit

class FetchingDataViewController: UIViewController {

    // MARK: - Properties
    
    var containerView: UIView!
    
    // MARK: - Helper Functions
    
    func showSpinningIndicator() {
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        
        containerView.backgroundColor = .systemBackground
        containerView.alpha = 0
        
        UIView.animate(withDuration: 0.25) { self.containerView.alpha = 0.75 }
        
        let dataSpinner = UIActivityIndicatorView(style: .large)
        containerView.addSubview(dataSpinner)
        dataSpinner.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dataSpinner.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            dataSpinner.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
        
        dataSpinner.startAnimating()
    }
    
    func dismissSpinner() {
        DispatchQueue.main.async {
            self.containerView.removeFromSuperview()
            self.containerView = nil
        }
    }
}
