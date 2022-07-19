import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapWidget extends StatelessWidget {

  String lat,lng;
  MapWidget({Key? key,required this.lat,required this.lng}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Set<Marker> markers = {};
    LatLng latLng =  LatLng(
      double.parse(lat),
      double.parse(lng),
    );
    markers.add(
      Marker(
        // icon: BitmapDescriptor.fromBytes(customMarker,),
        markerId: MarkerId('${DateTime.now()}'),
        position: latLng,
      ),
    );
    return GoogleMap(
      initialCameraPosition: CameraPosition(
          target: LatLng(double.parse(lat),
              double.parse(lng)),
          zoom: 9.5),
      myLocationButtonEnabled: false,
      zoomControlsEnabled: true,
      gestureRecognizers: Set()..add(Factory<EagerGestureRecognizer>(() => EagerGestureRecognizer())),
      markers: markers,
    );
  }
}
