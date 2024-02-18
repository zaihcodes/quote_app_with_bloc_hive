import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:quotes_app/features/quote/data/models/quote.dart';
import 'package:quotes_app/features/quote/data/repository/quotes_repository.dart';

part 'quote_state.dart';
part 'quote_event.dart';

class QuotesBloc extends Bloc<QuoteEvent, QuoteState> {
  final QuoteRepository quoteRepository;

  QuotesBloc({required this.quoteRepository}) : super(InitialQuoteState()) {
    on<LoadQuotes>((event, emit) async {
      emit(LoadingQuotes());
      try {
        final quotes = await quoteRepository.getQuotes();
        final favoriteQuotes = quotes.where((q) => q.isLiked == true).toList();
        emit(LoadedQuotes(quotes, favoriteQuotes));
      } catch (error) {
        emit(ErrorLoadingQuotes(error.toString()));
      }
    });

    on<ToggleLike>((event, emit) async {
      final updatedQuotes = _updateQuote(state as LoadedQuotes, event.quote);
      final updatedFavoriteQuotes =
          updatedQuotes.where((q) => q.isLiked == true).toList();

      final updatedQuote = Quote(
        id: event.quote.id,
        text: event.quote.text,
        author: event.quote.author,
        isLiked: !event.quote.isLiked,
      );
      await quoteRepository.updateQuote(updatedQuote);

      emit(LoadedQuotes(updatedQuotes, updatedFavoriteQuotes));
    });

    on<DeleteLikedQuote>((event, emit) async {
      emit(LoadedQuotes(
          _removeLikedQuote(state as LoadedQuotes, event.quoteId), []));
      await quoteRepository.deleteQuote(event.quoteId);
    });
  }

// Helper Methods

  List<Quote> _updateQuote(LoadedQuotes state, Quote quote) {
    debugPrint('In Update quote');
    return state.quotes
        .map((q) => q.id == quote.id ? q.copyWith(isLiked: !q.isLiked) : q)
        .toList();
  }

  List<Quote> _updateFavoriteQuotes(
      List<Quote> quotes, int quoteId, bool isLiked) {
    return List.of(quotes)
      ..retainWhere((quote) => quote.id != quoteId || quote.isLiked == isLiked);
  }

  List<Quote> _removeLikedQuote(LoadedQuotes state, int quoteId) {
    return state.quotes.where((quote) => quote.id != quoteId).toList();
  }
}
