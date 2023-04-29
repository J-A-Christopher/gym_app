import 'package:flutter/material.dart';
import '../widgets/grid_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Fitness Tracker'),
          elevation: 0,
        ),
        drawer: Drawer(
          child: ListView(
            padding: const EdgeInsets.all(0),
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(color: Colors.indigo),
                child: UserAccountsDrawerHeader(
                  accountName: Text(
                    'Cj',
                    style: TextStyle(fontSize: 20),
                  ),
                  accountEmail: Text('xyZ@gmail.com'),
                  currentAccountPictureSize: Size.square(55),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: Color(0xff6f00fe),
                    child: Text(
                      'C',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),
              ),
              ListTile(
                title: const Text('Home'),
                leading: const Icon(Icons.home),
                onTap: () {
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ),
        body: Column(
          children: const [
            GridWidget(),
          ],
        ));
  }
}
