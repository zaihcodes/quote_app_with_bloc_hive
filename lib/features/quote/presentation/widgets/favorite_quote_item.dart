import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quotes_app/features/quote/data/models/quote.dart';
import 'package:quotes_app/features/quote/presentation/bloc/quote/quote_bloc.dart';

class FavoriteQuoteItem extends StatelessWidget {
  const FavoriteQuoteItem({required this.quote, super.key});
  final Quote quote;
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(quote.hashCode.toString()), // Unique key for each item
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 40),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.error.withOpacity(0.5),
        ),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        context.read<QuotesBloc>().add(ToggleLike(quote));
      },
      child: Card(
        elevation: 0,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
        child: ListTile(
          title: Text(
            quote.text,
            style: TextStyle(
                fontSize: 16, color: Theme.of(context).colorScheme.onPrimary),
          ),
          subtitle: Text(
            quote.author,
            style: TextStyle(
                fontSize: 12, color: Theme.of(context).colorScheme.onPrimary),
          ),
          trailing: IconButton(
            icon: Icon(
              quote.isLiked ? Icons.favorite : Icons.favorite_border,
              color: quote.isLiked ? Colors.red : Colors.grey,
            ),
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}
