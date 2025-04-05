extern "C" void start(); // Entrada do arquivo Assembly

void setup(){
    Serial.begin(115200);
    start(); // Realiza a chamada do Assembly
}

void loop(){}