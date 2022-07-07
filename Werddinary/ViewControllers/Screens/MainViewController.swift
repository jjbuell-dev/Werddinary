//
// MainViewController.swift
// Werddinary
//


import UIKit

class MainViewController: FetchingDataViewController {
    
    // MARK: - Properties
    
    var words: [WordDetail]?
    var selectedWord: String?
    
    // MARK: - UI Properties
    
    let headerView = HeaderView()
    lazy var randomWordView: WordView = {
        let view = WordView() { [weak self] in
            self?.refreshRandomWord()
        }
        return view
    }()
    
    let verticalStackView = UIStackView()
    lazy var searchBar = SearchView(searchWordDefinitionDelegate: self)
    let tableView = UITableView()
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orangeYellow
        
        setupUI()
        refreshRandomWord()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    // MARK: - Actions
    
    func refreshRandomWord() {
        showSpinningIndicator()
        // weadsfasd
        NetworkManager.fetchRandomWord { [weak self] result in
            switch result {
            case .success(let randomWord):
                DispatchQueue.main.async {
                    self?.randomWordView.wordNameLabel.text = randomWord.word
                    self?.randomWordView.partOfSpeechLabel.text = randomWord.results?.first?.partOfSpeech
                    self?.randomWordView.wordDefinitionLabel.text = randomWord.results?.first?.definition
                    self?.dismissSpinner()
                }
                
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.dismissSpinner()
                }
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: - UI Setup Functions
    
    func configureTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(WDTableViewCell.self, forCellReuseIdentifier: WDTableViewCell.cellReuseID)
        
        tableView.separatorStyle = .none
        tableView.backgroundColor = .queenBlue
//        tableView.isHidden = true
    }
    
    func configureStackView() {
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        verticalStackView.axis = .vertical
        verticalStackView.spacing = 4
        verticalStackView.backgroundColor = .queenBlue
        verticalStackView.layer.cornerRadius = 10
        verticalStackView.distribution = .fill
    }
    
    func setupUI() {
        configureStackView()
        configureTableView()
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        randomWordView.translatesAutoresizingMaskIntoConstraints = false
        randomWordView.layer.cornerRadius = UIHelper.cornerRadius
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(headerView)
        view.addSubview(randomWordView)
        
        view.addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(searchBar)
        verticalStackView.addArrangedSubview(tableView)
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 4),
            headerView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 4),
            headerView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -4),
            headerView.heightAnchor.constraint(equalToConstant: 40),
            
            randomWordView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 24),
            randomWordView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 8),
            randomWordView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -8),
            randomWordView.heightAnchor.constraint(lessThanOrEqualTo: view.heightAnchor, multiplier: 0.25),
            
            verticalStackView.topAnchor.constraint(equalTo: randomWordView.bottomAnchor, constant: 28),
            verticalStackView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 8),
            verticalStackView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -8),
            verticalStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8)
        ])
    }
}

// MARK: - Extension TableView Data Source, Delegate

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        words?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WDTableViewCell.cellReuseID, for: indexPath) as? WDTableViewCell else { return UITableViewCell() }
        cell.updateViews(words?[indexPath.row], word: selectedWord)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedWord = selectedWord,
              let selectedWordDetails = words?[indexPath.row] else { return }
        
        navigationController?.pushViewController((WordDetailViewController(wordDetail: selectedWordDetails, selectedWord: selectedWord)), animated: true)
    }
}

// MARK: - Extensions SearchWordDefinitionDelegate Functions

extension MainViewController: SearchWordDefinitionDelegate {
    func searchWordDefinitions(_ word: String?) {
        guard let word = word, !word.isEmpty else {
            presentEmptyTextFieldAlert()
            return
        }
        
        showSpinningIndicator()
        
        NetworkManager.fetchWordWithDetails(word) { [weak self] result in
            switch result {
            case .success(let word):
                DispatchQueue.main.async {
                    let wordsWithDefinitions = word.results?.filter { $0.definition != nil }
                    self?.words = wordsWithDefinitions
                    self?.selectedWord = word.word
                    self?.tableView.reloadData()
                    self?.dismissSpinner()
                }
                
            case .failure(let error):
                print("Failed to retrieve word with error: \(error.localizedDescription)")
                
                self?.dismissSpinner()
            }
        }
    }
    
    // MARK: - Alert Functions
    
    private func presentEmptyTextFieldAlert() {
        let alertController = UIAlertController(title: "No Word Entered", message: "Please enter a word to receive definitions", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
}


#if DEBUG
import SwiftUI
struct SwiftUIPreviewViewController<ViewController: UIViewController>: UIViewControllerRepresentable {
    let viewController: ViewController
    
    init(_ builder: @escaping () -> ViewController) {
        viewController = builder()
    }
    
    func updateUIViewController(_ uiViewController: ViewController, context: Context) {
    }
    
    // MARK: - UIViewControllerRepresentable
    func makeUIViewController(context: Context) -> ViewController {
        viewController
    }
}

struct MainViewController_Preview: PreviewProvider {
    static var previews: some View {
        SwiftUIPreviewViewController{
            let viewController = MainViewController()
            return viewController
        }
    }
}
#endif
