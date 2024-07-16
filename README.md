# PhotoLister

## Display Photos from Flickr by Username or Tags

Photo Lister allows users to search for photos on Flickr by username or tags. Each displayed photo includes the user's ID and user icon above it. Clicking on a photo reveals detailed information about the photo, and clicking on the user's ID or icon takes you to the user's photo album.

## How to install and use the PhotoLister

1. Clone this project
2. Install via Swift package manager 3 frameworks -> Alamofire, Kingfisher and Swinject
3. Go into the Info.Plist file and change the value of the keys to your API key values. 

## Why MVVM architecture was used

I used MVVM architecture to seperate the UI logic (View), business logic (Model) and the logic to mediate between the two (Viewmodel). This allows the project to be more testable because each component has its own purpose. It also improved maintainability and extendability as making changes to one component has minimal impact on the other components. In conclusion, the project becomes more structured and organized, easier to maintain, test and extend.

## Why Alamofire was used

I used alamofire because it is built ontop of URLSession and provides built in functionality that simplifies processes such as response code validation, request object construction, parameter encoding. This results in a cleaner syntax that improves code readability. 

## Why Swinject was used

I used Swinject because Swinject simplifies dependency management, ensuring that dependencies are organized and easily accessible throughout the codebase. This enhances code maintainability by reducing coupling and promoting a modular architecture. 

Dependency injection makes unit testing easier by allowing dependencies to be easily mocked. This isolation of dependencies within Swinject containers simplifies the setup and execution of tests.

## Why Kingfisher was used

Initially, I used AsyncImage to display the images and noticed that the images needed to be retrieved from the API every single time a user returned to the image on the app, resulting in poor performance and user experience. For this reason, I switched to Kingfisher for better performance, as it uses caching and provides efficient image downloading and displaying under the hood.

## Known issues (work in progress)
1. Unit Tests and UI Tests need to be implemented
2. Images displayed do not display related tags 
3. UI is basic and could be improved dramatically
4. Photo detail screen can be more imformative
5. Error handling for displaying user images in photo album screen, no message notifying user that no images are found
6. Error handling for Search screen, no message notifying the user when no tags are found
7. Bug: Tags sometimes remain after deletion
8. Some views are too congested and UI components can be modularised
