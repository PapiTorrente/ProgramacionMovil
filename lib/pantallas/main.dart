import 'package:flutter/material.dart';

void main() {
  runApp(const ExploraCDMX_app());
}

/* Clase principal */
class ExploraCDMX_app extends StatelessWidget {
  const ExploraCDMX_app({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inicio', //Titulo efectivo de la aplicación.
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pinkAccent),
        useMaterial3: true,
      ),
      home: const pPrincipal(title: 'Inicio'),
    );
  }
}

class pPrincipal extends StatefulWidget { //Widget con estado
  const pPrincipal({super.key, required this.title});
  final String title;
  @override
  State<pPrincipal> createState() => _pPrincipalState();
}

class _pPrincipalState extends State<pPrincipal> { //Con barra baja es una variable privada
  //Variables para cambiar entre páginas
  var _indiceMenu = 0; //Variable para cambiar entre páginas
  final PageController _controladorPagina = PageController(initialPage: 0); //Controlador de la página

  final List<Widget> _paginas = [
    /* CÓDIGO PARA LA PÁGINA PRINCIPAL */
    ListView(
      children: [
        Container(
            padding: EdgeInsets.only(top: 18),
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
                      )
                  )
                ]
            )
        ),

        /* CÓDIGO DE LA TARJETA */
        Flexible( // Tarjeta
            child: Container(
              height: 160,
              padding: EdgeInsets.all(4), // Hacia adentro
              margin: EdgeInsets.all(10), // Hacia afuera
              decoration: BoxDecoration(
                  color: Colors.pinkAccent,
                  border: Border.all(
                      width: 4,
                      color: Colors.pink
                  ),
                  borderRadius: BorderRadius.circular(8)
              ),
              child: Flexible( //Ajuste a todo el espacio disponible
                  child: Container(
                    child: Column(
                      children: [
                        Container( // Contenedor para la imagen
                          decoration: BoxDecoration( //Decoración del borde
                              border: Border.all(width: 4),
                              borderRadius: BorderRadius.circular(8)
                          ),
                          height: 76,
                        ),
                        Flexible( //Texto de Titulo
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Titulo",
                                style: TextStyle(
                                    fontSize: 26,
                                    color: Colors.black
                                ),
                              ),
                            )
                        ),
                        Flexible( //Contenedor de botón
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
    /* FIN CÓDIGO PARA LA PÁGINA PRINCIPAL */

    /* CÓDIGO PARA EL CALENDARIO */
    Column(
      children: [
        Container(
          //color: Colors.green, //Color para ¿debug?
          padding: EdgeInsets.only(top: 18),
          child: Text(
              "Calendario de Eventos",
              style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold
              )
          ),
        ),
        Flexible( //Calendario
            child: Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration( //Decoración del borde
                  border: Border.all(
                      width: 4,
                      color: Colors.pink
                  ),
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.pinkAccent
              ),
            )
        ),
        Container( //¿Botón?
          color: Colors.deepOrange,
          height: 60,
          margin: EdgeInsets.only(left: 10.0, top: 0.0, right: 10.0, bottom: 10.0),
        )
      ],
    )
    /* FIN CÓDIGO PARA EL CALENDARIO */
  ];

  void _itemPresionado(int indice){
    setState(() {
      _indiceMenu = indice; //Se establece el indice del menu con la var indice proporcionada
      _controladorPagina.animateToPage( //Anima el cambio de la pantalla
        indice,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  void _paginaCambiada(int indice) {
    setState(() {
      _indiceMenu = indice;
    });
  }

  @override
  Widget build(BuildContext context) { //Aqui va el aspecto visual.

    return Scaffold(
      /* VISTA DE LA PÁGINA SELECCIONADA */
      body: PageView(
        controller: _controladorPagina,
        children: _paginas,
        onPageChanged: _paginaCambiada,
        //Physics evita el scroll horizontal para que sea solo por el menu
        physics: const NeverScrollableScrollPhysics(),
      ),

      /* CÓDIGO DE LA BARRA DE NAVEGACIÓN */
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _indiceMenu,
        backgroundColor: Colors.pinkAccent,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black45,
        onTap: _itemPresionado,
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
      /* FIN CÓDIGO DE LA BARRA DE NAVEGACIÓN */

    );
  }
}
