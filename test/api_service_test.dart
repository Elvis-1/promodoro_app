import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:promodoro_app/controller/entry_controller.dart';
import 'package:promodoro_app/repository/entry_repo.dart';
import 'package:promodoro_app/services/api_service.dart';

void main() {
  test('GET request test', () async {
    final client = MockClient((request) async {
      if (request.url.path == 'api/fetch-entries') {
        return Response(
            '[{"startTimestamp": "2023-01-01T00:00:00Z", "stopTimestamp": "2023-01-01T00:25:00Z"}]',
            200);
      }
      return Response('', 404);
    });
    final apiService = ApiService();
    final entryRepository = EntryRepository(apiService: apiService);
    final entryProviderController =
        EntryProviderController(entryRepository: entryRepository);
    final result = await entryRepository.fetchEntriesFromServer();

    expect(result.isNotEmpty, true);
  });

  test('POST request test', () async {
    final client = MockClient((request) async {
      if (request.url.path == '/create-entry') {
        return Response('', 200);
      }
      return Response('', 404);
    });

    final apiService = ApiService();
    final entryRepository = EntryRepository(apiService: apiService);
    final entryProviderController =
        EntryProviderController(entryRepository: entryRepository);
    final result = await entryProviderController.startTimer();

    expect(result, true);
  });
}
