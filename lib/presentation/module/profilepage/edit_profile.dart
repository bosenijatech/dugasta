import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dugasta/data/api_service.dart';
import 'package:dugasta/domain/pref.dart';
import 'package:dugasta/presentation/model/profilemodel.dart';
import 'package:dugasta/presentation/util/app_colors.dart';
import 'package:dugasta/presentation/util/app_utils.dart';
import 'package:dugasta/presentation/util/appcontants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;

class EditProfilePage extends StatefulWidget {
  ProfileModel model;
  EditProfilePage({super.key, required this.model});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  bool showPassword = true;
  final formKey = GlobalKey<FormState>();
  TextEditingController txtfirstname = TextEditingController();
  TextEditingController txtlastname = TextEditingController();
  TextEditingController txtemilid = TextEditingController();
  TextEditingController txtcountrycode = TextEditingController();
  TextEditingController txtmobilenumber = TextEditingController();
  TextEditingController txtusername = TextEditingController();
  TextEditingController txtpassword = TextEditingController();
  TextEditingController txtpassportnumber = TextEditingController();
  TextEditingController txtpassportexpdate = TextEditingController();
  TextEditingController txtemiratesnumber = TextEditingController();
  TextEditingController txtemiratesdate = TextEditingController();

  TextEditingController txtsubemiratesdate = TextEditingController();
  TextEditingController txtsubpassportdate = TextEditingController();
  TextEditingController txturlimage = TextEditingController();
  bool loading = false;
  File? selectedGalleryImage;
  List<String> files = [];
  String filepath = "";
  @override
  void initState() {
    if (widget.model.message != null) {
      setState(() {
        txtfirstname.text = widget.model.message!.tenantFirstname.toString();
        txtlastname.text = widget.model.message!.tenantLastname.toString();
        txtemilid.text = widget.model.message!.tenantEmail.toString();
        txtcountrycode.text = "";
        txtmobilenumber.text = widget.model.message!.tenantMobileno.toString();
        txtusername.text = widget.model.message!.tenantUsername.toString();
        txtpassword.text = widget.model.message!.tenantPassword.toString();
        txtpassportnumber.text =
            widget.model.message!.tenantPassportno.toString();
        txtsubpassportdate.text =
            widget.model.message!.tenantPassportexpdate.toString();

        txtpassportexpdate.text =
            widget.model.message!.tenantPassportexpdate.toString();

        txtemiratesnumber.text =
            widget.model.message!.tenantEmirtesid.toString();

        txtemiratesdate.text =
            widget.model.message!.tenantEmirtesexpdate.toString();
        txtsubemiratesdate.text =
            widget.model.message!.tenantEmirtesexpdate.toString();
        if (widget.model.message!.tenantimgurl.toString() != "") {
        } else {
          files.add(AppConstants.liveurl +
              widget.model.message!.tenantimgurl.toString());
          filepath = widget.model.message!.tenantimgurl.toString();
          txturlimage.text = widget.model.message!.tenantimgurl.toString();
        }
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    txtfirstname.clear();
    txtlastname.clear();
    txtemilid.clear();
    txtcountrycode.clear();
    txtmobilenumber.clear();
    txtusername.clear();
    txtpassword.clear();
    txtpassportnumber.clear();
    txtpassportexpdate.clear();
    txtemiratesnumber.clear();
    txtemiratesdate.clear();
    txtsubpassportdate.dispose();
    txtsubemiratesdate.dispose();
    txturlimage.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppUtils.buildNormalText(
            text: 'Edit Profile', fontSize: 20, color: Colors.white),
      ),
      body: !loading
          ? SingleChildScrollView(
              child: Column(
                children: [
                  profilephotos(),
                  editprofilebuild(),
                ],
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
      persistentFooterButtons: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MaterialButton(
              padding: EdgeInsets.symmetric(horizontal: 50),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              onPressed: () {},
              child: Text("CANCEL",
                  style: TextStyle(
                      fontSize: 14, letterSpacing: 2.2, color: Colors.black)),
            ),
            MaterialButton(
              onPressed: () {
                onSave();
              },
              color: AppColor.primaryColor,
              padding: EdgeInsets.symmetric(horizontal: 50),
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Text(
                "SAVE",
                style: TextStyle(
                    fontSize: 14, letterSpacing: 2.2, color: Colors.white),
              ),
            )
          ],
        )
      ],
    );
  }

