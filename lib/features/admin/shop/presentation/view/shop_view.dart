import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/config/firebase/path_mapper.dart';
import '../../../../../core/config/route/route_mapper.dart';
import '../../../../../core/util/widget/animated_loading_button.dart';
import '../../../../common/presentation/bloc/auth_bloc.dart';

/// @author : Jibin K John
/// @date   : 17/08/2024
/// @time   : 15:48:21

class ShopView extends StatefulWidget {
  const ShopView({super.key});

  @override
  State<ShopView> createState() => _ShopViewState();
}

class _ShopViewState extends State<ShopView> {
  final ValueNotifier<bool> _signingOut = ValueNotifier(false);

  @override
  void dispose() {
    _signingOut.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseDatabase.instance.ref(PathMapper.shopPath).onValue,
      builder: (ctx, snapshot) {
        if (snapshot.hasData) {
          final Map<Object?, Object?> shopData =
              snapshot.data!.snapshot.value as Map<Object?, Object?>;

          return ListView(
            children: [
              const CircleAvatar(
                radius: 60.0,
                child: Icon(Icons.shopping_cart_rounded, size: 80.0),
              ),
              const SizedBox(height: 30.0),
              _listTile(
                title: "Name",
                value: shopData["name"]?.toString() ?? "Click to update",
                icon: Icons.home_work_rounded,
                onPressed: () {},
              ),
              _listTile(
                title: "Location",
                value: shopData["location"]?.toString() ?? "Click to update",
                icon: Icons.location_on_rounded,
                onPressed: () {},
              ),
              const SizedBox(height: 30.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: BlocListener<AuthBloc, AuthState>(
                  listener: (ctx, state) {
                    _signingOut.value =
                        state.authStatus == AuthStatus.signingOut;

                    if (state.authStatus == AuthStatus.idle) {
                      if (state.error != null) {
                        state.error!.showSnackBar(context);
                      } else {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            RouteMapper.root, (_) => false);
                      }
                    }
                  },
                  child: ValueListenableBuilder(
                    valueListenable: _signingOut,
                    builder: (ctx, signingOut, _) {
                      return AnimatedLoadingButton(
                        onPressed: () =>
                            context.read<AuthBloc>().add(SignOut()),
                        loading: signingOut,
                        child: const Text("Sign out"),
                      );
                    },
                  ),
                ),
              ),
            ],
          );
          return Text("Data is $shopData");
        }
        return const Center(
          child: CircularProgressIndicator(strokeWidth: 2.0),
        );
      },
    );
  }

  // PRIVATE
  Widget _listTile(
          {required String title,
          required String value,
          required IconData icon,
          required void Function() onPressed}) =>
      ListTile(
        onTap: onPressed,
        leading: Icon(
          icon,
          color: Colors.grey,
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.normal,
            fontSize: 14.0,
          ),
        ),
        subtitle: Text(
          value,
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.w500,
            fontSize: 16.0,
          ),
        ),
      );
}
