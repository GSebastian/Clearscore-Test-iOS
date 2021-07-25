# Clearscore Test

## Submission by Sebastian Ghetu

### Getting Started

This project is built using Xcode 12.5.1. No dependencies, so nice and easy - open and run!

### Notes

I've added most of my notes and comments directly in the code, however there are a few things that couldn't be added in there. Please find them below!

**Networking**

The test sheet does not come with a contract, so:
- Where the values always came back as `null`, I've commented out those properties. I though about building a type-erased AnyCodable, however it seemed a bit overkill: it's not something you would typically use in production
- Wherever it made sense, I've converted value strings into enum cases. They're safer to work with in production

In production, I would be much more cautious with what can be null, so I would mark things as optional within the models. In this particular case, to save time and boilerplate, I have not marked anything as optional.

As I was constrained by time, for test coverage I've only checked parsing. In production, I would create my own URL session, pass it into `CreditService`, and test the networking stack end to end - from raw response to parsed models. I would usually do this as part of the UI test suite.

**Tests**

- I have added UI and Unit tests to the main view controller and the networking stack however I skipped the details view controller deliberately for lack of time.
- In production, I would build a way of mocking network responses as part of the UI test suite in order to test the different views for all the states
