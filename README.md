# impulse
Simple 2D game made purely in Flutter using MVP design (inspired by medicine)

# how the game works
Users are flashed a symbol, and are expected to respond within a certain time frame by tapping the screen. If the user does not tap in time, they lose. If the user taps again, prior to the next symbol being flashed, they lose. If the user taps a special symbol (the letter X, for now), they lose.

The game tests the user's impulse control, patience, working memory, focus, reaction time, and comprehension rate. It also gets harder as the game progresses.

# project goals
1. Become more fluent in Dart
2. Become more fluent in Flutter
3. Become more fluent in the mobile platform
4. Practice MVP architecture in order to create better code
5. Deploy the application on iOS and Android using a single code base
6. Practice dependency injection
7. Test my code effectively
8. Deliver usable functionality frequently
9. Springboard off of what I learn to create a more complicated project (Memebox)
10. Exercise some creative muscles by making the application visually appealing through a mixture of animations and visual design.

# MVP Design Considerations
I would like to be able to:
1. Visually represent the behavior of the game in any way, without concern for specific game mechanics or a specific game state
2. Use different game mechanics without concern for how the game is specifically displayed or a specific game state.
3. Change how the game state is represented without concern for specific game mechanics or specific display strategies
4. Deploy on both iOS and Android using one code base
5. Re-use much of my abstractions and framework to create other, completely different 2D games
