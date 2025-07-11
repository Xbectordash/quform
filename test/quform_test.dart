import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quform/button/button.dart' hide TextButton; // Hide custom TextButton
import 'package:quform/checklist/checklist.dart';
import 'package:quform/text_feild/feilds.dart/email_text_feild.dart' show EmailTextFeild;
import 'package:quform/text_feild/feilds.dart/base_text_feild.dart' show BaseTextFeild;
import 'package:quform/text_feild/util/validators.dart';

void main() {
  group('Validators', () {
    final validators = Validators();

    test('email validator', () {
      expect(validators.emailValidator('test@example.com'), isNull);
      expect(validators.emailValidator('invalid-email'), isNotNull);
      expect(validators.emailValidator(''), isNotNull);
    });

    test('password validator', () {
      expect(validators.passwordValidator('Password123!'), isNull);
      expect(validators.passwordValidator('short'), isNotNull);
      expect(validators.passwordValidator(''), isNotNull);
    });

    test('number validator', () {
      expect(validators.numberValidator('123'), isNull);
      expect(validators.numberValidator('abc'), isNotNull);
      expect(validators.numberValidator(''), isNotNull);
    });
  });

  group('BaseChecklistItem', () {
    test('equality', () {
      final item1 = BaseChecklistItem(value: '1', label: 'One');
      final item2 = BaseChecklistItem(value: '1', label: 'One');
      final item3 = BaseChecklistItem(value: '2', label: 'Two');

      expect(item1, item2);
      expect(item1, isNot(equals(item3)));
    });
  });

  group('SingleSelectChecklist', () {
    testWidgets('selection works', (WidgetTester tester) async {
      String? selectedValue;
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SingleSelectChecklist<String>(
              items: [
                BaseChecklistItem(value: '1', label: 'One'),
                BaseChecklistItem(value: '2', label: 'Two'),
              ],
              onChanged: (value) => selectedValue = value,
            ),
          ),
        ),
      );

      await tester.tap(find.text('One'));
      await tester.pump();
      
      expect(selectedValue, '1');
    });
  });

  group('MultiSelectChecklist', () {
    testWidgets('multiple selection works', (WidgetTester tester) async {
      List<String> selectedValues = [];
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MultiSelectChecklist<String>(
              items: [
                BaseChecklistItem(value: '1', label: 'One'),
                BaseChecklistItem(value: '2', label: 'Two'),
              ],
              onChanged: (values) => selectedValues = values,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(Checkbox).first);
      await tester.pump();
      
      expect(selectedValues, ['1']);
    });
  });

  group('Buttons', () {
    testWidgets('PrimaryButton onPressed is called', (WidgetTester tester) async {
      bool pressed = false;
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PrimaryButton(
              text: 'Test',
              onPressed: () => pressed = true,
            ),
          ),
        ),
      );

      await tester.tap(find.text('Test'));
      await tester.pump();
      
      expect(pressed, isTrue);
    });

    testWidgets('SecondaryButton is disabled when loading', (WidgetTester tester) async {
      bool pressed = false;
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SecondaryButton(
              text: 'Test',
              isLoading: true,
              onPressed: () {
                pressed = true;
              },
            ),
          ),
        ),
      );

      // Try to tap the button
      await tester.tap(find.byType(SecondaryButton));
      await tester.pump();
      
      // Verify the button's onPressed wasn't called
      expect(pressed, isFalse);
    });
  });

  group('Text Fields', () {
    testWidgets('BaseTextFeild shows error when validation fails', (WidgetTester tester) async {
      final formKey = GlobalKey<FormState>();
      final controller = TextEditingController();
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Form(
              key: formKey,
              autovalidateMode: AutovalidateMode.always,
              child: BaseTextFeild(
                label: 'Test',
                controller: controller,
                isRequired: true,
              ),
            ),
          ),
        ),
      );

      // Enter some text and then clear it to trigger validation
      await tester.enterText(find.byType(TextFormField), 'test');
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextFormField), '');
      await tester.pumpAndSettle();
      
      // Verify the error message matches the actual implementation
      expect(find.text('This field is required'), findsOneWidget);
    });

    testWidgets('EmailTextFeild validates email format', (WidgetTester tester) async {
      final formKey = GlobalKey<FormState>();
      final controller = TextEditingController();
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Form(
              key: formKey,
              autovalidateMode: AutovalidateMode.always,
              child: EmailTextFeild(
                label: 'Email',
                controller: controller,
                isRequired: true,
              ),
            ),
          ),
        ),
      );

      // Enter invalid email
      await tester.enterText(find.byType(TextFormField), 'invalid-email');
      await tester.pumpAndSettle();
      
      // Verify the error message matches the actual implementation
      expect(find.text('Invalid email address'), findsOneWidget);
    });
  });
}
