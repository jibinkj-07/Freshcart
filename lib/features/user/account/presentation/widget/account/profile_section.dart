import 'package:flutter/material.dart';

import '../../../../../../core/config/route/route_mapper.dart';
import '../../../../../common/presentation/bloc/auth_bloc.dart';

/// @author : Jibin K John
/// @date   : 17/08/2024
/// @time   : 12:58:07

class ProfileSection extends StatelessWidget {
  final EmailStatus emailStatus;

  const ProfileSection({
    super.key,
    required this.emailStatus,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // verify email tile
        if (emailStatus == EmailStatus.notVerified)
          ListTile(
            onTap: () =>
                Navigator.of(context).pushNamed(RouteMapper.userFaqScreen),
            leading: Icon(
              Icons.verified_outlined,
              color: Theme.of(context).primaryColor,
            ),
            title: const Text("Verify Email"),
            subtitle: const Text("Your email is not verified yet"),
            trailing: const Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.grey,
              size: 15.0,
            ),
          ),
        // edit profile tile
        ListTile(
          onTap: () =>
              Navigator.of(context).pushNamed(RouteMapper.userFaqScreen),
          leading: Icon(
            Icons.manage_accounts_outlined,
            color: Theme.of(context).primaryColor,
          ),
          title: const Text("Edit Profile"),
          trailing: const Icon(
            Icons.arrow_forward_ios_rounded,
            color: Colors.grey,
            size: 15.0,
          ),
        ),
        // my orders tile
        ListTile(
          onTap: () =>
              Navigator.of(context).pushNamed(RouteMapper.userFaqScreen),
          leading: Icon(
            Icons.shopping_cart_outlined,
            color: Theme.of(context).primaryColor,
          ),
          title: const Text("My Orders"),
          trailing: const Icon(
            Icons.arrow_forward_ios_rounded,
            color: Colors.grey,
            size: 15.0,
          ),
        ),
        // favourites tile
        ListTile(
          onTap: () =>
              Navigator.of(context).pushNamed(RouteMapper.userFaqScreen),
          leading: Icon(
            Icons.favorite_outline_rounded,
            color: Theme.of(context).primaryColor,
          ),
          title: const Text("Favorites Bucket"),
          trailing: const Icon(
            Icons.arrow_forward_ios_rounded,
            color: Colors.grey,
            size: 15.0,
          ),
        ),
        // address tile
        ListTile(
          onTap: () =>
              Navigator.of(context).pushNamed(RouteMapper.userFaqScreen),
          leading: Icon(
            Icons.home_outlined,
            color: Theme.of(context).primaryColor,
          ),
          title: const Text("Saved Address"),
          trailing: const Icon(
            Icons.arrow_forward_ios_rounded,
            color: Colors.grey,
            size: 15.0,
          ),
        ),
        const Divider(thickness: .2, height: 0),
      ],
    );
  }
}
