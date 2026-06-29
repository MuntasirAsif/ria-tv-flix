import 'package:flutter_riverpod/flutter_riverpod.dart';

class PremiumPlan {
  final String id;
  final String name;
  final String price;
  final String period;
  final List<String> benefits;
  final bool isPopular;
  final bool isCurrent;

  const PremiumPlan({
    required this.id,
    required this.name,
    required this.price,
    required this.period,
    required this.benefits,
    this.isPopular = false,
    this.isCurrent = false,
  });
}

class PremiumContent {
  final String id;
  final String title;
  final String subtitle;
  final String imageUrl;

  const PremiumContent({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
  });
}

final premiumPlansProvider = Provider<List<PremiumPlan>>(
  (ref) => [
    PremiumPlan(
      id: 'basic',
      name: 'Basic',
      price: '\$4.99',
      period: '/month',
      benefits: ['HD Streaming', '1 Device', 'Ad-free'],
      isCurrent: true,
    ),
    PremiumPlan(
      id: 'standard',
      name: 'Standard',
      price: '\$9.99',
      period: '/month',
      benefits: [
        'Full HD Streaming',
        '2 Devices',
        'Ad-free',
        'Offline Download',
      ],
      isPopular: true,
    ),
    PremiumPlan(
      id: 'premium',
      name: 'Premium',
      price: '\$14.99',
      period: '/month',
      benefits: [
        '4K + HDR',
        '4 Devices',
        'Ad-free',
        'Offline Download',
        'Family Sharing',
      ],
    ),
  ],
);

final premiumContentProvider = Provider<List<PremiumContent>>(
  (ref) => [
    PremiumContent(
      id: '1',
      title: 'The Crown Legacy',
      subtitle: 'Original Series',
      imageUrl: 'https://picsum.photos/seed/pc1/400/600',
    ),
    PremiumContent(
      id: '2',
      title: "Ocean's Deep",
      subtitle: 'Blockbuster Movie',
      imageUrl: 'https://picsum.photos/seed/pc2/400/600',
    ),
    PremiumContent(
      id: '3',
      title: 'Royal Sports HD',
      subtitle: 'Premium Channel',
      imageUrl: 'https://picsum.photos/seed/pc3/400/600',
    ),
    PremiumContent(
      id: '4',
      title: 'Midnight Express',
      subtitle: 'Exclusive Series',
      imageUrl: 'https://picsum.photos/seed/pc4/400/600',
    ),
    PremiumContent(
      id: '5',
      title: 'Nature 4K',
      subtitle: 'Documentary',
      imageUrl: 'https://picsum.photos/seed/pc5/400/600',
    ),
  ],
);
