#include <Arduino.h>
#include <ESP8266HTTPClient.h>
#include <ESP8266WiFi.h>
#include <MFRC522.h>
#include <SPI.h>
#include <WiFiClientSecure.h>

const int D0 = 16; // GPIO16 - WAKE UP //buzzer
const int D1 = 5;  // GPIO5
const int D2 = 4;  // GPIO4
const int D3 = 0;  // GPIO0
const int D4 = 2;  // GPIO2 - TXD1
const int D5 = 14; // GPIO14 - HSCLK
const int D6 = 12; // GPIO12 - HMISO
const int D7 = 13; // GPIO13 - HMOSI - RXD2
const int D8 = 15; // GPIO15 - HCS   - TXD2
const int RX = 3;  // GPIO3 - RXD0
const int TX = 1;  // GPIO1 - TXD0
const int S3 = 10;
const int S2 = 9;

const int SS_PIN = D8;
const int RST_PIN = D0;
const int BUZZER = D1;
const int BOTON = D2;
const int LED_VERDE = D3;
const int LED_ROJO = D4;

String modo = "check-out";
bool estadoAnteriorBoton = HIGH; // Estado inicial del botón (no presionado)
unsigned long ultimaPulsacion = 0;
unsigned long intervaloDebounce = 100;

MFRC522 rfid(SS_PIN, RST_PIN); // Instance of the class
MFRC522::MIFARE_Key key;
// Init array that will store new NUID
byte nuidPICC[4];

// xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
String DatoHex;
const String UserReg_1 = "F3073CF6";
const String UserReg_2 = "766BD999";
const String UserReg_3 = "";
// xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

const char IRG_Root_X1[] PROGMEM = R"CERT(
-----BEGIN CERTIFICATE-----
MIIDdzCCAl+gAwIBAgIEAgAAuTANBgkqhkiG9w0BAQUFADBaMQswCQYDVQQGEwJJ
RTESMBAGA1UEChMJQmFsdGltb3JlMRMwEQYDVQQLEwpDeWJlclRydXN0MSIwIAYD
VQQDExlCYWx0aW1vcmUgQ3liZXJUcnVzdCBSb290MB4XDTAwMDUxMjE4NDYwMFoX
DTI1MDUxMjIzNTkwMFowWjELMAkGA1UEBhMCSUUxEjAQBgNVBAoTCUJhbHRpbW9y
ZTETMBEGA1UECxMKQ3liZXJUcnVzdDEiMCAGA1UEAxMZQmFsdGltb3JlIEN5YmVy
VHJ1c3QgUm9vdDCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAKMEuyKr
mD1X6CZymrV51Cni4eiVgLGw41uOKymaZN+hXe2wCQVt2yguzmKiYv60iNoS6zjr
IZ3AQSsBUnuId9Mcj8e6uYi1agnnc+gRQKfRzMpijS3ljwumUNKoUMMo6vWrJYeK
mpYcqWe4PwzV9/lSEy/CG9VwcPCPwBLKBsua4dnKM3p31vjsufFoREJIE9LAwqSu
XmD+tqYF/LTdB1kC1FkYmGP1pWPgkAx9XbIGevOF6uvUA65ehD5f/xXtabz5OTZy
dc93Uk3zyZAsuT3lySNTPx8kmCFcB5kpvcY67Oduhjprl3RjM71oGDHweI12v/ye
jl0qhqdNkNwnGjkCAwEAAaNFMEMwHQYDVR0OBBYEFOWdWTCCR1jMrPoIVDaGezq1
BE3wMBIGA1UdEwEB/wQIMAYBAf8CAQMwDgYDVR0PAQH/BAQDAgEGMA0GCSqGSIb3
DQEBBQUAA4IBAQCFDF2O5G9RaEIFoN27TyclhAO992T9Ldcw46QQF+vaKSm2eT92
9hkTI7gQCvlYpNRhcL0EYWoSihfVCr3FvDB81ukMJY2GQE/szKN+OMY3EU/t3Wgx
jkzSswF07r51XgdIGn9w/xZchMB5hbgF/X++ZRGjD8ACtPhSNzkE1akxehi/oCr0
Epn3o0WC4zxe9Z2etciefC7IpJ5OCBRLbf1wbWsaY71k5h+3zvDyny67G7fyUIhz
ksLi4xaNmjICq44Y3ekQEe5+NauQrz4wlHrQMz2nZQ/1/I6eYs9HRCwBXbsdtTLS
R9I4LtD+gdwyah617jzV/OeBHRnDJELqYzmp
-----END CERTIFICATE-----
)CERT";

const char *ssid = "Integramundo";
const char *password = "integramundo2023";

String url = "https://flask-asistencia-odoo.onrender.com/hello/paula";

X509List cert(IRG_Root_X1);

void parpadearLed(int pin, int ms) {
  digitalWrite(pin, HIGH);
  delay(ms);
  digitalWrite(pin, LOW);
  delay(ms);
}

void pulsarBuzzer(int buzzer, int ms) {
  // LOW PRENDER HIGH APAGA
  digitalWrite(buzzer, LOW);
  delay(ms);
  digitalWrite(buzzer, HIGH);
  delay(ms);
}

