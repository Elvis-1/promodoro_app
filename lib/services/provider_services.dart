import 'package:promodoro_app/controller/entry_controller.dart';
import 'package:promodoro_app/controller/local_storage_entry_controller.dart';
import 'package:promodoro_app/repository/entry_repo.dart';
import 'package:promodoro_app/services/api_service.dart';
import 'package:promodoro_app/services/local_storage_service.dart';
import 'package:provider/provider.dart';

class ProviderService {
  static final providerService = [
    ChangeNotifierProvider.value(value: ApiService()),
    ChangeNotifierProvider.value(value: DatabaseHelper()),
    // ChangeNotifierProvider.value(value: LocalStorageController()),
    ChangeNotifierProxyProvider<DatabaseHelper, LocalStorageController>(
      create: (context) {
        return LocalStorageController();
      },
      update: (_, dbHelper, localStore) => LocalStorageController(),
    ),
    ChangeNotifierProxyProvider<ApiService, EntryRepository>(
      create: (context) {
        ApiService apiService = ApiService();
        return EntryRepository(apiService: apiService);
      },
      update: (_, apiService, entryRepo) =>
          EntryRepository(apiService: apiService),
    ),
    ChangeNotifierProxyProvider<EntryRepository, EntryProviderController>(
      create: (context) {
        ApiService apiService = ApiService();
        EntryRepository entryRepository =
            EntryRepository(apiService: apiService);
        return EntryProviderController(entryRepository: entryRepository);
      },
      update: (_, entryRepo, entryController) =>
          EntryProviderController(entryRepository: entryRepo),
    ),
  ];
}
