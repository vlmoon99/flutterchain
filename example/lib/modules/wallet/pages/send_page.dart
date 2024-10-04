import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SendPage extends StatelessWidget {
  const SendPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 115, 111, 111),
      body: Center(
        child: Container(
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
                  _BuildId("Account ID", 'Enter account  ID'),
                  _BuildId('Amount', '0.00'),
                  _BuildId('Memo(Optional)', 'Enter account  ID'),
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

  // ignore: non_constant_identifier_names
  Widget _BuildId(
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
      width: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: color,
      ),
      child: Center(
        child: InkWell(
          onTap: () => Modular.to.navigate('/'),
          child: Text(
            textt,
            style: TextStyle(
                color: textcolor, fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
