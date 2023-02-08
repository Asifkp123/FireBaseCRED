import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:wiceprojet/ProviderClass.dart';

import 'ThirdPage.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    ProviderClass donationProvider =
        Provider.of<ProviderClass>(context, listen: false);
    // donationProvider.TextFieldd();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(38.0),
        child: Consumer<ProviderClass>(builder: (context, vaue, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: vaue.Namecontroller,
                decoration: const InputDecoration(hintText: "Name"),
              ),
              TextField(
                controller: vaue.PhoneController,
                decoration: const InputDecoration(
                  hintText: "Phone Number",
                ),
              ),
              TextFormField(
                controller: vaue.AgeController,
                decoration: const InputDecoration(hintText: "Age"),
              ),
              ElevatedButton.icon(
                  onPressed: () {
                    donationProvider.AddData();

                    //    donationProvider.getdataa();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ThirdPage(),
                      ),
                    );
                    donationProvider.clearData();
                  },
                  icon: const Icon(Icons.mic),
                  label: const Text("ADD"))
            ],
          );
        }),
      ),
    );
  }
}
