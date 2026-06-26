import 'package:flutter_riverpod/legacy.dart';

final isSearchingProvider = StateProvider.autoDispose<bool>((ref) => false);

final searchTextProvider = StateProvider.autoDispose<String>((ref) => '');

final carouselPageProvider = StateProvider.autoDispose<int>((ref) => 0);
