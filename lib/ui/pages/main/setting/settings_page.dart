import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:oifyoo_mksr/core/core.dart';
import 'package:oifyoo_mksr/di/di.dart';
import 'package:oifyoo_mksr/ui/resources/resources.dart';
import 'package:oifyoo_mksr/ui/widgets/widgets.dart';
import 'package:oifyoo_mksr/utils/utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

///*********************************************
/// Created by Mudassir (ukietux) on 1/10/21 with ♥
/// (>’_’)> email : hey.mudassir@gmail.com
/// github : https://www.github.com/ukieTux <(’_’<)
///*********************************************
/// © 2021 | All Right Reserved
class SettingsPage extends StatefulWidget {
  SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String _backupPath = "";

  @override
  void initState() {
    super.initState();

    _prepareData();
  }

  @override
  Widget build(BuildContext context) {
    return Parent(
      appBar: context.appBar(title: Strings.settings),
      child: Column(
        children: [
          CardView(
              margin: EdgeInsets.symmetric(vertical: context.dp8()),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.backup,
                        color: Palette.colorPrimary,
                      ),
                      SizedBox(width: context.dp8()),
                      Text(
                        Strings.backup,
                        style: TextStyles.textBold
                            .copyWith(fontSize: Dimens.fontLarge),
                      )
                    ],
                  ),
                  SizedBox(height: context.dp8()),
                  Text(
                    "${Strings.backupDesc} $_backupPath",
                    style: TextStyles.text.copyWith(fontSize: Dimens.fontSmall),
                  )
                ],
              ).padding(edgeInsets: EdgeInsets.all(context.dp16())),
              onTap: () {
                _backupDb();
              }),
          CardView(
              margin: EdgeInsets.symmetric(vertical: context.dp8()),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.restore,
                        color: Palette.colorPrimary,
                      ),
                      SizedBox(width: context.dp8()),
                      Text(
                        Strings.restore,
                        style: TextStyles.textBold
                            .copyWith(fontSize: Dimens.fontLarge),
                      )
                    ],
                  ),
                  SizedBox(height: context.dp8()),
                  Text(
                    Strings.restoreDesc,
                    style: TextStyles.text.copyWith(fontSize: Dimens.fontSmall),
                  )
                ],
              ).padding(edgeInsets: EdgeInsets.all(context.dp16())),
              onTap: () {
                _restoreDb();
              })
        ],
      ),
    );
  }

  _prepareData() async {
    await _checkPermission();

    _backupPath = (await _findLocalPath());

    final savedDir = Directory(_backupPath);
    bool hasExisted = await savedDir.exists();
    logs("backup folder is Exist ? $hasExisted");
    if (!hasExisted) {
      savedDir.create();
    }
    setState(() {});
  }

  Future<bool> _checkPermission() async {
    if (Platform.isAndroid) {
      final status = await Permission.storage.status;
      if (status != PermissionStatus.granted) {
        final result = await Permission.storage.request();
        if (result == PermissionStatus.granted) {
          return true;
        }
      } else {
        return true;
      }
    } else {
      return true;
    }
    return false;
  }

  _restoreDb() async {
    try {
      FilePickerResult? _result =
          await FilePicker.platform.pickFiles(allowMultiple: false);
      logs("result pick ${_result?.paths[0]}");
      File _restoreFile = File(_result?.paths[0] ?? "");

      await _restoreFile.copy(sl<PrefManager>().getDbPath() ?? "");
      logs(
          "Copy file from ${_restoreFile.path} to ${sl<PrefManager>().getDbPath()}");

      await sl<DbHelper>().initDb();
      Strings.successRestoreData.toToastSuccess();
    } catch (e) {
      e.toString().toToastError();
      logs("Error Restore : $e");
    }
  }

  _backupDb() async {
    try {
      File _db = File(sl<PrefManager>().getDbPath() ?? "");
      await _db.copy(_backupPath + Strings.dbName??"");
      Strings.successBackupData.toToastSuccess();
    } catch (e) {
      e.toString().toToastError();
      logs("error $e");
    }
  }

  Future<String> _findLocalPath() async {
    final directory = await getApplicationDocumentsDirectory();
    return Platform.isAndroid
        ? "/storage/emulated/0/${Strings.appName.replaceAll(" ", "_")}/"
        : directory.path;
  }
}
