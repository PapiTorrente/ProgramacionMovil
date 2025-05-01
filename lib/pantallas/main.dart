import 'package:flutter/material.dart';

void main() {
  runApp(const MenuApp());
}

class MenuApp extends StatelessWidget {
  const MenuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inicio', //Titulo efectivo de la aplicación.
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pinkAccent),
        useMaterial3: true,
      ),
      home: const Menu(title: 'Inicio'),
    );
  }
}

class Menu extends StatefulWidget {
  const Menu({super.key, required this.title});
  final String title;
  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {

  @override
  Widget build(BuildContext context) { // Aqui va el aspecto visual.

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text(
                "¡Hola!",
                  style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold
                )
            ),
            Text(
                "¿A dónde irás hoy",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold
                ),
            ),

            /* CÓDIGO DE LA TARJETA */
            Flexible( // Tarjeta
                child: Container(
                  padding: EdgeInsets.all(4), // Hacia adentro
                  margin: EdgeInsets.all(10), // Hacia afuera
                  color: Colors.pinkAccent,
                  height: 160,
                  child: Flexible( //Ajuste a todo el espacio disponible
                      child: Container(
                        child: Column(
                          children: [
                            Container( // Contenedor para la imagen
                              color: Colors.green,
                              height: 76,
                            ),
                            Flexible( // Contenedor para el texto
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                      "Descripción: ",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black
                                      ),
                                  ),
                                )
                            ),
                            Flexible(
                                child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: ElevatedButton(
                                      onPressed: (){
                                        print("Presionado");
                                      },
                                      child: Text(
                                          "Más",
                                        style: TextStyle(
                                          color: Colors.black
                                        ),
                                      )
                                  ),
                                )
                            )
                          ],
                        ),
                      )
                  ),
                )
            )
            /* FIN DEL CÓDIGO DE LA TARJETA */

          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar( //Barra de Navegación
        backgroundColor: Colors.pinkAccent,
        selectedItemColor: Colors.black,
        items: const <BottomNavigationBarItem> [
          BottomNavigationBarItem(
            icon: Icon(
                Icons.home
            ),
            label: "Inicio"
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.calendar_month
              ),
              label: "Calendario"
          )
        ],
      ),
    );
  }
}
