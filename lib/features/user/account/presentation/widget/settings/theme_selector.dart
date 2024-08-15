import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../theme/presentation/bloc/theme_bloc.dart';

/// @author : Jibin K John
/// @date   : 09/08/2024
/// @time   : 16:19:22

class ThemeSelector extends StatefulWidget {
  const ThemeSelector({super.key});

  @override
  State<ThemeSelector> createState() => _ThemeSelectorState();
}

class _ThemeSelectorState extends State<ThemeSelector> {
  final List<ThemeMode> _themes = [
    ThemeMode.system,
    ThemeMode.dark,
    ThemeMode.light,
  ];

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => _showThemeSheet(context),
      leading: Icon(
        Icons.wb_sunny_outlined,
        color: Theme.of(context).primaryColor,
      ),
      title: const Text("Theme"),
      subtitle: const Text("App theme preference"),
      trailing: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (ctx, theme) {
          return Text(
            theme.themeMode.toString().split(".").last,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 12.0,
            ),
          );
        },
      ),
    );
  }

  _showThemeSheet(BuildContext context) {
    List<String> description = [
      'Apply your system theme',
      'Change theme to dark mode',
      'Change theme to light mode',
    ];
    return showModalBottomSheet(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      context: context,
      builder: (ctx) {
        return Container(
          margin: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Theme.of(context).colorScheme.surface,
          ),
          child: Material(
            color: Colors.transparent,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                //heading
                ListTile(
                  title: const Text(
                    'Select theme mode',
                    style: TextStyle(fontSize: 15.0),
                  ),
                  trailing: IconButton(
                    onPressed: () => Navigator.of(ctx).pop(),
                    style: IconButton.styleFrom(foregroundColor: Colors.grey),
                    icon: const Icon(Icons.close_rounded),
                  ),
                ),
                Divider(
                  color: Colors.grey.withOpacity(.3),
                  height: 0.0,
                  thickness: .5,
                ),
                //body
                Flexible(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(
                      _themes.length,
                      (index) => ListTile(
                        onTap: () {
                          // Closing bottom modal sheet
                          Navigator.of(ctx).pop();
                          // Updating app theme mode
                          context
                              .read<ThemeBloc>()
                              .add(SetAppTheme(theme: _themes[index]));
                        },
                        shape: index == _themes.length - 1
                            ? const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  bottom: Radius.circular(20.0),
                                ),
                              )
                            : null,
                        title: Text(_themes[index].toString().split(".").last),
                        subtitle: Text(
                          description[index],
                          style: const TextStyle(fontSize: 11.0),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
