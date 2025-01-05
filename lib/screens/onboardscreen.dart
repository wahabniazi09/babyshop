// import 'package:drawer/screens/loginpage.dart';
import 'package:drawer/routes/pages_routes.dart';
import 'package:drawer/screens/splashlogin.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class Onboardscreen extends StatelessWidget {
  static const String routeName = "/OnBoardScreen";

  final introkey = GlobalKey<IntroductionScreenState>();

  Onboardscreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
      ),
      bodyTextStyle: TextStyle(fontSize: 19),
      bodyPadding: EdgeInsets.fromLTRB(16, 0, 16, 16),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );
    return IntroductionScreen(
      key: introkey,
      globalBackgroundColor: Colors.white,
      pages: [
        PageViewModel(
          title: 'Shop Now',
          body:
              "Shopping is truly enjoyable when everything is perfect! Whether it’s clothes,gadgets, or daily essentials, it’s all about staying within budget without compromising on quality! 💸🛍️",
          image: Image.asset(
            "images/shop2.png",
            width: 200,
          ),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: 'Dicount',
          body:
              "Who doesn't love a great deal? Grab your favorites now at unbeatable discounts! Because saving money while shopping smart is the ultimate win-win! 🛍️💰",
          image: Image.asset(
            "images/shop3.png",
            width: 200,
          ),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: 'Delivery',
          body:
              "Fast, reliable, and hassle-free delivery,right to your doorstep! Shop from anywhere and let us bring convenience to you. 🚚📦",
          image: Image.asset(
            "images/shop1.png",
            width: 200,
          ),
          decoration: pageDecoration,
          footer: Padding(
            padding: const EdgeInsets.only(
              left: 15,
              right: 15,
            ),
            child: ElevatedButton(
              onPressed: () {
                            Navigator.pushReplacementNamed(context, PageRoutes.splashlogin);
              },
              // ignore: sort_child_properties_last
              child: const Text(
                "Let's Shop",
                style: TextStyle(fontSize: 20),
              ),
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(30),
                  backgroundColor: Colors.redAccent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8))),
            ),
          ),
        ),
      ],
      showSkipButton: true,
      showDoneButton: false,
      showBackButton: false,
      back: const Text(
        "Back",
        style: TextStyle(fontWeight: FontWeight.w600, color: Colors.redAccent),
      ),
      next: const Text(
        "Next",
        style: TextStyle(fontWeight: FontWeight.w600, color: Colors.redAccent),
      ),
      skip: const Text(
        "Skip",
        style: TextStyle(fontWeight: FontWeight.w600, color: Colors.redAccent),
      ),
      done: const Text(
        "Done",
        style: TextStyle(fontWeight: FontWeight.w600, color: Colors.redAccent),
      ),
      onSkip: () {
        Navigator.pushReplacementNamed(context, PageRoutes.splashlogin);
      },
      onDone: () {},
      dotsDecorator: DotsDecorator(
          size: const Size.square(10),
          activeSize: const Size(20, 10),
          activeColor: Colors.redAccent,
          color: Colors.black,
          spacing: const EdgeInsets.symmetric(horizontal: 3),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          )),
    );
  }
}
