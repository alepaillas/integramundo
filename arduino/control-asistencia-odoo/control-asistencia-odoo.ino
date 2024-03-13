#define D0   16 //GPIO16 - WAKE UP
#define D1   5  //GPIO5
#define D2   4  //GPIO4
#define D3   0  //GPIO0
#define D4   2  //GPIO2 - TXD1

#define D5   14 //GPIO14 - HSCLK
#define D6   12 //GPIO12 - HMISO
#define D7   13 //GPIO13 - HMOSI - RXD2
#define D8   15 //GPIO15 - HCS   - TXD2
#define RX   3  //GPIO3 - RXD0 
#define TX   1  //GPIO1 - TXD0


const int buttonPin1 = D3; 
const int buttonPin2 = D4;  
  
const int ledPin1 =  D5;      
const int ledPin2 =  D6;      
const int ledPin3 =  D7;      

// variables will change:
int buttonState1 = 0;   
int buttonState2 = 0;        

void setup() 
{
  pinMode(ledPin1, OUTPUT);
  pinMode(ledPin2, OUTPUT);
  pinMode(ledPin3, OUTPUT);
  
  pinMode(buttonPin1, INPUT);
  pinMode(buttonPin2, INPUT);
}

void loop() 
{ 
  buttonState1 = digitalRead(buttonPin1);
  buttonState2 = digitalRead(buttonPin2);
  
  // check if the pushbutton is pressed.
  if (buttonState1 == HIGH) {
    // turn LED off:
    digitalWrite(ledPin2, LOW);   
  } else {
    // turn LED on:
    digitalWrite(ledPin2, HIGH);  
  }


  if (buttonState2 == HIGH) {
    // turn LED on:
    digitalWrite(ledPin1, HIGH);
    digitalWrite(ledPin3, LOW);   
  } else {
    // turn LED off:
    digitalWrite(ledPin1, LOW);
    digitalWrite(ledPin3, HIGH);   
  }
}
