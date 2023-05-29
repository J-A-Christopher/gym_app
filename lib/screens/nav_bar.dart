import 'package:flutter/material.dart';
import 'package:gym_app/widgets/tab_content.dart';

import '../widgets/tab_content1.dart';
import '../widgets/tab_content2.dart';
import '../widgets/tab_content3.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Expanded(
        child: Column(
          children: [
            SizedBox(
              height: 50,
              child: AppBar(
                  elevation: 0,
                  backgroundColor: Colors.white24,
                  bottom: const PreferredSize(
                      preferredSize: Size.fromHeight(10),
                      child: TabBar(
                          isScrollable: true,
                          labelColor: Colors.black,
                          unselectedLabelColor: Colors.grey,
                          tabs: [
                            Tab(
                              text: 'LEGS',
                            ),
                            Tab(
                              text: 'ARMS',
                            ),
                            Tab(
                              text: 'BACK',
                            ),
                            Tab(
                              text: 'CHEST',
                            )
                          ]))),
            ),
            const Expanded(
                child: TabBarView(children: [
              TabContent(),
              TabContent1(),
              TabContent2(),
              TabContent3()
            ]))
          ],
        ),
      ),
    );
  }
}
