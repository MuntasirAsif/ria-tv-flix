import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/model/content_model.dart';
import 'widgets/app_bar_widget.dart';
import 'widgets/carousel_section.dart';
import 'widgets/category_section.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final featured = sampleContents.take(5).toList();

    final categories = [
      ('Top Rating Originals', 'original'),
      ('Trending Music', 'music'),
      ('Action Movies', 'action'),
      ('Bangla Movies', 'bangla'),
      ('Romantic Movies', 'romantic'),
      ('Bangla Natok', 'natok'),
      ('Sports Heights', 'sports'),
      ('Cartoon Videos', 'cartoon'),
    ];

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: const HomeAppBar(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CarouselSection(items: featured).animate().fadeIn(duration: 500.ms),
            24.verticalSpace,
            ...categories.asMap().entries.map((e) {
              final c = e.value;
              final items = sampleContents
                  .where((e) => e.category == c.$2)
                  .toList();
              if (items.isEmpty) return const SizedBox();
              return CategorySection(title: c.$1, items: items)
                  .animate(delay: (e.key * 100).ms)
                  .fadeIn(duration: 400.ms)
                  .slideY(begin: 0.3);
            }),
            24.verticalSpace,
          ],
        ),
      ),
    );
  }
}
