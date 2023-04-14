class Routes {
  static final _Auth auth = _Auth();
  static final _Home home = _Home();
}

class _Auth extends RouteClass {
  @override
  String module = '/auth';
  String login = '/login';
  String intro = '/';
}

class _Home extends RouteClass {
  @override
  String module = '/home';
  String startPage = '/';
  String sendTransaction = '/sendTransaction';
  String callSmartContractFunction = '/callSmartContractFunction';
  String actions = '/actions';
}

abstract class RouteClass {
  String module = '/';

  String getRoute(String moduleRoute) => module + moduleRoute;

  String getModule() => '$module/';
}
