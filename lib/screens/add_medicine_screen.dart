import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/medicine.dart';
import '../services/notification_service.dart';

class AddMedicineScreen extends StatefulWidget {
  const AddMedicineScreen({super.key});

  @override
  State<AddMedicineScreen> createState() => _AddMedicineScreenState();
}

class _AddMedicineScreenState extends State<AddMedicineScreen> {
  final _nameCtrl = TextEditingController();
  final _doseCtrl = TextEditingController();
  TimeOfDay _time = TimeOfDay.now();

  Future<void> _pickTime() async {
    final picked =
        await showTimePicker(context: context, initialTime: _time);
    if (picked != null) setState(() => _time = picked);
  }

  void _save() async {
    if (_nameCtrl.text.isEmpty || _doseCtrl.text.isEmpty) return;

    final now = DateTime.now();
    DateTime scheduled = DateTime(
      now.year,
      now.month,
      now.day,
      _time.hour,
      _time.minute,
    );

    if (scheduled.isBefore(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }

    final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;

   
    await NotificationService.schedule(
      id: id,
      title: _nameCtrl.text,
      body: 'Take ${_doseCtrl.text}',
      time: scheduled,
    );

    final medicine = Medicine(
      name: _nameCtrl.text,
      dose: _doseCtrl.text,
      timeInMinutes: _time.hour * 60 + _time.minute,
      notificationId: id,
    );

    Hive.box<Medicine>('medicines').add(medicine);

    Navigator.pop(context, {
      'name': medicine.name,
      'dose': medicine.dose,
      'time': scheduled,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: const Text('Add Medicine'), backgroundColor: Colors.teal),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _nameCtrl,
              decoration: const InputDecoration(labelText: 'Medicine Name'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _doseCtrl,
              decoration: const InputDecoration(labelText: 'Dose'),
            ),
            const SizedBox(height: 20),
            ListTile(
              title: Text('Time: ${_time.format(context)}'),
              trailing: const Icon(Icons.access_time),
              onTap: _pickTime,
            ),
            const Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                minimumSize: const Size(double.infinity, 48),
              ),
              onPressed: _save,
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
