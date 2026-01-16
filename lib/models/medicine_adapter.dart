import 'package:hive/hive.dart';
import 'medicine.dart';

class MedicineAdapter extends TypeAdapter<Medicine> {
  @override
  final int typeId = 0;

  @override
  Medicine read(BinaryReader reader) {
    final name = reader.readString();
    final dose = reader.readString();
    final timeInMinutes = reader.readInt();
    final notifId = reader.readInt();

    return Medicine(
      name: name,
      dose: dose,
      timeInMinutes: timeInMinutes,
      notificationId: notifId == -1 ? null : notifId,
    );
  }

  @override
  void write(BinaryWriter writer, Medicine obj) {
    writer.writeString(obj.name);
    writer.writeString(obj.dose);
    writer.writeInt(obj.timeInMinutes);

    
    writer.writeInt(obj.notificationId ?? -1);
  }
}


