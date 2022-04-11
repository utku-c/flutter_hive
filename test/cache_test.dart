import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() {
  setUp(() {
    Hive.init("database");
  });
  test("Name Box Create and Put", () async {
    final box = await Hive.openBox<String>("VB10");

    await box.add("UTKUU");
    expect(box.values.first, "VB10");
  });
}
