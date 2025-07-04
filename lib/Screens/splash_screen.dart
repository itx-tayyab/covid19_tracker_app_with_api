import 'dart:async';
import 'dart:math' as math;
import 'package:covid19_tracker_app_with_api/Screens/stats_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{

  late final AnimationController controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3))..repeat();
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 10),(){
     Navigator.push(context, MaterialPageRoute(builder: (context) => StatsScreen(),));});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
          animation: controller,
          child: Center(child: Image(image: AssetImage('images/virus.png'))),
          builder: (BuildContext context, Widget? child){
            return Transform.rotate(
                angle: controller.value * 2.0 * math.pi,
                child: child,);
          })
    );
  }
}
