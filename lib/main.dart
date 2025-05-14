//Imports para usar firebase
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart'; //Import para usar widgets y hacer interfaces
import 'package:syncfusion_flutter_calendar/calendar.dart'; //Import del calendario
import 'package:flex_color_picker/flex_color_picker.dart'; //Import del selector de color
import 'package:cupertino_calendar_picker/cupertino_calendar_picker.dart'; //Import del selector de fechas
import 'package:url_launcher/url_launcher.dart'; //Import para abrir enlaces.
import 'package:cached_network_image/cached_network_image.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ExploraCDMX_app());
}

/* CLASE PRINCIPAL */
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

/* WIDGET CON ESTADO */
class pPrincipal extends StatefulWidget {
  const pPrincipal({super.key, required this.title});
  final String title;
  @override
  State<pPrincipal> createState() => _pPrincipalState();
}

/* CLASE PRINCIPAL PARA LA PÁGINA PRINCIPAL */
class _pPrincipalState extends State<pPrincipal> {
  //VARIABLES PARA CAMBIAR ENTRE PÁGINAS
  var _indiceMenu = 0; //Variable del índice de la página
  final PageController _controladorPagina = PageController(initialPage: 0); //Controlador de la animación de la página
  List<Widget> _paginas=[]; //Lista de widgets para poner en la página
  
  //VARIABLES PARA USAR EL CALENDARIO
  DateTime? _fechaInicio = DateTime.now();
  DateTime? _fechaFinalizacion = DateTime.now();
  int ? _colorElegido; //Almacena el color del evento
  final List<Map<String,dynamic>> _visitas=[]; //Lista para almacenar los datos de los eventos

  //VARIABLES PARA LA BASE DE DATOS
  /*
  FirebaseFirestore db = FirebaseFirestore.instance; //Instancia de base de datos para interactuar con ella.
  final List<Meeting> meetings = <Meeting>[]; //Lista de objetos "Meeting" para mostrar en el widget del calendario
  final List<String> _nombresEventos=[]; //Lista para almacenar IDs de los eventos
   */

  @override
  void initState() {
    super.initState();
    _entrada(); // Llamada al método asíncrono
  }
  
