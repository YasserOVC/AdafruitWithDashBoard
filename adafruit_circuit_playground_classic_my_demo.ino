#include <Adafruit_CircuitPlayground.h>

void setup() {
  Serial.begin(9600);
  while (!Serial) {
    delay(10);
  }
  CircuitPlayground.begin();
}

void loop() {
  Serial.print("Capacitive Touch: ");
  for (int i = 0; i < 8; i++) {
    Serial.print(CircuitPlayground.readCap(i));
    Serial.print(" ");
  }
  Serial.println();

  Serial.print("Light: ");
  Serial.println(CircuitPlayground.lightSensor());

  Serial.print("Sound: ");
  Serial.println(CircuitPlayground.mic.soundPressureLevel(10));

  Serial.print("Temp C: ");
  Serial.print(CircuitPlayground.temperature());
  Serial.print(" Temp F: ");
  Serial.println(CircuitPlayground.temperatureF());

  Serial.print("Left Button: ");
  Serial.print(CircuitPlayground.leftButton());
  Serial.print(" Right Button: ");
  Serial.println(CircuitPlayground.rightButton());

  Serial.print("Slide Switch: ");
  Serial.println(CircuitPlayground.slideSwitch());

  Serial.println("---");
  delay(1000);
}
