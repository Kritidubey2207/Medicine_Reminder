import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/medicine.dart';
import '../services/notification_service.dart';
import '../services/notification_permission.dart';
import 'add_medicine_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
   
    NotificationPermission.request();
  }

  
  void scheduleDialog(DateTime time, String message) {
    final delay = time.difference(DateTime.now());
    if (delay.isNegative) return;

    _timer?.cancel();
    _timer = Timer(delay, () {
      if (!mounted) return;

      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Medicine Reminder'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final box = Hive.box<Medicine>('medicines');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Medicine Reminder'),
        backgroundColor: Colors.teal,
      ),

      body: ValueListenableBuilder<Box<Medicine>>(
        valueListenable: box.listenable(),
        builder: (context, box, _) {
          if (box.isEmpty) {
            return const Center(
              child: Text(
                'No medicines added.\nTap + to add one.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
            );
          }

         
          final keys = box.keys.cast<int>().toList()
            ..sort((a, b) =>
                box.get(a)!.timeInMinutes
                    .compareTo(box.get(b)!.timeInMinutes));

          return ListView.builder(
            itemCount: keys.length,
            itemBuilder: (context, index) {
              final key = keys[index];
              final medicine = box.get(key)!;

              final h = medicine.timeInMinutes ~/ 60;
              final m = medicine.timeInMinutes % 60;

              return Dismissible(
                key: ValueKey(key),
                direction: DismissDirection.endToStart,
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20),
                  child: const Icon(Icons.delete, color: Colors.white),
                ),

                onDismissed: (_) async {
                  if (medicine.notificationId != null) {
                    await NotificationService.cancel(
                      medicine.notificationId!,
                    );
                  }
                  await box.delete(key);
                },

                child: Card(
                  child: ListTile(
                    title: Text(medicine.name),
                    subtitle: Text(
                      '${medicine.dose} at '
                      '${h.toString().padLeft(2, '0')}:'
                      '${m.toString().padLeft(2, '0')}',
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        child: const Icon(Icons.add),
        onPressed: () async {
          final result = await Navigator.push<Map<String, dynamic>>(
            context,
            MaterialPageRoute(builder: (_) => const AddMedicineScreen()),
          );

          if (result != null) {
            scheduleDialog(
              result['time'],
              'Take ${result['name']} (${result['dose']})',
            );
          }
        },
      ),
    );
  }
}
