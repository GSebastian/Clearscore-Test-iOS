#  Clearscore Test
##  Submission by Sebastian Ghetu

###  Getting Started
This project is built using Xcode 12.5.1. No dependencies, so nice and easy - open and run!

###  Notes
#### Networking
The test sheet does not come with a contract, so:
 * I've made every property an optional, to guard against unexpected `null`s
 * Where the responses always came back as `null`, I've commented out those properties. I though about building a type-erased AnyCodable, however it seemed a bit overkill: it's not something you would typically use in production
 * Wherever it made sense, I've converted value strings into enum cases. They're safer to work with in production


