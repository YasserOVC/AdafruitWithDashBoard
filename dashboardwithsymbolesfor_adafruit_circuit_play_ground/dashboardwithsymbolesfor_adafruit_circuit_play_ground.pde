import processing.serial.*;

Serial port;
String[] dataLines = new String[6];
int[] capTouch = new int[8];
int light, sound;
float tempC, tempF;
boolean leftButton, rightButton, slideSwitch;

void setup() {
  size(800, 600);
  background(0);
  
  // List serial ports
  printArray(Serial.list());
  String portName = "COM7"; // Replace with your port (e.g., "COM7" or "/dev/ttyACM0")
  try {
    port = new Serial(this, portName, 9600);
    println("Connected to " + portName);
  } catch (Exception e) {
    println("Error opening serial port: " + e.getMessage());
    exit();
  }
  
  for (int i = 0; i < dataLines.length; i++) {
    dataLines[i] = "";
  }
}

void draw() {
  background(0);
  textSize(16);
  fill(255);
  
  // Capacitive Touch (Hand Symbol)
  drawHand(10, 15);
  text("Capacitive Touch:", 40, 30);
  for (int i = 0; i < 8; i++) {
    text("Pad " + i + ": " + capTouch[i], 40, 60 + i * 20);
    fill(0, 255, 0);
    rect(170, 45 + i * 20, capTouch[i] / 2, 10);
    fill(255);
  }
  
  // Light Sensor (Light Bulb Symbol)
  drawLightBulb(290, 15);
  text("Light: " + light, 320, 30);
  fill(255, 255, 0);
  rect(420, 15, light / 5, 10);
  fill(255);
  
  // Sound Level (Speaker Symbol)
  drawSpeaker(290, 45);
  text("Sound (dB): " + sound, 320, 60);
  fill(0, 255, 255);
  rect(420, 45, sound * 2, 10);
  fill(255);
  
  // Temperature (Thermometer Symbol)
  drawThermometer(290, 75);
  text("Temp C: " + tempC + "  Temp F: " + tempF, 320, 90);
  
  // Buttons (Button Symbol)
  drawButton(290, 105);
  text("Left Button: " + (leftButton ? "Pressed" : "Released"), 320, 120);
  drawButton(290, 135);
  text("Right Button: " + (rightButton ? "Pressed" : "Released"), 320, 150);
  
  // Slide Switch (Switch Symbol)
  drawSwitch(290, 165);
  text("Slide Switch: " + (slideSwitch ? "Right" : "Left"), 320, 180);
}

// Symbol Drawing Functions
void drawHand(float x, float y) {
  fill(255);
  ellipse(x + 10, y + 10, 10, 10); // Palm
  rect(x + 7, y, 2, 5); // Thumb
  rect(x + 11, y, 2, 5); // Fingers
  rect(x + 15, y, 2, 5);
}

void drawLightBulb(float x, float y) {
  fill(255, 255, 0);
  ellipse(x + 10, y + 10, 15, 15); // Bulb
  rect(x + 8, y + 15, 4, 5); // Base
}

void drawSpeaker(float x, float y) {
  fill(0, 255, 255);
  triangle(x, y + 15, x + 10, y, x + 10, y + 30); // Cone
  rect(x + 10, y + 5, 5, 10); // Body
}

void drawThermometer(float x, float y) {
  fill(255, 0, 0);
  rect(x + 8, y, 4, 20); // Tube
  ellipse(x + 10, y + 20, 10, 10); // Bulb
}

void drawButton(float x, float y) {
  fill(150);
  rect(x + 5, y, 10, 10, 3); // Rounded square button
}

void drawSwitch(float x, float y) {
  fill(150);
  rect(x, y, 20, 10); // Switch body
  fill(slideSwitch ? 0 : 255); // Toggle color based on state
  ellipse(x + (slideSwitch ? 15 : 5), y + 5, 8, 8); // Toggle
}

void serialEvent(Serial port) {
  String input = port.readStringUntil('\n');
  if (input != null) {
    input = trim(input);
    if (input.startsWith("Capacitive Touch:")) {
      String[] parts = split(input, " ");
      for (int i = 0; i < 8; i++) {
        capTouch[i] = int(parts[i + 2]);
      }
    } else if (input.startsWith("Light:")) {
      light = int(split(input, " ")[1]);
    } else if (input.startsWith("Sound:")) {
      sound = int(split(input, " ")[1]);
    } else if (input.startsWith("Temp C:")) {
      String[] parts = split(input, " ");
      tempC = float(parts[2]);
      tempF = float(parts[5]);
    } else if (input.startsWith("Left Button:")) {
      String[] parts = split(input, " ");
      leftButton = parts[2].equals("1");
      rightButton = parts[5].equals("1");
    } else if (input.startsWith("Slide Switch:")) {
      slideSwitch = int(split(input, " ")[2]) == 1;
    }
  }
}
