import UIKit
import SwiftUI

class CharactersListVC: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Variables
    var charactersListData: Characters?
    var filteredCharacters: [Result] = []
    let statusFilterList = ["Alive", "Dead", "unknown"]
    var currentPage = 1
    let charactersPerPage = 20
    var numberOfAllPages = 1
    var isLoadingMore = false
    var selectedStatus: String?
    var selectedStatusIndex: Int?
    let refreshControl = UIRefreshControl()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupRefreshControl()
        registerCells()
        loadCharacters(page: currentPage)
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Characters"
    }
    
    private func setupRefreshControl() {
        // Add refresh control to table view
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
        
        // Configure refresh control
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
    }
    
    @objc private func refreshData(_ sender: Any) {
        // Reset the page number to 1 for the new request
        currentPage = 1
        
        filteredCharacters.removeAll()
        charactersListData?.results?.removeAll()
        loadCharacters(page: currentPage)
    }

    
    // MARK: - Data Loading
    private func loadCharacters(page: Int) {
        guard !isLoadingMore else { return } // Prevent multiple simultaneous requests
        
        ActivityIndicatorManager.start()
        isLoadingMore = true
        
        API.getCharactersApiList(pageNumber: page) { characterData, message, error in
            DispatchQueue.main.async {
                ActivityIndicatorManager.stop()
                self.refreshControl.endRefreshing()
                
                self.isLoadingMore = false // Stop loading indicator after request finishes
                
                if let error = error {
                    print("Error fetching characters: \(error.localizedDescription)")
                    self.errorAlert(title: "Alert", body: message)
                    return
                }
                
                if let response = characterData {
                    if self.charactersListData == nil {
                        self.charactersListData = response
                    } else {
                        self.charactersListData?.info = response.info
                        self.charactersListData?.results?.append(contentsOf: response.results ?? [])
                    }
                    self.numberOfAllPages = response.info?.pages ?? 1
                    self.applyFilter()
                    self.collectionView.reloadData()
                    self.tableView.reloadData()
                }
            }
        }
    }
    
     func applyFilter() {
        if let selectedStatus = selectedStatus {
            filteredCharacters = charactersListData?.results?.filter { $0.status == selectedStatus } ?? []
        } else {
            filteredCharacters = charactersListData?.results ?? []
        }
        tableView.reloadData()
    }
    
    // MARK: - Cell Registration
    private func registerCells() {
        tableView.register(UINib(nibName: "CharactersCell", bundle: nil), forCellReuseIdentifier: CharacterCell.cellID)
        collectionView.register(UINib(nibName: "FilterCharactersCell", bundle: nil), forCellWithReuseIdentifier: FilterCharactersCell.cellID)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 170
    }
}

// MARK: - UITableViewDataSource & UITableViewDelegate
extension CharactersListVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredCharacters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CharacterCell.cellID, for: indexPath) as? CharacterCell else {
            fatalError("Unable to dequeue CharacterCell")
        }
        configure(cell, with: filteredCharacters[indexPath.row])
        return cell
    }
    
    private func configure(_ cell: CharacterCell, with character: Result) {
        cell.setData(obj: character)
        print("status\(character.status ?? "")")
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == filteredCharacters.count - 1 && currentPage < numberOfAllPages && !isLoadingMore {
            currentPage += 1
            loadCharacters(page: currentPage)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let obj = filteredCharacters[indexPath.row]
        let swiftUIView = CharacterDetails(myObject: obj)
        let hostingController = UIHostingController(rootView: swiftUIView)
        self.navigationItem.backButtonTitle = ""
        navigationController?.pushViewController(hostingController, animated: true)
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
extension CharactersListVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return statusFilterList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilterCharactersCell.cellID, for: indexPath) as? FilterCharactersCell else {
            fatalError("Unable to dequeue FilterCharactersCell")
        }
        configure(cell, with: statusFilterList[indexPath.row], isSelected: indexPath.item == selectedStatusIndex)
        return cell
    }
    
    private func configure(_ cell: FilterCharactersCell, with status: String, isSelected: Bool) {
        cell.titleLabel.text = status
        if isSelected {
            cell.contentView.backgroundColor = .systemBlue
            cell.titleLabel.textColor = .white
        } else {
            cell.contentView.backgroundColor = .clear
            cell.titleLabel.textColor = .black
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let selectedIndex = selectedStatusIndex {
            let previousSelectedIndexPath = IndexPath(item: selectedIndex, section: 0)
            selectedStatusIndex = nil
            collectionView.reloadItems(at: [previousSelectedIndexPath])
        }
        
        selectedStatusIndex = indexPath.item
        collectionView.reloadItems(at: [indexPath])
        selectedStatus = statusFilterList[indexPath.item]
        applyFilter()
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? FilterCharactersCell else {
            return
        }
        cell.contentView.backgroundColor = .clear
        cell.titleLabel.textColor = .black
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let text = statusFilterList[indexPath.item]
        let textWidth = text.width(withConstrainedHeight: 30, font: UIFont.systemFont(ofSize: 17))
        return CGSize(width: textWidth + 32, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 0)
    }
}
