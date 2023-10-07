import 'package:calculations/providers/loginProvider.dart';
import 'package:calculations/screens/homepage.dart';
import 'package:calculations/src/homescreen.dart';
import 'package:calculations/src/welcomePage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Looding extends StatefulWidget {
  @override
  _LoodingState createState() => _LoodingState();
}

class _LoodingState extends State<Looding> {
  @override
  void initState() {
    super.initState();

    Provider.of<LoginRegister>(context, listen: false).checkiftoken();
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<LoginRegister>(context).checkiftoken();

    return Scaffold(
      body: Center(
        child: Center(
          child: FutureBuilder(
            future: data,
            initialData: false,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              return showme(snapshot);
            },
          ),
        ),
      ),
    );
  }
}

Widget showme(AsyncSnapshot snapshot) {
  if (snapshot.connectionState == null) {
    return CircularProgressIndicator();
  } else if (snapshot.data == true) {
    return MyHomePage();
  } else {
    return WelcomePage();
  }
}
