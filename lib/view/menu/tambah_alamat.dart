import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

class TambahAlamat extends StatelessWidget {
  const TambahAlamat({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Alamat"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black87,
                    foregroundColor: Colors.white),
                onPressed: () async{
                  Location location = Location();
                  bool _serviceEnabled;
                  PermissionStatus _permissionGranted;

                  // Check if location services are enabled
                  _serviceEnabled = await location.serviceEnabled();
                  if (!_serviceEnabled) {
                    _serviceEnabled = await location.requestService();
                    if (!_serviceEnabled) {
                      return; // Can't proceed without location service
                    }
                  }

                  // Check for location permissions
                  _permissionGranted = await location.hasPermission();
                  if (_permissionGranted == PermissionStatus.denied) {
                    _permissionGranted = await location.requestPermission();
                    if (_permissionGranted != PermissionStatus.granted) {
                      return; // Can't proceed without permission
                    }
                  }

                  // Get the current location
                  LocationData _locationData = await location.getLocation();
                  LatLng currentLatLng = LatLng(_locationData.latitude!, _locationData.longitude!);
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Dialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 0,
                        backgroundColor: Colors.transparent,
                        child: Container(
                          height: 400, // Set the height of the map inside the dialog
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: FlutterMap(
                            options: MapOptions(
                              initialCenter: LatLng(51.5, -0.09),
                              initialZoom: 13.0,

                            ),
                            children: [
                              TileLayer( // Bring your own tiles
                                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png', // For demonstration only
                                userAgentPackageName: 'com.example.app', // Add your app identifier
                                // And many more recommended properties!
                              ),
                              MarkerLayer(
                                markers: [
                                  Marker(
                                    point: currentLatLng,
                                    width: 80,
                                    height: 80,
                                    child: Container(
                                      child: Icon(
                                        Icons.location_on,
                                        color: Colors.red,
                                        size: 40,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                child: Row(
                  children: [
                    Text("Lewat Peta"),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(Icons.map_outlined)
                  ],
                )),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 40,
              child: SearchBar(
                controller: TextEditingController(),
                // onChanged: controller.updateSearchQuery,
                leading: const Icon(Icons.search),
                elevation: WidgetStatePropertyAll(0),
                backgroundColor: WidgetStatePropertyAll(Color(0xfff4f4f4)),
                hintText: 'Mau Pengerjaan di mana?',
                hintStyle: WidgetStatePropertyAll(
                  TextStyle(color: Colors.grey[500], fontSize: 14),
                ),
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: Colors.black12)),
                ),
              ),
            ),
            SizedBox(height: 10,),
            Text(
              "Layanan kami saat ini tersedia di Jabodetabek, Bandung, Surabaya, Denpasar, Medan, Batam, dan Pontianak",
              style: TextStyle(fontSize: 9, color: Colors.grey),
            ),
            SizedBox(height: 10,),
            TextButton.icon(
              style: TextButton.styleFrom(
                foregroundColor: Colors.black,
                textStyle: TextStyle(fontSize: 13),

              ),
              onPressed: () {

              },
              icon:  Icon(Icons.my_location,size: 20,),
              label: Text("Gunakan Lokasi saat ini"),
            ),
          ],
        ),
      ),
    );
  }
}
