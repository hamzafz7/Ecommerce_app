import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../network/local/CasheHelper.dart';
import '../login/login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

bool islast = false;

class _OnboardingScreenState extends State<OnboardingScreen> {
  void submit() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    if (await sh.setBool('onboarding', true)) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: ((context) => LoginScreen())));
    }
    ;
  }

  @override
  Widget build(BuildContext context) {
    //   bool islast = false;
    var pagecontroller = PageController();
    List<Boardmodel> boarding = [
      Boardmodel(
          image: "assets/images/onboarding1.jpg",
          title: "Title 1",
          body: "Bodyscreen 1"),
      Boardmodel(
          image: "assets/images/onboarding1.jpg",
          title: "Title 2",
          body: "Bodyscreen 2"),
      Boardmodel(
          image: "assets/images/onboarding1.jpg",
          title: "Title 3",
          body: "Bodyscreen 3")
    ];
    return Scaffold(
        appBar: AppBar(
          title: Text("SALLA"),
          actions: [
            TextButton(
                onPressed: () {
                  submit();
                },
                child: Text("skip"))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                    onPageChanged: (value) {
                      if (value == boarding.length - 1) {
                        setState(() {
                          islast = true;
                        });
                      } else {
                        setState(() {
                          islast = false;
                        });
                      }
                    },
                    controller: pagecontroller,
                    itemCount: 3,
                    itemBuilder: ((context, index) =>
                        buildonboardingitem(boarding[index]))),
              ),
              Row(
                children: [
                  SmoothPageIndicator(
                      controller: pagecontroller, count: boarding.length),
                  Spacer(),
                  FloatingActionButton(
                    onPressed: () {
                      if (islast) {
                        submit();
                      } else {
                        pagecontroller.nextPage(
                            duration: Duration(microseconds: 750),
                            curve: Curves.fastLinearToSlowEaseIn);
                      }
                    },
                    child: Icon(Icons.arrow_forward),
                  )
                ],
              )
            ],
          ),
        ));
  }
}

Widget buildonboardingitem(Boardmodel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            image: AssetImage("${model.image}"),
            fit: BoxFit.fill,
            width: double.infinity,
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            "${model.title}",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            "${model.body}",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          )
        ]);

class Boardmodel {
  String? image;
  String? title;
  String? body;
  Boardmodel({this.image, this.title, this.body});
}
