# ABN AMRO Assignment-iOS

Changes made to the Wikipedia app to support deep linking with coordinates can be viewed in the following pull request:
[https://github.com/jordainfg/wikipedia-ios-clone/pull/1](https://github.com/jordainfg/wikipedia-ios-clone/pull/1)

# Demo of Functionality
https://github.com/user-attachments/assets/52987618-bdf7-4598-972e-0dc2e58edb6f

A demo video showcases the deep link functionality in both a **cold start** scenario, where the app is not running, and a **background launch**, where the app is resumed from the background. In both cases, the use of **pending coordinates** ensures that the map centers on the correct location once the app is fully initialized.

# Notes

- The response from [https://raw.githubusercontent.com/abnamrocoesd/assignment-ios/main/locations.json](https://raw.githubusercontent.com/abnamrocoesd/assignment-ios/main/locations.json) contains one location with a missing name. In the test app, I made the `name` field optional. Handling missing names can be adjusted depending on requirements or preferences from the product owner (PO).