  Widget profilephotos() {
    return SizedBox(
      height: 210,
      child: Center(
        child: ListView(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              decoration: const BoxDecoration(),
              child: Column(
                children: [
                  (widget.model.message!.tenantimgurl!.isNotEmpty)
                      ? InkWell(
                          onTap: () async {
                            Map<Permission, PermissionStatus> statuses = await [
                              Permission.camera,
                            ].request();
                            statuses.values.forEach((element) async {
                              if (element.isDenied ||
                                  element.isPermanentlyDenied) {
                                await openAppSettings();
                              }
                            });

                            AppUtils.showBottomCupertinoDialog(context,
                                title: "Choose any one option",
                                btn1function: () async {
                              AppUtils.pop(context);
                              _pickImageFromCamera();
                            }, btn2function: () {
                              AppUtils.pop(context);
                              _pickImageFromGallery();
                            });
                          },
                          child: SizedBox(
                            width: 100,
                            height: 100,
                            child: CachedNetworkImage(
                              imageUrl: AppConstants.liveurl +
                                  txturlimage.text.toString(),
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: Image.asset(
                                      'assets/icons/plus.png',
                                      width: 30,
                                      height: 30,
                                    )),
                              ),
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                        )
                      : InkWell(
                          onTap: () async {
                            Map<Permission, PermissionStatus> statuses = await [
                              Permission.camera,
                            ].request();
                            statuses.values.forEach((element) async {
                              if (element.isDenied ||
                                  element.isPermanentlyDenied) {
                                await openAppSettings();
                              }
                            });
                            AppUtils.showBottomCupertinoDialog(context,
                                title: "Choose any one option",
                                btn1function: () async {
                              AppUtils.pop(context);
                              // getImageFromCamera();
                              _pickImageFromCamera();
                            }, btn2function: () {
                              AppUtils.pop(context);
                              // pickFiles();
                              _pickImageFromGallery();
                            });
                          },
                          child: Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              //color: Colors.white,
                              image: const DecorationImage(
                                image: AssetImage('assets/images/user.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future _pickImageFromGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    // if (selectedGalleryImage == null) return;
    setState(() {
      files.clear();
      selectedGalleryImage = File(returnedImage!.path);
      files.add(selectedGalleryImage!.path);
      txturlimage.text = selectedGalleryImage!.path;
      print(selectedGalleryImage);
    });
  }

  Future _pickImageFromCamera() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    //if (selectedGalleryImage == null) return;
    setState(() {
      files.clear();
      selectedGalleryImage = File(returnedImage!.path);
      files.add(selectedGalleryImage!.path);
      print(selectedGalleryImage);
      txturlimage.text = selectedGalleryImage!.path;
    });
  }

  Widget editprofilebuild() {
    return Form(
      key: formKey,
      child: Column(children: [
        Padding(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: Column(children: [
              TextFormField(
                controller: txtfirstname,
                decoration: const InputDecoration(
                    labelText: 'First Name', icon: Icon(CupertinoIcons.person)),
                validator: (value) =>
                    value!.isNotEmpty ? null : "First Name Is Empty",
              ),
              TextFormField(
                controller: txtlastname,
                decoration: const InputDecoration(
                    labelText: 'Last Name', icon: Icon(CupertinoIcons.person)),
                validator: (value) =>
                    value!.isNotEmpty ? null : "Last Name Is Empty",
              ),
              TextFormField(
                controller: txtemilid,
                readOnly: true,
                decoration: const InputDecoration(
                    labelText: 'Email', icon: Icon(CupertinoIcons.mail)),
                validator: (value) =>
                    value!.isNotEmpty ? null : "Email Is Empty",
              ),
              TextFormField(
                controller: txtcountrycode,
                readOnly: true,
                decoration: const InputDecoration(
                    labelText: 'Country Code',
                    icon: Icon(CupertinoIcons.list_number_rtl)),
              ),
              TextFormField(
                controller: txtmobilenumber,
                readOnly: true,
                decoration: const InputDecoration(
                    labelText: 'Mobile Number',
                    icon: Icon(CupertinoIcons.phone)),
              ),
              TextFormField(
                controller: txtusername,
                readOnly: true,
                decoration: const InputDecoration(
                    labelText: 'User Name', icon: Icon(CupertinoIcons.person)),
              ),
              Visibility(
                visible: false,
                child: TextFormField(
                  obscureText: showPassword,
                  controller: txtpassword,
                  readOnly: false,
                  decoration: InputDecoration(
                      labelText: 'User Password',
                      icon: Icon(CupertinoIcons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(showPassword
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          setState(
                            () {
                              showPassword = !showPassword;
                            },
                          );
                        },
                      )),
                ),
              ),
              TextFormField(
                controller: txtpassportnumber,
                decoration: const InputDecoration(
                    labelText: 'Passport Number',
                    icon: Icon(CupertinoIcons.creditcard)),
                validator: (value) =>
                    value!.isNotEmpty ? null : "Passport Number is Empty",
              ),
              TextFormField(
                controller: txtpassportexpdate,
                readOnly: true,
                onTap: () {
                  pickerdate(txtpassportexpdate);
                },
                decoration: const InputDecoration(
                    labelText: 'Passport ExpDate',
                    icon: Icon(CupertinoIcons.calendar)),
                validator: (value) =>
                    value!.isNotEmpty ? null : "Passport Exp Date is Empty",
              ),
              TextFormField(
                controller: txtemiratesnumber,
                decoration: const InputDecoration(
                    labelText: 'Emirates Number',
                    icon: Icon(CupertinoIcons.creditcard)),
                validator: (value) =>
                    value!.isNotEmpty ? null : "Emirates Number is Empty",
              ),
              TextFormField(
                readOnly: true,
                onTap: () {
                  pickerdate(txtemiratesdate);
                },
                controller: txtemiratesdate,
                decoration: const InputDecoration(
                    labelText: 'Emirates Exp Date',
                    icon: Icon(CupertinoIcons.calendar)),
                validator: (value) =>
                    value!.isNotEmpty ? null : "Emirates Exp Date is Empty",
              )
            ]))
      ]),
    );
  }

  onSave() {
    final isValid = formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    formKey.currentState!.save();
    if (selectedGalleryImage == null) {
      updateprofiledata();
    } else {
      uploadimages();
    }
  }

  void pickerdate(controller) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(), //.subtract(Duration(days: 1)),
        lastDate: DateTime(2100));

    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);

      var dateFormate =
          DateFormat("dd/MM/yyyy").format(DateTime.parse(formattedDate));
      if (controller == txtpassportexpdate) {
        txtsubpassportdate.text = formattedDate;
      } else {
        txtsubemiratesdate.text = formattedDate;
      }

      controller.text = dateFormate;
    }
  }

  Future uploadimages() async {
    setState(() {
      loading = true;
    });
    Uri url;
    url = Uri.parse(AppConstants.liveurl + AppConstants.uploadimage);

    var request = http.MultipartRequest('POST', url);
    for (int i = 0; i < files.length; i++) {
      request.files.add(await http.MultipartFile.fromPath('files', files[i]));
    }

    http.StreamedResponse response = await request.send();
    response.stream.transform(utf8.decoder).listen((value) {
      setState(() {
        loading = false;
      });
      if (response.statusCode == 200) {
        var imagename2 = "";
        List<dynamic> list = json.decode(value);
        imagename2 = list[0]["filename"];
        filepath = list[0]["path"];
        txturlimage.text = list[0]["path"];
        print(filepath);
        updateprofiledata();
      }
    });
    setState(() {
      loading = false;
    });
  }

  void updateprofiledata() async {
    var data = {
      "firstname": txtfirstname.text.toString(),
      "tenant_lastname": txtlastname.text.toString(),
      "tenant_passportno": txtpassportnumber.text.toString(),
      "tenant_passportexpdate": txtsubpassportdate.text.toString(),
      "tenant_emirtesid": txtemiratesnumber.text.toString(),
      "tenant_emirtesexpdate": txtsubemiratesdate.text.toString(),
      "tenantimgurl": txturlimage.text,
      "tenant_id": Prefs.getTenentID("UserID"),
    };
    setState(() {
      loading = true;
    });
    Apiservice.updateprofilepage(data).then((response) {
      setState(() {
        loading = false;
      });
      if (response.statusCode == 200) {
        if (jsonDecode(response.body)['status'].toString() == "true") {
          AppUtils.showSingleDialogPopup(context,
              jsonDecode(response.body)['message'].toString(), "Ok", onrefresh);
        } else {
          AppUtils.showSingleDialogPopup(context,
              jsonDecode(response.body)['message'].toString(), "Ok", exitpopup);
        }
        //return response;
      } else {
        throw Exception(jsonDecode(response.body)['message'].toString());
      }
    }).catchError((e) {
      setState(() {
        loading = false;
      });
      AppUtils.showSingleDialogPopup(context, e.toString(), "Ok", exitpopup);
    });
  }

  void exitpopup() {
    Navigator.of(context).pop();
  }

  void onrefresh() {
    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }
}
