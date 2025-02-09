import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineChartSample2 extends StatefulWidget {
  const LineChartSample2({super.key});

  @override
  State<LineChartSample2> createState() => _LineChartSample2State();
}

class _LineChartSample2State extends State<LineChartSample2> {
  
  bool showAvg = false;

  @override
  Widget build(BuildContext context) {
    return LineChart(
          LineChartData(
            titlesData: FlTitlesData(
              topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, getTitlesWidget: (value, meta) => Text(value.toString(), style: TextStyle(fontFamily: '', color: Theme.of(context).hintColor, fontSize: 12.0)))),
            ),
            gridData: const FlGridData(show: false),
            borderData: FlBorderData(
              show: false,
            ),
            lineBarsData: [
              LineChartBarData(
                spots: [
                  const FlSpot(1, 2),
                  const FlSpot(2, 3),
                  const FlSpot(3, 3.5),
                  const FlSpot(4, 4.5),
                  const FlSpot(5, 5.5),
                  const FlSpot(6, 6),
                  const FlSpot(7, 5),
                  const FlSpot(8, 7.5),
                  const FlSpot(9, 8.5),
                  const FlSpot(10, 9.5),
                  const FlSpot(11, 10),
                  const FlSpot(12, 9),
                  const FlSpot(13, 11),
                  const FlSpot(14, 12),
                  const FlSpot(15, 12.5),
                  const FlSpot(16, 13),
                  const FlSpot(17, 11),
                  const FlSpot(18, 13.5),
                  const FlSpot(19, 16.5),
                  const FlSpot(20, 19.5),
                  const FlSpot(21, 21),
                ],
                isCurved: true,
                color: Colors.blue,
                barWidth: 1,
                isStrokeCapRound: true,
                belowBarData: BarAreaData(show: false),
                dotData: const FlDotData(show: true),
                showingIndicators: [2, 4, 6],
                
              ),
            ],
            lineTouchData: LineTouchData(
              touchTooltipData: LineTouchTooltipData(
                getTooltipColor: (touchedSpot) => Colors.grey.withOpacity(0.2),
                tooltipRoundedRadius: 6,
                fitInsideHorizontally: false,
                fitInsideVertically: false,
              ),
              touchSpotThreshold: 4,
              getTouchLineStart: (barData, spotIndex) => 0.0,
              getTouchLineEnd: (barData, spotIndex) => 0.0,
            ),
          ),
        );
  }
}