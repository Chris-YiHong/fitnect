import 'package:fitnect/core/widgets/toast_service.dart';
import 'package:fitnect/modules/authentication/providers/signin_state_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A widget that demonstrates the different toast types.
///
/// This widget can be used to showcase how the toast service works
/// and the different types of toasts available.
class ToastDemo extends ConsumerWidget {
  const ToastDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final toastService = ref.read(toastServiceProvider);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ElevatedButton(
          onPressed: () {
            toastService.showSuccess('Profile updated successfully!');
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
          ),
          child: const Text('Show Success Toast'),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            toastService.showError('Failed to connect to server');
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
          ),
          child: const Text('Show Error Toast'),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            toastService.showInfo('New updates are available');
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
          ),
          child: const Text('Show Info Toast'),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            toastService.showWarning('Your subscription will expire soon');
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange,
            foregroundColor: Colors.white,
          ),
          child: const Text('Show Warning Toast'),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            toastService.showCustom(
              'Custom toast with purple background',
              backgroundColor: Colors.purple,
              textColor: Colors.white,
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.purple,
            foregroundColor: Colors.white,
          ),
          child: const Text('Show Custom Toast'),
        ),
        const SizedBox(height: 32),
        const Divider(),
        const SizedBox(height: 16),
        Text(
          'Test API Implementation',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () async {
            try {
              final result =
                  await ref
                      .read(signinStateProvider.notifier)
                      .signinWithGoogle();

              toastService.showSuccess(
                'Google Sign-in Successful: ${result.isNewUser ? "New User" : "Existing User"}\nToken: ${result.credentials.token.substring(0, 10)}...',
              );
            } catch (e) {
              toastService.showError('Google Sign-in Failed: $e');
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
          ),
          child: const Text('Test Google Sign-in API'),
        ),
      ],
    );
  }
}

/// A page that shows the toast demo widget.
///
/// This page can be added to your app for testing purposes.
///
/// Example usage:
/// ```dart
/// GoRoute(
///   path: '/toast-demo',
///   builder: (context, state) => const ToastDemoPage(),
/// ),
/// ```
class ToastDemoPage extends StatelessWidget {
  const ToastDemoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Toast & API Demo')),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Center(child: ToastDemo()),
        ),
      ),
    );
  }
}
