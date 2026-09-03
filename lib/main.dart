import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() => runApp(const PaddleProvisionsApp());

final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) =>
          const HomeScreen(),
      routes: <RouteBase>[
        GoRoute(
          path: 'paddles/:id',
          builder: (BuildContext context, GoRouterState state) =>
              const ProductDetailsPage(),
        ),
      ],
    ),
  ],
);

class PaddleProvisionsApp extends StatefulWidget {
  const PaddleProvisionsApp({super.key});

  @override
  State<PaddleProvisionsApp> createState() => _PaddleProvisionsAppState();
}

class _PaddleProvisionsAppState extends State<PaddleProvisionsApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void _toggleTheme() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ThemeController(
      toggleTheme: _toggleTheme,
      isDark: _themeMode == ThemeMode.dark,
      child: MaterialApp.router(
        title: 'Paddle Provisions',
        debugShowCheckedModeBanner: false,
        themeMode: _themeMode,
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        routerConfig: _router,
      ),
    );
  }
}

class ThemeController extends InheritedWidget {
  const ThemeController({
    required this.toggleTheme,
    required this.isDark,
    required super.child,
    super.key,
  });

  final VoidCallback toggleTheme;
  final bool isDark;

  static ThemeController of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ThemeController>()!;
  }

  @override
  bool updateShouldNotify(ThemeController oldWidget) =>
      isDark != oldWidget.isDark;
}

class AppTheme {
  static const Color _lime = Color(0xFFD7F95A);
  static const Color _ink = Color(0xFF10221E);
  static const Color _cream = Color(0xFFF8F7F0);

  static ThemeData get light => _build(Brightness.light);
  static ThemeData get dark => _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final bool dark = brightness == Brightness.dark;
    final ColorScheme colors = ColorScheme.fromSeed(
      seedColor: _lime,
      brightness: brightness,
      surface: dark ? const Color(0xFF142521) : _cream,
      onSurface: dark ? const Color(0xFFF0F5EF) : _ink,
    );
    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colors,
      scaffoldBackgroundColor: colors.surface,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: colors.onSurface,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w800,
          letterSpacing: -0.6,
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: dark ? const Color(0xFF1B302A) : Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
      ),
      chipTheme: ChipThemeData(
        side: BorderSide.none,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(99)),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: _ink,
          foregroundColor: _lime,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          textStyle: const TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _Mark(),
            SizedBox(width: 10),
            Text('PADDLE PROVISIONS'),
          ],
        ),
        actions: <Widget>[
          IconButton(
            tooltip: ThemeController.of(context).isDark
                ? 'Use light theme'
                : 'Use dark theme',
            icon: Icon(ThemeController.of(context).isDark
                ? Icons.light_mode_outlined
                : Icons.dark_mode_outlined),
            onPressed: ThemeController.of(context).toggleTheme,
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 6, 20, 32),
          children: <Widget>[
            const _Eyebrow(text: 'THE PICKLEBALL EDIT'),
            const SizedBox(height: 8),
            Text('FIND YOUR\nSWEET SPOT.',
                style: theme.textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.w900,
                    height: .92,
                    letterSpacing: -2)),
            const SizedBox(height: 12),
            Text(
                'Premium pickleball paddles for every kind of player — selected for the Philippine court.',
                style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant, height: 1.35)),
            const SizedBox(height: 24),
            const _PromoBanner(),
            const SizedBox(height: 22),
            const _CategoryStrip(),
            const SizedBox(height: 28),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Featured paddles',
                    style: theme.textTheme.titleLarge
                        ?.copyWith(fontWeight: FontWeight.w800)),
                Text('${paddles.length} SELECTED',
                    style: theme.textTheme.labelSmall?.copyWith(
                        letterSpacing: 1.1, fontWeight: FontWeight.w800)),
              ],
            ),
            const SizedBox(height: 14),
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final int count = constraints.maxWidth >= 700 ? 3 : 2;
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: paddles.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: count,
                    mainAxisSpacing: 14,
                    crossAxisSpacing: 14,
                    childAspectRatio: count == 2 ? .62 : .72,
                  ),
                  itemBuilder: (BuildContext context, int index) =>
                      PaddleCard(paddle: paddles[index]),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _PromoBanner extends StatelessWidget {
  const _PromoBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: const Color(0xFF18372F),
        borderRadius: BorderRadius.circular(24),
      ),
      child: const Row(
        children: <Widget>[
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                _Eyebrow(text: 'NEW SEASON', color: Color(0xFFD7F95A)),
                SizedBox(height: 9),
                Text('COURT-READY\nGEAR',
                    style: TextStyle(
                        color: Color(0xFFD7F95A),
                        fontSize: 25,
                        height: .95,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -1)),
                SizedBox(height: 10),
                Text('Find your next favorite paddle.',
                    style: TextStyle(color: Colors.white70, height: 1.3)),
              ])),
          _BannerPaddle(),
        ],
      ),
    );
  }
}

class _Eyebrow extends StatelessWidget {
  const _Eyebrow({required this.text, this.color});
  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) => Text(
        text,
        style: TextStyle(
          color: color ?? Theme.of(context).colorScheme.primary,
          fontSize: 10,
          fontWeight: FontWeight.w900,
          letterSpacing: 1.35,
        ),
      );
}

class _CategoryStrip extends StatelessWidget {
  const _CategoryStrip();

