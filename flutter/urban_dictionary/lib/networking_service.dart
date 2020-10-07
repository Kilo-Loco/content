import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:urban_dictionary/define_term_response.dart';
import 'package:urban_dictionary/term.dart';

class NetworkingService {
  Future<List<Term>> defineTerm(String searchTerm) async {
    final queryParameters = {'term': searchTerm};

    final uri = Uri.https('mashape-community-urban-dictionary.p.rapidapi.com',
        'define', queryParameters);

    final headers = {
      "x-rapidapi-host": "mashape-community-urban-dictionary.p.rapidapi.com",
      "x-rapidapi-key": "pYQEsMdOHWmsh0C3bRjjDNLGS1kVp1NQ4F2jsnZbMfGJcMbn2M"
    };

    final response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      final decodedBody = jsonDecode(response.body);
      final defineTermsResponse = DefineTermResponse.fromJson(decodedBody);
      return defineTermsResponse.list;
    } else {
      throw Exception('Failed to define term');
    }
  }
}
