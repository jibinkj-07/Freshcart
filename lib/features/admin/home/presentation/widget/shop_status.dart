import 'package:flutter/material.dart';

/// @author : Jibin K John
/// @date   : 17/08/2024
/// @time   : 16:02:49

class ShopStatus extends StatefulWidget {
  const ShopStatus({super.key});

  @override
  State<ShopStatus> createState() => _ShopStatusState();
}

class _ShopStatusState extends State<ShopStatus> {
  final ValueNotifier<bool> _status = ValueNotifier(false);

  @override
  void dispose() {
    _status.dispose();
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
        ValueListenableBuilder(
          valueListenable: _status,
          builder: (ctx, status, _) {
            return Row(
              children: [
                const Text(
                  "Shop is ",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 25.0,
                  ),
                ),
                Text(
                  status ? "Open" : "Closed",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: status ? Colors.green : Colors.red,
                    fontSize: 25.0,
                  ),
                ),
                const Spacer(),
                Switch(
                  value: status,
                  onChanged: (value) => _status.value = value,
                )
              ],
            );
          },
        ),
      ],
    );
  }
}
