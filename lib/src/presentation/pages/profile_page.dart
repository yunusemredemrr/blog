// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, curly_braces_in_flow_control_structures, no_logic_in_create_state

import 'dart:async';
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

  Completer<GoogleMapController> _controller = Completer();
  final ImagePicker _picker = ImagePicker();
  XFile? _profilPhoto;

  @override
  Widget build(BuildContext context) {
    AccountViewModel _accountViewModel = Provider.of<AccountViewModel>(context);
    double _latitude = _accountViewModel.latitude!;
    double _longitude = _accountViewModel.longitude!;

    final CameraPosition _kGooglePlex = CameraPosition(
      target: LatLng(_latitude, _longitude),
      zoom: 14.4746,
    );
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

                                          _profilPhoto = null;
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
                                  child:
                                      _accountViewModel.account!.data!.image !=
                                              null
                                          ? Image.network(_accountViewModel
                                              .account!.data!.image
                                              .toString())
                                          : Image.asset(
                                              "assets/images/no_profile.png"),
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
                          _controller.complete(controller);
                        },
                      ),
                    ),
                    SizedBox(height: 25),
                    DefaultButton(
                      width: 359,
                      height: 57,
                      buttonPressed: () {},
                      buttonText: "Save",
                      butonColor: kBackGroundColor,
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
}
