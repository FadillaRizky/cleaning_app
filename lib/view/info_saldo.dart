import 'package:cleaning_app/model/HistoryTransaksiResponse.dart';
import 'package:cleaning_app/widget/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../controller/home.dart';
import '../widget/card_saldo.dart';

class InfoSaldo extends GetView<HomeController> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Saldo"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          CardSaldo(
            saldo: "569.000",
            point: "1.556",
          ),
          SizedBox(height: 10),
          Text("Riwayat Transaksi", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          SizedBox(height: 10),
          FutureBuilder(
            future: controller.fetchHistoryTransaksi(),
            builder: (context, AsyncSnapshot<HistoryTransaksiResponse> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Skeletonizer(
                  child: ListTile(
                    title: Text("asdasdasd"),
                  ),
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (!snapshot.hasData || snapshot.data!.data!.isEmpty) {
                return Center(child: const Text('Belum ada riwayat transaksi.'));
              }
          
              return ListView.builder(
                shrinkWrap: true, // ✅ Allows ListView inside Column
                physics: NeverScrollableScrollPhysics(),
                itemCount: snapshot.data!.data!.length,
                itemBuilder: (context, index) {
                  final item = snapshot.data!.data![index];
                  return Padding(
                    padding: const EdgeInsets.symmetric( vertical: 5),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.blueAccent,
                          child: Icon(Icons.receipt_long, color: Colors.white),
                        ),
                        title: Text(
                          (item.tractionType! == "EXPENSE") ? "Transaksi" : "Top Up",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        subtitle: Text(
                          "${(item.tractionType == "EXPENSE" ? "-" : "")} ${Utils.formatCurrency(item.tractionNominal!)}", // assuming there's a `date` field
                          style: TextStyle(
                            color: Colors.grey[600],
                          ),
                        ),
                        trailing: Text(
                            Utils.formatTanggal(item.tractionDate!), // assuming `amount` exists
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  );
          
                  //   ListTile(
                  //   title: Text((item.tractionType! == "EXPENSE") ? "Transaksi" : "Top Up" ),
                  //   subtitle: Text("${(item.tractionType == "EXPENSE" ? "-" : "")} ${Utils.formatCurrency(item.tractionNominal!)}"),
                  // trailing: Text(Utils.formatTanggal(item.tractionDate!)),
                  //
                  // );
                },
              );
            },
          )
            ],
          ),
        ),
      ),
    );
  }
}
