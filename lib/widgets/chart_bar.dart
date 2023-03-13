import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  // const ChartBar({ Key? key }) : super(key: key);
  final String label;
  final double spendingAmount;
  final double spendingPctOfTotal;

  ChartBar(this.label, this.spendingAmount, this.spendingPctOfTotal);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {
      return Column(
        children: [
          Container(
            height: constraints.maxHeight * 0.15, // this allows me to create a container that is sized as a fraction of the main widget
            child: FittedBox(
              child: Text("N\$${spendingAmount.toStringAsFixed(0)}"),
            ),
          ),
          SizedBox(
            height: constraints.maxHeight * 0.05, // this allows me to create a container that is sized as a fraction of the main widget
          ),
          Container(
            height: constraints.maxHeight * 0.6, // this allows me to create a container that is sized as a fraction of the main widget
            width: 10,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                    color: Color.fromRGBO(220, 220, 220, 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                FractionallySizedBox(
                  heightFactor: spendingPctOfTotal,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ) // this allows me to create a box that is sized as a fraction of another value.
              ],
            ),
          ),
          SizedBox(
            height: constraints.maxHeight * 0.05, // this allows me to create a container that is sized as a fraction of the main widget
          ),
          Container(
            height: constraints.maxHeight * 0.15, // this allows me to create a container that is sized as a fraction of the main widget
            child: FittedBox(
              child: Text(label),
            ),
          ),
        ],
      );
    });
  }
}
