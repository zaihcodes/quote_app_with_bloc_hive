import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quotes_app/core/data/app_images.dart';
import 'package:quotes_app/features/quote/presentation/bloc/quote/quote_bloc.dart';
import 'package:quotes_app/features/quote/presentation/bloc/quote_background/cubit/quote_background_cubit.dart';
import 'package:quotes_app/features/quote/presentation/widgets/quote_pageview_widget.dart';
import 'package:quotes_app/features/quote/presentation/widgets/quotes_widgets.dart';

class QuotesScreen extends StatefulWidget {
  QuotesScreen({super.key, this.quoteIndex = -1});
  int quoteIndex;
  @override
  State<QuotesScreen> createState() => _QuotesScreenState();
}

class _QuotesScreenState extends State<QuotesScreen> {
  late PageController _pageController;
  @override
  void initState() {
    super.initState();
    initializePageController();
  }

  void initializePageController() {
    _pageController = PageController(
      initialPage: 0,
      viewportFraction: 1,
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          BlocBuilder<QuotesBloc, QuoteState>(
            builder: (context, state) {
              if (state is LoadedQuotes) {
                return Padding(
                  padding: const EdgeInsets.all(
                      40.0), // Add padding around the container
                  child: Stack(
                    children: [
                      PageView.builder(
                        controller: _pageController,
                        itemCount: state.quotes.length,
                        onPageChanged: (value) {
                          context
                              .read<QuoteBackgroundCubit>()
                              .ChangeBackground();
                        }, // Number of pages
                        itemBuilder: (context, index) {
                          final quote = state.quotes[index];
                          return QuotePageviewWidget(quote: quote);
                        },
                      ),
                      Positioned(
                        left: (size.width / 2) - (50 / 2) - 40,
                        bottom: 0,
                        child: builtRandomButton(
                            context: context,
                            func: () {
                              setState(() {
                                _pageController.animateToPage(
                                    Random().nextInt(20),
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.linear);
                              });
                            }),
                      ),
                    ],
                  ),
                );
              } else if (state is LoadingQuotes) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              return const Center(
                child: Text('Quotes App'),
              );
            },
          ),
        ],
      ),
    );
  }
}
