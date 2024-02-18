// Custom Drawer
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quotes_app/core/config/theme/theme_cubit.dart';
import 'package:quotes_app/core/data/app_color.dart';

Drawer buildDrawer(Size size, BuildContext context) {
  return Drawer(
    width: size.width / 2,
    backgroundColor: Theme.of(context).colorScheme.primaryContainer,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: double.infinity,
          height: 120,
          child: DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Colors'.toUpperCase(),
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontSize: 20),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              AppColor.colors.length,
              (index) => builtAppColor(
                context: context,
                color: AppColor.colors[index],
              ),
            ),
          ),
        )
      ],
    ),
  );
}

//  Drawer colors
Widget builtAppColor({
  required BuildContext context,
  required Color color,
  // required Function func
}) {
  return GestureDetector(
    onTap: () {
      debugPrint('Change theme color.');
      context.read<ThemeColorCubit>().changeThemeColor(color);
    },
    child: Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.only(left: 5),
      color: color.withOpacity(0.5),
      child: Row(children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(100),
            boxShadow: [
              BoxShadow(
                blurRadius: 5,
                spreadRadius: 1,
                offset: const Offset(-2, -2),
                // color: Colors.white.withOpacity(0.2),
                color: Theme.of(context).colorScheme.shadow.withOpacity(0.2),
              )
            ],
          ),
        ),
      ]),
    ),
  );
}

// Botton navigationbar

BottomNavigationBar buildBottomNavigationBar(
    BuildContext context, int currentIndex, Function(int) func) {
  return BottomNavigationBar(
    backgroundColor:
        Theme.of(context).colorScheme.primaryContainer.withOpacity(0.5),
    currentIndex: currentIndex,
    onTap: func,
    items: const [
      BottomNavigationBarItem(
        icon: Icon(Icons.list),
        label: 'Quotes',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.favorite),
        label: 'Favorites',
      ),
    ],
  );
}
