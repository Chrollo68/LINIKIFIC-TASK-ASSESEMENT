import 'package:flutter/material.dart';

import '../services/supabase_service.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoginMode = true;
  bool _isLoading = false;

  Future<void> _showMessage(String message) async {
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _submit() async {
    setState(() => _isLoading = true);
    try {
      if (_isLoginMode) {
        await SupabaseService.instance.signInWithEmail(
          _emailController.text.trim(),
          _passwordController.text.trim(),
        );
        await _showMessage('Signed in successfully.');
      } else {
        await SupabaseService.instance.signUpWithEmail(
          _emailController.text.trim(),
          _passwordController.text.trim(),
        );
        await _showMessage(
          'Registration complete. Check your email for confirmation.',
        );
      }
    } catch (error) {
      await _showMessage('Error: ${error.toString()}');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _magicLink() async {
    setState(() => _isLoading = true);
    try {
      await SupabaseService.instance.signInWithMagicLink(
        _emailController.text.trim(),
      );
      await _showMessage('Magic link sent. Check your email.');
    } catch (error) {
      await _showMessage('Error: ${error.toString()}');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _signInWithGoogle() async {
    setState(() => _isLoading = true);
    try {
      await SupabaseService.instance.signInWithGoogle();
    } catch (error) {
      await _showMessage('Error: ${error.toString()}');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _signInWithGitHub() async {
    setState(() => _isLoading = true);
    try {
      await SupabaseService.instance.signInWithGitHub();
    } catch (error) {
      await _showMessage('Error: ${error.toString()}');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_isLoginMode ? 'Sign In' : 'Register')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Welcome to Supabase Chat',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isLoading ? null : _submit,
              child: _isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : Text(_isLoginMode ? 'Sign In' : 'Create Account'),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: _isLoading
                  ? null
                  : () => setState(() => _isLoginMode = !_isLoginMode),
              child: Text(
                _isLoginMode
                    ? 'Create a new account'
                    : 'Already have an account? Sign in',
              ),
            ),
            const SizedBox(height: 10),
            OutlinedButton(
              onPressed: _isLoading ? null : _magicLink,
              child: const Text('Send Magic Link'),
            ),
            const SizedBox(height: 10),
            const Divider(),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: _isLoading ? null : _signInWithGoogle,
              icon: const Icon(Icons.login),
              label: const Text('Continue with Google'),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: _isLoading ? null : _signInWithGitHub,
              icon: const Icon(Icons.code),
              label: const Text('Continue with GitHub'),
            ),
          ],
        ),
      ),
    );
  }
}
