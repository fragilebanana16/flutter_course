import 'dart:async';
import 'dart:ui';

import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_course/common/utils/app_colors.dart';
import 'package:flutter_course/pages/fileManage/constants/app_constants.dart';
import 'package:flutter_course/pages/fileManage/shared_components/card_cloud.dart';
import 'package:flutter_course/pages/music/repo/today_in_history_repo.dart';
import 'package:flutter_course/pages/music/viewModel/StepViewModel.dart';
import 'package:flutter_course/pages/music/viewModel/startViewModel.dart';
import 'package:flutter_course/pages/music/views/Widgets/weather/currentWeather.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_course/pages/music/service/poem_service.dart';
import 'package:flutter_course/pages/music/models/poem.dart';

class MusicStartView extends StatefulWidget {
  const MusicStartView({super.key});

  @override
  State<MusicStartView> createState() => _SplashViewState();
}

class _SplashViewState extends State<MusicStartView> {
  final splashVM = Get.put(StartViewModel());
  final stepVM = Get.put(StepViewModel());
  bool _navigatedByButton = false;
  final trackingColor = TColor.lightblue.obs;
  final enRolled = false.obs;
  @override
  void initState() {
    super.initState();
    // // 如果不是点击按钮跳转，自动跳转
    // Future.delayed(const Duration(seconds: 2), () {
    //   if (!_navigatedByButton) {
    //     splashVM.loadView();
    //   }
    // });
  }

  Future<void> _requestPermissionAndStart() async {
    if (await Permission.activityRecognition.request().isGranted) {
      final success = await stepVM.startTracking();
      trackingColor.value = success ? TColor.lightGreen : TColor.lightblue;
      enRolled.value = success;
      print("track color is ${success ? 'blue' : 'green'}");
    } else {
      print("未授予运动权限");
      trackingColor.value = TColor.lightblue;
      enRolled.value = false;
    }
  }

  void _clearRollData() {
    trackingColor.value = TColor.lightblue;
    enRolled.value = false;

    stepVM.clearData(); // 清空数据
    Get.delete<StepViewModel>(); // 再释放控制器
  }

