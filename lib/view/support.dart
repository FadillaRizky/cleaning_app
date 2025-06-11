import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widget/popup.dart';

class SupportPage extends StatelessWidget {
  const SupportPage({super.key});

  final String phoneNumberCS = "+6285158426044";
  final String emailCS = "fadillarizky294@gmail.com";
  final String usernameIgCS = "fadillarizky294";

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
                      subtitle: phoneNumberCS,
                      icon: LineIcons.whatSApp,
                      ontap: ()async{
                        final url = Uri.parse("whatsapp://send?phone=$phoneNumberCS&text=Hi, I need some help");

                        if (await canLaunchUrl(url)) {
                        await launchUrl(url);
                        } else {
                          SnackbarUtil.error("Gagal akses Whatsapp");
                        print("Could not launch WhatsApp");
                        }
                      },
                    ),
                    TileSupport(
                      title: "Email",
                      subtitle: emailCS,
                      icon: LineIcons.envelope,
                      ontap: ()async{
                        final Uri emailUri = Uri(
                          scheme: 'mailto',
                          path: emailCS,
                          // query: 'subject=Hello&body=I want to contact you',
                        );

                        if (await canLaunchUrl(emailUri)) {
                        await launchUrl(emailUri);
                        } else {
                          SnackbarUtil.error("Gagal akses Email");
                        print('Could not launch email client');
                        }
                      },
                    ),
                    TileSupport(
                      title: "Call Center",
                      subtitle: "Senin - Minggu jam 07.00 - 22.00",
                      icon: LineIcons.headset,
                      ontap: (){},
                    ),
                    TileSupport(
                      title: "Cakupan Area",
                      subtitle: "Jakarta, Bogor, Depok, Tangerang",
                      icon: LineIcons.mapMarker,
                      ontap: (){},
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
                      subtitle: "@$usernameIgCS",
                      icon: LineIcons.instagram,
                      ontap: ()async {
                        final Uri url = Uri.parse('https://www.instagram.com/$usernameIgCS');

                        if (await canLaunchUrl(url)) {
                          await launchUrl(url, mode: LaunchMode.externalApplication);
                        } else {
                          SnackbarUtil.error("Gagal akses Instagram");
                          throw 'Could not launch $url';
                        }
                      },
                    ),
                    TileSupport(
                      title: "Facebook",
                      subtitle: "@fadillarizky294",
                      icon: LineIcons.facebookSquare,
                      ontap: ()async {
                        final url = Uri.parse('https://www.facebook.com/');
                        if (await canLaunchUrl(url)) {
                          await launchUrl(url, mode: LaunchMode.externalApplication);
                        } else {
                          SnackbarUtil.error("Gagal akses Facebook");
                          throw 'Could not launch $url';
                        }
                      },
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
  final VoidCallback ontap;
  const TileSupport({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon, required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: ontap,
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
