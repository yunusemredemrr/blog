// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:blog/src/domain/model/account.dart';
import 'package:blog/src/domain/model/image_model.dart';
import 'package:blog/src/domain/types/enums/account_view_state.dart';
import 'package:blog/src/domain/usecases/get_account.dart';
import 'package:blog/src/domain/usecases/get_location.dart';
import 'package:blog/src/domain/usecases/update_account.dart';
import 'package:blog/src/domain/usecases/upload_image.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../locator.dart';
import '../../domain/model/update.dart';

class AccountViewModel extends ChangeNotifier {
  AccountViewState _accountViewState = AccountViewState.Idle;
  String token;
  Position? _currentPosition;
  double? longitude, latitude;
  String? imageUrl;

  Account? account;

  AccountViewState get accountViewState => _accountViewState;
  Position? get currentPosition => _currentPosition;

  set accountViewState(AccountViewState value) {
    _accountViewState = value;
    notifyListeners();
  }

  AccountViewModel(this.token) {
    _accountViewState = AccountViewState.Idle;
    getAccount();
  }

  setLatLng(double lat, double lng) {
    longitude = lng;
    latitude = lat;
    notifyListeners();
  }

  getAccount() async {
    try {
      accountViewState = AccountViewState.Bussy;
      Account _currentAccount =
          await locator.get<GetAccount>().getAccount(token);
      if (!_currentAccount.hasError!) {
        account = _currentAccount;
      }
    } catch (e) {
      print(e);
    } finally {
      getLocation();
      accountViewState = AccountViewState.Loaded;
    }
  }

  Future<String> uploadImage(String imagePath, BuildContext context) async {
    try {
      accountViewState = AccountViewState.Bussy;
      ImageModel _currentImage =
          await locator.get<UploadImage>().uploadImage(token, imagePath);
      if (!_currentImage.hasError!) {
        imageUrl = _currentImage.data;
        print(_currentImage.data);
      }
      return _currentImage.message!;
    } catch (e) {
      print(e);
      rethrow;
    } finally {
      accountViewState = AccountViewState.Loaded;
    }
  }

  getLocation() async {
    try {
      accountViewState = AccountViewState.Bussy;
      if (account != null) {
        if (account!.data!.location != null) {
          longitude = double.parse(account!.data!.location!.longtitude!);
          latitude = double.parse(account!.data!.location!.latitude!);
        } else {
          bool isDenied = await Permission.location.isDenied;
          if (!isDenied) {
            _currentPosition =
                await locator.get<GetLocation>().getCurrentLocation();
            longitude = _currentPosition!.longitude;
            latitude = _currentPosition!.latitude;
            String body = jsonEncode(
              {
                "Location": {
                  "Longtitude": "$longitude",
                  "Latitude": "$latitude",
                }
              },
            );
            updateAccount(body);
          } else {
            longitude = 29.0280933;
            latitude = 41.049495;
          }
        }
      } else {
        bool isDenied = await Permission.location.isDenied;
        if (!isDenied) {
          _currentPosition =
              await locator.get<GetLocation>().getCurrentLocation();
          longitude = _currentPosition!.longitude;
          latitude = _currentPosition!.latitude;
        } else {
          longitude = 29.0280933;
          latitude = 41.049495;
        }
      }
    } catch (e) {
      print(e);
    } finally {
      accountViewState = AccountViewState.Loaded;
    }
  }

  updateAccount(body) async {
    try {
      accountViewState = AccountViewState.Bussy;
      Update _curentUpdate = await locator.get<UpdateAccount>().updateAccount(
            token,
            body,
          );
      print(_curentUpdate.message);
    } catch (e) {
      print(e);
    } finally {
      getAccount();
      accountViewState = AccountViewState.Loaded;
    }
  }
}
