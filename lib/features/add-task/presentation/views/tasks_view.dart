import 'package:flutter/material.dart';
import 'package:tasky/core/utils/app_colors.dart';
import 'package:tasky/core/utils/app_styles.dart';
import 'package:tasky/features/add-task/data/firebase/task_firbase_operation.dart';
import 'package:tasky/features/add-task/data/model/task_model.dart';
import 'package:tasky/features/add-task/presentation/views/widgets/add_task_button_sheet.dart';
import 'package:tasky/features/add-task/presentation/views/widgets/tasks_view_body.dart';
import 'package:fl_chart/fl_chart.dart';

class TasksView extends StatelessWidget {
  const TasksView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,

      backgroundColor: AppColors.scaffoldColor,
      body: TaskViewBody(),

      floatingActionButton: 
      Column(
        spacing: 20,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: "graphBtn",
            backgroundColor: Colors.green,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const TaskAnalysisView()),
              );
            },
            child: const Icon(Icons.bar_chart),
          ),
          AddTaskButtonSheet(),
        ],
      ),
    );
  }
}

class TaskAnalysisView extends StatefulWidget {
  const TaskAnalysisView({super.key});

  @override
  State<TaskAnalysisView> createState() => _TaskAnalysisViewState();
}

class _TaskAnalysisViewState extends State<TaskAnalysisView> {
  late final Stream<List<TaskModel>> taskStream;

  @override
  void initState() {
    super.initState();
    taskStream = TaskFirebaseOperation.getAllTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:  Text('Task Analysis',style: AppStyles.latoBold20.copyWith(fontSize: 25)),
        backgroundColor: Colors.green,
        elevation: 0,
      ),
      body: StreamBuilder<List<TaskModel>>(
        stream: taskStream,
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snap.hasError) {
            return const Center(child: Text('Error loading tasks'));
          }

          final tasks = snap.data ?? [];
          return TaskCharts(tasks: tasks);
        },
      ),
    );
  }
}


class TaskCharts extends StatefulWidget {
  final List<TaskModel> tasks;
  const TaskCharts({super.key, required this.tasks});

  @override
  State<TaskCharts> createState() => _TaskChartsState();
}

class _TaskChartsState extends State<TaskCharts> with SingleTickerProviderStateMixin {
  final ValueNotifier<int> activePieIndex = ValueNotifier<int>(-1);

  static const Color completedColor = Color(0xFF16A34A);
  static const Color pendingColor = Color(0xFFEF4444);
  static const Color barCompleted = Color(0xFF2563EB);
  static const Color barPending = Color(0xFFF97316);

  final Duration chartSwapDuration = const Duration(milliseconds: 400);
  final Curve chartSwapCurve = Curves.easeInOutCubic;

