import "package:demo/dal/http_repository.dart";
import "package:demo/view_models/users_view_model.dart";
import "package:mockito/annotations.dart";
import "package:mockito/mockito.dart";
import "package:test/test.dart";

import "../../test_helpers/mock_notify_listener.dart";
import "../../test_helpers/user_helper.dart";
import "users_view_model_test.mocks.dart";

@GenerateMocks(<Type>[HttpRepository])
void main() {
  late UsersViewModel viewModel;
  late MockHttpRepository repository;
  late MockNotifyListener mockNotifyListener;

  setUpAll(() {});

  setUp(() {
    repository = MockHttpRepository();
    mockNotifyListener = MockNotifyListener();
    viewModel = UsersViewModel(repository: repository)
      ..addListener(
        mockNotifyListener.call,
        <String>[UsersViewModelKeys.fetchUsers],
      );
  });

  test(
    "WHEN creating a VM, EXPECT to be empty",
    () async => expect(viewModel.users.isEmpty, isTrue),
  );

  test(
    "WHEN fetching all users, EXPECT to have 1 User",
    () async {
      when(repository.getUsers()).thenAnswer((_) async => UserHelper.validUsers);

      expect(viewModel.users.isEmpty, isTrue);
      verifyZeroInteractions(mockNotifyListener);

      await viewModel.fetchUsers();
      expect(viewModel.users.length, equals(1));

      verify(mockNotifyListener()).called(1);
    },
  );

  test(
    "WHEN fetching all users again, EXPECT to have only 1 User",
    () async {
      when(repository.getUsers()).thenAnswer((_) async => UserHelper.validUsers);

      expect(viewModel.users.isEmpty, isTrue);

      await viewModel.fetchUsers();
      await viewModel.fetchUsers();
      expect(viewModel.users.length, equals(1));
      verify(mockNotifyListener()).called(greaterThan(1));
    },
  );

  tearDown(() {
    reset(mockNotifyListener);
  });

  tearDownAll(() {});
}