void registrarUsuario (String DatoHex){
    if (UserReg_1 == DatoHex) {
      Serial.println("USUARIO 1 - PUEDE INGRESAR");

      WiFiClientSecure client;

      if ((WiFi.status() == WL_CONNECTED)) {

        client.setTrustAnchors(&cert);

        HTTPClient https;

        Serial.print("[HTTPS] begin...\n");

        if (modo == "check-in") {
          url = "https://flask-asistencia-odoo.onrender.com/hello/check-in";
        } else  {
          url = "https://flask-asistencia-odoo.onrender.com/hello/check-out";
        }

        if (https.begin(client, url)) { // HTTPS

          Serial.print("[HTTPS] GET...\n");
          int httpCode = https.GET();

          if (httpCode > 0) {
            Serial.printf("[HTTPS] GET... code: %d\n", httpCode);
            if (httpCode == HTTP_CODE_OK ||
                httpCode == HTTP_CODE_MOVED_PERMANENTLY) {
              String payload = https.getString();
              Serial.println(payload);
              pulsarBuzzer(BUZZER, 150);
              pulsarBuzzer(BUZZER, 150);
            }
          } else {
            Serial.printf("[HTTPS] GET... failed, error: %s\n",
                          https.errorToString(httpCode).c_str());
            pulsarBuzzer(BUZZER, 150);
            pulsarBuzzer(BUZZER, 150);
            pulsarBuzzer(BUZZER, 150);
          }

          https.end();
        } else {
          Serial.printf("[HTTPS] Unable to connect\n");
        }
      }
    } else {
      Serial.println("NO ESTA REGISTRADO - PROHIBIDO EL INGRESO");
      pulsarBuzzer(BUZZER, 150);
      pulsarBuzzer(BUZZER, 150);
      pulsarBuzzer(BUZZER, 150);
    }
}

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

String printHex(byte *buffer, byte bufferSize) {
  String DatoHexAux = "";
  for (byte i = 0; i < bufferSize; i++) {
    if (buffer[i] < 0x10) {
      DatoHexAux = DatoHexAux + "0";
      DatoHexAux = DatoHexAux + String(buffer[i], HEX);
    } else {
      DatoHexAux = DatoHexAux + String(buffer[i], HEX);
    }
  }

  for (int i = 0; i < DatoHexAux.length(); i++) {
    DatoHexAux[i] = toupper(DatoHexAux[i]);
  }
  return DatoHexAux;
}

void setup() {
  pinMode(BOTON, INPUT_PULLUP);
  pinMode(LED_VERDE, OUTPUT);
  pinMode(LED_ROJO, OUTPUT);
  pinMode(BUZZER, OUTPUT);

  // partir con el buzzer apagado
  digitalWrite(BUZZER, HIGH);

  Serial.begin(115200);
  // Serial.setDebugOutput(true);

  SPI.begin();     // Init SPI bus
  rfid.PCD_Init(); // Init MFRC522
  Serial.println();
  Serial.print(F("Reader :"));
  rfid.PCD_DumpVersionToSerial();
  for (byte i = 0; i < 6; i++) {
    key.keyByte[i] = 0xFF;
  }
  DatoHex = printHex(key.keyByte, MFRC522::MF_KEY_SIZE);
  Serial.println();
  Serial.println();
  Serial.println("Iniciando el Programa");

  Serial.println();
  Serial.println();
  Serial.println();

  // Connect to Wi-Fi
  WiFi.mode(WIFI_STA);
  WiFi.begin(ssid, password);
  Serial.print("Connecting to WiFi ..");
  while (WiFi.status() != WL_CONNECTED) {
    Serial.print('.');
    delay(1000);
  }

  // Set time via NTP, as required for x.509 validation
  configTime(3 * 3600, 0, "pool.ntp.org", "time.nist.gov");

  Serial.print("Waiting for NTP time sync: ");
  time_t now = time(nullptr);
  while (now < 8 * 3600 * 2) {
    delay(500);
    Serial.print(".");
    now = time(nullptr);
  }
  Serial.println("");
  struct tm timeinfo;
  gmtime_r(&now, &timeinfo);
  Serial.print("Current time: ");
  Serial.print(asctime(&timeinfo));

  // partimos en modo check-in
  cambiarModo(LED_VERDE, LED_ROJO);
}

void loop() {
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

  // Reset the loop if no new card present on the sensor/reader. This saves the
  // entire process when idle.
  if (!rfid.PICC_IsNewCardPresent()) {
    return;
  }

  // Verify if the NUID has been readed
  if (!rfid.PICC_ReadCardSerial()) {
    return;
  }

  Serial.print(F("PICC type: "));
  MFRC522::PICC_Type piccType = rfid.PICC_GetType(rfid.uid.sak);
  Serial.println(rfid.PICC_GetTypeName(piccType));
  // Check is the PICC of Classic MIFARE type
  if (piccType != MFRC522::PICC_TYPE_MIFARE_MINI &&
      piccType != MFRC522::PICC_TYPE_MIFARE_1K &&
      piccType != MFRC522::PICC_TYPE_MIFARE_4K) {
    Serial.println("Su Tarjeta no es del tipo MIFARE Classic.");
    return;
  }

  if (rfid.uid.uidByte[0] != nuidPICC[0] ||
      rfid.uid.uidByte[1] != nuidPICC[1] ||
      rfid.uid.uidByte[2] != nuidPICC[2] ||
      rfid.uid.uidByte[3] != nuidPICC[3]) {
    Serial.println("Se ha detectado una nueva tarjeta.");

    pulsarBuzzer(BUZZER, 150);

    // Store NUID into nuidPICC array
    for (byte i = 0; i < 4; i++) {
      nuidPICC[i] = rfid.uid.uidByte[i];
    }

    DatoHex = printHex(rfid.uid.uidByte, rfid.uid.size);
    Serial.print("Codigo Tarjeta: ");
    Serial.println(DatoHex);

    registrarUsuario (DatoHex);


    Serial.println();
  } else {
    Serial.println("Tarjeta leida previamente");
  }
  // Halt PICC
  rfid.PICC_HaltA();
  // Stop encryption on PCD
  rfid.PCD_StopCrypto1();
}