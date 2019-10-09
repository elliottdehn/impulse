# IMPULSE!
Just a simple 2D mobile game made purely in Flutter + Dart using a Model-View-ViewModel-Presenter design (inspired by a medical exam)

Here is a brief video explanation:
You may also download the application from the Google Play Store. Search: "IMPULSE!"

# Gameplay
Users are flashed a symbol, and are expected to respond within a certain time frame by tapping the screen. If the user does not tap in time, they lose a life. If the user taps a special symbol (the letter X, for now), they lose a life.

The game tests the user's impulse control, patience, working memory, focus, reaction time, and comprehension rate. It also gets harder as the game progresses.

# Points of Interest
1. Orderless, asynchronous state and view updates. Essentially: each field inside the state is its own self-contained state, enabling each field to update asynchronously instead of serially. This increases separation of concerns and reusability. State machines are notoriously fragile (for good reason) so this was necessary to increase the complexity of my application.
2. The application is available on the Google Play Store for you to try. Search: "IMPULSE!"
3. High level of effective test coverage

# Model-View-ViewModel-Presenter Design Considerations
I would like to be able to:
1. Be ignorant of the order in which state fields must be updated.
2. Be able to update the state fields asynchronously
3. Notify presenters of the state update asynchronously so they can update their view asynchronously, increasing performance significantly.
4. Interpret the state inside of presenters for communication to Views using a ViewModel
