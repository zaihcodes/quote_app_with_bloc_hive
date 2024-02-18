part of 'quote_bloc.dart';

abstract class QuoteState {
  const QuoteState();
}

class InitialQuoteState extends QuoteState {}

class LoadingQuotes extends QuoteState {}

class LoadedQuotes extends QuoteState {
  final List<Quote> quotes;
  final List<Quote> favoriteQuotes;

  const LoadedQuotes(this.quotes, this.favoriteQuotes);
}

class ErrorLoadingQuotes extends QuoteState {
  final String errorMessage;

  const ErrorLoadingQuotes(this.errorMessage);
}

class QuoteLiked extends QuoteState {}

class QuoteDisliked extends QuoteState {}

class LikedQuoteDeleted extends QuoteState {}

class ErrorDeletingLikedQuote extends QuoteState {
  final String errorMessage;

  const ErrorDeletingLikedQuote(this.errorMessage);
}
