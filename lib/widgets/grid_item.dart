import 'package:flutter/material.dart';

class GridItem extends StatelessWidget {
  final String title;
  final String img;
  final Function()? func;

  const GridItem(
      {super.key, required this.title, required this.img, this.func});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: GestureDetector(
        onTap: func,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Expanded(
                    child: Image.asset(
                  'assets/$img',
                )),
                Text(title),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
