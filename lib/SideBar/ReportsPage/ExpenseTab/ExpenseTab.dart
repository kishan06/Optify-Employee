import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mat_month_picker_dialog/mat_month_picker_dialog.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../Utils/CommonWidgets/Custombutton.dart';
import '../../../Utils/CommonWidgets/Text.dart';
import '../../../Utils/CommonWidgets/sized_box.dart';
import '../Common/CustomColorAndCategory.dart';

class ExpenseTab extends StatefulWidget {
  const ExpenseTab({super.key});

  @override
  State<ExpenseTab> createState() => _ExpenseTabState();
}

class _ExpenseTabState extends State<ExpenseTab> {
  late TooltipBehavior _tooltipBehavior;

  // Sample data for the doughnut chart
  final List<_ChartData> _chartData = [
    _ChartData('Food', 25.0),
    _ChartData('Travel', 38.0),
    _ChartData('Telecom', 34.0),
    _ChartData('Fuel', 52.0),
    _ChartData('Gift & voucher', 60.0),
    _ChartData('Book & Periodicals', 20.0),
  ];

  @override
  void initState() {
    super.initState();
    // Initialize the tooltip behavior for charts
    _tooltipBehavior = TooltipBehavior(enable: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      final selected = await showMonthPicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1970),
                        lastDate: DateTime(2050),
                      );
                    },
                    style: ButtonStyle(
                      shape:
                      MaterialStateProperty.all<RoundedRectangleBorder>(
                        const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                      ),
                      padding: MaterialStateProperty.all(EdgeInsets.zero),
                      elevation: MaterialStateProperty.all(0),
                      backgroundColor:
                      MaterialStateProperty.all(Colors.transparent),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width * 0.6,
                      decoration: BoxDecoration(
                        color: const Color(0xFFffffff),
                        border: Border.all(
                          color: const Color(0xffD4D6D9),
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(6),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.calendar_today,
                                color: Color(0xff000000),
                              ),
                              sizedBoxWidth(5.w),
                              text16w400cblack('Weekly'),
                            ],
                          ),
                          const Icon(
                            Icons.arrow_drop_down,
                            color: Color(0xff000000),
                          ),
                        ],
                      ),
                    ),
                  ),
                  sizedBoxWidth(10.w),
                  const Expanded(child: ExportDropdown()),
                ],
              ),
              sizedBoxHeight(44.h),
              text20w400c343C6A('Spend summary'),
              _buildSplineChart(),
              sizedBoxHeight(24.h),
              text20w400c343C6A('Total spent by category'),
              DoughnutChartWithCenterText(
                dataSource: _chartData,
                tooltipBehavior: _tooltipBehavior,
                totalAmount: _calculateTotalSpent(),
              ),

              // Horizontal scrolling for the first Row
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    CustomColorAndCategory(
                      color: Color(0xff4C78FF),
                      categoryName: 'Food',
                    ),
                    sizedBoxWidth(30.w),
                    CustomColorAndCategory(
                      color: Color(0xffFF82AC),
                      categoryName: 'Travel',
                    ),
                    sizedBoxWidth(30.w),
                    CustomColorAndCategory(
                      color: Color(0xff4C78FF),
                      categoryName: 'Telecom',
                    ),
                  ],
                ),
              ),

              sizedBoxHeight(15.h),

              // Horizontal scrolling for the second Row
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    CustomColorAndCategory(
                      color: Color(0xff16DBCC),
                      categoryName: 'Fuel',
                    ),
                    sizedBoxWidth(30.w),
                    CustomColorAndCategory(
                      color: Color(0xffFFBB38),
                      categoryName: 'Gift & voucher',
                    ),
                    sizedBoxWidth(30.w),
                    CustomColorAndCategory(
                      color: Color(0xff16DBCC),
                      categoryName: 'Books & periodicals',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );

  }



  /// Build the Spline chart showing the spending summary
  Widget _buildSplineChart() {
    return Container(
      height: 287.h,
      child: SfCartesianChart(
        primaryXAxis: CategoryAxis(),
        tooltipBehavior: _tooltipBehavior,
        series: <CartesianSeries>[
          SplineSeries<SalesData, String>(
            dataSource: _getSalesData(),
            color: const Color(0xff1814F3),
            xValueMapper: (SalesData sales, _) => sales.day,
            yValueMapper: (SalesData sales, _) => sales.amount,
          ),
        ],
      ),
    );
  }

  /// Calculate the total amount spent from chart data
  double _calculateTotalSpent() {
    return _chartData.fold<double>(0, (total, item) => total + item.y);
  }

  /// Sample sales data for the chart
  List<SalesData> _getSalesData() {
    return [
      SalesData('Mon', 12),
      SalesData('Tue', 22),
      SalesData('Wed', 30),
      SalesData('Thu', 50),
      SalesData('Fri', 10),
      SalesData('Sat', 35),
      SalesData('Sun', 60),
    ];
  }
}

