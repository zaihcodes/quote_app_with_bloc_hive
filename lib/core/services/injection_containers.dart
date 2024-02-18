import 'package:get_it/get_it.dart';
import 'package:quotes_app/core/config/theme/theme_cubit.dart';
import 'package:quotes_app/features/quote/data/repository/quotes_repository.dart';
import 'package:quotes_app/features/quote/presentation/bloc/quote/quote_bloc.dart';
import 'package:quotes_app/features/quote/presentation/bloc/quote_background/cubit/quote_background_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Theme
  sl.registerFactory(() => ThemeColorCubit());
  // Quote Background image
  sl.registerFactory(() => QuoteBackgroundCubit());
  // Quotes
  // Bloc
  sl.registerFactory(() => QuotesBloc(quoteRepository: sl()));
  // repository
  sl.registerLazySingleton<QuoteRepository>(() => QuoteRepositoryImpl());
}
