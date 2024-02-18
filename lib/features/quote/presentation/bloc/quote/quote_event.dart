part of 'quote_bloc.dart';

abstract class QuoteEvent {
  const QuoteEvent();
}

class LoadQuotes extends QuoteEvent {}

class ToggleLike extends QuoteEvent {
  final Quote quote;

  const ToggleLike(this.quote);
}

class DeleteLikedQuote extends QuoteEvent {
  final int quoteId;

  const DeleteLikedQuote(this.quoteId);
}
