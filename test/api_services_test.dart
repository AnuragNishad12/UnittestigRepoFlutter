import 'package:flutter_test/flutter_test.dart';
import 'package:riverpoddemo/ApiServices.dart';
import 'package:riverpoddemo/DogModel.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late MockHttpClient mockHttpClient;
  late ApiServices apiServices;

  setUp(() {
    mockHttpClient = MockHttpClient();
    apiServices = ApiServices(client: mockHttpClient);
  });

  test('✅ fetchRandomDog returns DogModel when API call is successful', () async {
    const fakeJson =
        '{"message": "https://images.dog.ceo/breeds/hound.jpg", "status": "success"}';

    when(
      () => mockHttpClient.get(Uri.parse(apiServices.baseUrl)),
    ).thenAnswer((_) async => http.Response(fakeJson, 200));

    // Call the function
    final result = await apiServices.fetchRandomDog();

    // Check the result
    expect(result, isA<DogModel>());
    expect(result.message, contains("dog.ceo"));
    expect(result.status, "success");
  });

  test('❌ fetchRandomDog throws Exception when API call fails', () async {
    // Fake API error
    when(
      () => mockHttpClient.get(Uri.parse(apiServices.baseUrl)),
    ).thenAnswer((_) async => http.Response("Error", 404));

    // Check that an exception is thrown
    expect(() async => await apiServices.fetchRandomDog(), throwsException);
  });
}
