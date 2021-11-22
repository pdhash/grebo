import 'dart:convert';

import 'package:flutter_keychain/flutter_keychain.dart';

putKeyChain(String credential) async {
  await FlutterKeychain.put(key: "com.example.grebo", value: credential);
}

Future<Map<String, dynamic>?> getKeyChain() async {
  var v = await FlutterKeychain.get(key: "com.example.grebo");
  return jsonDecode(v!);
}