// Class for representing the sales data used in the Spline chart
class SalesData {
  SalesData(this.day, this.amount);

  final String day;
  final double amount;
}


class DoughnutChartWithCenterText extends StatelessWidget {
  /// The data source for the chart.
  final List<_ChartData> dataSource;

  /// The tooltip behavior for the chart.
  final TooltipBehavior tooltipBehavior;

  /// The total amount to display at the center of the chart.
  final double totalAmount;

  /// Creates a [DoughnutChartWithCenterText] widget.
  DoughnutChartWithCenterText({
    required this.dataSource,
    required this.tooltipBehavior,
    required this.totalAmount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 270.h,
      child: Stack(
        children: [
          // Doughnut chart
          SfCircularChart(
            tooltipBehavior: tooltipBehavior,
            series: <CircularSeries<_ChartData, String>>[
              DoughnutSeries<_ChartData, String>(
                dataSource: dataSource,
                xValueMapper: (_ChartData data, _) => data.x,
                yValueMapper: (_ChartData data, _) => data.y,
                name: 'Category',
                dataLabelSettings: DataLabelSettings(
                  isVisible: true,
                  labelPosition: ChartDataLabelPosition.outside,
                  labelAlignment: ChartDataLabelAlignment.outer,
                  textStyle: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  labelIntersectAction: LabelIntersectAction.none,
                ),
                pointColorMapper: (_ChartData data, _) {
                  switch (data.x) {
                    case 'Food':
                      return Color(0xff4C78FF);
                    case 'Travel':
                      return Color(0xffFF82AC);
                    case 'Telecom':
                      return Color(0xff4C78FF);
                    case 'Fuel':
                      return Color(0xff16DBCC);
                    case 'Gift & voucher':
                      return Color(0xffFFBB38);
                    case 'Book & Periodicals':
                      return Color(0xff16DBCC);
                    default:
                      return Colors.grey;
                  }
                },
                explode: true,
                explodeIndex: 0,
                explodeOffset: '10%',
              )
            ],
          ),
          // Center text
          Center(
            child: Text(
              '₹ ${totalAmount.toStringAsFixed(2)}',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class _ChartData {
  /// Creates a [_ChartData] instance.
  _ChartData(this.x, this.y);

  /// The category name.
  final String x;

  /// The value associated with the category.
  final double y;
}


class ExportDropdown extends StatefulWidget {
  const ExportDropdown({super.key});

  @override
  _ExportDropdownState createState() => _ExportDropdownState();
}

class _ExportDropdownState extends State<ExportDropdown> {
  final List<String> _exportOptions = [
    'Export',
    'Export as PDF',
    'Export as Excel'
  ];

  String? _selectedExportOption;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45.h,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xffffffff),
        border: Border.all(
          color: const Color(0xFFDFDEDE),
        ),
        borderRadius: const BorderRadius.all(Radius.circular(5)),
      ),
      child: DropdownButton<String>(
        value: _selectedExportOption,
        isExpanded: true,
        hint: const Text('Export'),
        onChanged: (String? newValue) {
          setState(() {
            _selectedExportOption = newValue!;
            // Handle actions based on the selected option here
          });
        },
        items: _exportOptions.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Row(
              children: [
                _getExportIcon(value), // Get the appropriate icon
                SizedBox(width: 10.w), // Space between icon and text
                Text(value),
              ],
            ),
          );
        }).toList(),
        style: const TextStyle(color: Colors.black, fontSize: 16),
        underline: Container(
          height: 2,
          color: Colors.transparent,
        ),
      ),
    );
  }

  // Method to return the correct icon based on the option
  Widget _getExportIcon(String value) {
    switch (value) {
      case 'Export as PDF':
        return Image.asset(
          'assets/images/png/pdf.png',
          width: 20,
        );
      case 'Export as Excel':
        return Image.asset(
          'assets/images/png/excel.png',
          width: 20,
        );
      default:
        return Image.asset(
          'assets/images/png/export.png',
          width: 20,
        );
    }
  }
}