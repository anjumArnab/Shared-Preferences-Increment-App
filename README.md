# Tilt Increment Counter

A simple Flutter app that utilizes SharedPreferences, Provider for state management, and gesture detection to increment and decrement a counter based on user tilting the box. The counter increases when you tilt the box to the left and decreases when you tilt it to the right.

## Features

- **Counter**: Displays the number of times the box has been tilted.
- **Gesture Detection**: The box's position and rotation are adjusted based on the horizontal drag.
- **State Management**: Uses `Provider` for state management to handle the tilt angle and counter values.
- **Persistence**: The counter value is saved using `SharedPreferences` to retain the data between app sessions.

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/anjumArnab/Tilt-Increment-Counter.git
