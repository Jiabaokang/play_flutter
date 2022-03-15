import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'structure_logic.dart';


class StructurePage extends StatelessWidget {
  const StructurePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(StructureLogic());

    return Container(
      color: Colors.red,
      child: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Container(
                  color: Colors.purple,
                  width: 400,
                  height: 400,
                ),
                Container(
                  color: Colors.white,
                  width: 350,
                  height: 350,
                ),
                Container(
                  color: Colors.blue,
                  width: 300,
                  height: 300,
                ),
                Container(
                  color: Colors.orange,
                  width: 250,
                  height: 250,
                ),

                Container(
                  color: Colors.pink,
                  width: 200,
                  height: 200,
                ),
                Container(
                  color: Colors.yellow,
                  width: 100,
                  height: 100,
                ),
              ],

            ),
          ),
          Stack(
            children: [
              Container(
                color: Colors.purple,
                width: 400,
                height: 400,
              ),
              Container(
                color: Colors.white,
                width: 350,
                height: 350,
              ),
              Container(
                color: Colors.blue,
                width: 300,
                height: 300,
              ),
              Container(
                color: Colors.orange,
                width: 250,
                height: 250,
              ),

              Container(
                color: Colors.pink,
                width: 200,
                height: 200,
              ),
              Container(
                color: Colors.yellow,
                width: 100,
                height: 100,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
