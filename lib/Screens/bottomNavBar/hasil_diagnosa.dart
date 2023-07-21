import 'package:flutter/material.dart';

import '../../Style/colors.dart';

class HasilDiagnosaScreens extends StatefulWidget {
  const HasilDiagnosaScreens({Key? key}) : super(key: key);

  @override
  State<HasilDiagnosaScreens> createState() => _HasilDiagnosaScreensState();
}

class _HasilDiagnosaScreensState extends State<HasilDiagnosaScreens> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: AppColors.black, width: 1.0)),
              child: Column(
                children: [Text("Ini Merupakan Hasil Diagnosa")],
              ),
            ),
          )
        ],
      ),
    );
  }
}
