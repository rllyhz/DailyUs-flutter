import 'dart:convert';

import 'package:daily_us/data/models/upload_new_story_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../utils/data_helpers.dart';

void main() {
  group("Upload New Story Response Usecases", () {
    test("Should return successful response test", () {
      final response = UploadNewStoryResponse.fromJson(
        uploadNewStorySuccessJson,
      );

      expect(response.error, false);
      expect(response.message, "success");
    });

    test("Should return failed response test", () {
      final response = UploadNewStoryResponse.fromJson(
        uploadNewStoryFailedJson,
      );

      expect(response.error, true);
      expect(response.message, "failed");
    });
  });
}
