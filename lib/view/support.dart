import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class SupportPage extends StatelessWidget {
  const SupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset("assets/support.png"),
            SizedBox(
              height: 10,
            ),
            Text(
              "    Hubungi Kami",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
                ),
                child: Column(
                  children: [
                    TileSupport(
                      title: "WhatsApp",
                      subtitle: "+62-851-5842-6044",
                      icon: LineIcons.whatSApp,
                    ),
                    TileSupport(
                      title: "Email",
                      subtitle: "fadillarizky294@gmail.com",
                      icon: LineIcons.envelope,
                    ),
                    TileSupport(
                      title: "Call Center",
                      subtitle: "Senin - Minggu jam 07.00 - 22.00",
                      icon: LineIcons.headset,
                    ),
                    TileSupport(
                      title: "Cakupan Area",
                      subtitle: "Jakarta, Bogor, Depok, Tangerang",
                      icon: LineIcons.mapMarker,
                    ),
                  ],
                ),
              ),
            ),
            Text(
              "    Media Sosial",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
                ),
                child: Column(
                  children: [
                    TileSupport(
                      title: "Instagram",
                      subtitle: "@fadillarizky294",
                      icon: LineIcons.instagram,
                    ),
                    TileSupport(
                      title: "Facebook",
                      subtitle: "@fadillarizky294",
                      icon: LineIcons.facebookSquare,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TileSupport extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  const TileSupport({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        size: 30,
      ),
      title: Text(title),
      subtitle: Text(subtitle),
      subtitleTextStyle: TextStyle(fontSize: 13, color: Colors.grey),
      titleTextStyle: TextStyle(fontSize: 16, color: Colors.black87),
      trailing: Icon(LineIcons.angleRight),
      tileColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    );
  }
}
