import 'package:flutter/material.dart';
import 'package:flutter_course/common/utils/app_colors.dart';
import 'package:flutter_course/pages/music/viewModel/StepViewModel.dart';
import 'package:flutter_course/pages/music/viewModel/startViewModel.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
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
      trackingColor.value = success ? TColor.lightblue : TColor.lightGreen;
      enRolled.value = success;
      print("track color is $success");
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
      _requestPermissionAndStart();
    }

    // _navigatedByButton = true;
    // splashVM.loadView();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: TColor.darkGray,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      // ✅ 限制左侧 Column 的宽度
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(() => Text(
                                stepVM.currentTime.value,
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w600,
                                    color: TColor.lightWhite),
                              )),
                          SizedBox(height: 20.h),
                          Container(
                            width: double.infinity, // 自动适配 Column 宽度
                            constraints: BoxConstraints(
                              minHeight: 100.h,
                            ),
                            padding: EdgeInsets.symmetric(vertical: 10.0.w),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color(0xFF2F2F72), // 靛蓝紫
                                  trackingColor.value
                                ],
                              ),
                              image: DecorationImage(
                                image: AssetImage(
                                    "assets/images/poem/ink2.jpg"), // 👈 替换成你的背景图路径
                                fit: BoxFit.cover, // 👌 拉伸铺满容器
                                colorFilter: ColorFilter.mode(
                                  Colors.black
                                      .withOpacity(0.3), // 👈 控制图片的透明度，让渐变透出来
                                  BlendMode.dstATop,
                                ),
                              ),
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.4), // 阴影颜色
                                  offset: Offset(0, 6), // 阴影位置偏移
                                  blurRadius: 12, // 模糊程度
                                  spreadRadius: 2, // 扩散范围
                                ),
                              ],
                            ),
                            child: FutureBuilder<Poem>(
                              future: PoemService.getRandomPoem(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return const Center(
                                      child: CircularProgressIndicator(
                                          color: Colors.white));
                                }

                                final poem = snapshot.data!;
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
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
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  'Jogging',
                  style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: TColor.lightWhite),
                ),
              ),
              SizedBox(height: 20.h),
              GestureDetector(
                onLongPress: () async {
                  final confirmed = await showDialog<bool>(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text('确认清除？'),
                      content: const Text('这将重置你的步数、距离、状态和时间统计。是否继续？'),
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
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('数据已清除 🧹')),
                    );
                  }
                },
                child: Obx(() => Container(
                      width: size.width,
                      height: 140.h,
                      padding: EdgeInsets.symmetric(vertical: 20.sp),
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Color(0xFF2F2F72), trackingColor.value],
                        ),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.4),
                            offset: const Offset(0, 6),
                            blurRadius: 12,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(() => JoggingItem(
                                icon: Icons.directions_run,
                                value: "${stepVM.steps.value}",
                                measure: "Steps",
                              )),
                          Obx(() => JoggingItem(
                                icon: Icons.location_on,
                                value:
                                    "${stepVM.distanceKm.value.toStringAsFixed(2)}",
                                measure: "Km",
                              )),
                          Obx(() => JoggingItem(
                                icon: Icons.flash_on,
                                value: "${stepVM.status.value}",
                                measure: "State",
                              )),
                          Obx(() => JoggingItem(
                                icon: Icons.watch_later_outlined,
                                value: stepVM.formattedDuration,
                                measure: "Time",
                              )),
                          // 可选：你可以移除 TextButton，长按即是触发点
                        ],
                      ),
                    )),
              ),
              SizedBox(height: 20.h),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Speed (km/h)",
                        style: TextStyle(
                          color: TColor.lightWhite,
                          fontWeight: FontWeight.w600,
                          fontSize: 16.sp,
                        )),
                    const SizedBox(height: 12),
                    // fl_chart 的 LineChart 是一个自绘组件，它必须知道自己的尺寸
                    Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.4), // 阴影颜色
                              offset: Offset(0, 6), // 阴影位置偏移
                              blurRadius: 12, // 模糊程度
                              spreadRadius: 2, // 扩散范围
                            ),
                          ],
                        ),
                        child: SizedBox(
                            height: 200, child: _buildSpeedLineChart())),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              Obx(() => Container(
                    width: double.infinity,
                    height: 56,
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          enRolled.value ? Colors.redAccent : Color(0xFF00C853),
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
                              enRolled.value ? "Peace out!" : "Let's Roll",
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
                  )),
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
      padding: const EdgeInsets.all(12),
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
                reservedSize: 40,
                getTitlesWidget: (value, meta) => _buildAxisLabel(
                  text: value.toStringAsFixed(1),
                  alignment: Alignment.centerRight,
                ),
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) => _buildAxisLabel(
                  text: "T${value.toInt() + 1}",
                  alignment: Alignment.topCenter,
                ),
              ),
            ),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          borderData: FlBorderData(show: true),
          lineBarsData: [
            LineChartBarData(
              spots: speedData,
              isCurved: true,
              color: Colors.greenAccent,
              barWidth: 4,
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
