import 'package:flutter/material.dart';

class Booking extends StatelessWidget {
  String selectedLocation = "Semua Aktivitas"; // Default selected value
  List<String> locations = [
    "Semua Aktivitas",
    "Transaksi",
    "Utilize's GO",
  ];

  String selectedValue = "Semua Aktivitas";

  final List<Map<String, dynamic>> items = [
    {
      "label": "Semua Aktivitas",
      "icon": Icons.receipt_long, // Example icon
    },
    {
      "label": "Transaksi",
      "icon": Icons.sync_alt,
    },
    {
      "label": "Utilize’s GO",
      "icon": Icons.electric_bolt,
    },
  ];

  String selectedActivity = "Rumah";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // DropdownButton<String>(
            //   value: selectedLocation,
            //   icon: Icon(Icons.keyboard_arrow_down, color: Colors.black),
            //   underline: SizedBox(),
            //   onChanged: (String? newValue) {
            //     // setState(() {
            //     //   selectedLocation = newValue!;
            //     // });
            //   },
            //   items: locations.map<DropdownMenuItem<String>>((String location) {
            //     return DropdownMenuItem<String>(
            //       value: location,
            //       child: Row(
            //         children: [
            //           Icon(Icons.list_alt_outlined),
            //           Text(
            //             location,
            //             style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
            //           ),
            //         ],
            //       ),
            //     );
            //   }).toList(),
            // ),
            PopupMenuButton<String>(
              onSelected: (String value) {
                // setState(() {
                //   selectedValue = value;
                // });
              },
              color: Colors.white,
              itemBuilder: (BuildContext context) {
                return items.map((item) {
                  return PopupMenuItem<String>(
                    value: item["label"],
                    child: Row(
                      children: [
                        Icon(item["icon"], color: Colors.black54),
                        SizedBox(width: 10),
                        Expanded(child: Text(item["label"])),
                        
                        Radio(
                            value: "Rumah",
                            groupValue: selectedActivity,
                            onChanged: (value) {

                            })
                      ],
                    ),
                  );
                }).toList();
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    selectedValue,
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                  ),
                  Icon(Icons.keyboard_arrow_down),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ListTile(
                      title: Text("Aktivitas 1"),
                      subtitle: Text("2 Hari lalu"),
                      leading: CircleAvatar(),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
