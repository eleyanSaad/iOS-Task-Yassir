# iOS Task Yassir

## Project Setup

Follow these steps to set up and run the project:

1. **Clone the Repository:**
   ```bash
   git clone <https://github.com/eleyanSaad/iOS-Task-Yassir.git>

2. Navigate to the Project Directory:
cd iOS\ Task\ Yassir

3. Install CocoaPods:
If CocoaPods is not installed, you can install it with:

sudo gem install cocoapods

4. Install Dependencies:
Run the following command to install the project dependencies:

pod install

5. Open the Project:
Open the .xcworkspace file in Xcode:
open iOS\ Task\ Yassir.xcworkspace

6.Build and Run:
Select the appropriate scheme in Xcode and run the project using the play button or Cmd+R.


Assumptions and Decisions
Platform Version: The project is targeted for iOS 15.0 and later. This choice was made to leverage newer iOS features and ensure compatibility with modern APIs.
Libraries: CocoaPods was chosen for dependency management to simplify the inclusion of external libraries such as Alamofire, SwiftyJSON, and SDWebImage.
Architecture: The application uses a combination of UITableView and UICollectionView for displaying data, reflecting a decision to utilize both views for their respective strengths in list and grid layouts.
Challenges and Solutions
Challenge: Handling Multiple Requests

Problem: Managing multiple simultaneous requests for data loading could lead to issues with data consistency and performance.
Solution: Implemented a flag isLoadingMore to prevent concurrent data requests and ensure that only one request is processed at a time.
Challenge: Image Loading and Caching

Problem: Efficiently loading and caching images from remote sources can be complex.
Solution: Used SDWebImage to handle image loading and caching, which simplifies managing image resources and improves performance.
Challenge: Ensuring Compatibility with Multiple iOS Versions

Problem: Different pods might require different minimum iOS versions, leading to potential compatibility issues.
Solution: Added a post-install script in the Podfile to standardize the deployment target to iOS 15.0 for all pods.
Challenge: Handling Refresh and Pagination

Problem: Managing refresh control and pagination effectively while ensuring a smooth user experience.
Solution: Implemented a refresh control to handle data reloading and pagination logic to load additional data as the user scrolls.
Contributing




