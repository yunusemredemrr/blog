// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, curly_braces_in_flow_control_structures, no_logic_in_create_state, unrelated_type_equality_checks, avoid_print

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:blog/src/application/view_model/account_view_model.dart';
import 'package:blog/src/application/view_model/user_view_model.dart';
import 'package:blog/src/constants/constants.dart';
import 'package:blog/src/domain/model/user.dart';
import 'package:blog/src/domain/types/enums/banner_type.dart';
import 'package:blog/src/presentation/widgets/custom_bottom_sheet.dart';
import 'package:blog/src/presentation/widgets/default_app_bar.dart';
import 'package:blog/src/presentation/widgets/default_button.dart';
import 'package:blog/src/presentation/widgets/custom_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  final User _user;
  const ProfilePage(this._user, {Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState(_user);
}

class _ProfilePageState extends State<ProfilePage> {
  final User _user;
  _ProfilePageState(this._user);

  late GoogleMapController _controller;
  final ImagePicker _picker = ImagePicker();
  XFile? _profilPhoto;

  @override
  Widget build(BuildContext context) {
    AccountViewModel _accountViewModel = Provider.of<AccountViewModel>(context);
    Future.delayed(Duration(milliseconds: 500));
    final CameraPosition _kGooglePlex = CameraPosition(
      target: LatLng(_accountViewModel.latitude!, _accountViewModel.longitude!),
      zoom: 14,
    );

    LatLng _lastMapPosition = _kGooglePlex.target;
    final Set<Marker> _createMarker = {
      // ignore: prefer_collection_literals
      Marker(
        markerId: MarkerId("MyLocation"),
        position: _lastMapPosition,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        infoWindow: InfoWindow(title: "Your Location"),
      ),
    };

    void _cameraMove(CameraPosition position) {
      _lastMapPosition = position.target;
    }

    void _onTap(LatLng argument) {
      Provider.of<AccountViewModel>(context, listen: false)
          .setLatLng(argument.latitude, argument.longitude);
    }

    BuildContext thisContext = context;
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus &&
              currentFocus.focusedChild != null) {
            currentFocus.focusedChild!.unfocus();
          }
        },
        child: Column(
          children: [
            DefaultAppBar(
              leadingOnPressed: () {},
              actionOnPressed: () {},
              backgroundColor: kBackGroundColor,
              titleColor: kButtonColor,
              title: "My Profile",
            ),
            SizedBox(height: 32),
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(
                      width: 357,
                      height: 179,
                      child: Center(
                        child: GestureDetector(
                          onTap: () async {
                            CustomAlertDialog(
                              title: "Select a Pitcure",
                              cameraButtonText: "Camera",
                              galleryButtonText: "Gallery",
                              cameraButtonOnTap: () {
                                _takePhotoFromCamera();
                              },
                              galleryButtonOnTap: () {
                                _chosePhotoFromGallery();
                              },
                            ).show(context).then((value) {
                              showBottomSheet(
                                context: context,
                                builder: (context) => ChangeNotifierProvider(
                                  create: (context) => AccountViewModel(
                                      _user.data!.token.toString()),
                                  child: CustomButtomSheet(
                                    photo: _profilPhoto,
                                    removeButtonPressed: () {
                                      _profilPhoto = null;
                                      Navigator.pop(context);
                                    },
                                    selectButtonPressed: () async {
                                      if (_profilPhoto != null) {
                                        try {
                                          String message = await Provider.of<
                                                      AccountViewModel>(
                                                  thisContext,
                                                  listen: false)
                                              .uploadImage(
                                                  _profilPhoto!.path, context);

                                          Navigator.pop(context);
                                          kShowBanner(BannerType.SUCCESS,
                                              message, context);
                                        } catch (e) {
                                          kShowBanner(BannerType.ERROR,
                                              "Photo failed to load", context);
                                        }
                                      }
                                    },
                                  ),
                                ),
                              );
                            });
                          },
                          child: Stack(
                            children: [
                              SizedBox(
                                width: 176,
                                height: 178,
                                child: ClipOval(
                                  child: _profilPhoto != null
                                      ? Image.file(
                                          File(_profilPhoto!.path),
                                          fit: BoxFit.fill,
                                        )
                                      : _accountViewModel
                                                  .account!.data!.image !=
                                              null
                                          ? Image.network(
                                              _accountViewModel
                                                  .account!.data!.image
                                                  .toString(),
                                              fit: BoxFit.fill,
                                            )
                                          : Image.asset(
                                              "assets/images/no_profile.png",
                                              fit: BoxFit.fill,
                                            ),
                                ),
                              ),
                              Positioned(
                                right: 24,
                                bottom: 24,
                                child: Icon(
                                  Icons.camera_alt,
                                  color: kButtonColor,
                                  size: 30,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 25),
                    Container(
                      width: 357,
                      height: 179,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: GoogleMap(
                        mapType: MapType.normal,
                        initialCameraPosition: _kGooglePlex,
                        onMapCreated: (GoogleMapController controller) {
                          _controller = controller;
                        },
                        markers: _createMarker,
                        onCameraMove: _cameraMove,
                        onTap: _onTap,
                      ),
                    ),
                    SizedBox(height: 25),
                    DefaultButton(
                      width: 359,
                      height: 57,
                      buttonPressed: () {
                        try {
                          _save(_accountViewModel, context);
                          kShowBanner(BannerType.SUCCESS,
                              "Your Information Has Been Updated", context);
                        } catch (e) {
                          kShowBanner(BannerType.ERROR, e.toString(), context);
                        }
                      },
                      buttonText: "Save",
                      butonColor: kBackGroundColor,
                      icon: Icon(Icons.logout),
                    ),
                    SizedBox(height: 3),
                    DefaultButton(
                      width: 359,
                      height: 57,
                      buttonPressed: () {
                        Provider.of<UserViewModel>(context, listen: false)
                            .logOut(context);
                      },
                      buttonText: "Log Out",
                      textColor: kWhite,
                      icon: Icon(
                        Icons.logout,
                        color: kBackGroundColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  image(AccountViewModel _accountViewModel) {
    if (_accountViewModel.account!.data!.image != null)
      return AssetImage("assets/images/no_profile.png");
    else
      NetworkImage(_accountViewModel.account!.data!.image.toString());
  }

  void _takePhotoFromCamera() async {
    XFile? newPhoto = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      _profilPhoto = newPhoto;
      Navigator.of(context).pop();
    });
  }

  void _chosePhotoFromGallery() async {
    XFile? newPhoto = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _profilPhoto = newPhoto;
      Navigator.of(context).pop();
    });
  }

  void _save(AccountViewModel accountViewModel, BuildContext context) {
    try {
      if (accountViewModel.account!.data!.image != null) {
        if (accountViewModel.imageUrl != null) {
          if (accountViewModel.account!.data!.image !=
              accountViewModel.imageUrl) {
            String _body = jsonEncode({
              "Image": accountViewModel.imageUrl,
              "Location": {
                "Longtitude": "29.2049583",
                "Latitude": "41.200622",
              }
            });
            Provider.of<AccountViewModel>(context, listen: false)
                .updateAccount(_body);
            _updateCameraPosition(accountViewModel);
          } else {
            String _body = jsonEncode({
              "Image": accountViewModel.account!.data!.image,
              "Location": {
                "Longtitude": "${accountViewModel.longitude}",
                "Latitude": "${accountViewModel.latitude}"
              }
            });
            Provider.of<AccountViewModel>(context, listen: false)
                .updateAccount(_body);
            _updateCameraPosition(accountViewModel);
          }
        } else {
          String _body = jsonEncode({
            "Image": accountViewModel.account!.data!.image,
            "Location": {
              "Longtitude": "${accountViewModel.longitude}",
              "Latitude": "${accountViewModel.latitude}"
            }
          });
          Provider.of<AccountViewModel>(context, listen: false)
              .updateAccount(_body);
          _updateCameraPosition(accountViewModel);
        }
      } else {
        String _body = jsonEncode({
          "Image": accountViewModel.imageUrl,
          "Location": {
            "Longtitude": "${accountViewModel.longitude}",
            "Latitude": "${accountViewModel.latitude}"
          }
        });
        Provider.of<AccountViewModel>(context, listen: false)
            .updateAccount(_body);
        _updateCameraPosition(accountViewModel);
      }
    } catch (e) {
      print(e);
    } finally {
      _updateCameraPosition(accountViewModel);
    }
  }

  _updateCameraPosition(AccountViewModel accountViewModel) {
    Future.delayed(Duration(seconds: 2), () {
      _controller.moveCamera(
        CameraUpdate.newLatLng(
          LatLng(
            accountViewModel.latitude!,
            accountViewModel.longitude!,
          ),
        ),
      );
    });
  }
}
