const int D0 = 16; //GPIO16 - WAKE UP //buzzer
const int D1 = 5;  //GPIO5
const int D2 = 4;  //GPIO4
const int D3 = 0;  //GPIO0
const int LED_INTERNO = 2;  //GPIO2 - TXD1

const int D5 = 14; //GPIO14 - HSCLK
const int D6 = 12; //GPIO12 - HMISO
const int D7 = 13; //GPIO13 - HMOSI - RXD2
const int D8 = 15; //GPIO15 - HCS   - TXD2
const int RX = 3;  //GPIO3 - RXD0 
const int TX = 1;  //GPIO1 - TXD0

void parpadearLed (int pin, int ms) {
  digitalWrite(pin, HIGH);
  delay(ms);
  digitalWrite(pin, LOW);
  delay(ms);
}

void pulsarBuzzer (int buzzer, int ms) {
  digitalWrite(buzzer, HIGH);
  delay(ms);
  digitalWrite(buzzer, LOW);
  delay(ms);
}

void cambiarModo (int pin_boton1, int pin_led1, int pin_boton2, int pin_led2) {
  if (digitalRead(pin_boton1) == LOW) {
    digitalWrite (pin_led1, HIGH);
    digitalWrite (pin_led2, LOW);
  }
    if (digitalRead(pin_boton2) == LOW) {
    digitalWrite (pin_led2, HIGH);
    digitalWrite (pin_led1, LOW);
  }
}


void setup() {
  // configuramos los pines que serán leds
  pinMode(LED_INTERNO, OUTPUT);
  // D2 led verde 
  pinMode(D2, OUTPUT);
  // D3 led rojo
  pinMode(D3, OUTPUT);
  // D0 conectado un buzzer
  pinMode(D0, OUTPUT);
  // D1 esta conectado boton verde de entrada 
  pinMode(D1, INPUT_PULLUP);
  // D5 esta conectado boton rojo de entrada 
  pinMode(D5, INPUT_PULLUP);
}

void loop() {
  cambiarModo(D1, D2, D5,D3);
  
}
