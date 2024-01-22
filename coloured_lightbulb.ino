int red = 11;
int redSwitch = 4;
bool redLight = false;

int green = 10;
int greenSwitch = 3;
bool greenLight = false;

int blue = 9;
int blueSwitch = 2;
bool blueLight = false;

int sensor = A0;
int sensorValue = 0;


void updateSwitches() {
  redLight = digitalRead(redSwitch);
  greenLight = digitalRead(greenSwitch);
  blueLight = digitalRead(blueSwitch);
}


void setRGB(int light) {
  light = 1023 - light;

  if(redLight) {
    analogWrite(red, light);
  }
  else {analogWrite(red, 0);}

  if(greenLight) {
    analogWrite(green, light);
  }
  else {analogWrite(green, 0);}
  
  if(blueLight) {
    analogWrite(blue, light);
  }
  else {analogWrite(blue, 0);}
}


void setup() {
  // put your setup code here, to run once:
  pinMode(red, OUTPUT);
  pinMode(green, OUTPUT);
  pinMode(blue, OUTPUT);

  pinMode(redSwitch, INPUT);
  pinMode(blueSwitch, INPUT);
  pinMode(greenSwitch, INPUT);

  Serial.begin(9600);

}


void loop() {
  // put your main code here, to run repeatedly:
  sensorValue = analogRead(sensor);
  updateSwitches();
  setRGB(sensorValue);

  Serial.println(sensorValue);
  Serial.print("red: ");
  Serial.println(redLight);
  Serial.print("green: ");
  Serial.println(greenLight); 
  Serial.print("blue: ");
  Serial.println(blueLight);
    

  //delay(10);

}
