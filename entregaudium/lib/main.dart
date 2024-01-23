import 'dart:io';
import 'dart:typed_data';

import 'package:entregaudium/view/userscreen/UserDetails.dart';
import 'package:entregaudium/viewmodel/userdetails/userdetails_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'dart:ui' as ui;

import 'package:provider/provider.dart';


void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => UserDetailsViewModel(),
    child: MyApp())
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  /*
  * O MaterialApp foi substituído pelo GetMaterialApp para que o gerenciamento
  * de páginas do aplicativo seja feito pelo Get, através de rotas.
  * */
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Entregaudium',
      theme: ThemeData(
        colorScheme:  ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Entregaudium'),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      getPages: [
        GetPage(
            name: '/',
            page: () => MyHomePage(title: 'Entregaudium')
        ),
        GetPage(
            name: '/userdetails',
            page: () => UserDetails(),
            transition: Transition.rightToLeft,
            transitionDuration: Duration(milliseconds: 800)
        ),
      ],
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  late GoogleMapController mapController;
  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;
  final Map<String, Marker> _markers = {};



  final LatLng _center = const LatLng(-22.904093, -43.175293);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    if (markerIcon == BitmapDescriptor.defaultMarker) {
      getBytesFromAsset('assets/images/pin_user_white.png', 100).then((value) {
        setState(() {
          markerIcon = BitmapDescriptor.fromBytes(value!);
        });
      });
    } else {
      var marker = Marker(
        markerId: const MarkerId('user'),
        position: const LatLng(-22.904093, -43.175293),
        icon: markerIcon,
      );
      _markers['user'] = marker;
    }


    /*
    * Foi incluída um FloatActionButton apenas para chamar a nova tela. Pretendo
    * atualizar esse botão em breve, para tornar o aplicativo mais atraente.
    * Uso o Get.toNamed para chamar a nova tela, através da rota declarada.
    * */
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(widget.title, style: const TextStyle(color: Colors.white),),
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 14.0,
        ),
        markers: _markers.values.toSet(),
      ),
      floatingActionButton: FloatingActionButton(child: Icon(Icons.add, color: Colors.white,),onPressed: (){
        Get.toNamed('/userdetails');
      },),
    );
  }


  Future<Uint8List?> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))?.buffer.asUint8List();
  }
}
