import 'package:cloud_firestore/cloud_firestore.dart';
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
    ProviderClass donationProvider =
        Provider.of<ProviderClass>(context, listen: false);
    donationProvider.getdataa();

    return SafeArea(
      child: Scaffold(
          floatingActionButton: ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SecondPage()));
              },
              child: Icon(
                Icons.add,
                size: 50,
              )),
          body: Consumer<ProviderClass>(builder: (context, a, child) {
            return ListView.builder(
              itemCount: a.modellist.length,
              itemBuilder: (context, index) {
                var item = a.modellist[index];
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
                              onPressed: () {},
                              child: TextButton(
                                  onPressed: () {
                                     a.update_data(item.id, item.age, item.name,
                                       item.phoneNumber);
                                    print(item.id + "iddddd");
                               //     print(a.PhoneController.text + "phoneee");
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const SecondPage()));

//                                    donationProvider.getdataa();
                                  },
                                  child: const Text('EDIT')),
                            ),
                            TextButton(
                              onPressed: () {
                                a.delete(item.id);
                                a.notifyListeners();
                                // a.clear();

                                Navigator.pop(context);
                                //     a.notifyListeners();
                              },
                              child: const Text('DELETE'),
                            ),
                          ],
                        ),
                      );

                      const Text('Show Dialog');
                    },
                    child: Container(
                      height: 100,
                      width: 500,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(children: [
                        Consumer<ProviderClass>(
                            builder: (context, value, child) {
                          return Text(
                            value.modellist[index].name.toString(),
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                          );
                        }),
                        Consumer<ProviderClass>(
                          builder: (context, value, child) {
                            return Text(
                              value.modellist[index].phoneNumber.toString(),
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                            );
                          },
                        ),
                        Consumer<ProviderClass>(
                            builder: (context, value, child) {
                          return Text(
                            value.modellist[index].age.toString(),
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                          );
                        }),
                      ]),
                    ),
                  ),
                );
              },
            );
          })),
    );
  }
}
