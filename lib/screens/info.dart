import 'package:calculations/screens/tutorialScreen.dart';
import 'package:flutter/material.dart';

class InfoScreem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("About us"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Text(
                "  This app was built by OpenClues team, to help you Calculating your recipes and save your all ingredients and recipes in one place.",
                textAlign: TextAlign.justify,
                style: TextStyle(
                  height: 1.4,
                  fontSize: 18,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "For informing about any problems just send us an email attached with the problem here : albayan.ar7@gmail.com",
                textAlign: TextAlign.justify,
                style: TextStyle(
                  height: 1.4,
                  fontSize: 18,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => TutorialScreen()));
                },
                child: Text(
                  "  If you faced any difficulties using our app, Click here",
                  textAlign: TextAlign.justify,
                  style:
                      TextStyle(height: 1.4, fontSize: 16, color: Colors.green),
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ));
  }
}
