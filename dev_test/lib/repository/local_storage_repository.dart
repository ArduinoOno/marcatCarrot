import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// json형태의 String으로 저장함
class LocalStorageRepository{
  // 스토리지 생성
  final storage = new FlutterSecureStorage();

  // 스토리지 데이터 습득 
  // getter
  Future<String> getStorageData(String dataKey) 
  async {
    try{
      return await storage.read(key: dataKey);
    }
    catch(error){
      return null;
    }
  }

  // 스토리지 데이터 세팅
  // setter
  Future<void> setStorageData(String dataKey, String dataValue)
  async {
    try{
      return await storage.write(key: dataKey, value: dataValue);
    }
    catch(error) {
      return null;
    }
  }
    
}