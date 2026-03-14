import 'package:flutter/material.dart';

import '../../../core/components/custom_app_bar.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: CustomAppBar()),
      body:Column(
        children: [
          Row(
            children: [
              Container(

              )
            ],
          )
        ],

      ));
  }
}
