class Usuario {
  private:
    String nombre;
    String clave;

  public:
    // funcion constructura
    Usuario(String nombre, String clave) {
      this->nombre = nombre;
      this->clave = clave;
    }

    String obtenerNombre(){
      return nombre;
    }

    String obtenerClave(){
      return clave;
    }
};

Usuario paula = Usuario("paula", "12345");

// Definir un array de usuarios
Usuario usuarios[2] = {
  Usuario("paula", "12345"),
  Usuario("juan", "67890")
};

void setup() {
  paula.obtenerClave();
}

void loop() {
}
