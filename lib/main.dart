import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
//import 'package:firebase_core/firebase_core.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:cupertino_calendar_picker/cupertino_calendar_picker.dart';
//import 'package:flex_color_picker/flex_color_picker.dart';

void main() { //async
  //WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
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
  /*
  FirebaseFirestore db = FirebaseFirestore.instance; //Instancia de base de datos para interactuar con ella.
  final List<Meeting> meetings = <Meeting>[]; //Lista de objetos "Meeting" para mostrar en el widget del calendario
  final List<String> _nombresEventos=[]; //Lista para almacenar IDs de los eventos
  final List<Map<String,dynamic>> _eventos=[]; //Lista para almacenar los datos de los eventos
  DateTime? _fechaIn = DateTime.now(); //Fecha y hora de inicio
  DateTime? _fechaFin = DateTime.now(); //Fecha y hora de finalización
  int ? _color; //Almacena el color del evento
   */
  
  /* PÁGINAS */
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
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "Titulo",
                                  style: TextStyle(
                                      fontSize: 26,
                                      color: Colors.black
                                  ),
                                ),
                              )
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

          //Calendario
          Flexible(
              child: Container(
                padding: EdgeInsets.all(10),
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

  /* FUNCIONES PARA EL CALENDARIO */
  /*
  void _setMeeting() async{
    Map<String,dynamic> datos = {
      "color":_color,
      "fechaFinal":_fechaFin,
      "fechaInicio":_fechaIn,
    };
  }

  void _getMeeting() async{
    QuerySnapshot eventos = await db.collection("eventos").get();
    for(DocumentSnapshot evento in eventos.docs){
      _nombresEventos.add(evento.id);
      _eventos.add(evento.data() as Map<String,dynamic>);
    }
    setState(() {

    });
  }

  void _fijarFechaInicial(DateTime fechaNue){
    setState(() {
      _fechaIn=fechaNue;
    });
  }

  void _fijarFechaFinal(DateTime fechaNue){
    setState(() {
      _fechaFin=fechaNue;
    });
  }

  void _muestraColor(){
    showDialog(context: context, builder: (BuildContext context)
    {
      return AlertDialog(
        title: const Text("Color"),
        content: ColorPicker(
          onColorChanged: (value){
            _color=value.value32bit;
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Cancelar"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Aceptar"),
          ),
        ],
      );
    });
  }
  */

  /* ASPECTO VISUAL DE LA APLICACIÓN*/
  @override
  Widget build(BuildContext context) { //Aqui va el aspecto visual.

    return Scaffold(
      /* CÓDIGO DE LA VISTA DE LA PÁGINA SELECCIONADA */
      body: PageView(
        controller: _controladorPagina,
        children: _paginas,
        onPageChanged: _paginaCambiada,
        //Physics evita el scroll horizontal para que sea solo por el menu
        physics: const NeverScrollableScrollPhysics(),
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

/* ESPACIO PARA EL CALENDARIO */
/*
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

*/