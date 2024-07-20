import 'dart:convert';
import 'package:http/http.dart' as http;

const baseUrl = "https://api.timbu.cloud/products";
const apiKey = "096e309415294b7fb8881a1674fc3e3720240713045911535430";
const orgId = "277d7e20b120419f816e2a13aaff78f2";
const appId = "B9XYV6V7LHD46BW";
const catUrl = "https://api.timbu.cloud/categories";

class Service {
  Future<List<dynamic>> fetchProducts() async {
    try {
      var response = await http.get(
        Uri.parse(
            'https://api.timbu.cloud/products?Apikey=096e309415294b7fb8881a1674fc3e3720240713045911535430&organization_id=277d7e20b120419f816e2a13aaff78f2&Appid=B9XYV6V7LHD46BW'),
        // Uri.parse(
        //     '$baseUrl?Apikey=$apiKey&organization_id=$orgId&Appid=$appId&size=10'),
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        return data['items']; // Returning the list of items
      } else {
        print('Request failed with status: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }
//////

  Future<List<dynamic>> fetchProductWish() async {
    try {
      var response = await http.get(
        Uri.parse(
          'https://api.timbu.cloud/products?Apikey=096e309415294b7fb8881a1674fc3e3720240713045911535430&organization_id=277d7e20b120419f816e2a13aaff78f2&Appid=B9XYV6V7LHD46BW',
        ),
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        return data['items']; // Returning the list of items
      } else {
        print('Request failed with status: ${response.statusCode}');
        return [];
      }

    } catch (e) {
      print('Error: $e');
      return [];
    }
  }




  ///////
  Future<Map<String, dynamic>> fetchProduct(String id) async {
    try {
      var response = await http.get(
        Uri.parse(
            'https://api.timbu.cloud/products/$id?Apikey=096e309415294b7fb8881a1674fc3e3720240713045911535430&organization_id=277d7e20b120419f816e2a13aaff78f2&Appid=B9XYV6V7LHD46BW'),
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        return data; // Returning the single item
      } else {
        print('Request failed with status: ${response.statusCode}');
        return {}; // Returning an empty map
      }
    } catch (e) {
      print('Error: $e');
      return {}; // Returning an empty map
    }
  }
/////////////////




  Future<List<dynamic>> fetchSearchProduct(String name) async {
    try {
      var response = await http.get(
        Uri.parse(
            'https://api.timbu.cloud/products?Apikey=096e309415294b7fb8881a1674fc3e3720240713045911535430&organization_id=277d7e20b120419f816e2a13aaff78f2&Appid=B9XYV6V7LHD46BW'),
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);

        List<dynamic> products = data['items']; // Assuming 'products' is the key holding the product list
        return products.where((product) => product['name'].toLowerCase().contains(name.toLowerCase())).toList();
      } else {
        print('Request failed with status: ${response.statusCode}');
        return []; // Returning an empty list
      }
    } catch (e) {
      print('Error: $e');
      return []; // Returning an empty list
    }
  }



/////////////////
}