  /* PÁGINAS */
  @override
  Future<void> _entrada() async {
    final snapshot = await FirebaseFirestore.instance.collection('coleccion-lugares').get();
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
                            fontFamily: 'Roboto',
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
          for (var doc in snapshot.docs)
           Flexible( // Tarjeta 999
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

                          //CONTENEDOR DE LA IMAGEN
                          Container(
                            decoration: BoxDecoration( //Decoración del borde
                                border: Border.all(width: 4),
                                borderRadius: BorderRadius.circular(8)
                            ),
                            height: 76,

                            //DESCOMENTAR CUANDO ENCONTREMOS ALMACENAR IMAGENES
                            /*
                            child: CachedNetworkImage(
                                //imageUrl: doc['imagen'],
                                imageUrl: "",
                                placeholder: (context, url) => CircularProgressIndicator(),
                                errorWidget: (context, url, error) => Icon(Icons.error),
                            ),
                             */
                          ),

                          //TEXTO DEL TITULO DE LA TARJETA
                          Flexible(
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  doc['nombre'],
                                  softWrap: true,
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black
                                  ),
                                ),
                              )
                          ),

                          //CONTENEDOR DEL TEXTO Y BOTÓN DE LA TARJETA
                          Flexible(
                              child: Row(
                                children: [
                                  Flexible(
                                      child: Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Text(
                                          doc['etiqueta'],
                                          style: TextStyle(
                                            fontSize: 18,
                                            decoration: TextDecoration.underline,
                                            color: Colors.black
                                          ),
                                        ),
                                      )
                                  ),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: ElevatedButton(
                                        style: TextButton.styleFrom(
                                            backgroundColor: Colors.pink.shade600,
                                            foregroundColor: Colors.black,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(4),
                                            )
                                        ),
                                        onPressed: (){
                                          _mostrarTarjetaGrande(0, doc);
                                        },
                                        child: Text(
                                          "Más",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold
                                          ),
                                        )
                                    ),
                                  )
                                ],
                              ),
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
          //Texto de la sección del calendario
          Container(
            padding: EdgeInsets.only(top: 18),
            child: Text(
                "Calendario",
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold
                )
            ),
          ),

          //Calendario
          Flexible(
              child: Container(
                margin: EdgeInsets.all(10), //Hacia afuera
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 4,
                    color: Colors.pink
                  ),
                  borderRadius: BorderRadius.circular(8)
                ),
                child: SfCalendar(
                  view: CalendarView.month,
                  initialSelectedDate: DateTime.now(),
                  headerStyle: CalendarHeaderStyle(
                    backgroundColor: Colors.pinkAccent,
                    textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                    )
                  ),
                  cellBorderColor: Colors.transparent,
                  todayHighlightColor: Colors.pink,
                  selectionDecoration: BoxDecoration(
                    color: Colors.transparent
                  ),
                  monthViewSettings: MonthViewSettings(
                    showAgenda: true,
                  ),
                  //dataSource: MeetingDataSource(_getDataSource(_nombresEventos,_eventos)),
                ),
              )
          )
        ],
      )
      /* FIN CÓDIGO PARA EL CALENDARIO */
    ];
  }

  /* FUNCIÓN PARA MOSTRAR LA TARJETA GRANDE */
  void _mostrarTarjetaGrande(int idBD, doc){
    String eWeb = '${doc['enlaceWeb']}';
    final enlace = Uri.parse(eWeb);
    print('Nombre del lugar: ${doc['nombre']}');
    showDialog(
      builder: (context){
        return Flexible(
            child: Container(
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

              //CONTENIDO DENTRO DE LA TARJETA GRANDE
              child: Flexible(
                  child: Container(
                    child: Column(
                      children: [
                        Container( //CONTENEDOR PARA LA IMAGEN EN LA TARJETA GRANDE
                            height: 170,
                            decoration: BoxDecoration( //DECORACIÓN DEL BORDE
                                border: Border.all(width: 4),
                                borderRadius: BorderRadius.circular(8)
                            )
                        ),

                        //TEXTO DEL TITULO DE LA TARJETA GRANDE
                        Flexible(
                            flex: 0,
                            child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "${doc['nombre']}",
                                  softWrap: true,
                                  style: TextStyle(
                                      fontSize: 32,
                                      color: Colors.black,
                                      decoration: TextDecoration.none,
                                      fontWeight: FontWeight.bold
                                  ),
                                )
                            )
                        ),

                        //TEXTO DE LA DESCRIPCIÓN
                        Container(
                          margin: EdgeInsets.only(top:4, bottom: 4),
                          child: Flexible(
                              child: Column(
                                children: [

                                  //CONTENEDOR DEL TEXTO DESCRIPCIÓN
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.text_snippet_outlined,
                                          size: 24,
                                        ),
                                        Text(
                                          "Descripción:",
                                          style: TextStyle(
                                              fontSize: 24,
                                              color: Colors.black,
                                              decoration: TextDecoration.none
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  //CONTENEDOR DEL TEXTO "DESCRIPCIÓN QUE DEBE CAMBIARSE DINÁMICAMENTE
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "${doc['descripcion']}",
                                      softWrap: true,
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.black,
                                          decoration: TextDecoration.none
                                      ),
                                    ),
                                  )
                                ],
                              )
                          ),
                        ),

                        //TEXTO DE LA UBICACIÓN
                        Container(
                          margin: EdgeInsets.only(top:4, bottom: 4),
                          child: Flexible(
                              child: Column(
                                children: [

                                  //CONTENEDOR DEL TEXTO UBICACIÓN
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.location_on_outlined,
                                          size: 24,
                                        ),
                                        Text(
                                          "Ubicación:",
                                          style: TextStyle(
                                              fontSize: 24,
                                              color: Colors.black,
                                              decoration: TextDecoration.none
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  //CONTENEDOR DEL TEXTO "UBICACIÓN" QUE DEBE CAMBIARSE DINÁMICAMENTE
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "${doc['ubicacion']}",
                                      softWrap: true,
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.black,
                                          decoration: TextDecoration.none
                                      ),
                                    ),
                                  )
                                ],
                              )
                          ),
                        ),

                        //TEXTO DEL HORARIO
                        Container(
                          margin: EdgeInsets.only(top:4, bottom: 4),
                          child: Flexible(
                            child: Column(
                              children: [

                                //CONTENEDOR DEL TEXTO HORARIO
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.access_time_outlined,
                                        size: 24,
                                      ),
                                      Text(
                                        "Horario:",
                                        style: TextStyle(
                                            fontSize: 24,
                                            color: Colors.black,
                                            decoration: TextDecoration.none
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                //CONTENEDOR DEL TEXTO "HORARIO" QUE DEBE CAMBIARSE DINÁMICAMENTE
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "${doc['horario']}",
                                    softWrap: true,
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        decoration: TextDecoration.none
                                    ),
                                  ),
                                )
                              ],
                            ),

                          ),
                        ),

                        //CONTENEDOR PARA EL ENLACE WEB
                        Flexible(
                            child: Column(
                              children: [

                                //ESPACIO PARA EL TEXTO DEL ENLACE WEB
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.link,
                                        size: 24,
                                      ),
                                      Text(
                                        "Sitio Web:",
                                        style: TextStyle(
                                            fontSize: 24,
                                            color: Colors.black,
                                            decoration: TextDecoration.none
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                //ESPACIO PARA EL BOTÓN DEL ENLACE WEB DÓNDE DEBE COLOCARSE EL ENLACE DINÁMICAMENTE
                                ElevatedButton(
                                  style: TextButton.styleFrom(
                                      backgroundColor: Colors.pink.shade600,
                                      foregroundColor: Colors.black,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4),
                                      )
                                  ),
                                  onPressed: () =>setState(() {
                                    launchUrl(
                                        enlace,
                                        mode: LaunchMode.externalApplication
                                    );
                                  }),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      eWeb,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  )
                                ),
                              ],
                            ),
                        ),

                        //ESPACIO PARA LOS BOTONES DE LA TARJETA GRANDE
                        Row(
                          children: [
                            //CONTENEDOR DEL BOTÓN PARA AGREGAR EVENTO
                            Flexible(
                                child: Align(
                                  alignment: Alignment.bottomLeft,
                                  child: ElevatedButton(
                                      style: TextButton.styleFrom(
                                          backgroundColor: Colors.pink.shade600,
                                          foregroundColor: Colors.black,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(4),
                                          )
                                      ),
                                      onPressed: (){
                                        Navigator.of(context).pop();
                                        _agregarAlCalendario(0);
                                      },
                                      child: Text(
                                        "Agendar",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold
                                        ),
                                      )
                                  ),
                                )
                            ),

                            //CONTENEDOR DEL BOTÓN PARA CERRAR LA TARJETA GRANDE
                            Flexible(
                                child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: ElevatedButton(
                                      style: TextButton.styleFrom(
                                          backgroundColor: Colors.pink.shade600,
                                          foregroundColor: Colors.black,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(4),
                                          )
                                      ),
                                      onPressed: (){
                                        Navigator.of(context).pop();
                                      },
                                      child: Text(
                                        "Cerrar",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold
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
  /* FIN FUNCIÓN PARA MOSTRAR TARJETA GRANDE */

  /* FUNCIÓN PARA AGREGAR EL LUGAR AL CALENDARIO */
  void _agregarAlCalendario(int idBD){
    showDialog(
      builder: (context){
        return Flexible(
            child: Container(
              height: 200,
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

              //CONTENIDO DENTRO DE LA TARJETA DE AGREGAR AL CALENDARIO
              child: Flexible(
                  child: Column(
                    children: [

                      //CONTENEDOR PARA EL TEXTO DE LA FECHA DE INICIO
                      Flexible(
                        flex: 0,
                          child: Align(
                            alignment: Alignment.center,
                            child: Container(
                              margin: EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                  color: Colors.pink.shade600,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      width: 3,
                                      color: Colors.pink.shade700
                                  )
                              ),
                              child: Column(
                                children: [
                                    Text(
                                      "Día y hora de Inicio:",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.black,
                                          decoration: TextDecoration.none
                                      ),
                                    ),
                                    SizedBox(
                                      child: CupertinoCalendarPickerButton(
                                        buttonDecoration: PickerButtonDecoration(
                                            backgroundColor: Colors.pink.shade700
                                        ),
                                        minimumDateTime: DateTime(2024, 7, 10),
                                        maximumDateTime: DateTime(2025, 7, 10),
                                        initialDateTime: DateTime.now(),
                                        currentDateTime: DateTime.now(),
                                        mode: CupertinoCalendarMode.dateTime,
                                        timeLabel: 'Inicio',
                                        onDateTimeChanged: (date) {
                                          _fijarFechaInicial(date);
                                        },),
                                    ),
                                ],
                              ),
                            )
                          )
                      ),

                      //CONTENEDOR PARA EL TEXTO DE LA FECHA DE FINALIZACIÓN
                      Flexible(
                        flex: 0,
                          child: Align(
                            alignment: Alignment.center,
                            child: Container(
                              margin: EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                  color: Colors.pink.shade600,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      width: 3,
                                      color: Colors.pink.shade700
                                  )
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    "Día y hora de Finalización:",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        decoration: TextDecoration.none
                                    ),
                                  ),
                                  SizedBox(
                                    child: CupertinoCalendarPickerButton(
                                      buttonDecoration: PickerButtonDecoration(
                                          backgroundColor: Colors.pink.shade700
                                      ),
                                      minimumDateTime: DateTime.now(),
                                      maximumDateTime: DateTime(2080, 12, 12),
                                      initialDateTime: DateTime.now(),
                                      currentDateTime: DateTime.now(),
                                      mode: CupertinoCalendarMode.dateTime,
                                      timeLabel: 'Final',
                                      onDateTimeChanged: (date) {
                                        _fijarFechaFinal(date);
                                      },),
                                  ),
                                ],
                              ),
                            )
                          )
                      ),

                      //CONTENEDOR PARA LA ELECCIÓN DE COLOR
                      Flexible(
                          child: Align(
                            alignment: Alignment.center,
                            child: Container(
                              margin: EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                color: Colors.pink.shade600,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  width: 3,
                                  color: Colors.pink.shade700
                                )
                              ),
                              child: ColorPicker(
                                heading: Text(
                                  "Elige un color",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      decoration: TextDecoration.none
                                  ),
                                ),
                                subheading: Text(
                                  "Elige la variación",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      decoration: TextDecoration.none
                                  ),
                                ),
                                onColorChanged: (value){
                                  _colorElegido = value.value32bit;
                                },
                              ),
                            )
                          )
                      ),

                      //ESPACIO PARA LOS BOTONES DE LA PANTALLA DE AGENDAR EVENTO
                      Row(
                        children: [
                          //CONTENEDOR DEL BOTÓN DE FINALIZAR AGENDA
                          Flexible(
                              child: Align(
                                alignment: Alignment.bottomLeft,
                                child: ElevatedButton(
                                    style: TextButton.styleFrom(
                                        backgroundColor: Colors.pink.shade600,
                                        foregroundColor: Colors.black,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(4),
                                        )
                                    ),
                                    onPressed: (){
                                      _agendarVisitaLugar();

                                      //Reestablece los valores
                                      _fechaInicio = DateTime.now();
                                      _fechaFinalizacion = DateTime.now();
                                      _colorElegido = 0;

                                      //Cierra la tarjeta de agregar
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      "¡Todo Listo!",
                                      style: TextStyle(
                                          color: Colors.black
                                      ),
                                    )
                                ),
                              )
                          ),

                          //CONTENEDOR DEL BOTÓN PARA CERRAR LA TARJETA DE AGENDAR
                          Flexible(
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: ElevatedButton(
                                    style: TextButton.styleFrom(
                                        backgroundColor: Colors.pink.shade600,
                                        foregroundColor: Colors.black,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(4),
                                        )
                                    ),
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
                  )
              ),
            )
        );
      },
      context: context,
    );
  }
  /* FIN FUNCIÓN PARA AGREGAR EL LUGAR AL CALENDARIO */

  /* FUNCIONES PARA CAMBIAR DE PANTALLA EN EL MENÚ BAJO */
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
  /* FIN DE FUNCIONES PARA CAMBIAR DE PANTALLA EN EL MENÚ BAJO */

  /* FUNCIONES PARA AGENDAR EVENTOS EN EL CALENDARIO */
  void _fijarFechaInicial(DateTime fechaNueva){
    setState(() { _fechaInicio = fechaNueva; });
  }

  void _fijarFechaFinal(DateTime fechaNueva){
    setState(() { _fechaFinalizacion = fechaNueva; });
  }

  void _agendarVisitaLugar() async{
    Map<String, dynamic> datos = {
      "fechaInicio":_fechaInicio,
      "fechaFinalizacion":_fechaFinalizacion,
      "color":_colorElegido
    };
    //await db.collection("visita").doc(_nombreEvento.text).set(datos);
  }

  //ARREGLAR ESTA PARTE
  void _obtenerVisitaLugar() async{
    //QuerySnapshot visitas = await db.collection("visita").get();
    /*
    for(DocumentSnapshot visita in visitas.docs){
      _visitas.add(visita.data() as Map<String, dynamic>);
    }
     */
    setState(() {  });
  }
  /* FIN FUNCIONES PARA AGENDAR EVENTOS EN EL CALENDARIO */

  /* ASPECTO VISUAL DE LA APLICACIÓN*/
  @override
  Widget build(BuildContext context) { //Aqui va el aspecto visual.

    return Scaffold(
      /* CÓDIGO DE LA VISTA DE LA PÁGINA SELECCIONADA */
      body: PageView(
        controller: _controladorPagina,
        onPageChanged: _paginaCambiada,
        //Physics evita el scroll horizontal para que sea solo por el menu
        physics: const NeverScrollableScrollPhysics(),
        children: _paginas,
      ),

      /* FIN CÓDIGO DE LA VISTA DE LA PÁGINA SELECCIONADA */

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
  /* FIN ASPECTO VISUAL DE LA APLICACIÓN */


  //ESTO NO SÉ PARA QUÉ ES
  /*
  List<Meeting> _getDataSource(List<String> nombresEventos, List<Map<String,dynamic>> eventos) {
    for(int i=0;i<nombresEventos.length;i++){
      DateTime fechaInicio=(eventos[i]["fechaInicio"] as Timestamp).toDate();
      DateTime fechaFinal=(eventos[i]["fechaFinal"] as Timestamp).toDate();

      meetings.add(
          Meeting(
              nombresEventos[i],
              fechaInicio,
              fechaFinal,
              Color(eventos[i]["color"])
          )
      );
    }
    return meetings;
  }
  */
}

/* CÓDIGO CREADO EN LA CLASE DE PROGRAMACIÓN MÓVIL */
class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }
}

class Meeting {
  Meeting(this.eventName, this.from, this.to, this.background);
  String eventName;
  DateTime from;
  DateTime to;
  Color background;
}
