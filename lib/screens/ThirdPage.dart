import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:wiceprojet/ProviderClass.dart';
import 'package:wiceprojet/screens/SecondPage.dart';

class ThirdPage extends StatelessWidget {
  const ThirdPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: ListView.builder(
        itemCount: 4,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onLongPress: () {
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    //    title: const Text('AlertDialog Title'),
                    //    content: const Text(''),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SecondPage()));
                        },
                        child: const Text('EDIT'),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text('DELETE'),
                      ),
                    ],
                  ),
                );
                child:
                const Text('Show Dialog');
              },
              child: Container(
                child:  Column(
                  children: [
                    Consumer<ProviderClass>(builder: (context, value, child) {
                      return Text(
                        value.Namecontroller.text,
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      );}),
                      Consumer<ProviderClass>(builder: (context, value, child) {
                        return Text(
                         value.PhoneController.text,
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        );
                        },
                        ),
                        Consumer<ProviderClass>(
                            builder: (context, value, child) {
                          return Text(
                            value.AgeController.text,
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          );
                            }),
                      
                    
            
               ] ),
                height: 100,
                width: 500,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.amber),
              ),
            ),
          );
        },
      )),
    );
  }
}
