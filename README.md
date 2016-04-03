# devtoolbox-ios-app

This app is a simple app based on the [devToolBox](https://www.devtoolbox.co) website. It lists development and design resources such as frameworks, libraries, icons, backgrounds, themes, webapps and more in table views.

When you first open the app, you'll be taken to the Browse tab, that loads a list of resources. If you select an item, you'll see a longer description of the tool or resource. You can save it to your favorites if you want.

In the Favorite Tab, you can select an item to view it's description, remove it from your favorite's list or open the official website. You can also remove on the table view by sliding the item to the left.


*BrowseViewController*
It reuses the same table view for the browsing and favorites list.

*ItemDetailViewController*
It shows a longer description of an item.

*AboutViewController*
About the devToolBox website.

In the `Model` folder, there is some convenience methods for accessing the api. There are some methods that are not used in this version, but will be used in a future version.

___

To test the app, open the project on Xcode and click on the run button. 
