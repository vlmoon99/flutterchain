import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

Widget WalletPageSendButton() {
  {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
      child: AlertDialog(
        title: const Center(child: Text('Send Crypto')),
        content: Container(
            padding: const EdgeInsets.only(top: 33),
            height: 470,
            width: 384,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: const Color.fromARGB(255, 252, 250, 250),
            ),
            child: Center(
                child: SizedBox(
              height: 412,
              width: 341,
              child: Column(
                children: [
                  const Text('SendPage Crypto'),
                  _buildId("Account ID", 'Enter account  ID'),
                  _buildId('Amount', '0.00'),
                  _buildId('Memo(Optional)', 'Enter account  ID'),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: buildButton('Send',
                        const Color.fromARGB(224, 57, 112, 206), Colors.white),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: buildButton(
                        'Close',
                        const Color.fromARGB(255, 252, 250, 250),
                        const Color.fromARGB(255, 104, 93, 93)),
                  ),
                ],
              ),
            ))),
      ),
    );
  }
}

Widget _buildId(
  String name,
  dynamic second,
) {
  return Column(
    children: [
      const Padding(padding: EdgeInsets.only(top: 28)),
      Text(name),
      SizedBox(
        height: 38,
        width: 286,
        child: TextField(
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            hintText: second,
          ),
        ),
      )
    ],
  );
}

Widget buildButton(String textt, Color color, Color textcolor) {
  return Container(
    height: 40,
    width: 70,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(4),
      color: color,
    ),
    child: Center(
      child: TextButton(
        onPressed: () {
          Modular.to.pop();
        },
        child: Center(
            child: Text(
          textt,
          style: TextStyle(
              color: textcolor, fontSize: 16, fontWeight: FontWeight.bold),
        )),
      ),
    ),
  );
}
