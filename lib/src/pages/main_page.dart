import 'package:flutter/material.dart';
import 'map_widget.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  TextEditingController searchButton = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Centro comercial NEVAL'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Card(
                  child: Container(
                padding: const EdgeInsets.only(
                    left: 3.0, right: 8.0, top: 3.0, bottom: 10.0),
                child: TextField(
                  controller: searchButton,
                  decoration: const InputDecoration(
                      hintText: 'Buscar elemento',
                      icon: Icon(Icons.find_in_page_outlined)),
                ),
              )),
              Expanded(
                child: Container(
                    alignment: Alignment.center, child: const MapScreen()),
              ),
              Container(
                alignment: Alignment.topRight,
                child: Row(
                  children: [
                    Card(
                      child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.shopping_bag,
                            size: 50.0,
                          )),
                    ),
                    Card(
                      child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.add_shopping_cart_sharp,
                            size: 50.0,
                          )),
                    ),
                    Card(
                      child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.accessibility_new_rounded,
                            size: 50.0,
                          )),
                    ),
                    Card(
                      child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.data_exploration_sharp,
                            size: 50.0,
                          )),
                    ),
                    Card(
                      child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.add_location_alt,
                            size: 50.0,
                          )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
