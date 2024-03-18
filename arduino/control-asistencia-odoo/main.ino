#include <Arduino.h>
#include <SPI.h>
#include <MFRC522.h>

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

MFRC522 rfid(SS_PIN, RST_PIN); // Instance of the class
MFRC522::MIFARE_Key key;
// Init array that will store new NUID
byte nuidPICC[4];

//xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
String DatoHex;
const String UserReg_1 = "F3073CF6";
const String UserReg_2 = "";
const String UserReg_3 = "";
//xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

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


void setup() 
{
  pinMode(BOTON, INPUT_PULLUP);
  pinMode(LED_VERDE, OUTPUT);
  pinMode(LED_ROJO, OUTPUT);
  pinMode(BUZZER, OUTPUT);
 


   Serial.begin(115200);
   SPI.begin(); // Init SPI bus
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
 

}

void loop() 
{
digitalWrite(BUZZER, HIGH);
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

     // Reset the loop if no new card present on the sensor/reader. This saves the entire process when idle.
     if ( ! rfid.PICC_IsNewCardPresent()){return;}
     
     // Verify if the NUID has been readed
     if ( ! rfid.PICC_ReadCardSerial()){return;}
     
     Serial.print(F("PICC type: "));
     MFRC522::PICC_Type piccType = rfid.PICC_GetType(rfid.uid.sak);
     Serial.println(rfid.PICC_GetTypeName(piccType));
     // Check is the PICC of Classic MIFARE type
     if (piccType != MFRC522::PICC_TYPE_MIFARE_MINI && piccType != MFRC522::PICC_TYPE_MIFARE_1K && piccType != MFRC522::PICC_TYPE_MIFARE_4K)
     {
       Serial.println("Su Tarjeta no es del tipo MIFARE Classic.");
       return;
     }
     
     if (rfid.uid.uidByte[0] != nuidPICC[0] || rfid.uid.uidByte[1] != nuidPICC[1] || rfid.uid.uidByte[2] != nuidPICC[2] || rfid.uid.uidByte[3] != nuidPICC[3] )
     {
       Serial.println("Se ha detectado una nueva tarjeta.");
       
       // Store NUID into nuidPICC array
       for (byte i = 0; i < 4; i++) {nuidPICC[i] = rfid.uid.uidByte[i];}
    
       DatoHex = printHex(rfid.uid.uidByte, rfid.uid.size);
       Serial.print("Codigo Tarjeta: "); Serial.println(DatoHex);
    
       if(UserReg_1 == DatoHex)
       {
        Serial.println("USUARIO 1 - PUEDE INGRESAR");
        pulsarBuzzer ( BUZZER, 300);   
       }
       else if(UserReg_2 == DatoHex)
       {
        Serial.println("USUARIO 2 - PUEDE INGRESAR");
       }
       else if(UserReg_3 == DatoHex)
       {
        Serial.println("USUARIO 3 - PUEDE INGRESAR");
       }
       else
       {
        Serial.println("NO ESTA REGISTRADO - PROHIBIDO EL INGRESO");
        pulsarBuzzer ( BUZZER, 150);  
        pulsarBuzzer ( BUZZER, 150);  
       }  
       Serial.println();
     }
     else 
     {
      Serial.println("Tarjeta leida previamente");
     }
     // Halt PICC
     rfid.PICC_HaltA();
     // Stop encryption on PCD
     rfid.PCD_StopCrypto1();
}


String printHex(byte *buffer, byte bufferSize)
{  
   String DatoHexAux = "";
   for (byte i = 0; i < bufferSize; i++) 
   {
       if (buffer[i] < 0x10)
       {
        DatoHexAux = DatoHexAux + "0";
        DatoHexAux = DatoHexAux + String(buffer[i], HEX);  
       }
       else { DatoHexAux = DatoHexAux + String(buffer[i], HEX); }
   }
   
   for (int i = 0; i < DatoHexAux.length(); i++) {DatoHexAux[i] = toupper(DatoHexAux[i]);}
   return DatoHexAux;
}
