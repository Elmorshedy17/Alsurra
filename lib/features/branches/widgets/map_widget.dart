import 'package:alsurrah/app_core/app_core.dart';
import 'package:alsurrah/features/branches/branches_manager.dart';
import 'package:alsurrah/features/branches/branches_response.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapViewWidget extends StatefulWidget {
  List<Branches>? branches;
  MapViewWidget({Key? key, required List<Branches> branches}) : super(key: key);

  @override
  State<MapViewWidget> createState() => _MapViewWidgetState();
}

class _MapViewWidgetState extends State<MapViewWidget> {
  @override
  Widget build(BuildContext context) {
    final branchesManager = context.use<BranchesManager>();

    return GoogleMap(
      initialCameraPosition: CameraPosition(
          target: LatLng(double.parse("${widget.branches![0].lat}"),
              double.parse("${widget.branches![0].lng}")),
          zoom: 13.5),
      myLocationButtonEnabled: false,
      zoomControlsEnabled: false,
      // markers: markersSnapshot.data!,
    );

    // return StreamBuilder<Set<Marker>>(
    //     stream: branchesManager.markersSubject.stream,
    //     initialData: const {},
    //     builder: (context, markersSnapshot) {
    //       return GoogleMap(
    //         // initialCameraPosition: _initialCameraPosition,
    //         initialCameraPosition: CameraPosition(
    //             target: LatLng(double.parse("${widget.branches![0].lat}"),
    //                 double.parse("${ widget.branches![0].lng}")),
    //             zoom: 13.5),
    //         myLocationButtonEnabled: false,
    //         zoomControlsEnabled: false,
    //         markers: markersSnapshot.data!,
    //       );
    //     }
    // );
  }
}
