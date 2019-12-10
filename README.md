# IMPULSE!
Just a simple 2D mobile game made purely in Flutter + Dart using a Model-View-ViewModel-Presenter design (inspired by a medical exam)

You may download the application from the Google Play Store. Search: "IMPULSE!"

# Gameplay
Users are flashed a symbol, and are expected to respond within a certain time frame by tapping the screen. If the user does not tap in time, they lose a life. If the user taps a special symbol (the letter X, for now), they lose a life.

The game tests the user's impulse control, patience, working memory, focus, reaction time, and comprehension rate. It also gets harder as the game progresses.

# Points of Interest
1. Orderless state updates. Essentially: each field inside the state is its own self-contained state, enabling each field to update asynchronously instead of serially. This increases separation of concerns and reusability. This was strictly necessary to increase the complexity of my application.
2. Emphasis on immutability, though not perfect.
3. Effective tests which helped execute a massive refactor without introducing chaos.

# Victories
1. I learned a whole heck of a lot just by doing my own non-trivial project. It was a great idea, and I should do it more often.
2. I set a goal of creating a functioning minimum viable product within two weeks. I was able to do this using a new language and framework that I'd never used before, so I'm proud of it.
3. By unit and integration testing my code, I was able to integrate a 1500 line refactor, and only needed to fix a small handful of resulting bugs. This startled me, and cemented the value of tests forever.

# Lessons Learned
1. Start from the top, every time! It seems I have a habit of starting with the most complicated ("mathy") parts of an application living at the bottom of the stack; this is almost always a mistake.
2. In addition to starting from the top, it's a good idea to write your tests first. Writing tests first ensures effective test coverage, but it also encourages better, more modular, more "usable and reusable" designs. You're highly unlikely to shoot yourself in the foot if you start with tests.
3. I learned a bit about functional programming by virtue of Dart's method tear-off feature. As a result, I've bought a textbook to further my study functional programming (using Scala). The repository for that is somewhere on my profile.
