import 'dart:async';
import 'package:mineral/api.dart';
import 'package:mineral/container.dart';
import 'package:mineral/contracts.dart';
import 'package:mineral_cache/providers/memory.dart';


void sendReminder(String channelId) async {
  print('Envoi du rappel à 17h...');
  try {
    final datastore = ioc.resolve<DataStoreContract>();
    final channel = await datastore.channel.get<ServerTextChannel>(channelId, true);
    final builder = MessageBuilder()
      ..addText("@everyone")
      ..addContainer(builder: MessageBuilder()
        ..addText('C\'est l\'heure de faire le CCNA ! 🕔')
      );
    await channel!.send(builder);
    print('Rappel envoyé à 17h !');
  } catch (e) {
    print('Erreur envoi rappel: $e');
  }
}

void main(_, port) async {
  print('Work Reminder Bot 🚀');

  final client = ClientBuilder()
      .setCache(MemoryProvider.new)
      .setHmrDevPort(port)
      .build();

  env.defineOf(AppEnv.new);

  int? lastSentDay;

  client.events.ready((bot) async {
    client.logger.info('Bot is ready as ${bot.username}!');
    final channelId = env.get<String>('CHANNEL_ID');
    print(channelId);
    if (channelId.isEmpty) {
      client.logger.error('CHANNEL_ID is not set in environment variables!');
      return;
    }

    client.logger.info('Will send reminders to channel: $channelId');

    sendReminder(channelId); // Send immediately on startup

    Timer.periodic(Duration(seconds: 30), (timer) async {
      final now = DateTime.now();
      if (now.hour == 17 && now.minute == 0 && lastSentDay != now.day) {
        lastSentDay = now.day;
        sendReminder(channelId);
      }
    });
  });

  await client.init();
}


final class AppEnv implements DefineEnvironment {
  static final String channelId = 'CHANNEL_ID';

  @override
  final Map<String, EnvSchema> schema = {
    channelId: env.string().optional(),
  };
}