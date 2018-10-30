#include <Wire.h>

//Variables globales utilizadas para el sensor MPU_6050
const double pi = 3.141592654;
int16_t Acc_rawX, Acc_rawY, Acc_rawZ, Gyro_rawX, Gyro_rawY, Gyro_rawZ;
double Angulo_aceleracion_X;
double Gyro_angulo_X, angulo_total_X;
double rad_to_deg = 180/pi;
//Variables globales utilizadas para el control PID
unsigned long tiempo_actual, tiempo_previo, tiempo_previo_segundos;
unsigned long ultimo_tiempo = 0;
int tiempo_muestreo = 10;
double setPoint = -300;
double error;
double kp = 1;
double ki = 0.01;
double kd = 0;
int salida = 0;

//otras
double integral = 0;
double delta = 0;

//Definiciones del motor
#define pin_pmw_motor 6


void setup() {
  Wire.begin();
  Wire.beginTransmission(0x68);
  Wire.write(0x6b);
  Wire.write(0);
  Wire.endTransmission(true);
  Serial.begin(9600);
  delay(5000);
}

void loop() {
    tiempo_actual = millis();
    read_mpu_6050();
    compute_error();
    graph();
}

void graph(){
    Serial.print(setPoint);
    Serial.print("\t");
    Serial.print(angulo_total_X);
    Serial.print("\t");
    Serial.print(error);
    //Serial.print("\t");
    Serial.print("\t");
    Serial.println(salida);
}
 void compute_error(){
    tiempo_actual = millis();
    tiempo_previo = (tiempo_actual-ultimo_tiempo);
    tiempo_previo_segundos = (tiempo_actual - tiempo_previo) / 1000; 
        if (tiempo_previo >= tiempo_muestreo){           
                error = setPoint - angulo_total_X;             
        }
    salida = controlPID();
    analogWrite(pin_pmw_motor, salida);
}

void motor_to_setPoint(){
  analogWrite(pin_pmw_motor, map(setPoint, -84, 87, 64, 130));
}


void read_mpu_6050(){
    //Leer valores del acelerometro
    Wire.beginTransmission(0x68);
    Wire.write(0x3B);
    Wire.endTransmission(false);
    Wire.requestFrom(0x68, 6 ,true);
    Acc_rawX = Wire.read()<<8|Wire.read();
    Acc_rawY = Wire.read()<<8|Wire.read();
    Acc_rawZ = Wire.read()<<8|Wire.read();
    //Calculo de la aceleracion del acelerometro sobre el eje X
    Angulo_aceleracion_X = atan((Acc_rawY/16384.0)/sqrt(pow((Acc_rawX/16384.0),2) + pow((Acc_rawZ/16384.0),2)))*rad_to_deg;
    //Leer valores del giroscopio
    Wire.beginTransmission(0x68);
    Wire.write(0x43); 
    Wire.endTransmission(false);
    Wire.requestFrom(0x68,4,true); 
    Gyro_rawX=Wire.read()<<8|Wire.read();
    Gyro_rawY=Wire.read()<<8|Wire.read();
    Gyro_angulo_X = Gyro_rawX/131.0; 
    //Calculo del angulo utilizando la aceleracion y el valor del giroscopio sobre el eje X
    angulo_total_X = 0.98 *(angulo_total_X + Gyro_angulo_X*tiempo_previo_segundos) + 0.02*Angulo_aceleracion_X;
}

int controlPID() {
  double control = 0;
  integral += error;
  control += kp * error;
  //control += ki * integral;
  //control -= kd * delta;
  if (control < 0) {
    control = 0;
  }
  if (control > 255) {
    control = 255;
  }
  delta = error;
  return control;
}
