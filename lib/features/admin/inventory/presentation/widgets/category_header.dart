import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/config/route/route_mapper.dart';
import '../bloc/category_bloc.dart';

/// @author : Jibin K John
/// @date   : 20/08/2024
/// @time   : 15:19:02

class CategoryHeader extends StatelessWidget {
  final ValueNotifier<String> filter;

  const CategoryHeader({super.key, required this.filter});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * .06,
      child: Row(
        children: [
          const SizedBox(width: 5.0),
          IconButton.outlined(
            onPressed: () =>
                Navigator.of(context).pushNamed(RouteMapper.addCategoryScreen),
            icon: const Icon(Icons.add_rounded),
          ),
          Expanded(
            child: BlocBuilder<CategoryBloc, CategoryState>(
              builder: (ctx, state) {
                return ListView.builder(
                  itemCount: state.category.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (ctx, index) => Center(
                    child: _button(
                      label: state.category[index].title,
                      context: context,
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _button({
    required String label,
    required BuildContext context,
  }) =>
      ValueListenableBuilder(
        valueListenable: filter,
        builder: (ctx, filterValue, _) {
          final isSelected = filterValue.toLowerCase() == label.toLowerCase();
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: FilledButton(
              onPressed: () => filter.value = label,
              style: FilledButton.styleFrom(
                side: isSelected
                    ? null
                    : const BorderSide(
                        color: Colors.grey,
                        width: .5,
                      ),
                foregroundColor:
                    isSelected ? null : Theme.of(context).primaryColor,
                backgroundColor: isSelected
                    ? null
                    : Theme.of(context).scaffoldBackgroundColor,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 0,
                ),
              ),
              child: Text(
                label,
                style: const TextStyle(fontSize: 13.0),
              ),
            ),
          );
        },
      );
}
