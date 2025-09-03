import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpoddemo/DogModel.dart';
import 'package:riverpoddemo/DogRepository.dart';

class DogState {
  final AsyncValue<DogModel> value;
  DogState(this.value);
}

class DogViewModel extends StateNotifier<AsyncValue<DogModel>> {
  final DogRepository repository;
  // DogViewModel({required this.repository}):super(const AsyncValue.loading()
  //   fetchRandomDog();
  // ));

  DogViewModel({required this.repository}) : super(const AsyncValue.loading()) {
    fetchRandomDog();
  }

  Future<void> fetchRandomDog() async {
    state = const AsyncValue.loading();
    try {
      final dog = await repository.getRandomDog();
      state = AsyncValue.data(dog);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final dogViewModelProvider =
    StateNotifierProvider<DogViewModel, AsyncValue<DogModel>>(
      (ref) => DogViewModel(repository: ref.read(dogRepositoryProvider)),
    );
