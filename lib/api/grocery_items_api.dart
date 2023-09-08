import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shopping_list/data/categories.dart';

import 'package:shopping_list/models/grocery_item.dart';

class GroceryItemApi {
  final _url = Uri.https(
    'shopping-list-flutter-a2db5-default-rtdb.firebaseio.com',
    'shopping-list.json',
  );
  final Map<String, String> _headers = {
    'Content-type': 'application/json',
  };

  Future<http.Response> createGroceryItemRequest(
    String name,
    int quantity,
    String categoryTitle,
  ) async {
    return http.post(
      _url,
      headers: _headers,
      body: json.encode(
        {
          'name': name,
          'quantity': quantity,
          'category': categoryTitle,
        },
      ),
    );
  }

  Future<List<GroceryItem>> getGroceryItemsRequest() async {
    final response = await http.get(_url);

    if (response.body == 'null') {
      return [];
    }

    final Map<String, dynamic> listData = json.decode(response.body);
    final List<GroceryItem> loadedItems = [];

    for (final item in listData.entries) {
      final category = categories.entries
          .firstWhere(
            (element) => element.value.title == item.value['category'],
          )
          .value;

      loadedItems.add(GroceryItem(
        id: item.key,
        name: item.value['name'],
        quantity: item.value['quantity'],
        category: category,
      ));
    }

    return loadedItems;
  }

  Future<http.Response> deleteGroceryItemRequest(String itemId) async {
    final deleteUrl = Uri.https(
      'shopping-list-flutter-a2db5-default-rtdb.firebaseio.com',
      'shopping-list/$itemId.json',
    );
    return http.delete(
      deleteUrl,
    );
  }
}