  @override
  Widget build(BuildContext context) {
    const labels = <String>['All paddles', 'Control', 'Power', 'Spin'];
    return SizedBox(
      height: 38,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: labels.length,
        separatorBuilder: (BuildContext context, int index) =>
            const SizedBox(width: 8),
        itemBuilder: (BuildContext context, int index) => Chip(
          label: Text(labels[index]),
          backgroundColor: index == 0
              ? const Color(0xFFD7F95A)
              : Theme.of(context).cardColor,
          labelStyle: TextStyle(
              fontWeight: FontWeight.w800,
              color: index == 0 ? const Color(0xFF10221E) : null),
          padding: const EdgeInsets.symmetric(horizontal: 10),
        ),
      ),
    );
  }
}

class PaddleCard extends StatelessWidget {
  const PaddleCard({required this.paddle, super.key});
  final Paddle paddle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => context.go('/paddles/${paddle.id}'),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(child: _PaddleArtwork(paddle: paddle)),
              const SizedBox(height: 13),
              Text(paddle.brand.toUpperCase(),
                  style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1)),
              const SizedBox(height: 3),
              Text(paddle.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.w800)),
              const SizedBox(height: 6),
              Row(children: <Widget>[
                Text(formatPeso(paddle.price),
                    style: theme.textTheme.titleSmall
                        ?.copyWith(fontWeight: FontWeight.w900)),
                const Spacer(),
                Icon(Icons.arrow_outward_rounded,
                    size: 18, color: theme.colorScheme.primary),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}

class _PaddleArtwork extends StatelessWidget {
  const _PaddleArtwork({required this.paddle});
  final Paddle paddle;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: paddle.background, borderRadius: BorderRadius.circular(15)),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
              top: 10,
              left: 10,
              child: Text(paddle.badge,
                  style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 10,
                      letterSpacing: .5))),
        ],
      ),
    );
  }
}

class _PaddleShape extends StatelessWidget {
  const _PaddleShape({required this.color});
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 138,
      width: 90,
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          Container(
            height: 108,
            width: 82,
            decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.all(Radius.elliptical(40, 47)),
              border: Border.all(
                  color: Colors.white.withValues(alpha: .55), width: 3),
              boxShadow: const <BoxShadow>[
                BoxShadow(
                    color: Color(0x33000000),
                    blurRadius: 12,
                    offset: Offset(2, 7))
              ],
            ),
            child: Center(
                child: Icon(Icons.bolt_rounded,
                    color: Colors.white.withValues(alpha: .85), size: 29)),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: 25,
              height: 43,
              decoration: const BoxDecoration(
                color: Color(0xFF293A36),
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(7)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BannerPaddle extends StatelessWidget {
  const _BannerPaddle();
  @override
  Widget build(BuildContext context) => Transform.rotate(
        angle: -.28,
        child: const _PaddleShape(color: Color(0xFFD7F95A)),
      );
}

class _Mark extends StatelessWidget {
  const _Mark();
  @override
  Widget build(BuildContext context) => Container(
        width: 28,
        height: 28,
        decoration: const BoxDecoration(
            color: Color(0xFFD7F95A), shape: BoxShape.circle),
        child: const Icon(Icons.sports_tennis_rounded,
            size: 18, color: Color(0xFF10221E)),
      );
}

/// Deliberately empty for the first project milestone.
class ProductDetailsPage extends StatelessWidget {
  const ProductDetailsPage({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar());
}

class Paddle {
  const Paddle(
      {required this.id,
      required this.brand,
      required this.name,
      required this.price,
      required this.badge,
      required this.background,
      required this.color});
  final String id;
  final String brand;
  final String name;
  final double price;
  final String badge;
  final Color background;
  final Color color;
}

const List<Paddle> paddles = <Paddle>[
  Paddle(
      id: 'selkirk-luxx',
      brand: 'Selkirk',
      name: 'LUXX Control Air',
      price: 14250,
      badge: 'CONTROL',
      background: Color(0xFFE8E4FF),
      color: Color(0xFF6750C9)),
  Paddle(
      id: 'joola-hyperion',
      brand: 'JOOLA',
      name: 'Hyperion C2',
      price: 12500,
      badge: 'POWER',
      background: Color(0xFFFFE4D6),
      color: Color(0xFFE56C39)),
  Paddle(
      id: 'crbn-1x',
      brand: 'CRBN',
      name: 'Power Series 1X',
      price: 13000,
      badge: 'ALL COURT',
      background: Color(0xFFD9F1E3),
      color: Color(0xFF16764A)),
  Paddle(
      id: 'paddletek-bantam',
      brand: 'Paddletek',
      name: 'Bantam TKO-C',
      price: 14250,
      badge: 'ATTACK',
      background: Color(0xFFDDF0FA),
      color: Color(0xFF1878A6)),
  Paddle(
      id: 'engage-pursuit',
      brand: 'Engage',
      name: 'Pursuit Pro EX',
      price: 14700,
      badge: 'SPIN',
      background: Color(0xFFFFEDBC),
      color: Color(0xFFB57100)),
  Paddle(
      id: 'six-zero',
      brand: 'Six Zero',
      name: 'Double Black',
      price: 10200,
      badge: 'HYBRID',
      background: Color(0xFFF0E2E9),
      color: Color(0xFF9B3E67)),
];

String formatPeso(double amount) {
  final String digits = amount.toStringAsFixed(0);
  return '₱${digits.replaceAllMapped(RegExp(r'(?=(\d{3})+(?!\d))'), (_) => ',')}';
}
