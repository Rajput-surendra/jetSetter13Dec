
import 'dart:convert';
import 'package:flutter/services.dart';

import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import '../../Helper/String.dart';
import '../../Helper/constant.dart';
import '../Test/Widget/ListTile2.dart';

class UserMapScreen extends StatefulWidget {
   String ? dId;
  UserMapScreen({this.dId});
  @override
  _UserMapScreenState createState() => _UserMapScreenState();
}


class _UserMapScreenState extends State<UserMapScreen> {
 // final DocumentReference documentReference = FirebaseFirestore.instance.collection('92').doc('qPoeXMGDCkuWuiDkBnf0');

  LatLng driverLocation = LatLng(22.7177, 75.8545);
  LatLng userLocation = LatLng(22.7281,  75.8042);

  BitmapDescriptor? myIcon ;

  List<LatLng> routeCoordinates = [];

  List<Polyline> polyLines = [];

  late double bearing;
  double dNewLat = 0.0 ;
  double dNewLong = 0.0 ;
  double userLat = 0.0 ;
  double userLong = 0.0 ;

 // CollectionReference collectionRef=FirebaseFirestore.instance.collection("driverlocation");

  late Timer _timer;
  void _startTimer() {

    _timer = Timer.periodic(Duration(seconds: 3), (timer) async {
     getLatLongApi();
    });
  }


  @override
  void initState() {
    super.initState();
    ///userLocation = LatLng(double.parse(widget.venorlat ?? ''),double.parse(widget.venorlang ?? '0.0'));

    getLatLongApi();

    _startTimer();
    // init();

    BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(5, 5)), 'assets/images/png/plan.png')
        .then((onValue) {
      myIcon = onValue;
    });



  }


  init() async{
    var encodedPoly = await getRouteCoordinates(
        LatLng(dNewLat,  dNewLong),
        // const LatLng(22.7281,  75.8042));
       LatLng(userLat,userLong));


    polyLines.add(Polyline(
        polylineId: const PolylineId("1"), //pass any string here
        width: 7,
        geodesic: true,
        points: convertToLatLng(decodePoly(encodedPoly)),
        color: primary));

    setState(() {

    });
  }


  getLatLongApi() async {
    var headers = {
      'Cookie': 'ci_session=bec982583a172f8af24d3074f39cddbc10290cd5'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${baseUrl}get_lat_lang'));
    request.fields.addAll({
      'user_id':CUR_USERID.toString(),
      'driver_id':"24"
    });
    print('_____request.fields_____${request.fields}_________');
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result  =  await response.stream.bytesToString();
      var finalResult = jsonDecode(result);


      userLat =  double.parse(finalResult['user']['longitude']);
      userLong =  double.parse(finalResult['user']['longitude']);
      dNewLat =  double.parse(finalResult['driver']['latitude']);
      dNewLong =  double.parse(finalResult['driver']['longitude']);
      driverLocation = LatLng(dNewLat, dNewLong);
      bearing = await getBearing( LatLng(dNewLat, dNewLong),  LatLng(userLat,userLong));
      userLocation = LatLng(userLat,userLong);

      print('____2______${dNewLat}______${bearing}___');
      print('_____3_____${userLocation}_________');
      print('___1_______${driverLocation}_________');
      setState(() {

      });
    }
    else {
      print(response.reasonPhrase);
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            onPressed: (){
              init();
            },
            child: const Icon(Icons.directions)),
        body:


        // dNewLat==0.0?Container(
        //     height: MediaQuery.of(context).size.height,
        //     width: MediaQuery.of(context).size.width,
        //
        //     child: Center(child: CircularProgressIndicator())):
        GoogleMap(
          initialCameraPosition: CameraPosition(
            target: userLocation,
            zoom: 15.0,
          ),
          markers: <Marker>{
            Marker(
                markerId: const MarkerId('userMarker'),
                position: driverLocation,
                icon: myIcon ?? BitmapDescriptor.defaultMarker,
                anchor: const Offset(0.5, 0.5),
                flat: true,
                rotation: bearing,
                draggable: false),
            Marker(
              markerId: const MarkerId('driverMarker'),
              position: userLocation,
              icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueRed),
            ),
          },
          polylines: Set<Polyline>.of(
              polyLines) /*{
          Polyline(
            polylineId: const PolylineId('user-driver-polyline'),
            color: Colors.blue,
            points: routeCoordinates,
          ),
        }*/
          ,
        )
    );
  }



  static List<LatLng> convertToLatLng(List points) {
    List<LatLng> result = <LatLng>[];
    for (int i = 0; i < points.length; i++) {
      if (i % 2 != 0) {
        result.add(LatLng(points[i - 1], points[i]));
      }
    }
    return result;
  }

  Future<String> getRouteCoordinates(LatLng l1, LatLng l2) async {
    String url =
    // "https://maps.googleapis.com/maps/api/directions/json?origin=${l1.latitude},${l1.longitude}&destination=${l2.latitude},${l2.longitude}&key=AIzaSyDi_XlHtopewZHtpWWxIO-EQ7mCegHr5o0";
   // "https://maps.googleapis.com/maps/api/directions/json?origin=${l1.latitude},${l1.longitude}&destination=${l2.latitude},${l2.longitude}&key=AIzaSyAXL1tpx0xZORmWdCkqaStqHC4BhklFZ78";
       "https://maps.googleapis.com/maps/api/directions/json?origin=${l1.latitude},${l1.longitude}&destination=${l2.latitude},${l2.longitude}&key=AIzaSyCWqeExucDcWrf-3oC6WFQldhLI1Ued62w";
    http.Response response = await http.get(Uri.parse(url));
    print(url);
    Map values = jsonDecode(response.body);
    print("Predictions " + values.toString());
    print("Predictions ${values["routes"][0]["overview_polyline"]["points"]}");

    return values["routes"][0]["overview_polyline"]["points"];
  }


  static List decodePoly(String poly) {
    var list = poly.codeUnits;
    var lList = [];
    int index = 0;
    int len = poly.length;
    int c = 0;
    // repeating until all attributes are decoded
    do {
      var shift = 0;
      int result = 0;

      // for decoding value of one attribute
      do {
        c = list[index] - 63;
        result |= (c & 0x1F) << (shift * 5);
        index++;
        shift++;
      } while (c >= 32);
      // if value is negative then bitwise not the value /
      if (result & 1 == 1) {
        result = ~result;
      }
      var result1 = (result >> 1) * 0.00001;
      lList.add(result1);
    } while (index < len);

    /*adding to previous value as done in encoding */
    for (var i = 2; i < lList.length; i++) lList[i] += lList[i - 2];

    print(lList.toString());

    return lList;
  }

  double getBearing(LatLng begin, LatLng end) {

    double lat = (begin.latitude - end.latitude).abs();

    double lng = (begin.longitude - end.longitude).abs();

    if (begin.latitude < end.latitude && begin.longitude < end.longitude) {

      return (atan(lng / lat) * (180 / pi));

    } else if (begin.latitude >= end.latitude && begin.longitude < end.longitude) {

      return (90 - (atan(lng / lat) * (180 / pi))) + 90;

    } else if (begin.latitude >= end.latitude && begin.longitude >= end.longitude) {

      return (atan(lng / lat) * (180 / pi)) + 180;

    } else if (begin.latitude < end.latitude && begin.longitude >= end.longitude) {

      return (90 - (atan(lng / lat) * (180 / pi))) + 270;

    }

    return -1;

  }

  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _timer.cancel();
  }
}
