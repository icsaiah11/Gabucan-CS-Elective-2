import 'package:flutter_test/flutter_test.dart';

import 'package:paddle_provisions/app.dart';

void main() {
  testWidgets('shows the paddle product browser', (tester) async {
    await tester.pumpWidget(const PaddleProvisionsApp());
    await tester.pumpAndSettle();

    expect(find.text('PADDLE PROVISIONS'), findsOneWidget);
    expect(find.text('Featured paddles'), findsOneWidget);
    expect(find.text('LUXX Control Air'), findsOneWidget);
  });
}
