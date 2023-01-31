import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:wiceprojet/ProviderClass.dart';

import 'ThirdPage.dart';

class SecondPage extends StatelessWidget {
  SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    ProviderClass donationProvider =
        Provider.of<ProviderClass>(context, listen: false);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(38.0),
        child: Consumer<ProviderClass>(builder: (context, vaue, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: vaue.Namecontroller,
                decoration: InputDecoration(hintText: "Name"),
              ),
              TextField(
                controller: vaue.PhoneController,
                decoration: InputDecoration(hintText: "Phone Number"),
              ),
              TextField(
                controller: vaue.AgeController,
                decoration: InputDecoration(hintText: "Age"),
              ),
              ElevatedButton.icon(
                  onPressed: () {
                    print("click here");
                    print("rere" + vaue.PhoneController.text.toString());
                    donationProvider.AddData();
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => const ThirdPage(),
                    //       ),
                    //    );
                  },
                  icon: Icon(Icons.add),
                  label: Text("ADD"))
            ],
          );
        }),
      ),
    );
  }
}
