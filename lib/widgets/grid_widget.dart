import 'package:flutter/material.dart';
import './grid_item.dart';
import '../screens/chest_screen.dart';
import '../screens/back_screen.dart';
import '../screens/armas_screen.dart';
import '../screens/legs_screen.dart';

class GridWidget extends StatelessWidget {
  const GridWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> titles = ['Legs', 'Arms', 'Back', 'Chest'];
    final images = ['leg.png', 'arm.png', 'back.png', 'chest.png'];
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 8.0, top: 8),
            child: Text(
              'Choose a \n Workout.',
              style: TextStyle(fontSize: 40),
            ),
          ),
          Flexible(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3 / 2,
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 2),
              itemBuilder: ((context, index) => GridItem(
                    title: titles[index],
                    img: images[index],
                    func: () {
                      if (titles[index] == 'Chest') {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: ((context) => const ChestScreen())));
                      } else if (titles[index] == 'Back') {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: ((context) => const BackScreen())));
                      } else if (titles[index] == 'Arms') {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: ((context) => const ArmsScreen())));
                      } else if (titles[index] == 'Legs') {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: ((context) => const LegsScreen())));
                      }
                    },
                  )),
              itemCount: images.length,
            ),
          ),
        ],
      ),
    );
  }
}
