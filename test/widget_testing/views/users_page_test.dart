import "package:demo/dal/http_repository.dart";
import "package:demo/view_models/users_view_model.dart";
import "package:demo/views/users_page.dart";
import "package:flutter_test/flutter_test.dart";
import "package:mockito/annotations.dart";
import "package:mockito/mockito.dart";
import "package:nock/nock.dart";

import "../../test_helpers/converters.dart";
import "../../test_helpers/image_http_request_helper.dart";
import "../../test_helpers/image_request.dart";
import "../../test_helpers/pumpers.dart";
import "../../test_helpers/reg_exp_key_finder.dart";
import "../../test_helpers/setup_testing.dart";
import "../../test_helpers/user_helper.dart";
import "users_page_test.mocks.dart";

@GenerateMocks(<Type>[HttpRepository])
void main() {
  late UsersViewModel viewModel;
  late MockHttpRepository repository;

  final Finder pageFinder = find.byKeyString((UsersPage).toString());
  final Finder pageTitleFinder = find.byKeyString("pageTitleKey");
  final Finder fetchButtonFinder = find.byKeyString("fetchButton");
  final Finder listViewFinder = find.byKeyString("listView");
  final Finder listTileFinder = RegExpKeyFinder(RegExp(r"^userTile.*$", caseSensitive: false));

  Future<void> pumpUsersPage(WidgetTester tester) async {
    await tester.pumpPage(page: UsersPage.obtainPage(viewModel: viewModel));
    await tester.pump();
  }

  setUpAll(() {});

  setUp(() {
    nock.init();
    repository = MockHttpRepository();
    viewModel = UsersViewModel(repository: repository);
  });

  testWidgets(
    "The page has the basic structure",
    (WidgetTester tester) async {
      await pumpUsersPage(tester);

      expect(pageFinder, findsOneWidget);
      expect(pageTitleFinder, findsOneWidget);
      expect(fetchButtonFinder, findsOneWidget);
      expect(listViewFinder, findsOneWidget);
    },
    variant: mobile,
  );

  testWidgets(
    "WHEN the user clicks on the fetch button, EXPECT to eventually populate the view",
    (WidgetTester tester) async {
      stubImageRequest(
        ImageRequest(Uri.parse(UserHelper.validUser.data!.avatar!), "test/mock/thumbnail.jpg"),
      );
      await pumpUsersPage(tester);

      when(repository.getUsers()).thenAnswer((_) async => UserHelper.validUsers);

      expect(fetchButtonFinder, findsOneWidget);
      await tester.tap(fetchButtonFinder);
      await tester.pumpAndSettle();

      expect(listTileFinder, findsAtLeastNWidgets(1));
    },
    variant: mobile,
  );

  tearDown(nock.cleanAll);

  tearDownAll(() {});
}
