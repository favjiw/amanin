import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:mobile_flutter3/services/laporan_services.dart';

class StatScreen extends StatefulWidget {
  const StatScreen({super.key});

  @override
  State<StatScreen> createState() => _StatScreenState();
}

class _StatScreenState extends State<StatScreen> {
  List<int> monthlyReportCounts = List.filled(12, 0);
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadMonthlyReportCounts();
  }

  Future<void> _loadMonthlyReportCounts() async {
    try {
      final counts = await getMonthlyReportCounts();
      setState(() {
        monthlyReportCounts = counts;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('Error loading monthly report counts: $e');
    }
  }

  Future<List<int>> getMonthlyReportCounts() async {
    final laporan2024 = await LaporanService().fetchLaporan2024();
    final monthlyCounts = List<int>.filled(12, 0);


    for (final laporan in laporan2024) {
      try {
        // Debug log untuk melihat nilai datetime
        print("Raw datetime: ${laporan.datetime}");

        // Trim datetime untuk memastikan tidak ada spasi tersembunyi
        final trimmedDateTime = laporan.datetime.trim();

        // Parsing datetime
        final date = DateTime.parse(trimmedDateTime);

        // Ambil bulan
        final month = date.month;

        // Increment jumlah laporan di bulan tersebut
        monthlyCounts[month - 1]++;
      } catch (e) {
        print("Error parsing datetime: ${laporan.datetime}, error: $e");
      }
    }

    return monthlyCounts;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text(
          'Statistik Laporan Kriminalitas',
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Jumlah Laporan Per Bulan (2024)',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: BarChart(
                BarChartData(
                  maxY: (monthlyReportCounts.reduce((a, b) => a > b ? a : b) + 20)
                      .toDouble(),
                  barGroups: List.generate(12, (index) {
                    return BarChartGroupData(
                      x: index,
                      barRods: [
                        BarChartRodData(
                          toY: monthlyReportCounts[index].toDouble(),
                          color: Colors.blue,
                          width: 16,
                        ),
                      ],
                    );
                  }),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 1,
                        reservedSize: 40,
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          const months = [
                            'Jan',
                            'Feb',
                            'Mar',
                            'Apr',
                            'Mei',
                            'Jun',
                            'Jul',
                            'Agu',
                            'Sep',
                            'Okt',
                            'Nov',
                            'Des',
                          ];
                          return SideTitleWidget(
                            axisSide: meta.axisSide,
                            child: Text(
                              months[value.toInt()],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        },
                        reservedSize: 28,
                      ),
                    ),
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  gridData: FlGridData(show: false),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