  @override
  void dispose() {
    activePieIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final total = widget.tasks.length;
    final completedCount = widget.tasks.where((t) => t.isCompleted == true).length;
    final pendingCount = total - completedCount;

    // build per-day aggregated counts (Mon=1 ... Sun=7)
    final Map<int, int> totalPerDay = {for (var i = 1; i <= 7; i++) i: 0};
    final Map<int, int> completedPerDay = {for (var i = 1; i <= 7; i++) i: 0};

    for (final t in widget.tasks) {
      final dt = t.dateTime;
      if (dt == null) continue;
      final weekday = dt.weekday;
      totalPerDay[weekday] = (totalPerDay[weekday] ?? 0) + 1;
      if (t.isCompleted == true) {
        completedPerDay[weekday] = (completedPerDay[weekday] ?? 0) + 1;
      }
    }

    final List<int> days = List<int>.generate(7, (i) => i + 1); // 1..7

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Row(
                children: [
                  const Icon(Icons.analytics_outlined, size: 28, color: Colors.green),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Overview', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                        const SizedBox(height: 4),
                        Text('$total tasks • $completedCount completed', style: const TextStyle(fontSize: 12, color: Colors.black54)),
                      ],
                    ),
                  ),
                  // small summary badges
                  _smallBadge('$completedCount', 'Done', completedColor),
                  const SizedBox(width: 8),
                  _smallBadge('$pendingCount', 'Pending', pendingColor),
                ],
              ),
            ),
          ),

          const SizedBox(height: 22),

          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Completion Ratio', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                  ),
                  const SizedBox(height: 12),

                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 220,
                          child: ValueListenableBuilder<int>(
                            valueListenable: activePieIndex,
                            builder: (context, active, _) {
                              return PieChart(
                                PieChartData(
                                  pieTouchData: PieTouchData(
                                    enabled: true,
                                    touchCallback: (event, response) {
                                      if (!event.isInterestedForInteractions || response?.touchedSection == null) {
                                        activePieIndex.value = -1;
                                        return;
                                      }
                                      activePieIndex.value = response!.touchedSection!.touchedSectionIndex;
                                    },
                                  ),
                                  sectionsSpace: 8,
                                  centerSpaceRadius: 42,
                                  sections: [
                                    PieChartSectionData(
                                      value: completedCount.toDouble(),
                                      color: completedColor,
                                      radius: active == 0 ? 88 : 70,
                                      title: total == 0 ? '0%' : '${(completedCount / total * 100).toStringAsFixed(1)}%',
                                      titleStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 14),
                                    ),
                                    PieChartSectionData(
                                      value: pendingCount.toDouble(),
                                      color: pendingColor,
                                      radius: active == 1 ? 88 : 70,
                                      title: total == 0 ? '0%' : '${(pendingCount / total * 100).toStringAsFixed(1)}%',
                                      titleStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 14),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),

                      const SizedBox(width: 12),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _legendTile(color: completedColor, title: 'Completed', value: completedCount),
                          const SizedBox(height: 12),
                          _legendTile(color: pendingColor, title: 'Pending', value: pendingCount),
                          const SizedBox(height: 18),
                          _insightRow(Icons.check_circle, 'Completion', total == 0 ? '—' : '${(completedCount / total * 100).toStringAsFixed(0)}%'),
                          const SizedBox(height: 6),
                          _insightRow(Icons.timelapse, 'Active Days', '${_activeDaysCount(totalPerDay)}'),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 22),

          // --- Grouped Bar Chart Card
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Weekly Distribution', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 300,
                    child: BarChart(
                      BarChartData(
                        alignment: BarChartAlignment.spaceBetween,
                        maxY: _maxY(totalPerDay) + 1.0,
                        barTouchData: BarTouchData(
                          enabled: true,
                          touchTooltipData: BarTouchTooltipData(
                            getTooltipItem: (group, groupIndex, rod, rodIndex) {
                              final dayIndex = group.x.toInt();
                              final dayName = _shortDayName(dayIndex);
                              final isCompletedRod = rodIndex == 0;
                              final value = rod.toY.round();
                              return BarTooltipItem(
                                '$dayName\n${isCompletedRod ? 'Done' : 'Pending'}: $value',
                                const TextStyle(color: Colors.white),
                              );
                            },
                          ),
                        ),
                        titlesData: FlTitlesData(
                          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true)),
                          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, meta) {
                                return Padding(
                                  padding: const EdgeInsets.only(top: 6.0),
                                  child: Text(_shortDayName(value.toInt()), style: const TextStyle(fontSize: 12)),
                                );
                              },
                              reservedSize: 36,
                            ),
                          ),
                        ),
                        gridData: FlGridData(show: true),
                        borderData: FlBorderData(show: false),
                        barGroups: days.map((day) {
                          final completedForDay = completedPerDay[day]?.toDouble() ?? 0.0;
                          final totalForDay = totalPerDay[day]?.toDouble() ?? 0.0;
                          final pendingForDay = (totalForDay - completedForDay).clamp(0.0, totalForDay);

                          return BarChartGroupData(
                            x: day,
                            barsSpace: 6,
                            barRods: [
                              BarChartRodData(
                                toY: completedForDay,
                                width: 8,
                                borderRadius: BorderRadius.circular(4),
                                color: barCompleted,
                                rodStackItems: [],
                              ),
                              BarChartRodData(
                                toY: pendingForDay,
                                width: 8,
                                borderRadius: BorderRadius.circular(4),
                                color: barPending,
                                rodStackItems: [],
                              ),
                            ],
                          );
                        }).toList(),
                        groupsSpace: 18,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // small legend for bars
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _legendIconText(barCompleted, 'Done'),
                      const SizedBox(width: 20),
                      _legendIconText(barPending, 'Pending'),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _smallBadge(String value, String label, Color bg) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(color: bg.withOpacity(0.12), borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          Container(width: 8, height: 8, decoration: BoxDecoration(color: bg, shape: BoxShape.circle)),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(value, style: TextStyle(fontWeight: FontWeight.w700, color: bg)),
              Text(label, style: const TextStyle(fontSize: 10, color: Colors.black54)),
            ],
          )
        ],
      ),
    );
  }

  Widget _legendTile({required Color color, required String title, required int value}) {
    return Row(
      children: [
        Container(width: 12, height: 12, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(4))),
        const SizedBox(width: 8),
        Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(width: 8),
        Text('($value)', style: const TextStyle(color: Colors.black54)),
      ],
    );
  }

  Widget _insightRow(IconData icon, String title, String s) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.black54),
        const SizedBox(width: 8),
        Text(title, style: const TextStyle(fontSize: 12, color: Colors.black54)),
      ],
    );
  }

  String _shortDayName(int dayNumber) {
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    if (dayNumber < 1 || dayNumber > 7) return '';
    return days[dayNumber - 1];
  }

  int _activeDaysCount(Map<int, int> map) {
    return map.values.where((v) => v > 0).length;
  }

  double _maxY(Map<int, int> totals) {
    final maxVal = totals.values.fold<int>(0, (prev, e) => e > prev ? e : prev);
    return maxVal.toDouble();
  }

  Widget _legendIconText(Color color, String text) {
    return Row(
      children: [
        Container(width: 14, height: 14, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(4))),
        const SizedBox(width: 8),
        Text(text, style: const TextStyle(fontSize: 13)),
      ],
    );
  }
}
