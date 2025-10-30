import 'package:fluttertoast/fluttertoast.dart';
import 'package:toastification/toastification.dart';

enum ToastType {
  info(ToastificationType.info),
  warning(ToastificationType.warning),
  error(ToastificationType.error),
  success(ToastificationType.success);

  const ToastType(this.value);
  final ToastificationType value;
}

void showCustomToast(msg, {color}) {
  Fluttertoast.showToast(
    msg: "$msg",
    backgroundColor: color,
    timeInSecForIosWeb: 1,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    webPosition: "center",
    webBgColor: "linear-gradient(to right, #dc1c13, #dc1c13)",
  );
}
