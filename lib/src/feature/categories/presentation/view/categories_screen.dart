import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../home/data/model/content_model.dart';
import '../view_model/category_provider.dart' show selectedCategoryProvider;
import 'widgets/premium_tab_bar.dart';
import 'widgets/video_grid.dart';

class CategoriesScreen extends ConsumerStatefulWidget {
  const CategoriesScreen({super.key});

  @override
  ConsumerState<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends ConsumerState<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: PremiumTabBar.labels.length,
      vsync: this,
    );
    _tabController.addListener(_onTabChanged);
  }

  void _onTabChanged() {
    if (!_tabController.indexIsChanging) {
      ref.read(selectedCategoryProvider.notifier).state = _tabController.index;
    }
  }

  @override
  void dispose() {
    _tabController.removeListener(_onTabChanged);
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          PremiumTabBar(
            tabController: _tabController,
            currentIndex: ref.watch(selectedCategoryProvider),
          ).animate().fadeIn(duration: 400.ms).slideY(begin: -0.2),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: PremiumTabBar.filters.map((filter) {
                final items = filter == null
                    ? sampleContents
                    : sampleContents
                          .where((e) => e.category == filter)
                          .toList();
                return VideoGrid(
                  items: items,
                ).animate().fadeIn(duration: 500.ms);
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
