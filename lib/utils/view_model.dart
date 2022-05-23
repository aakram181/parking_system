import 'package:parking_system/entities/car.dart';
import 'package:parking_system/entities/user.dart';
import 'package:parking_system/repository/auth_repo.dart';
import 'package:parking_system/repository/car_repo.dart';
import 'package:parking_system/repository/user_repo.dart';

class ViewModel {
  static Future<Map> getUser() async {
    var uID = AuthRepo.currentUid();
    var email = AuthRepo.currentEmail();
    String username = await UserRepo.getUsername(uID);
    return {"uID": uID, "email": email, "username": username};
  }

  static Future<bool> login(String email, String pwd) async {
    bool isSuccess = false;
    await AuthRepo.signIn(email, pwd).then((uID) {
      if (uID != null) {
        isSuccess = true;
      }
    });
    return isSuccess;
  }

  static void emailSignUp(String email, String password, String licensePlate,
      String username) async {
    await AuthRepo.signUp(email, password).then((uID) {
      if (uID != null) {
        Car car = Car(licensePlate: licensePlate, uID: uID);
        User user = User(uid: uID, email: email, username: username);
        CarRepo cRepo = CarRepo(car);
        cRepo.addCar();
        UserRepo.addUser(user);
      }
    });
  }

  static void updateInfo(String email,String password, String username) async {
    var uID = AuthRepo.currentUid();
    if (uID != null) {
        User user = User(uid: uID, email: email, username: username);
        UserRepo.UpdateUser(user);
        AuthRepo.changeEmail(email);
        AuthRepo.changePassword(password);
      }
  }

}
