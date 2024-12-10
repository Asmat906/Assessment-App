import 'package:flutter/material.dart';
import 'package:makeup_browser/assets/images.dart';
import 'package:makeup_browser/view/home_screen.dart';
import 'package:nb_utils/nb_utils.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 1.0, curve: Curves.easeInOut),
      ),
    );

    _controller.forward();

    Future.delayed(const Duration(seconds: 4), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) =>  HomeScreen(),
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: wheat,
      body: Center(
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Transform.scale(
                scale: _animation.value,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // ClipOval(
                      //   child: Image.asset(
                      //     image_splash,
                      //     // width: double.infinity,
                      //     fit: BoxFit.fill,
                      //     height: MediaQuery.sizeOf(context).height * .4,
                      //     width: MediaQuery.sizeOf(context).width * .9,
                      //   ),
                      // ),
                      // const SizedBox(
                      //   height: 20,
                      // ),
                      AnimatedTextKit(
                        animatedTexts: [
                          TypewriterAnimatedText(
                            curve: Curves.easeInCirc,
                            'MakeUp Browser...',textAlign: TextAlign.center,
                            textStyle: const TextStyle(
                              fontFamily: "Arvo",
                              fontSize: 22.0,
                              color: indigo,
                              fontWeight: FontWeight.bold,
                            ),
                            speed: const Duration(milliseconds: 50),
                          ),
                        ],
                        totalRepeatCount: 1,
                        pause: const Duration(milliseconds: 100),
                        displayFullTextOnTap: true,
                        stopPauseOnTap: true,
                      ).paddingTop(20.0),
                    ],
                  ).paddingSymmetric(horizontal: 20),
                ));
          },
        ),
      ),
    );
  }
}
