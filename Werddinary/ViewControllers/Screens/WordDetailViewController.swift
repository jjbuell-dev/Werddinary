//
// WordDetailViewController.swift
// Werddinary
//


import UIKit

class WordDetailViewController: UIViewController {

    
    // MARK: - Properties
    
    let wordDetail: WordDetail
    let selectedWord: String
    
    let definitionView = RoundedCornerView(backgroundColor: .blueJeans)
    let synonymsView = RoundedCornerView(backgroundColor: .turquoise)
    let antonymsView = RoundedCornerView(backgroundColor: .systemRed)
    let examplesView = RoundedCornerView(backgroundColor: .systemIndigo)
    
    let scrollView: UIScrollView = {
       let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    let contentStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 12
        return stackView
    }()
    
    
    // MARK: - Initializers
    
    init(wordDetail: WordDetail, selectedWord: String) {
        self.wordDetail = wordDetail
        self.selectedWord = selectedWord
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orangeYellow
        
        configureNavigationController()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }

    // MARK: - Setup UI Functions
    
    private func configureNavigationController() {
        navigationController?.navigationBar.prefersLargeTitles = true
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        navigationController?.navigationBar.largeTitleTextAttributes = textAttributes
        navigationItem.title = selectedWord
    }
    
    func setupViews() {
        addScrollView()
        addStackView()
        setupDefinitionsView()
        setupSynonymsView()
        setupAntonymsView()
        setupExamplesView()
    }
    
    func addScrollView() {
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: UIHelper.padding),
            scrollView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -UIHelper.padding),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    func addStackView() {
        contentStackView.addArrangedSubview(definitionView)
        contentStackView.addArrangedSubview(synonymsView)
        contentStackView.addArrangedSubview(antonymsView)
        contentStackView.addArrangedSubview(examplesView)
        scrollView.addSubview(contentStackView)
        
        let emptyView = UIView()
        emptyView.translatesAutoresizingMaskIntoConstraints = false
       
        contentStackView.addArrangedSubview(emptyView)
        
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            definitionView.widthAnchor.constraint(equalTo: contentStackView.widthAnchor)
        ])
    }
    
    func setupDefinitionsView() {
        definitionView.translatesAutoresizingMaskIntoConstraints = false
        definitionView.title = "Definition"
        definitionView.partOfSpeech = wordDetail.partOfSpeech
        definitionView.descriptionText = wordDetail.definition
        definitionView.showPartOfSpeech()
    }
    
    func setupSynonymsView() {
        synonymsView.translatesAutoresizingMaskIntoConstraints = false
        synonymsView.title = "Synonyms"
        synonymsView.isHidden = wordDetail.synonyms == nil
        synonymsView.descriptionText = wordDetail.synonyms?.joined(separator: ", ")
    }
    
    func setupAntonymsView() {
        antonymsView.translatesAutoresizingMaskIntoConstraints = false
        antonymsView.title = "Antonyms"
        antonymsView.isHidden = wordDetail.antonyms == nil
        antonymsView.descriptionText = wordDetail.antonyms?.joined(separator: ", ")
    }
    
    func setupExamplesView() {
        examplesView.translatesAutoresizingMaskIntoConstraints = false
        examplesView.title = "Examples"
        examplesView.isHidden = wordDetail.examples == nil
        examplesView.descriptionText = wordDetail.examples?.joined(separator: ", ")
    }
}
