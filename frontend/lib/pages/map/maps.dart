// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import 'dart:math';
//
// class GoogleMapScreen extends StatefulWidget {
//   const GoogleMapScreen({Key? key}) : super(key: key);
//
//   @override
//   _GoogleMapScreenState createState() => _GoogleMapScreenState();
// }
//
// class _GoogleMapScreenState extends State<GoogleMapScreen> {
//   GoogleMapController? mapController;
//   LatLng? _currentPosition;
//   LatLng? _destinationPosition;
//   Set<Marker> _markers = {};
//   Set<Polyline> _polylines = {};
//   List<LatLng> polylineCoordinates = [];
//   PolylinePoints polylinePoints = PolylinePoints();
//
//   // IMPORTANT: Replace with your actual Google Maps API Key
//   final String googleMapsApiKey = 'AIzaSyDPtQTJ28o18RNC3P94AOnrrwQtjXOQ0wo';
//
//   @override
//   void initState() {
//     super.initState();
//     _getCurrentLocation();
//   }
//
//   Future<void> _getCurrentLocation() async {
//     try {
//       // Request location permissions
//       LocationPermission permission = await Geolocator.requestPermission();
//
//       if (permission == LocationPermission.denied) {
//         // Handle denied permission
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Location permissions are required')),
//         );
//         return;
//       }
//
//       // Get current position
//       Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high,
//       );
//
//       setState(() {
//         _currentPosition = LatLng(position.latitude, position.longitude);
//         _addCurrentLocationMarker();
//       });
//     } catch (e) {
//       print('Error getting location: $e');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to get current location')),
//       );
//     }
//   }
//
//   void _addCurrentLocationMarker() {
//     if (_currentPosition != null) {
//       setState(() {
//         _markers.add(
//           Marker(
//             markerId: MarkerId('current_location'),
//             position: _currentPosition!,
//             icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
//             infoWindow: InfoWindow(title: 'Current Location'),
//           ),
//         );
//       });
//     }
//   }
//
//   Future<void> _drawPolyline(LatLng start, LatLng end) async {
//     try {
//       // Use the standard method signature
//       PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
//         googleApiKey: googleMapsApiKey,
//         request: PolylineRequest(
//           origin: PointLatLng(start.latitude, start.longitude),
//
//           destination:   PointLatLng(end.latitude, end.longitude),
//           mode: TravelMode.driving,
//           wayPoints: [PolylineWayPoint(location: "Sabo, Yaba Lagos Nigeria")],
//         ),
//       );
//
//       // Clear previous coordinates
//       polylineCoordinates.clear();
//
//       // Process route points
//       if (result.points.isNotEmpty) {
//         for (var point in result.points) {
//           polylineCoordinates.add(
//             LatLng(point.latitude, point.longitude),
//           );
//         }
//
//         setState(() {
//           // Clear previous polylines
//           _polylines.clear();
//
//           // Add new polyline
//           _polylines.add(
//             Polyline(
//               polylineId: PolylineId('route'),
//               color: Colors.deepPurple,
//               points: polylineCoordinates,
//               width: 6,
//               geodesic: true,
//             ),
//           );
//         });
//
//         // Adjust map view to show entire route
//         _fitBoundsToRoute();
//       } else {
//         print('No route points found');
//         print('Route Status: ${result.status}');
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Unable to draw route: ${result.status}')),
//         );
//       }
//     } catch (e) {
//       print('Polyline drawing error: $e');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error drawing route: $e')),
//       );
//     }
//   }
//   void _fitBoundsToRoute() {
//     if (mapController != null && _currentPosition != null && _destinationPosition != null) {
//       // Calculate bounds including start and end points
//       LatLngBounds bounds = LatLngBounds(
//         southwest: LatLng(
//           min(_currentPosition!.latitude, _destinationPosition!.latitude),
//           min(_currentPosition!.longitude, _destinationPosition!.longitude),
//         ),
//         northeast: LatLng(
//           max(_currentPosition!.latitude, _destinationPosition!.latitude),
//           max(_currentPosition!.longitude, _destinationPosition!.longitude),
//         ),
//       );
//
//       // Animate camera to show entire route
//       CameraUpdate cu = CameraUpdate.newLatLngBounds(bounds, 100);
//       mapController?.animateCamera(cu);
//     }
//   }
//
//   void _addDestinationMarker(LatLng destination) {
//     // Remove existing destination marker
//     _markers.removeWhere((marker) => marker.markerId.value == 'destination');
//
//     setState(() {
//       _destinationPosition = destination;
//
//       // Add new destination marker
//       _markers.add(
//         Marker(
//           markerId: MarkerId('destination'),
//           position: destination,
//           icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
//           infoWindow: InfoWindow(title: 'Destination'),
//         ),
//       );
//
//       // Draw route if current position is available
//       if (_currentPosition != null) {
//         _drawPolyline(_currentPosition!, destination);
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Google Maps Routing'),
//       ),
//       body: _currentPosition == null
//           ? Center(child: CircularProgressIndicator())
//           : GoogleMap(
//         onMapCreated: (GoogleMapController controller) {
//           mapController = controller;
//         },
//         initialCameraPosition: CameraPosition(
//           target: _currentPosition!,
//           zoom: 15.0,
//         ),
//         myLocationEnabled: true,
//         myLocationButtonEnabled: true,
//         markers: _markers,
//         polylines: _polylines,
//         onTap: (LatLng tappedLocation) {
//           // Add destination on map tap
//           _addDestinationMarker(tappedLocation);
//         },
//       ),
//       floatingActionButton: Column(
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: [
//           FloatingActionButton(
//             onPressed: _getCurrentLocation,
//             child: Icon(Icons.my_location),
//             heroTag: 'locationButton',
//           ),
//           SizedBox(height: 10),
//           FloatingActionButton(
//             onPressed: () {
//               // Clear destination and polyline
//               setState(() {
//                 _markers.removeWhere((marker) =>
//                 marker.markerId.value == 'destination');
//                 _polylines.clear();
//                 _destinationPosition = null;
//               });
//             },
//             child: Icon(Icons.clear),
//             heroTag: 'clearButton',
//           ),
//         ],
//       ),
//     );
//   }
// }