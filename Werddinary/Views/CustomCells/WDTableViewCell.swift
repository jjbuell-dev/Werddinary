//
// WDTableViewCell.swift
// Werddinary
//


import UIKit

class WDTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let cellReuseID = "WDTableViewCell"
    
    let tableCellContainer = UIView()
    let wordNameLabel = WDWordTitleLabel(textAlignment: .left)
    let partOfSpeechLabel = WDSecondaryWordLabel()
    let wordDefinitionLabel = WDBodyLabel(textAlignment: .left)
    
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureTableViewCell()
        setupTableViewContainer()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helper Functions
    
    func updateViews(_ wordDetail: WordDetail?, word: String?) {
        wordNameLabel.text = word
        wordNameLabel.font = UIFont(name: "Merriweather-Bold", size: 14)
        
        partOfSpeechLabel.text = wordDetail?.partOfSpeech
        partOfSpeechLabel.font = UIFont(name: "Merriweather-LightItalic", size: 10)
        wordDefinitionLabel.text = wordDetail?.definition
    }
    
    // MARK: - Configure TableView Cell Functions
    
    func setupTableViewContainer() {
        tableCellContainer.translatesAutoresizingMaskIntoConstraints = false
        tableCellContainer.backgroundColor = .systemGray3
        tableCellContainer.layer.cornerRadius = 10
        wordDefinitionLabel.numberOfLines = 0
    }
    
    private func configureTableViewCell() {
        backgroundColor = .queenBlue
        selectionStyle = .none
        addSubview(tableCellContainer)
        tableCellContainer.addSubview(wordNameLabel)
        tableCellContainer.addSubview(partOfSpeechLabel)
        tableCellContainer.addSubview(wordDefinitionLabel)
        
        NSLayoutConstraint.activate([
            tableCellContainer.topAnchor.constraint(equalTo: topAnchor, constant: UIHelper.padding),
            tableCellContainer.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UIHelper.padding),
            tableCellContainer.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -UIHelper.padding),
            tableCellContainer.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -UIHelper.padding),
            
            wordNameLabel.topAnchor.constraint(equalTo: tableCellContainer.topAnchor, constant: UIHelper.padding),
            wordNameLabel.leadingAnchor.constraint(equalTo: tableCellContainer.leadingAnchor, constant: UIHelper.padding),
            wordNameLabel.heightAnchor.constraint(equalToConstant: 18),
            
            partOfSpeechLabel.firstBaselineAnchor.constraint(equalTo: wordNameLabel.firstBaselineAnchor),
            partOfSpeechLabel.leadingAnchor.constraint(equalTo: wordNameLabel.trailingAnchor, constant: 4),
            partOfSpeechLabel.heightAnchor.constraint(equalToConstant: 12),
            
            wordDefinitionLabel.topAnchor.constraint(equalTo: wordNameLabel.bottomAnchor),
            wordDefinitionLabel.leadingAnchor.constraint(equalTo: tableCellContainer.leadingAnchor, constant: UIHelper.padding),
            wordDefinitionLabel.trailingAnchor.constraint(equalTo: tableCellContainer.trailingAnchor, constant: -10),
            wordDefinitionLabel.bottomAnchor.constraint(equalTo: tableCellContainer.bottomAnchor, constant: -UIHelper.padding),
        ])
    }
}

