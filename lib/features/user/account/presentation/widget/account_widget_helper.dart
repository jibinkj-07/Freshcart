import 'package:flutter/material.dart';

import '../../../../../core/config/app_config.dart';
import '../../../../../core/util/helper/asset_mapper.dart';

sealed class AccountWidgetHelper {
  static Widget spacer({double? height}) => SizedBox(height: height ?? 15.0);

  static Widget appIconBox(BuildContext context) => Container(
        color: AppConfig.appColor,
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).viewPadding.top,
        ),
        child: Center(
          child: Image.asset(
            AssetMapper.appIconImage,
            width: 180.0,
            height: 180.0,
            fit: BoxFit.cover,
          ),
        ),
      );
}
