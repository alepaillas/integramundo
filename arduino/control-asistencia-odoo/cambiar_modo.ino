const int D0 = 16; //GPIO16 - WAKE UP //buzzer
const int D1 = 5;  //GPIO5
const int D2 = 4;  //GPIO4
const int D3 = 0;  //GPIO0
const int D4 = 2;  //GPIO2 - TXD1
const int D5 = 14; //GPIO14 - HSCLK
const int D6 = 12; //GPIO12 - HMISO
const int D7 = 13; //GPIO13 - HMOSI - RXD2
const int D8 = 15; //GPIO15 - HCS   - TXD2
const int RX = 3;  //GPIO3 - RXD0 
const int TX = 1;  //GPIO1 - TXD0
const int S3 = 10;
const int S2 = 9;

const int SS_PIN = D8;
const int RST_PIN = D0;
const int BUZZER = D1;
const int BOTON = D2;
const int LED_VERDE = D3;
const int LED_ROJO = D4;

String modo = "check-in";
bool estadoAnteriorBoton = HIGH; // Estado inicial del botón (no presionado)
unsigned long ultimaPulsacion = 0;
unsigned long intervaloDebounce = 100;

void cambiarModo(int led1, int led2) {
  if (modo == "check-in") {
    modo = "check-out";
    digitalWrite(led1, HIGH);
    digitalWrite(led2, LOW);
  } else if (modo == "check-out") {
    modo = "check-in";
    digitalWrite(led2, HIGH);
    digitalWrite(led1, LOW);
  }
}

void setup() {
  pinMode(BOTON, INPUT_PULLUP);
  pinMode(LED_VERDE, OUTPUT);
  pinMode(LED_ROJO, OUTPUT);
}

void loop() {
  // Lee el estado actual del botón
  bool estadoBoton = digitalRead(BOTON);
  unsigned long tiempoActual = millis();

  // Verifica si ha pasado suficiente tiempo desde la última pulsación
  if (tiempoActual - ultimaPulsacion >= intervaloDebounce) {
    // Verifica si el botón ha cambiado de no presionado a presionado
    if (estadoBoton == LOW && estadoAnteriorBoton == HIGH) {
      cambiarModo(LED_VERDE, LED_ROJO);
      ultimaPulsacion = tiempoActual;
    }
    // Actualiza el estado anterior del botón
    estadoAnteriorBoton = estadoBoton;
  }
}
