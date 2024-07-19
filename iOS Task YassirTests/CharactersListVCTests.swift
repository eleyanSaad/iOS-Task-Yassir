import XCTest
@testable import iOS_Task_Yassir // Replace `YourProject` with the actual name of your project/module

class CharactersListVCTests: XCTestCase {

    var charactersListVC: CharactersListVC!
    var navigationController: UINavigationController!
    override func setUp() {
        super.setUp()
        
        // Get the storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        // Instantiate the navigation controller
        if let navController = storyboard.instantiateViewController(withIdentifier: "CharactersNavigationController") as? UINavigationController {
            
            // Get the CharactersListVC from the navigation stack
            if let charactersListVC = navController.viewControllers.first as? CharactersListVC {
                
                // Assign to instance variables for testing
                self.navigationController = navController
                self.charactersListVC = charactersListVC
                
                // Load the view hierarchy (if not loaded already)
                if charactersListVC.viewIfLoaded == nil {
                    charactersListVC.loadViewIfNeeded()
                }
            } else {
                XCTFail("CharactersListVC not found in storyboard navigation stack")
            }
        } else {
            XCTFail("NavigationController not found in storyboard with identifier 'CharactersNavigationController'")
        }
    }


    override func tearDown() {
        charactersListVC = nil
        navigationController = nil
        super.tearDown()
    }

    func testViewDidLoad_SetsUpUI() {
        charactersListVC.viewDidLoad()
        XCTAssertEqual(charactersListVC.navigationController?.navigationBar.prefersLargeTitles, true)
        XCTAssertEqual(charactersListVC.title, "Characters")
    }

    func testLoadCharacters_CallsAPIAndUpdatesData() {
        let expectation = XCTestExpectation(description: "Load characters data")
        charactersListVC.currentPage = 1
        API.getCharactersApiList(pageNumber: 1) { characterData, message, error in
            DispatchQueue.main.async {
                if let error = error {
                    XCTFail("Error fetching characters: \(error.localizedDescription)")
                } else if let response = characterData {
                    self.charactersListVC.charactersListData = response
                    self.charactersListVC.applyFilter()
                    self.charactersListVC.collectionView.reloadData()
                    self.charactersListVC.tableView.reloadData()
                    XCTAssertEqual(self.charactersListVC.charactersListData?.results?.count, 20)
                }
                expectation.fulfill()
            }
        }

        wait(for: [expectation], timeout: 5.0)
    }

    func testApplyFilter_FiltersCharactersByStatus() {
        // Create a mock character with status "Alive"
        let mockCharacter = Result(id: 1, name: "Character 1", status: "Alive", species: nil, type: nil, gender: nil, origin: nil, location: nil, image: nil, episode: nil, url: nil, created: nil)
        
        // Create a Characters object and set its results to an array containing the mock character
        let mockCharacters = Characters()
        mockCharacters.results = [mockCharacter]
        
        // Set the charactersListData property of the view controller to the mock characters
        charactersListVC.charactersListData = mockCharacters

        // Set the selected status to "Alive"
        charactersListVC.selectedStatus = "Alive"
        
        // Apply the filter
        charactersListVC.applyFilter()
        
        // Verify that the filtered characters array contains one character with the status "Alive"
        XCTAssertEqual(charactersListVC.filteredCharacters.count, 1)
        XCTAssertEqual(charactersListVC.filteredCharacters[0].status, "Alive")
    }

}
