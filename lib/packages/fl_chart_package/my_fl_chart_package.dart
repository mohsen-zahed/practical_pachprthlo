import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:practical_pachprthlo/config/constants/colors.dart';

class MyFlChartPackage {
  static MyFlChartPackage? _instance;
  MyFlChartPackage._();
  static MyFlChartPackage get instance {
    _instance ??= MyFlChartPackage._();
    return _instance!;
  }

  PieChart drawPieChart({required List<dynamic> sections, required List<Color> colors}) {
    return PieChart(
      swapAnimationCurve: Curves.easeInOut,
      PieChartData(
        sections: [
          ...List.generate(
            sections.length,
            (index) => PieChartSectionData(value: sections[index], color: colors[index]),
          ),
        ],
      ),
    );
  }

  LineChart drawLineChart() {
    return LineChart(
      LineChartData(
        gridData: const FlGridData(show: true),
        titlesData: const FlTitlesData(show: true),
        borderData: FlBorderData(
          show: true,
          border: Border.all(color: Colors.black, width: 1),
        ),
        minX: 0,
        maxX: 6,
        minY: 0,
        maxY: 580,
        lineBarsData: [
          LineChartBarData(
            spots: const [
              FlSpot(0, 120),
              FlSpot(1, 240),
              FlSpot(2, 268),
              FlSpot(3, 355),
              FlSpot(4, 440),
              FlSpot(5, 350),
              FlSpot(6, 500),
            ],
            isCurved: true,
            barWidth: 3,
            isStrokeCapRound: true,
            belowBarData: BarAreaData(
              show: true,
              color: Colors.blue.withOpacity(0.3),
            ),
            dotData: const FlDotData(show: true),
          ),
        ],
      ),
    );
  }

  BarChart drawBarChart() {
    return BarChart(
      BarChartData(
        gridData: const FlGridData(show: true),
        titlesData: const FlTitlesData(show: true),
        borderData: FlBorderData(
          show: true,
          border: Border.all(color: Colors.black, width: 1),
        ),
        barGroups: [
          BarChartGroupData(
            x: 0,
            barRods: [
              BarChartRodData(
                toY: 120,
                width: 3,
                color: Colors.blue,
              ),
            ],
          ),
          BarChartGroupData(
            x: 1,
            barRods: [
              BarChartRodData(
                width: 3,
                color: Colors.blue,
                toY: 240,
              ),
            ],
          ),
          BarChartGroupData(
            x: 2,
            barRods: [
              BarChartRodData(
                toY: 2,
              )
            ],
          ),
        ],
      ),
    );
  }

  ScatterChart drawScatterChart() {
    return ScatterChart(
      ScatterChartData(
        gridData: const FlGridData(show: true),
        borderData: FlBorderData(
          show: true,
          border: Border.all(color: Colors.black, width: 1),
        ),
        minX: 0,
        maxX: 6,
        minY: 0,
        maxY: 580,
        scatterSpots: [
          ScatterSpot(0, 120),
          ScatterSpot(1, 240),
          ScatterSpot(2, 268),
          ScatterSpot(3, 355),
          ScatterSpot(4, 440),
          ScatterSpot(5, 350),
          ScatterSpot(6, 500),
        ],
      ),
    );
  }

  RadarChart drawRadarChart() {
    return RadarChart(
      RadarChartData(
        tickCount: 1,
        titlePositionPercentageOffset: 1,
        gridBorderData: const BorderSide(width: 0),
        tickBorderData: const BorderSide(width: 0),
        borderData: FlBorderData(
          show: true,
          border: Border.all(color: Colors.black, width: 1),
        ),
        radarTouchData: RadarTouchData(enabled: false),
        radarBorderData: const BorderSide(),
        dataSets: [
          RadarDataSet(
            entryRadius: 6,
            borderColor: kRedColor,
            borderWidth: 2,
            fillColor: kTransparentColor,
            dataEntries: [
              const RadarEntry(value: 1),
              const RadarEntry(value: 2),
              const RadarEntry(value: 3),
              const RadarEntry(value: 4),
              const RadarEntry(value: 5),
              const RadarEntry(value: 7),
            ],
          ),
          RadarDataSet(
            entryRadius: 5,
            borderColor: kPurpleColor,
            borderWidth: 1,
            fillColor: kTransparentColor,
            dataEntries: [
              const RadarEntry(value: 4),
              const RadarEntry(value: 3),
              const RadarEntry(value: 6),
              const RadarEntry(value: 8),
              const RadarEntry(value: 7),
              const RadarEntry(value: 2),
            ],
          ),
        ],
      ),
    );
  }
}
