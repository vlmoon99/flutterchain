import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mintbase_example/modules/models/models.dart';
import 'package:mintbase_example/modules/pages/init/widgets/near_account_create_dialog.dart';
import 'package:mintbase_example/modules/pages/init/widgets/near_account_import_default_dialog.dart';
import 'package:mintbase_example/modules/pages/init/widgets/near_account_import_nearAPIjs_dialog.dart';
import 'package:mintbase_example/modules/pages/init/widgets/near_account_import_mnemonic.dart';

class InitPage extends StatefulWidget {
  const InitPage({super.key});

  @override
  State<InitPage> createState() => _InitPageState();
}

class _InitPageState extends State<InitPage> {
  NearNetworkType networkType = NearNetworkType.testnet;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          children: [
            SizedBox(height: 52.h),
            Text(
              """Sign to interact with NFT Mintbase""",
              style: TextStyle(
                fontSize: 30.sp,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.2,
              ),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 63.h),
            Center(
              child: Container(
                height: 40.h,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: DropdownButton<NearNetworkType>(
                  isExpanded: false,
                  value: networkType,
                  underline: const SizedBox(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  dropdownColor: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(12).r,
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                  items: [NearNetworkType.testnet, NearNetworkType.mainnet]
                      .map(
                        (net) => DropdownMenuItem(
                          value: net,
                          //TODO: mainnet disable flag
                          enabled:
                              net == NearNetworkType.mainnet ? false : true,
                          child: Text(
                            net.name,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary,
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (net) {
                    setState(() {
                      networkType = net!;
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 31.h),
            Center(
              child: FilledButton(
                onPressed: () async {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: .1.sw),
                        child: Dialog(
                          child: NearAccountCreationActionDialog(
                            networkType: networkType,
                          ),
                        ),
                      );
                    },
                  );
                },
                child: Text(
                  'Create new Near account',
                  style: TextStyle(
                    fontSize: 16.sp,
                  ),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10).r,
                child: Text(
                  'OR',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Center(
              child: FilledButton(
                onPressed: () async {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                        child: NearAccountImportActionDialogDefault(
                          networkType: networkType,
                        ),
                      );
                    },
                  );
                },
                child: Text(
                  'Import Near account Default',
                  style: TextStyle(
                    fontSize: 16.sp,
                  ),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10).r,
                child: Text(
                  'OR',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Center(
              child: FilledButton(
                onPressed: () async {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                        child: NearAccountImportActionDialog(
                          networkType: networkType,
                        ),
                      );
                    },
                  );
                },
                child: Text(
                  'Import Near account NEARAPIJS',
                  style: TextStyle(
                    fontSize: 16.sp,
                  ),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10).r,
                child: Text(
                  'OR',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Center(
              child: FilledButton(
                onPressed: () async {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                        child: NearAccountImportMnemonic(
                          networkType: networkType,
                        ),
                      );
                    },
                  );
                },
                child: Text(
                  'Import Near account whit mnemonic',
                  style: TextStyle(
                    fontSize: 16.sp,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
