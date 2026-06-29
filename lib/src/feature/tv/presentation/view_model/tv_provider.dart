import 'package:flutter_riverpod/flutter_riverpod.dart';

class TvChannel {
  final String id;
  final String name;
  final String logoUrl;
  final String category;
  final bool isPremium;
  final int channelNumber;

  const TvChannel({
    required this.id,
    required this.name,
    required this.logoUrl,
    required this.category,
    this.isPremium = false,
    required this.channelNumber,
  });
}

final sampleChannels = [
  TvChannel(
    id: '1',
    name: 'BBC World',
    logoUrl: 'https://picsum.photos/seed/bbc/200/200',
    category: 'news',
    channelNumber: 101,
  ),
  TvChannel(
    id: '2',
    name: 'CNN International',
    logoUrl: 'https://picsum.photos/seed/cnn/200/200',
    category: 'news',
    channelNumber: 102,
    isPremium: true,
  ),
  TvChannel(
    id: '3',
    name: 'Al Jazeera',
    logoUrl: 'https://picsum.photos/seed/aljaz/200/200',
    category: 'news',
    channelNumber: 103,
  ),
  TvChannel(
    id: '4',
    name: 'Sky News',
    logoUrl: 'https://picsum.photos/seed/skynews/200/200',
    category: 'news',
    channelNumber: 104,
    isPremium: true,
  ),
  TvChannel(
    id: '5',
    name: 'ESPN',
    logoUrl: 'https://picsum.photos/seed/espn/200/200',
    category: 'sports',
    channelNumber: 201,
    isPremium: true,
  ),
  TvChannel(
    id: '6',
    name: 'Sky Sports',
    logoUrl: 'https://picsum.photos/seed/skysports/200/200',
    category: 'sports',
    channelNumber: 202,
    isPremium: true,
  ),
  TvChannel(
    id: '7',
    name: 'Star Sports',
    logoUrl: 'https://picsum.photos/seed/starsports/200/200',
    category: 'sports',
    channelNumber: 203,
  ),
  TvChannel(
    id: '8',
    name: 'Sports HD',
    logoUrl: 'https://picsum.photos/seed/sportshd/200/200',
    category: 'sports',
    channelNumber: 204,
  ),
  TvChannel(
    id: '9',
    name: 'HBO',
    logoUrl: 'https://picsum.photos/seed/hbo/200/200',
    category: 'entertainment',
    channelNumber: 301,
    isPremium: true,
  ),
  TvChannel(
    id: '10',
    name: 'Netflix TV',
    logoUrl: 'https://picsum.photos/seed/netflix/200/200',
    category: 'entertainment',
    channelNumber: 302,
    isPremium: true,
  ),
  TvChannel(
    id: '11',
    name: 'Disney Channel',
    logoUrl: 'https://picsum.photos/seed/disney/200/200',
    category: 'entertainment',
    channelNumber: 303,
  ),
  TvChannel(
    id: '12',
    name: 'Comedy Central',
    logoUrl: 'https://picsum.photos/seed/comedy/200/200',
    category: 'entertainment',
    channelNumber: 304,
  ),
  TvChannel(
    id: '13',
    name: 'MTV',
    logoUrl: 'https://picsum.photos/seed/mtv/200/200',
    category: 'music',
    channelNumber: 401,
  ),
  TvChannel(
    id: '14',
    name: 'VH1',
    logoUrl: 'https://picsum.photos/seed/vh1/200/200',
    category: 'music',
    channelNumber: 402,
  ),
  TvChannel(
    id: '15',
    name: 'Sony Mix',
    logoUrl: 'https://picsum.photos/seed/sonymix/200/200',
    category: 'music',
    channelNumber: 403,
    isPremium: true,
  ),
  TvChannel(
    id: '16',
    name: 'Cartoon Network',
    logoUrl: 'https://picsum.photos/seed/cartoonnet/200/200',
    category: 'kids',
    channelNumber: 501,
  ),
  TvChannel(
    id: '17',
    name: 'Nickelodeon',
    logoUrl: 'https://picsum.photos/seed/nick/200/200',
    category: 'kids',
    channelNumber: 502,
  ),
  TvChannel(
    id: '18',
    name: 'Pogo',
    logoUrl: 'https://picsum.photos/seed/pogo/200/200',
    category: 'kids',
    channelNumber: 503,
  ),
  TvChannel(
    id: '19',
    name: 'Discovery',
    logoUrl: 'https://picsum.photos/seed/discovery/200/200',
    category: 'documentary',
    channelNumber: 601,
  ),
  TvChannel(
    id: '20',
    name: 'National Geographic',
    logoUrl: 'https://picsum.photos/seed/natgeo/200/200',
    category: 'documentary',
    channelNumber: 602,
    isPremium: true,
  ),
  TvChannel(
    id: '21',
    name: 'History TV18',
    logoUrl: 'https://picsum.photos/seed/history/200/200',
    category: 'documentary',
    channelNumber: 603,
  ),
];

final tvChannelProvider = Provider<List<TvChannel>>((ref) => sampleChannels);
