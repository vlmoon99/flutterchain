import 'package:rxdart/subjects.dart';

class UserStore {
  final BehaviorSubject<String> walletIdStream = BehaviorSubject<String>()
    ..add('0');
}
