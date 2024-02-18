import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:quotes_app/core/config/theme/theme_cubit.dart';
import 'package:quotes_app/core/data/app_images.dart';
import 'package:quotes_app/features/quote/data/models/quote.dart';
import 'package:quotes_app/features/quote/presentation/bloc/quote/quote_bloc.dart';
import 'package:quotes_app/features/quote/presentation/bloc/quote_background/cubit/quote_background_cubit.dart';
import 'package:quotes_app/features/quote/presentation/screens/favorite_quote_screen.dart';
import 'package:quotes_app/features/quote/presentation/screens/quotes_screen.dart';
import 'package:quotes_app/features/quote/presentation/widgets/main_widgets.dart';

import 'core/services/injection_containers.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(QuoteAdapter());
  await Hive.openBox<Quote>('quotes');
  await di.init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => di.sl<QuotesBloc>()..add(LoadQuotes())),
        BlocProvider(create: (context) => di.sl<ThemeColorCubit>()),
        BlocProvider(create: (context) => di.sl<QuoteBackgroundCubit>()),
      ],
      child: BlocBuilder<ThemeColorCubit, Color>(
        builder: (context, color) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData.from(
                colorScheme: ColorScheme.fromSeed(seedColor: color)),
            home: const MainPage(), // Use a wrapper widget for navigation logic
          );
        },
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0; // Track currently selected bottom navigation item

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocBuilder<QuoteBackgroundCubit, int>(
      builder: (context, index) {
        return Stack(
          children: [
            AnimatedOpacity(
              opacity: 1,
              duration: const Duration(milliseconds: 500),
              // The green box must be a child of the AnimatedOpacity widget.
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Image.asset(
                  AppImages.images[index],
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: Theme.of(context)
                    .colorScheme
                    .inversePrimary
                    .withOpacity(0.5),
                title: Builder(builder: (context) {
                  return InkWell(
                    onTap: () => Scaffold.of(context).openDrawer(),
                    child: Icon(
                      Icons.menu,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  );
                }),
              ),
              // Drawer
              drawer: buildDrawer(size, context),
              body: IndexedStack(
                index: _currentIndex,
                children: [
                  QuotesScreen(),
                  const FavoriteQuotesScreen(),
                ],
              ),
              bottomNavigationBar:
                  buildBottomNavigationBar(context, _currentIndex, (newIndex) {
                setState(() {
                  _currentIndex = newIndex;
                });
              }),
            ),
          ],
        );
      },
    );
  }
}
