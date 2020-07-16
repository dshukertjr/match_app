import 'package:app/models/match_pair.dart';
import 'package:app/models/user_public.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Match', () {
    test('uid sort works', () {
      final UserPublic userPublic1 = UserPublic(
        imageUrls: <String>[],
        description: '',
        name: '',
        uid: 'aaa',
        createdAt: DateTime.now(),
      );
      final UserPublic userPublic2 = UserPublic(
        imageUrls: <String>[],
        description: '',
        name: '',
        uid: 'bbb',
        createdAt: DateTime.now(),
      );
      final MatchPair matchPair = MatchPair.fromTwoUserPublic(
          userPublic1: userPublic1, userPublic2: userPublic2);
      expect(matchPair.documentId, '${userPublic1.uid}${userPublic2.uid}');
    });
  });
}
