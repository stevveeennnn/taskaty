import 'package:flutter/material.dart';
import 'package:ftoast/ftoast.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:todo_app/utils/app_str.dart';

String lottieUrl = 'assets/lottie/1.json';

dynamic emptyWarning(BuildContext context) {
  return FToast.toast(
    context,
    msg: AppStr.oopsMsg,
    subMsg: 'You must submit all the fields!',
    corner: 20.0,
    duration: 2000,
    padding: const EdgeInsets.all(20),
  );
}

dynamic updateTaskWarning(BuildContext context) {
  return FToast.toast(
    context,
    msg: AppStr.oopsMsg,
    subMsg: 'You must edit the tasks before updating them.',
    corner: 20.0,
    duration: 5000,
    padding: const EdgeInsets.all(20),
  );
}

dynamic noTaskWarning(BuildContext context) {
  return PanaraInfoDialog.showAnimatedGrow(
    context,
    title: AppStr.oopsMsg,
    message: 'There\'re no tasks to delete!\nTry adding some to delete.',
    buttonText: 'ok',
    onTapDismiss: () {
      Navigator.pop(context);
    },
    panaraDialogType: PanaraDialogType.error,
  );
}

dynamic deleteAllTasks(BuildContext context) {
  return PanaraConfirmDialog.show(
    context,
    title: AppStr.areYouSure,
    message: 'All tasks will be deleted, you can\'t undo this.',
    confirmButtonText: 'Delete',
    cancelButtonText: 'Cancel',
    onTapConfirm: () {
      // BaseWidget.of(context).dataStore.box.clear();
      Navigator.pop(context);
    },
    onTapCancel: () {
      Navigator.pop(context);
    },
    panaraDialogType: PanaraDialogType.error,
    barrierDismissible: false,
  );
}
