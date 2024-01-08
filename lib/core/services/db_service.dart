import 'package:hive_flutter/adapters.dart';
import 'package:weather_app/core/services/hive_db/models/temp_model.dart';

Future<void> initHiveDb()async{
  await Hive.initFlutter();
  var box = await Hive.openBox('temp_data');
  Hive.registerAdapter(TempModelAdapter());
}

class HiveDBHandler{
  HiveDBHandler();
  void addData(String labelKey, TempModel data){
    Box box = Hive.box('temp_data');
    box.put(labelKey.toLowerCase(), data);
    print('data added');
  }

  TempModel getData(String labelKey){
    Box box = Hive.box('temp_data');
    TempModel data = box.get(labelKey.toLowerCase());
    return data;
    print('data received');
  }

  void updateData(String labelKey,dynamic data){
    Box box = Hive.box('temp_data');
    box.put(labelKey.toLowerCase(), data);
    print('data updated');
  }

  void deleteData(String labelKey){
    Box box = Hive.box('temp_data');
    box.delete(labelKey.toLowerCase());
    print('data deleted');
  }
}
