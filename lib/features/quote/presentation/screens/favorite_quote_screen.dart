import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quotes_app/features/quote/presentation/bloc/quote/quote_bloc.dart';
import 'package:quotes_app/features/quote/presentation/widgets/favorite_quote_item.dart';

class FavoriteQuotesScreen extends StatelessWidget {
  const FavoriteQuotesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: BlocBuilder<QuotesBloc, QuoteState>(
        builder: (context, state) {
          if (state is LoadedQuotes) {
            if (state.favoriteQuotes.isNotEmpty) {
              return Padding(
                padding: const EdgeInsets.all(20),
                child: ListView.separated(
                  itemBuilder: (context, index) =>
                      FavoriteQuoteItem(quote: state.favoriteQuotes[index]),
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 5,
                  ),
                  itemCount: state.favoriteQuotes.length,
                ),
              );
            }
            return const Padding(
              padding: EdgeInsets.all(20),
              child: Center(
                child: Text('Add a favorite quote'),
              ),
            );
          }
          return const Padding(
            padding: EdgeInsets.all(20),
            child: Center(
              child: Text('Add a favorite quote'),
            ),
          );
        },
      ),
    );
  }
}
