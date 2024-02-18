import 'package:hive_flutter/adapters.dart';
import 'package:quotes_app/core/data/quotes_provider.dart';
import 'package:quotes_app/features/quote/data/models/quote.dart';

abstract class QuoteRepository {
  Future<void> addQuotes(List<Quote> quotes);
  Future<List<Quote>> getQuotes();
  Future<void> updateQuote(Quote quote);
  Future<void> deleteQuote(int id);
}

class QuoteRepositoryImpl implements QuoteRepository {
  static const boxName = 'quotes';

  @override
  Future<void> addQuotes(List<Quote> quotes) async {
    final box = Hive.box<Quote>(boxName);
    box.clear();
    box.addAll(quotes);
  }

  @override
  Future<List<Quote>> getQuotes() async {
    final box = Hive.box<Quote>(boxName);
    if (box.values.isEmpty) {
      box.addAll(QuotesProvider.quotes);
    }
    return box.values.toList();
  }

  @override
  Future<void> updateQuote(Quote quote) async {
    final box = Hive.box<Quote>(boxName);
    await box.put(quote.id, quote);
  }

  @override
  Future<void> deleteQuote(int id) async {
    final box = Hive.box<Quote>(boxName);
    await box.delete(id);
  }
}
