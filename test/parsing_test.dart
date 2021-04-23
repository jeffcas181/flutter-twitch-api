import 'dart:convert';
import 'dart:io';

import 'package:test/test.dart';
import 'package:twitch_api/src/models/twitch_extension_transaction.dart';
import 'package:twitch_api/src/models/twitch_response.dart';
import 'package:twitch_api/twitch_api.dart';

void main() {
  String readFileString(String name) =>
      File('test/test_resources/$name').readAsStringSync();

  group('Parsing test', () {
    test('Get Cheermotes', () {
      final json = jsonDecode(readFileString('get_cheermotes.json'));
      final obj = TwitchResponse<TwitchCheermote>.cheermotes(json);

      expect(obj.data.length, 1);

      final cheermote = obj.data.first;
      expect(cheermote.prefix, 'Cheer');
      expect(cheermote.type, TwitchCheermoteType.globalFirstParty);
      expect(cheermote.lastUpdated.year, 2018);
      expect(cheermote.lastUpdated.month, 5);
      expect(cheermote.lastUpdated.day, 22);
      expect(cheermote.isCharitable, false);
      expect(cheermote.tiers.length, 1);

      final cheermoteTier = cheermote.tiers.first;
      expect(cheermoteTier.minBits, 1);
      expect(cheermoteTier.id, '1');
      expect(cheermoteTier.color, '#979797');
      expect(cheermoteTier.canCheer, true);
      expect(cheermoteTier.showInBitsCard, true);
      expect(cheermoteTier.images.dark.animated.length, 5);
      expect(cheermoteTier.images.dark.staticImgs.length, 5);

      final darkAnimated = cheermoteTier.images.dark.animated;
      expect(darkAnimated.containsKey('1'), true);
      expect(darkAnimated['1'],
          'https://d3aqoihi2n8ty8.cloudfront.net/actions/cheer/dark/animated/1/1.gif');

      final darkStatic = cheermoteTier.images.dark.staticImgs;
      expect(darkStatic.containsKey('1'), true);
      expect(darkStatic['1'],
          'https://d3aqoihi2n8ty8.cloudfront.net/actions/cheer/dark/static/1/1.png');
    });

    test('Get Extension Transactions', () {
      final json =
          jsonDecode(readFileString('get_extension_transactions.json'));
      final obj =
          TwitchResponse<TwitchExtensionTransaction>.extensionTransaction(json);

      expect(obj.data.length, 2);
    });
  });
}
