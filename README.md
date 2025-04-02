# Circuit Playground Classic Sensor Dashboard

This project uses an Adafruit Circuit Playground Classic to collect sensor data and a Processing sketch to display it in a graphical dashboard. The dashboard visualizes readings from capacitive touch pads, light sensor, microphone (sound pressure level), temperature sensor, buttons, and slide switch, with intuitive symbols next to each measurement.

## Features
- **Sensors Monitored**:
  - 8 capacitive touch pads.
  - Light sensor (0–1023).
  - Sound pressure level (dB).
  - Temperature (Celsius and Fahrenheit).
  - Left and right buttons (pressed/released).
  - Slide switch (left/right).
- **Visuals**:
  - Bar graphs for capacitive touch, light, and sound.
  - Text labels for all readings.
  - Symbols: hand (touch), light bulb (light), speaker (sound), thermometer (temperature), buttons (buttons), and switch (slide switch).

## Hardware Requirements
- Adafruit Circuit Playground Classic.
- USB cable for connection to a computer.

## Software Requirements
- **Arduino IDE**:
  - Adafruit Circuit Playground library (install via Sketch > Include Library > Manage Libraries).
- **Processing**:
  - Processing IDE (download from [processing.org](https://processing.org/download)).
  - No additional libraries required (uses built-in `processing.serial`).

## Installation
1. **Arduino Setup**:
   - Open the Arduino IDE.
   - Set the board to "Adafruit Circuit Playground" (Tools > Board).
   - Select the correct COM port (Tools > Port).
   - Open `CircuitPlaygroundDemo.ino` from this repository.
   - Upload the sketch to your Circuit Playground Classic.

2. **Processing Setup**:
   - Open the Processing IDE.
   - Open `CircuitPlaygroundDashboard.pde` from this repository.
   - Update the `portName` variable in `setup()` to match your Circuit Playground’s serial port (e.g., `"COM7"` on Windows or `"/dev/ttyACM0"` on Linux/Mac). Use `printArray(Serial.list());` to find it.
   - Save and run the sketch (click "Play").

## Usage
1. Connect the Circuit Playground Classic to your computer via USB.
2. Upload the Arduino sketch (`CircuitPlaygroundDemo.ino`).
3. Close the Arduino Serial Monitor to free the serial port.
4. Run the Processing sketch (`CircuitPlaygroundDashboard.pde`).
5. The dashboard will display real-time sensor data with symbols and bar graphs.

## Files
- **`CircuitPlaygroundDemo.ino`**: Arduino sketch that sends sensor data over serial at 9600 baud.
- **`CircuitPlaygroundDashboard.pde`**: Processing sketch that reads serial data and renders the dashboard.

## Dashboard Layout
- **Left Column**: Capacitive touch values (8 pads) with green bars and a hand symbol.
- **Right Column**:
  - Light sensor with a yellow bar and light bulb symbol.
  - Sound level (dB) with a cyan bar and speaker symbol.
  - Temperature (C and F) with a thermometer symbol.
  - Left and right button states with button symbols.
  - Slide switch state with a switch symbol (toggle color changes with position).

## Troubleshooting
- **No Data in Dashboard**:
  - Ensure the Arduino sketch is running and the board is connected.
  - Verify the `portName` in Processing matches your COM port.
  - Close other programs (e.g., Arduino Serial Monitor) using the serial port.
- **Serial Error**:
  - Check the Processing console for messages (e.g., "Error opening serial port").
  - Update the port name or restart Processing if needed.
- **Debugging**:
  - Add `println(input);` in `serialEvent()` to see raw serial data:
    ```java
    void serialEvent(Serial port) {
      String input = port.readStringUntil('\n');
      if (input != null) {
        input = trim(input);
        println(input); // Debug
        // Rest of parsing code...
      }
    }
    ```

## License
This project is open-source and provided as-is for educational purposes.


