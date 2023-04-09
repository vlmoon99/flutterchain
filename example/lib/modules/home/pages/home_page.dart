import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutterchain_example/modules/auth/pages/login_page.dart';
import 'package:flutterchain_example/modules/home/vm/home_vm.dart';
import 'package:flutterchain_example/routes/routes.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final homeVM = Modular.get<HomeVM>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            // Padding(
            //   padding: const EdgeInsets.only(
            //     top: 70,
            //     left: 20,
            //     right: 20,
            //   ),
            //   child: FutureBuilder<Wallet>(
            //     future: homeVM.getWallet(),
            //     builder: (context, snapshot) {
            //       final wallet = snapshot.data;
            //       return Text(
            //         "Your mnemonic : ${wallet?.mnemonic ?? 'mnemonic not founded'}",
            //         style: const TextStyle(
            //           fontSize: 24,
            //           fontWeight: FontWeight.w600,
            //         ),
            //       );
            //     },
            //   ),
            // ),
            AppButton(
              title: "Go to send transaction",
              onPress: () {
                Modular.to.pushNamed(
                    Routes.home.getRoute(Routes.home.sendTransaction));
              },
            ),
            AppButton(
              title: "Go to send call function contract",
              onPress: () {
                Modular.to.pushNamed(Routes.home
                    .getRoute(Routes.home.callSmartContractFunction));
              },
            ),
          ],
        ),
      ),
    );
  }
}
