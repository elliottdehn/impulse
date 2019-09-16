# IMPULSE!
Just a simple 2D game made purely in Flutter using MVP design (inspired by medicine)

# Gameplay
Users are flashed a symbol, and are expected to respond within a certain time frame by tapping the screen. If the user does not tap in time, they lose. If the user taps again, prior to the next symbol being flashed, they lose. If the user taps a special symbol (the letter X, for now), they lose.

The game tests the user's impulse control, patience, working memory, focus, reaction time, and comprehension rate. It also gets harder as the game progresses.

# Project Goals
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

# Implemented Features (in the order they were added)
1. Generate a random letter when the user taps the text box
2. Generate a random letter periodically
3. Generate a random letter using an interval generation algorithm that I control
4. Make the random letter invisible after a breif period of time

# Planned Features (the order in which they will be added)
1. If the user taps when the symbol is an X, send them to a death/retry screen
2. Create a game statistics widget to display: score, # of symbols tapped, average reaction time
3. When the user taps on a symbol that is not an X, update the game statistics and display them to the user
4. Display the final game statistics on the death/retry screen
5. Kill the player if they tap twice on the same symbol
6. Add a minimum reaction time that is strictly less than the minimum symbol interval
7. Kill the player if they do not tap on a symbol that is not an X within the reaction window
8. Add an animated indicator in the game field to inform the user how long they have to react
9. Make the game progressively harder by decreasing how long the player has to react as the game progresses
10. Add a minimum amount of time the window can shrink to so the game doesn't become impossible

# Beyond the minimum viable product
11. Come up with various "distractions" that can be added as the game progresses, to make it harder.
12. Add some distractions.
