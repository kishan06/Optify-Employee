import 'package:Optifii_Corporate/MainScreen/GiftVoucherTab/VoucherTab/CommonWidgets/CustomAccordionOfVoucherTab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Utils/CommonWidgets/sized_box.dart';

class Vouchertab extends StatefulWidget {
  const Vouchertab({super.key});

  @override
  State<Vouchertab> createState() => _VouchertabState();
}

class _VouchertabState extends State<Vouchertab> {

  // Create a list of order data
  final List<VoucherData> voucher = [
    VoucherData(
      voucherImg: 'assets/images/png/h&m.png',
      dateTime: '10 June 2024, 10 am',
      department: 'Sales, Design',
      status: 'Completed',
      valuation: ': ₹ 70,000',
    ),
    VoucherData(
      voucherImg: 'assets/images/png/h&m.png',
      dateTime: '10 June 2024, 10 am',
      department: 'Sales, Design',
      status: 'Completed',
      valuation: ': ₹ 70,000',
    ),
    VoucherData(
      voucherImg: 'assets/images/png/h&m.png',
      dateTime: '10 June 2024, 10 am',
      department: 'Sales, Design',
      status: 'Completed',
      valuation: ': ₹ 70,000',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCFCFC),
      body: SingleChildScrollView(
        child: Column(
          children: voucher.map((voucherData) {
            return Column(
              children: [
                sizedBoxHeight(37.h),
                Customaccordionofvouchertab(
                    voucherImg: voucherData.voucherImg,
                    dateTime: voucherData.dateTime,
                    valuation: voucherData.valuation,
                    status: voucherData.status,
                    department: voucherData.department),
                Divider(),
                sizedBoxHeight(31.h),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}

// Define an OrderData class to structure the data
class VoucherData  {
  final String voucherImg;
  final String dateTime;
  final String valuation;
  final String department;
  final String status;

  VoucherData({
    required this.voucherImg,
    required this.department,
    required this.dateTime,
    required this.valuation,
    required this.status,
  });
}