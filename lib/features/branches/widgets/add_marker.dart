import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:alsurrah/app_core/locator.dart';
import 'package:alsurrah/app_core/resources/app_assets/app_assets.dart';
import 'package:alsurrah/features/branches/branches_manager.dart';
import 'package:alsurrah/features/branches/branches_response.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Future addMarker(
    {required BuildContext context, required List<Branches> branches}) async {
  /// Get Marker From Assets.

  Future<Uint8List> getBytesFromAssets() async {
    ByteData byteData =
        await DefaultAssetBundle.of(context).load(AppAssets.ooo);
    ui.Codec codec =
        await ui.instantiateImageCodec(byteData.buffer.asUint8List());
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  Set<Marker> markers = {};
  var customMarker = await getBytesFromAssets();

  for (int i = 0; i < branches.length; i++) {
    LatLng latLng =
        // LatLng(double.parse("${branches[i].lng}"),
        //        double.parse("${branches[i].lng}")

        // LatLng(double.parse("29.014559834896154"),
        //        double.parse("48.02783913910389")

        LatLng(
      double.parse(
          "${locator<BranchesManager>().subject.value.data!.branches![i].lat}"),
      double.parse(
          "${locator<BranchesManager>().subject.value.data!.branches![i].lng}"),
    );
    markers.add(
      Marker(
        // icon: BitmapDescriptor.fromBytes(customMarker,),
        markerId: MarkerId('${DateTime.now()}'),
        position: latLng,
      ),
    );
  }
  locator<BranchesManager>().markersSubject.sink.add(markers);
}

//
// "lat": "29.014559834896154",
// "lng": "48.02783913910389"
