import "package:collection/collection.dart";
import "package:demo/dal/http_repository.dart";
import "package:dio/dio.dart";
import "package:mockito/annotations.dart";
import "package:mockito/mockito.dart";
import "package:test/test.dart";

import "../../test_helpers/user_helper.dart";
import "http_repository_test.mocks.dart";

@GenerateMocks(<Type>[HttpRepository])
void main() {
  late MockHttpRepository repository;

  setUpAll(() async {});

  setUp(() async {
    repository = MockHttpRepository();
  });

  test(
    "WHEN fetching a single user with a valid id, EXPECT to receive a user",
    () async {
      when(repository.getUser(UserHelper.validUserId)).thenAnswer((_) async => UserHelper.validUser);

      expect(UserHelper.validUser == await repository.getUser(UserHelper.validUserId), isTrue);
    },
  );

  test(
    "WHEN fetching a single user with an invalid id, EXPECT to fail",
    () async {
      const int id = -1;

      when(repository.getUser(id)).thenThrow(UserHelper.invalidRequestDioExceptionForGetUser);

      expect(
        () async => repository.getUser(id),
        throwsA(isA<DioException>()),
      );
    },
  );

  test(
    "WHEN fetching all users, EXPECT to succeed",
    () async {
      when(repository.getUsers()).thenAnswer((_) async => UserHelper.validUsers);

      expect(
        const DeepCollectionEquality().equals(UserHelper.validUsers, await repository.getUsers()),
        isTrue,
      );
    },
  );

  tearDown(() async {});

  tearDownAll(() async {});
}
