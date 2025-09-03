import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'DogViewModel.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dogState = ref.watch(dogViewModelProvider);
    final viewModel = ref.read(dogViewModelProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Random Dog (MVVM + Riverpod)')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: dogState.when(
            data: (dog) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    dog.message,
                    width: 300,
                    height: 300,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        const SizedBox(
                          width: 300,
                          height: 300,
                          child: Center(child: Text('Image failed to load')),
                        ),
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const SizedBox(
                        width: 300,
                        height: 300,
                        child: Center(child: CircularProgressIndicator()),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () => viewModel.fetchRandomDog(),
                  icon: const Icon(Icons.refresh),
                  label: const Text('Fetch New Dog'),
                ),
              ],
            ),
            loading: () => const CircularProgressIndicator(),
            error: (err, stack) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Error: $err'),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () => viewModel.fetchRandomDog(),
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
