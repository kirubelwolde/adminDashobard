import 'package:admin/utility/extensions.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../../core/data/data_provider.dart';
import '../../../utility/constants.dart';

class Chart extends StatelessWidget {
  final bool isOrder;

  const Chart({Key? key, required this.isOrder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Stack(
        children: [
          PieChart(
            PieChartData(
              sectionsSpace: 0,
              centerSpaceRadius: 70,
              startDegreeOffset: -90,
              sections: _buildPieChartSelectionData(context),
            ),
          ),
          Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: defaultPadding),
                Consumer<DataProvider>(
                  builder: (context, dataProvider, child) {
                    return Text(
                      '${isOrder ? dataProvider.calculateOrdersWithStatus() : dataProvider.calculateTicketsWithStatus()}',
                      style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            height: 0.5,
                          ),
                    );
                  },
                ),
                SizedBox(height: defaultPadding),
                Text(isOrder ? "Orders" : "Tickets")
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> _buildPieChartSelectionData(BuildContext context) {
    final DataProvider dataProvider = Provider.of<DataProvider>(context);

    int total = isOrder
        ? dataProvider.calculateOrdersWithStatus()
        : dataProvider.calculateTicketsWithStatus();
    int pending = isOrder
        ? dataProvider.calculateOrdersWithStatus(status: 'pending')
        : dataProvider.calculateTicketsWithStatus(status: 'pending');
    int processing = isOrder
        ? dataProvider.calculateOrdersWithStatus(status: 'processing')
        : dataProvider.calculateTicketsWithStatus(status: 'processing');
    int cancelled = isOrder
        ? dataProvider.calculateOrdersWithStatus(status: 'cancelled')
        : dataProvider.calculateTicketsWithStatus(status: 'cancelled');
    int shipped = isOrder
        ? dataProvider.calculateOrdersWithStatus(status: 'shipped')
        : dataProvider.calculateTicketsWithStatus(status: 'shipped');
    int delivered = isOrder
        ? dataProvider.calculateOrdersWithStatus(status: 'delivered')
        : dataProvider.calculateTicketsWithStatus(status: 'delivered');

    List<PieChartSectionData> pieChartSelectionData = [
      PieChartSectionData(
        color: Color(0xFFFFCF26),
        value: pending.toDouble(),
        showTitle: false,
        radius: 20,
      ),
      PieChartSectionData(
        color: Color(0xFFEE2727),
        value: cancelled.toDouble(),
        showTitle: false,
        radius: 20,
      ),
      PieChartSectionData(
        color: Color(0xFF2697FF),
        value: shipped.toDouble(),
        showTitle: false,
        radius: 20,
      ),
      PieChartSectionData(
        color: Color(0xFF26FF31),
        value: delivered.toDouble(),
        showTitle: false,
        radius: 20,
      ),
      PieChartSectionData(
        color: Colors.white,
        value: processing.toDouble(),
        showTitle: false,
        radius: 20,
      ),
    ];

    return pieChartSelectionData;
  }
}
