import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

/*void main() {
  runApp(const MapsScreen());
}*/

class MapsScreen extends StatelessWidget {
  const MapsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late StreamSubscription<LocationData> _locationSubscription;
  Location _locationTracker = Location();
  Marker? marker;
  Circle? circle;
  late GoogleMapController _controller;

  static final CameraPosition initialLocation = CameraPosition(
    target: LatLng(38.5163, 27.7019),
    zoom: 14.4746,
  );

  Future<Uint8List> getMarker() async {
    ByteData byteData =
        await DefaultAssetBundle.of(context).load("assets/car_icon.png");
    return byteData.buffer.asUint8List();
  }

  void updateMarkerAndCircle(LocationData newLocalData, Uint8List imageData) {
    LatLng latlng = LatLng(newLocalData.latitude!, newLocalData.longitude!);
    setState(() {
      marker = Marker(
        markerId: MarkerId("home"),
        position: latlng,
        rotation: newLocalData.heading!,
        draggable: false,
        zIndex: 2,
        flat: true,
        anchor: Offset(0.5, 0.5),
        icon: BitmapDescriptor.fromBytes(imageData),
      );
      circle = Circle(
        circleId: CircleId("car"),
        radius: newLocalData.accuracy!,
        zIndex: 1,
        strokeColor: Colors.blue,
        center: latlng,
        fillColor: Colors.blue.withAlpha(70),
      );
    });
  }

  Future<void> getCurrentLocation() async {
    try {
      Uint8List imageData = await getMarker();
      var location = await _locationTracker.getLocation();

      updateMarkerAndCircle(location, imageData);

      if (_locationSubscription != null) {
        _locationSubscription.cancel();
      }

      _locationSubscription =
          _locationTracker.onLocationChanged.listen((LocationData newLocalData) {
        if (_controller != null) {
          updateMarkerAndCircle(newLocalData, imageData);
          _controller.animateCamera(CameraUpdate.newLatLng(
              LatLng(newLocalData.latitude!, newLocalData.longitude!)));
        }
      });
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        debugPrint("Permission Denied");
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _locationSubscription =
        _locationTracker.onLocationChanged.listen((LocationData newLocalData) {
      if (_controller != null) {
        updateMarkerAndCircle(newLocalData, Uint8List(0));
      }
    });
  }

  @override
  void dispose() {
    if (_locationSubscription != null) {
      _locationSubscription.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: initialLocation,
        markers: Set.of(marker != null ? [marker!] : []),
        circles: Set.of(circle != null ? [circle!] : []),
        onMapCreated: (GoogleMapController controller) {
          _controller = controller;
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 5.0),
        child: FloatingActionButton(
          backgroundColor: Colors.transparent,
          
          child: Icon(Icons.location_searching),
          onPressed: () {
            getCurrentLocation();
          },
        ),
      ),
    );
  }
}
