import 'package:carRecordApp/Operations/operations_users_page.dart';
import 'package:carRecordApp/model/filter_data_user_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('test users page functions', () async {
    var list = await UserOperations.getUserDataFromAPI();

    expect(list.length, 86);

    var filters = FilterUserModel(
        colors: ['Red', 'Orange', 'Blue'],
        countries: ['Japan', 'South Africa'],
        gender: 'Female');

    var filteredList = UserOperations.filterUsersList(list, filters);

    expect(filteredList.length, 17);
  });
}
