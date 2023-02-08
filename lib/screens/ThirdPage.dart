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
    // donationProvider.search_data("");

    return SafeArea(
      child: Scaffold(
          floatingActionButton: ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SecondPage(
                              from: 'new',
                              oldId: '',
                            )));
              },
              child: Icon(
                Icons.add,
                size: 50,
              )),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: ((ask) {
                    donationProvider.search_data(ask);
                  }),
                  // controller: donationProvider.SearchController,
                  decoration: InputDecoration(labelText: "SEARCH"),
                ),
              ),
              Expanded(
                child: Consumer<ProviderClass>(builder: (context, a, child) {
                  return a.found.isNotEmpty
                      ? ListView.builder(
                          itemCount: a.found.length,
                          itemBuilder: (context, index) {
                            var item = a.found[index];

                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onLongPress: () {
                                  showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                      //    title: const Text('AlertDialog Title'),
                                      //    content: const Text(''),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {},
                                          child: TextButton(
                                              onPressed: () {
                                                a.update_data(
                                                    item.age,
                                                    item.name,
                                                    item.phoneNumber);
                                                //a.updateDocument(item.id);
                                                //     print(a.PhoneController.text + "phoneee");
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            SecondPage(
                                                              name1: item.name,
                                                              from: 'edit',
                                                              oldId: item.id
                                                                  .toString(),
                                                            )));

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
                                        value.found[index].name.toString(),
                                        style: const TextStyle(
                                          fontSize: 20,
                                        ),
                                      );
                                    }),
                                    Consumer<ProviderClass>(
                                      builder: (context, value, child) {
                                        return Text(
                                          value.found[index].phoneNumber
                                              .toString(),
                                          style: const TextStyle(
                                            fontSize: 20,
                                          ),
                                        );
                                      },
                                    ),
                                    Consumer<ProviderClass>(
                                        builder: (context, value, child) {
                                      return Text(
                                        value.found[index].age.toString(),
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
                        )
                      : Text("No Value Found");
                }),
              ),
            ],
          )),
    );
  }
}
