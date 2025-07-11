# Quform

A Flutter form component library that provides a set of customizable and reusable form components with built-in validation and consistent styling.

## Features

- **Text Fields**: Pre-built text fields for common input types (email, password, number, etc.)
- **Buttons**: Various button styles with consistent theming
- **Checklists**: Single and multi-select checklist components
- **Form Validation**: Built-in validators and easy custom validation
- **Customizable**: Full control over styling and behavior
- **Accessible**: Built with accessibility in mind

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  quform: ^1.0.0
```

Then run:

```bash
flutter pub get
```

## Usage

### Import the package

```dart
import 'package:quform/quform.dart';
```

## Text Fields

### Base Text Field

```dart
BaseTextField(
  label: 'Username',
  isRequired: true,
  hintText: 'Enter your username',
  onChanged: (value) {
    // Handle text changes
  },
)
```

### Email Field

```dart
EmailTextField(
  label: 'Email',
  isRequired: true,
  onChanged: (value) {
    // Handle email changes
  },
)
```

### Password Field

```dart
PasswordTextField(
  label: 'Password',
  isRequired: true,
  onChanged: (value) {
    // Handle password changes
  },
)
```

### Number Field

```dart
NumberTextField(
  label: 'Age',
  isRequired: true,
  onChanged: (value) {
    // Handle number changes
  },
)
```

### Phone Number Field

```dart
PhoneNumberTextField(
  label: 'Phone Number',
  isRequired: true,
  countryCode: '+1',
  onChanged: (value) {
    // Handle phone number changes
  },
)
```

## Buttons

### Primary Button

```dart
PrimaryButton(
  text: 'Submit',
  onPressed: () {
    // Handle button press
  },
  isFullWidth: true,
)
```

### Secondary Button

```dart
SecondaryButton(
  text: 'Cancel',
  onPressed: () {
    // Handle button press
  },
  borderColor: Colors.red,
  textColor: Colors.red,
)
```

### Text Button

```dart
TextButton(
  text: 'Forgot Password?',
  onPressed: () {
    // Handle button press
  },
)
```

### Icon Button

```dart
IconBtn(
  icon: Icons.add,
  onPressed: () {
    // Handle button press
  },
  tooltip: 'Add Item',
)
```

## Checklists

### Single Select Checklist

```dart
SingleSelectChecklist<String>(
  title: Text('Select an option'),
  items: [
    BaseChecklistItem(value: 'option1', label: 'Option 1'),
    BaseChecklistItem(value: 'option2', label: 'Option 2'),
  ],
  onChanged: (value) {
    // Handle selection changes
  },
)
```

### Multi-Select Checklist

```dart
MultiSelectChecklist<String>(
  title: Text('Select options'),
  items: [
    BaseChecklistItem(value: 'option1', label: 'Option 1'),
    BaseChecklistItem(value: 'option2', label: 'Option 2'),
  ],
  onChanged: (values) {
    // Handle selection changes
  },
  showSelectAll: true,
)
```

## Form Validation

### Using Built-in Validators

```dart
final validators = Validators();

// In your form field
validator: validators.emailValidator,
```

### Custom Validation

```dart
validator: (value) {
  if (value == null || value.isEmpty) {
    return 'This field is required';
  }
  if (value.length < 6) {
    return 'Must be at least 6 characters';
  }
  return null;
},
```

## Customization

All components are highly customizable. Here's an example of a customized button:

```dart
PrimaryButton(
  text: 'Custom Button',
  onPressed: () {},
  width: 200,
  height: 50,
  borderRadius: 12,
  backgroundColor: Colors.purple,
  textColor: Colors.white,
  elevation: 4,
  textStyle: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  ),
)
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
