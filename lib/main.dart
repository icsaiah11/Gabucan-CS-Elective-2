import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Instagram Layout',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
      ),
      home: const InstagramScreen(),
    );
  }
}

/// A static recreation made with basic Flutter layout widgets.
class InstagramScreen extends StatelessWidget {
  const InstagramScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const _TopBar(),
            const Divider(height: 1, color: Color(0xFFEAEAEA)),
            const _ProfileRow(),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Expanded(child: _GradientPost()),
                  _PostActions(),
                  _PostDetails(),
                ],
              ),
            ),
            const Divider(height: 1, color: Color(0xFFEAEAEA)),
            const _BottomNav(),
          ],
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 58,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            const Text(
              'Instagram',
              style: TextStyle(
                fontFamily: 'Billabong',
                fontSize: 31,
                height: 1,
                color: Color(0xFF171717),
              ),
            ),
            const Spacer(),
            const Icon(Icons.favorite_border_rounded, size: 28),
            const SizedBox(width: 20),
            Badge(
              smallSize: 9,
              child: const Icon(Icons.chat_bubble_outline_rounded, size: 26),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileRow extends StatelessWidget {
  const _ProfileRow();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 10, 10, 10),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            padding: const EdgeInsets.all(2),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [Color(0xFFF9CE34), Color(0xFFEE2A7B), Color(0xFF6228D7)],
              ),
            ),
            child: const DecoratedBox(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(width: 10),
          const Text(
            'username',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          const Spacer(),
          const Icon(Icons.more_vert, size: 24),
        ],
      ),
    );
  }
}

class _GradientPost extends StatelessWidget {
  const _GradientPost();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color(0xFF505BC7),
            Color(0xFFB74FB7),
            Color(0xFFF0478E),
            Color(0xFFFF7C60),
            Color(0xFFFDD067),
          ],
          stops: [0.0, 0.28, 0.52, 0.75, 1.0],
        ),
      ),
    );
  }
}

class _PostActions extends StatelessWidget {
  const _PostActions();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 9, 14, 4),
      child: Row(
        children: [
          const Icon(Icons.favorite, color: Color(0xFFED2D45), size: 28),
          const SizedBox(width: 17),
          const Icon(Icons.mode_comment_outlined, size: 27),
          const SizedBox(width: 17),
          const Icon(Icons.send_outlined, size: 27),
          const Spacer(),
          const Icon(Icons.bookmark_border_rounded, size: 27),
        ],
      ),
    );
  }
}

class _PostDetails extends StatelessWidget {
  const _PostDetails();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.fromLTRB(14, 0, 14, 9),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('10,547 Likes', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
          SizedBox(height: 4),
          Text.rich(
            TextSpan(
              style: TextStyle(fontSize: 12, color: Color(0xFF202020)),
              children: [
                TextSpan(text: 'username ', style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(text: 'Lorem ipsum dolor sit amet, consectetur.'),
              ],
            ),
          ),
          SizedBox(height: 4),
          Text(
            '#lorem  #ipsum  #dolor  #sit  #amet  #consectetur',
            style: TextStyle(fontSize: 10, color: Color(0xFF7792AE)),
          ),
        ],
      ),
    );
  }
}

class _BottomNav extends StatelessWidget {
  const _BottomNav();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(Icons.home_filled, size: 27),
          Icon(Icons.search_rounded, size: 27),
          Icon(Icons.add_box_outlined, size: 26),
          Icon(Icons.video_library_outlined, size: 26),
          Icon(Icons.person_outline_rounded, size: 27),
        ],
      ),
    );
  }
}
