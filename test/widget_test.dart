import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_application_2/main.dart';

void main() {
  testWidgets('shows the static Instagram-inspired screen', (tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Instagram'), findsOneWidget);
    expect(find.text('username'), findsNWidgets(2));
    expect(find.text('10,547 Likes'), findsOneWidget);
  });
}
