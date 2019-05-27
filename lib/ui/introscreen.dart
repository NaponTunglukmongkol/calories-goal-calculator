// import 'package:health_app/ui/Home.dart';
// import 'package:health_app/ui/SignIn.dart';
// import 'package:intro_slider/intro_slider.dart';
// import 'package:flutter/material.dart';

// class Intro extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     // TODO: implement createState
//     return IntroState();
//   }
// }

// class IntroState extends State<Intro> {
//   List<Slide> slides = new List();

//   @override
//   void initState() {
//     super.initState();

//     slides.add(
//       new Slide(
//         title: "Want to con",
//         description:
//             "Allow miles wound place the leave had. To sitting subject no improve studied limited",
//         // pathImage: "images/photo_eraser.png",
//         backgroundColor: Color(0xfff5a623),
//       ),
//     );
//     slides.add(
//       new Slide(
//         title: "PENCIL",
//         description:
//             "Ye indulgence unreserved connection alteration appearance",
//         // pathImage: "images/photo_pencil.png",
//         backgroundColor: Color(0xff203152),
//       ),
//     );
//     slides.add(
//       new Slide(
//         title: "RULER",
//         description:
//             "Much evil soon high in hope do view. Out may few northward believing attempted. Yet timed being songs marry one defer men our. Although finished blessing do of",
//         // pathImage: "images/photo_ruler.png",
//         backgroundColor: Color(0xff9932CC),
//       ),
//     );
//   }

//   void onDonePress() {
//     Navigator.pop(context);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return new IntroSlider(
//       slides: this.slides,
//       onDonePress: this.onDonePress,
//     );
//   }
// }

import 'package:health_app/ui/Home.dart';
import 'package:health_app/ui/SignIn.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:flutter/material.dart';

class Intro extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return IntroState();
  }
}

class IntroState extends State<Intro> {
  List<Slide> slides = new List();

  @override
  void initState() {
    super.initState();

    slides.add(
      new Slide(
        pathImage: "assets/images/icon/checked.png",
        title: "Easy to Use",
        description:
            "Easy UI that you can use and see result in just a few touch in any time and any place.",
        // pathImage: "images/photo_eraser.png",
        backgroundColor: Color(0xfff5a623),
      ),
    );
    slides.add(
      new Slide(
        pathImage: "assets/images/icon/burger.png",
        title: "Track Your Calories",
        description:
            "Tracking what you Eat and Calories you get is way easy than before! You Can Track Calorie and retain data that you have eat in last 7 day in any time any place.",
        // pathImage: "images/photo_pencil.png",
        backgroundColor: Color(0xff203152),
      ),
    );
    slides.add(
      new Slide(
        pathImage: "assets/images/icon/burn.png",
        title: "Track Burned Calories",
        description:
            " How much Calorie I has been burn? Your answer is in this fantastic application! you can track burned Calorie due to your exercise and retain data in last 7 day.",
        // pathImage: "images/photo_ruler.png",
        backgroundColor: Color(0xff9932CC),
      ),
    );
  }

  void onDonePress() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return new IntroSlider(
      slides: this.slides,
      onDonePress: this.onDonePress,
    );
  }
}
