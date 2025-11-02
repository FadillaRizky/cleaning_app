import 'package:cleaning_app/model/HistoryTransaksiResponse.dart';
import 'package:cleaning_app/widget/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
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
        child: DefaultTabController(
          length: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CardSaldo(),
              SizedBox(height: 40.h),
              Text("Riwayat Transaksi",
                  style:
                      TextStyle(fontSize: 45.sp, fontWeight: FontWeight.w600)),
              SizedBox(height: 10),
              TabBar(
                indicatorColor: Colors.blue,
                labelColor: Colors.blue,
                unselectedLabelColor: Colors.grey,
                labelStyle: TextStyle(fontWeight: FontWeight.bold),
                tabs: [
                  Tab(
                    text: "Saldo Masuk",
                  ),
                  Tab(text: "Saldo Keluar")
                ],
              ),
              FutureBuilder(
                future: controller.fetchHistoryTransaksi(),
                builder: (context,
                    AsyncSnapshot<HistoryTransaksiResponse> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Skeletonizer(
                      child: ListTile(
                        title: Text("asdasdasd"),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData ||
                      snapshot.data!.data!.isEmpty) {
                    return Center(
                        child: const Text('Belum ada riwayat transaksi.'));
                  }

                  return Expanded(
                    child: TabBarView(children: [
                      TractionBalanceWidget(
                        data: snapshot.data!.data!
                            .where((item) => item.tractionType == 'TOPUP')
                            .toList(),
                      ),
                      TractionBalanceWidget(
                        data: snapshot.data!.data!
                            .where((item) => item.tractionType == 'EXPENSE')
                            .toList(),
                      )
                    ]),
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

class TractionBalanceWidget extends StatelessWidget {
  final List<Data> data;
  const TractionBalanceWidget({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true, // ✅ Allows ListView inside Column
      // physics: NeverScrollableScrollPhysics(),
      itemCount: data.length,
      itemBuilder: (context, index) {
        final item = data[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
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
                child: Icon(Icons.receipt_long, color: Colors.white,size: 60.r,),
              ),
              title: Text(
                (item.tractionType! == "EXPENSE") ? "Transaksi" : "Top Up",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40.sp,
                ),
              ),
              subtitle: Text(
                "${(item.tractionType == "EXPENSE" ? "-" : "")} ${Utils.formatCurrency(item.tractionNominal!)}", // assuming there's a `date` field
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 38.sp
                ),
              ),
              trailing: Text(
                Utils.formatTanggal(
                    item.tractionDate!), // assuming `amount` exists
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 35.sp,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
