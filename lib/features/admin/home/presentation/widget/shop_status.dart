import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../view_model/home_helper.dart';

/// @author : Jibin K John
/// @date   : 17/08/2024
/// @time   : 16:02:49

enum Status { open, closed }

class ShopStatus extends StatefulWidget {
  const ShopStatus({super.key});

  @override
  State<ShopStatus> createState() => _ShopStatusState();
}

class _ShopStatusState extends State<ShopStatus> {
  final ValueNotifier<Status> _status = ValueNotifier(Status.closed);

  @override
  void initState() {
    HomeHelper.listenShopStatus(status: _status);
    super.initState();
  }

  @override
  void dispose() {
    _status.dispose();
    HomeHelper.disposeShopStatusListener();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Welcome back!",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 25.0,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Shop is ",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20.0,
              ),
            ),
            ValueListenableBuilder(
              valueListenable: _status,
              builder: (ctx, status, _) {
                return CupertinoSlidingSegmentedControl<Status>(
                  thumbColor: status == Status.open ? Colors.green : Colors.red,
                  groupValue: status,
                  children: const {
                    Status.open: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text("Open"),
                    ),
                    Status.closed: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text("Closed"),
                    ),
                  },
                  onValueChanged: (value) => HomeHelper.toggleShopStatus(
                    value ?? Status.closed,
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
