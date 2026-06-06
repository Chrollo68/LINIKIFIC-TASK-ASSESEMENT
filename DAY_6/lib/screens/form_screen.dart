import 'package:flutter/material.dart';
import '../themes/app_theme.dart';
import '../widgets/custom_widgets.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({Key? key}) : super(key: key);

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _messageController;

  String? _selectedCountry;
  bool _agreeToTerms = false;
  bool _subscribeNewsletter = true;

  final List<String> _countries = [
    'United States',
    'Canada',
    'United Kingdom',
    'Australia',
    'Germany',
    'France',
  ];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _messageController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Form submitted successfully!'),
          backgroundColor: AppColors.success,
          duration: Duration(seconds: 3),
        ),
      );

      _formKey.currentState!.reset();
      _nameController.clear();
      _emailController.clear();
      _messageController.clear();
      setState(() {
        _selectedCountry = null;
        _agreeToTerms = false;
        _subscribeNewsletter = true;
      });
    }
  }

  void _resetForm() {
    _formKey.currentState!.reset();
    _nameController.clear();
    _emailController.clear();
    _messageController.clear();
    setState(() {
      _selectedCountry = null;
      _agreeToTerms = false;
      _subscribeNewsletter = true;
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Form Components')),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomHeader(
                title: 'Contact Form',
                subtitle: 'Demonstrates themed form components',
              ),
              Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Form(
                  key: _formKey,
                  child: Column(
                    spacing: AppSpacing.md,
                    children: [
                      // Name Field
                      TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          labelText: 'Full Name',
                          hintText: 'Enter your full name',
                          prefixIcon: Icon(Icons.person),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Name is required';
                          }
                          if (value.length < 3) {
                            return 'Name must be at least 3 characters';
                          }
                          return null;
                        },
                      ),

                      // Email Field
                      TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          labelText: 'Email Address',
                          hintText: 'Enter your email',
                          prefixIcon: Icon(Icons.email),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email is required';
                          }
                          const pattern =
                              r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
                          final regex = RegExp(pattern);
                          if (!regex.hasMatch(value)) {
                            return 'Enter a valid email';
                          }
                          return null;
                        },
                      ),

                      // Country Dropdown
                      DropdownButtonFormField<String>(
                        initialValue: _selectedCountry,
                        decoration: const InputDecoration(
                          labelText: 'Select Country',
                          prefixIcon: Icon(Icons.public),
                        ),
                        items: _countries
                            .map(
                              (country) => DropdownMenuItem(
                                value: country,
                                child: Text(country),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          setState(() => _selectedCountry = value);
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'Please select a country';
                          }
                          return null;
                        },
                      ),

                      // Message Field
                      TextFormField(
                        controller: _messageController,
                        decoration: const InputDecoration(
                          labelText: 'Message',
                          hintText: 'Enter your message',
                          prefixIcon: Icon(Icons.message),
                        ),
                        maxLines: 4,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Message is required';
                          }
                          if (value.length < 10) {
                            return 'Message must be at least 10 characters';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: AppSpacing.md),

                      // Checkboxes
                      CheckboxListTile(
                        title:
                            const Text('I agree to the terms and conditions'),
                        value: _agreeToTerms,
                        onChanged: (value) {
                          setState(() => _agreeToTerms = value ?? false);
                        },
                        contentPadding: EdgeInsets.zero,
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                      CheckboxListTile(
                        title: const Text('Subscribe to our newsletter'),
                        value: _subscribeNewsletter,
                        onChanged: (value) {
                          setState(() => _subscribeNewsletter = value ?? false);
                        },
                        contentPadding: EdgeInsets.zero,
                        controlAffinity: ListTileControlAffinity.leading,
                      ),

                      const SizedBox(height: AppSpacing.lg),

                      // Buttons
                      Row(
                        spacing: AppSpacing.md,
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: _submitForm,
                              child: const Text('Submit'),
                            ),
                          ),
                          Expanded(
                            child: OutlinedButton(
                              onPressed: _resetForm,
                              child: const Text('Reset'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // Form Description Card
              Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Form Validation',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: AppSpacing.md),
                        Text(
                          'This form demonstrates:',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Padding(
                          padding: const EdgeInsets.only(left: AppSpacing.md),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: AppSpacing.sm,
                            children: [
                              _buildValidationPoint(
                                context,
                                '✓ Text input validation with regex',
                              ),
                              _buildValidationPoint(
                                context,
                                '✓ Dropdown field validation',
                              ),
                              _buildValidationPoint(
                                context,
                                '✓ Multi-line text area',
                              ),
                              _buildValidationPoint(
                                context,
                                '✓ Checkbox and switch components',
                              ),
                              _buildValidationPoint(
                                context,
                                '✓ Themed input decorations',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  Widget _buildValidationPoint(BuildContext context, String text) =>
      Text(text, style: Theme.of(context).textTheme.bodyMedium);
}
