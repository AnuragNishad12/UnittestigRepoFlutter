import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpoddemo/ApiServices.dart';
import 'package:riverpoddemo/DogModel.dart';

class DogRepository {
  // final ApiServices apiService;
  //
  //
  // DogRepository({required this.apiService});

  final ApiServices apiServices;

  DogRepository({required this.apiServices});

  Future<DogModel> getRandomDog() {
    return apiServices.fetchRandomDog();
  }
}

final dogRepositoryProvider = Provider(
  (ref) => DogRepository(apiServices: ref.read(dogApiServiceProvider)),
);