  void _navigateToMusicApp() {
    if (enRolled.value) {
      _clearRollData();
    } else {
      Navigator.of(context).push(
        PageRouteBuilder(
          opaque: false,
          pageBuilder: (_, __, ___) => FullScreenCountdown(
            onCountdownEnd: () {
              Navigator.pop(context); // 移除倒计时
              _requestPermissionAndStart();
              _navigatedByButton = true;
              splashVM.loadView(fromButtonRoll: true);
            },
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.primary_bg,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 6.h),
              // 天气
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: CurrentWeather()),
              SizedBox(height: 10.h),
              // 每日一句
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Ink(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFF2F2F72),
                        trackingColor.value,
                      ],
                    ),
                    image: DecorationImage(
                      image: AssetImage("assets/images/poem/ink2.jpg"),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.3),
                        BlendMode.dstATop,
                      ),
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.4),
                        offset: Offset(0, 6),
                        blurRadius: 12,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16), // 👈 水波纹圆角同步
                    onTap: () {
                      splashVM.loadView();
                    },
                    child: Container(
                      width: double.infinity,
                      constraints: BoxConstraints(minHeight: 80.h),
                      padding: EdgeInsets.symmetric(vertical: 10.0.w),
                      child: FutureBuilder<Poem>(
                        future: PoemService.getRandomPoem(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(
                              child: CircularProgressIndicator(
                                  color: Colors.white),
                            );
                          }

                          final poem = snapshot.data!;
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '"${poem.content}"',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontStyle: FontStyle.italic,
                                    color: TColor.lightWhite,
                                  ),
                                  textAlign: TextAlign.center,
                                  softWrap: true,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  '- ${poem.author}（${poem.dynasty}）',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.white70,
                                  ),
                                  textAlign: TextAlign.center,
                                  softWrap: true,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(() => Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 6.sp, vertical: 6.sp),
                        margin: EdgeInsets.symmetric(horizontal: 10.h),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Color(0xFF2F2F72), trackingColor.value],
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: SizedBox(
                          width: 136.h,
                          height: 166.h,
                          child: CarouselSlider(
                            items: [
                              // 1轨迹
                              Stack(
                                alignment: Alignment.bottomCenter,
                                children: [
                                  GestureDetector(
                                    onLongPress: () async {
                                      final confirmed = await showDialog<bool>(
                                        context: context,
                                        builder: (_) => AlertDialog(
                                          title: const Text('确认清除？'),
                                          content: const Text(
                                              '这将重置你的步数、距离、状态和时间统计。是否继续？'),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context, false);
                                              },
                                              child: const Text('取消'),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                _clearRollData();
                                                Navigator.pop(context, true);
                                              },
                                              child: const Text('确认'),
                                            ),
                                          ],
                                        ),
                                      );

                                      if (confirmed == true) {
                                        stepVM.clearData();
                                        Get.delete<StepViewModel>();
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                              content: Text('数据已清除 🧹')),
                                        );
                                      }
                                    },
                                    child: CircularPercentIndicator(
                                      radius: 140.0, // 你可以根据 UI 需求调整
                                      lineWidth: 12.0,
                                      animation: true,
                                      percent: 0.62, // 假设已完成 62%
                                      circularStrokeCap:
                                          CircularStrokeCap.round,
                                      progressColor:
                                          Theme.of(context).primaryColor,
                                      backgroundColor: Colors.grey.shade300,
                                      center: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "6.2", // 假数据，表示 km
                                            style: TextStyle(
                                              fontSize: 28,
                                              color: Colors.white,
                                            ),
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                            "km",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          SizedBox(height: 8),
                                          Text(
                                            "00:28:37", // 假数据，可换成动态格式化值
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  // 顶部按钮 + 文本
                                  Positioned(
                                    top: 0,
                                    left: 0,
                                    right: 0,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        // 重置
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          child: BackdropFilter(
                                            filter: ImageFilter.blur(
                                                sigmaX: 8, sigmaY: 8),
                                            child: Container(
                                              width: 30,
                                              height: 30,
                                              decoration: BoxDecoration(
                                                color: Colors.white24,
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                border: Border.all(
                                                    color: Colors.white
                                                        .withOpacity(0.2)),
                                              ),
                                              child: IconButton(
                                                icon: Icon(Icons.refresh,
                                                    color: Colors.white),
                                                padding: EdgeInsets.zero,
                                                onPressed: () async {
                                                  // 设置目标
                                                  final repo =
                                                      TodayInHistoryRepo();
                                                  await repo.open();
                                                  final records = await repo
                                                      .getTodayRecords();
                                                  await repo
                                                      .close(); // 用完关闭释放资源
                                                  for (var item in records) {
                                                    print(
                                                        '${item['year']}年: ${item['data']}');
                                                  }
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          "Breath",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                          ),
                                        ),
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          child: BackdropFilter(
                                            filter: ImageFilter.blur(
                                                sigmaX: 8, sigmaY: 8),
                                            child: Container(
                                              width: 30,
                                              height: 30,
                                              decoration: BoxDecoration(
                                                color: Colors.white24,
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                border: Border.all(
                                                    color: Colors.white
                                                        .withOpacity(0.2)),
                                              ),
                                              child: IconButton(
                                                icon: Icon(Icons.settings,
                                                    color: Colors.white),
                                                padding: EdgeInsets.zero,
                                                onPressed: () {
                                                  // 设置目标
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                              // 曲线图
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Speed (km/h)",
                                        style: TextStyle(
                                          color: TColor.lightWhite,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14.sp,
                                        )),
                                    SizedBox(
                                      height: 4.h,
                                    ),
                                    Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        ),
                                        child: SizedBox(
                                            height: 140.h,
                                            child: _buildSpeedLineChart())),
                                  ],
                                ),
                              ),
                            ],
                            options: CarouselOptions(
                              enlargeCenterPage: true,
                              // autoPlay: true,
                              autoPlayCurve: Curves.fastOutSlowIn,
                              enableInfiniteScroll: true,
                              autoPlayAnimationDuration: Duration(seconds: 2),
                              autoPlayInterval: Duration(seconds: 5),
                              viewportFraction: 1,
                            ),
                          ),
                        ),
                      )),

                  // Let's Roll
                  Obx(() => Expanded(
                        child: Container(
                          height: 56.h,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                enRolled.value
                                    ? Colors.redAccent
                                    : Color(0xFF00C853),
                                enRolled.value
                                    ? Color.fromARGB(192, 226, 171, 179)
                                    : Color.fromARGB(255, 134, 173, 136)
                              ],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.4), // 阴影颜色
                                offset: Offset(0, 6), // 阴影位置偏移
                                blurRadius: 12, // 模糊程度
                                spreadRadius: 2, // 扩散范围
                              ),
                            ],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(12),
                              onTap: _navigateToMusicApp,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    enRolled.value
                                        ? "Peace out!"
                                        : "Let's Roll",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: TColor.lightWhite,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )),
                ],
              ),

              SizedBox(height: 10.h),

              // roll
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSpeedLineChart() {
    final List<FlSpot> speedData = [
      FlSpot(0, 5.2),
      FlSpot(1, 5.8),
      FlSpot(2, 6.1),
      FlSpot(3, 6.4),
      FlSpot(4, 6.0),
      FlSpot(5, 6.5),
    ];

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(3),
      child: LineChart(
        LineChartData(
          backgroundColor: const Color(0xFF1E1E1E),
          gridData: FlGridData(
            show: true,
            drawVerticalLine: true,
            drawHorizontalLine: true,
            horizontalInterval: 0.2,
            verticalInterval: 1,
            getDrawingHorizontalLine: (value) => FlLine(
              color: Colors.white10,
              strokeWidth: 0.5,
            ),
            getDrawingVerticalLine: (value) => FlLine(
              color: Colors.white10,
              strokeWidth: 0.5,
            ),
          ),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 28,
                getTitlesWidget: (value, meta) => _buildAxisLabel(
                  text: value.toStringAsFixed(1),
                  alignment: Alignment.centerRight,
                ),
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 20,
                getTitlesWidget: (value, meta) => _buildAxisLabel(
                  text: "T${value.toInt() + 1}",
                  alignment: Alignment.topCenter,
                ),
              ),
            ),
            topTitles: AxisTitles(
                sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 18,
              getTitlesWidget: (value, meta) => Container(), // 空组件占位
            )),
            rightTitles: AxisTitles(
                sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 18,
              getTitlesWidget: (value, meta) => Container(), // 空组件占位
            )),
          ),
          borderData: FlBorderData(show: true),
          lineBarsData: [
            LineChartBarData(
              spots: speedData,
              isCurved: true,
              color: Colors.greenAccent,
              barWidth: 1,
              dotData: FlDotData(show: true),
              belowBarData: BarAreaData(
                show: true,
                color: Colors.greenAccent.withOpacity(0.2),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAxisLabel({
    required String text,
    Alignment alignment = Alignment.center,
  }) {
    return Align(
      alignment: alignment,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        decoration: BoxDecoration(
          color: Colors.white10,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 8,
            color: Colors.white70,
          ),
        ),
      ),
    );
  }
}

