import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  //WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
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
  List<Widget> _paginas=[];

  //FUNCIÓN PARA MOSTRAR LA TARJETA GRANDE
  void mostrarTarjetota(int i){
    showDialog(
      builder: (context){
        return Flexible(
            child: Container(
              height: 450,
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

              //CONTENIDO DENTRO DE LA TARJETA
              child: Flexible(
                  child: Container(
                    child: Column(
                      children: [
                        Container( //CONTENEDOR PARA LA IMAGEN
                            height: 170,
                            decoration: BoxDecoration( //DECORACIÓN DEL BORDE
                                border: Border.all(width: 4),
                                borderRadius: BorderRadius.circular(8)
                            )
                        ),

                        //TEXTO DEL TITULO
                        Flexible(
                            flex: 0,
                            child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "Título",
                                  style: TextStyle(
                                      fontSize: 26,
                                      color: Colors.black
                                  ),
                                )
                            )
                        ),

                        //TEXTO DE LA DESCRIPCIÓN
                        Flexible(
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Container(
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.text_snippet_outlined,
                                      size: 19,
                                    ),
                                    Text(
                                      "Descripción:",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.black
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                        ),

                        //TEXTO DEL HORARIO
                        Flexible(
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Container(
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.location_on_outlined,
                                      size: 19,
                                    ),
                                    Text(
                                      "Ubicación:",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.black
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                        ),

                        //TEXTO DE LA UBICACIÓN
                        Flexible(
                            child: Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.access_time_outlined,
                                        size: 19,
                                      ),
                                      Text(
                                        "Horario:",
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.black
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                            )
                        ),

                        //TEXTO DEL ENLACE WEB
                        Flexible(
                            child: Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.link,
                                        size: 19,
                                      ),
                                      Text(
                                        "Sitio Web:",
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.black
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                            )
                        ),

                        //ESPACIO PARA LOS BOTONES
                        Row(
                          children: [
                            //CONTENEDOR DEL BOTÓN PARA AGREGAR EVENTO
                            Flexible(
                                child: Align(
                                  alignment: Alignment.bottomLeft,
                                  child: ElevatedButton(
                                      onPressed: (){
                                        print("Presionado Boton1");
                                      },
                                      child: Text(
                                        "Agregar Lugar",
                                        style: TextStyle(
                                            color: Colors.black
                                        ),
                                      )
                                  ),
                                )
                            ),

                            //CONTENEDOR DEL BOTÓN PARA CERRAR LA TARJETA
                            Flexible(
                                child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: ElevatedButton(
                                      onPressed: (){
                                        Navigator.of(context).pop();
                                      },
                                      child: Text(
                                        "Cerrar",
                                        style: TextStyle(
                                            color: Colors.black
                                        ),
                                      )
                                  ),
                                )
                            )
                          ],
                        )
                      ],
                    ),
                  )
              ),
            )
        );
      },
        context: context,
    );
  }

  @override
  void initState() {
    super.initState();
    _paginas = [
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
                            fontSize: 50,
                            fontWeight: FontWeight.bold
                        )
                    ),
                    Text(
                        "¿A dónde irás hoy?",
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
                padding: EdgeInsets.all(4), //Hacia adentro
                margin: EdgeInsets.all(10), //Hacia afuera
                decoration: BoxDecoration(
                    color: Colors.pinkAccent,
                    border: Border.all(
                        width: 4,
                        color: Colors.pink
                    ),
                    borderRadius: BorderRadius.circular(8)
                ),

                //CONTENIDO DENTRO  DE LA TARJETA
                child: Flexible(
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

                          //TEXTO DEL TITULO
                          Flexible(
                            child: FutureBuilder<QuerySnapshot>(
                              future: FirebaseFirestore.instance.collection('coleccion-lugares').get(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return const CircularProgressIndicator();
                                } else if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                                  return const Text('No hay lugares');
                                }

                                final lugares = snapshot.data!.docs;

                                return ListView.builder(
                                  shrinkWrap: true, // importante dentro de Flexible
                                  itemCount: lugares.length,
                                  itemBuilder: (context, index) {
                                    final data = lugares[index].data() as Map<String, dynamic>;
                                    final nombre = data['nombre'] ?? 'Sin nombre';

                                    return Text(
                                      'Nombre: $nombre',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),

                          //CONTENEDOR DEL BOTÓN
                          Flexible(
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: ElevatedButton(
                                    onPressed: (){
                                      mostrarTarjetota(0);
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

          /* CÓDIGO DE LA TARJETA GRANDE */

          /*Flexible(
            child: Container(
              height: 450,
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

              //CONTENIDO DENTRO DE LA TARJETA
              child: Flexible(
                  child: Container(
                    child: Column(
                      children: [
                        Container( //CONTENEDOR PARA LA IMAGEN
                          height: 170,
                          decoration: BoxDecoration( //DECORACIÓN DEL BORDE
                              border: Border.all(width: 4),
                              borderRadius: BorderRadius.circular(8)
                          )
                        ),

                        //TEXTO DEL TITULO
                        Flexible(
                            flex: 0,
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Titulo",
                                style: TextStyle(
                                    fontSize: 26,
                                    color: Colors.black
                                ),
                              )
                            )
                        ),

                        //TEXTO DE LA DESCRIPCIÓN
                        Flexible(
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Container(
                                child: Row(
                                  children: [
                                    Icon(
                                        Icons.text_snippet_outlined,
                                        size: 19,
                                    ),
                                    Text(
                                      "Descripción:",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.black
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                        ),

                        //TEXTO DEL HORARIO
                        Flexible(
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Container(
                                child: Row(
                                  children: [
                                    Icon(
                                        Icons.location_on_outlined,
                                        size: 19,
                                    ),
                                    Text(
                                      "Ubicación:",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.black
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                        ),

                        //TEXTO DE LA UBICACIÓN
                        Flexible(
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Container(
                                child: Row(
                                  children: [
                                    Icon(
                                        Icons.access_time_outlined,
                                        size: 19,
                                    ),
                                    Text(
                                      "Horario:",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.black
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            )
                        ),

                        //ESPACIO PARA LOS BOTONES
                        Row(
                          children: [
                            //CONTENEDOR DEL BOTÓN PARA AGREGAR EVENTO
                            Flexible(
                                child: Align(
                                  alignment: Alignment.bottomLeft,
                                  child: ElevatedButton(
                                      onPressed: (){
                                        print("Presionado Boton1");
                                      },
                                      child: Text(
                                        "Agregar Lugar",
                                        style: TextStyle(
                                            color: Colors.black
                                        ),
                                      )
                                  ),
                                )
                            ),

                            //CONTENEDOR DEL BOTÓN PARA CERRAR LA TARJETA
                            Flexible(
                                child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: ElevatedButton(
                                      onPressed: (){
                                        print("Presionado Boton2");
                                      },
                                      child: Text(
                                        "Cerrar",
                                        style: TextStyle(
                                            color: Colors.black
                                        ),
                                      )
                                  ),
                                )
                            )
                          ],
                        )
                      ],
                    ),
                  )
              ),
            )
        )
        */
          /* FIN DEL CÓDIGO DE LA TARJETA GRANDE */

        ],
      ),
      /* FIN CÓDIGO PARA LA PÁGINA PRINCIPAL */

      /* CÓDIGO PARA EL CALENDARIO */
      Column(
        children: [
          //Texto de la sección del calendario
          Container(
            padding: EdgeInsets.only(top: 18),
            child: Text(
                "Tu Calendario de Eventos",
                style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold
                )
            ),
          ),

          //Placeholder para el calendario
          Placeholder(

          )
        ],
      )
      /* FIN CÓDIGO PARA EL CALENDARIO */
    ];
  }



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
