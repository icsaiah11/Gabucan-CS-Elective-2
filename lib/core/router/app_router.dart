import 'package:go_router/go_router.dart';

import '../../features/catalog/presentation/screens/home_screen.dart';
import '../../features/catalog/presentation/screens/product_details_page.dart';
import '../../features/cart/presentation/screens/cart_screen.dart';
import '../../features/cart/presentation/screens/checkout_confirmation_screen.dart';
import '../../features/cart/state/cart_controller.dart';

abstract final class AppRouter {
  static GoRouter create(CartController cartController) => GoRouter(
        refreshListenable: cartController,
        routes: <RouteBase>[
          GoRoute(
            path: '/',
            builder: (context, state) => const HomeScreen(),
            routes: <RouteBase>[
              GoRoute(
                path: 'paddles/:id',
                builder: (context, state) => ProductDetailsPage(
                  paddleId: state.pathParameters['id']!,
                ),
              ),
            ],
          ),
          GoRoute(
            path: '/cart',
            builder: (context, state) => const CartScreen(),
          ),
          GoRoute(
            path: '/checkout-confirmation',
            redirect: (context, state) =>
                cartController.isEmpty ? '/cart' : null,
            builder: (context, state) => const CheckoutConfirmationScreen(),
          ),
        ],
      );
}