class JoggingItem extends StatelessWidget {
  final IconData icon;
  final String value;
  final String measure;

  const JoggingItem({
    Key? key,
    required this.icon,
    required this.value,
    required this.measure,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Icon(icon, color: TColor.lightWhite),
        Text(
          value,
          style: TextStyle(
            fontSize: 16.sp,
            color: TColor.lightWhite,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          measure,
          style: TextStyle(fontSize: 12.sp, color: TColor.lightWhite),
        ),
      ],
    );
  }
}

class GoalCard extends StatelessWidget {
  final int goalNumber;

  const GoalCard({
    Key? key,
    required this.goalNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      // height: 100,
      padding: EdgeInsets.all(25.w),
      margin: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Color(0xFFF4F4F4),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            spreadRadius: 1,
            blurRadius: 2,
            offset: Offset(0, 0), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            radius: 30.r,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Goals #$goalNumber',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 10.h),
              Row(
                children: [
                  Container(
                    height: 5,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      children: [
                        Container(
                          height: 5,
                          width: 20,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    '20% completed',
                    style: TextStyle(
                      fontSize: 10.sp,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(Icons.more_vert),
              Icon(Icons.more_vert),
            ],
          )
        ],
      ),
    );
  }
}

class FullScreenCountdown extends StatefulWidget {
  final VoidCallback onCountdownEnd;

  const FullScreenCountdown({super.key, required this.onCountdownEnd});

  @override
  State<FullScreenCountdown> createState() => _FullScreenCountdownState();
}

class _FullScreenCountdownState extends State<FullScreenCountdown> {
  int count = 3;

  @override
  void initState() {
    super.initState();
    _start();
  }

  void _start() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (count == 1) {
        timer.cancel();
        widget.onCountdownEnd(); // 结束后触发逻辑
      }
      setState(() => count--);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withOpacity(0.6), // 半透明遮罩
      child: Center(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          child: Text(
            '$count',
            key: ValueKey(count),
            style: const TextStyle(
              fontSize: 120,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
