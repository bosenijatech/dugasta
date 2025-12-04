import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../../data/api_service.dart';
import '../../../../domain/pref.dart';
import '../../../../widgets/custom_dropdown.dart';
import '../../../../widgets/custom_textfield.dart';
import '../../../model/sales_categorymodel.dart';
import '../../../model/sales_projectmodel.dart';
import '../../../model/sales_subcategorymodel.dart';
import '../../../model/sales_typecasemodel.dart';
import '../../../model/sales_typemodel.dart';
import '../../../model/sales_unitnumbermodel.dart';
import '../../../util/app_colors.dart';
import '../../../util/app_utils.dart';
import '../../../utils/custom_button.dart';
import 'thankyouscreen.dart';

class Addservicerequest extends StatefulWidget {
  const Addservicerequest({super.key});

  @override
  State<Addservicerequest> createState() => _AddservicerequestState();
}

class _AddservicerequestState extends State<Addservicerequest> {
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController companynameController = TextEditingController();
  final TextEditingController mailController = TextEditingController();
  final TextEditingController subjectController = TextEditingController();
  final TextEditingController messageController = TextEditingController();
  bool isLoading = true;

  String? selectedProject;
  Unitnumlist? selectedUnitnumber;
  ProjectList? selectedCompanyname;
  typecaselist? selectedCasetype;
  Categorylist? selectedCategory;
  Subcategorylist? selectedSubCategory;
  Typelist? selectedPriority;

  List<Categorylist> categoryList = [];
  List<String> categoryNames = [];
  List<Subcategorylist> subcategoryList = [];
  List<String> subcategoryNames = [];
  List<Typelist> typelist = [];
  List<String> typeNames = [];
  List<typecaselist> Typecaselist = [];
  List<String> typecaseNames = [];
  List<Unitnumlist> Unitlist = [];
  List<String> UnitNames = [];
  List<ProjectList> projectlist = [];
  List<String> projectNames = [];

  @override
  void initState() {
    super.initState();
    fetchcategory();
    fetchtypecase();
    fetchtype();
    fetchunitnumber();
    companynameController.text =
      Prefs.getcompanyName("companyName")!;
    mailController.text =
      Prefs.getEmail("Email")!;
    mobileController.text =
      Prefs.getMobileNo("MobileNo")!;
  }

//category
  Future<void> fetchcategory() async {
    print("📌 Fetching categories...");

    final result = await Apiservice.mobileappgetcategory();

    print("📥 API Result Received: $result");

    if (result != null && result.success) {
      print("✅ API Success: ${result.message}");
      print("🔹 Total Categories: ${result.payload.length}");

      // Print each category
      for (var item in result.payload) {
        print("➡ ID: ${item.internalId} | Name: ${item.name}");
      }

      setState(() {
        categoryList = result.payload;
        categoryNames = result.payload.map((e) => e.name).toList();
        isLoading = false;
      });

      print("📌 categoryList updated: ${categoryList.length}");
      print("📌 categoryNames updated: $categoryNames");
    } else {
      print("❌ API Failed or Returned Null");
      setState(() {
        isLoading = false;
      });
    }

    print("🏁 Fetch category completed.\n");
  }

//sub category
  Future<void> fetchSubCategory() async {
    if (selectedCategory == null) {
      print("❌ Select category first!");
      return;
    }

    print("📌 Fetching subcategories for ID ${selectedCategory!.internalId}");

    final result = await Apiservice.getSubCategory(
      selectedCategory!.internalId.toString(),
    );

    if (result != null && result.success) {
      setState(() {
        subcategoryList = result.payload;
        subcategoryNames = result.payload.map((e) => e.name ?? "").toList();
      });

      print("✅ Subcategories Loaded: ${subcategoryList.length}");
    } else {
      print("❌ Subcategory API Failed");
    }
  }

//type
  Future<void> fetchtype() async {
    print("📌 Fetching type...");

    final result = await Apiservice.gettype();

    print("📥 API Result Received: $result");

    if (result != null && result.status) {
      print("✅ API Success: ${result.message}");
      print("🔹 Total type: ${result.payload.length}");

      for (var item in result.payload) {
        print("➡ ID: ${item.internalId} | Name: ${item.name}");
      }

      setState(() {
        typelist = result.payload;
        typeNames = result.payload.map((e) => e.name ?? "").toList();
        isLoading = false;
      });

      print("📌 typeList updated: ${typelist.length}");
      print("📌 typeNames updated: $typeNames");
    } else {
      print("❌ API Failed or status=false");
      setState(() {
        isLoading = false;
      });
    }

    print("🏁 Fetch type completed.\n");
  }

//typecase

  Future<void> fetchtypecase() async {
    print("📌 Fetching type...");

    final result = await Apiservice.gettypecase();

    print("📥 API Result Received: $result");

    if (result != null && result.success) {
      print("✅ API Success: ${result.message}");
      print("🔹 Total type: ${result.payload.length}");

      for (var item in result.payload) {
        print("➡ ID: ${item.internalId} | Name: ${item.name}");
      }

      setState(() {
        Typecaselist = result.payload;
        typecaseNames = result.payload.map((e) => e.name ?? "").toList();
        isLoading = false;
      });

      print("📌 Typecaselist updated: ${Typecaselist.length}");
      print("📌 typecaseNames updated: $typecaseNames");
    } else {
      print("❌ API Failed or status=false");
      setState(() {
        isLoading = false;
      });
    }

    print("🏁 Fetch type completed.\n");
  }

//unitnumber

  Future<void> fetchunitnumber() async {
    print("📌 Fetching type...");

    final result = await Apiservice.getunitnum();

    print("📥 API Result Received: $result");

    if (result != null && result.success) {
      print("✅ API Success: ${result.message}");
      print("🔹 Total type: ${result.payload.length}");

      for (var item in result.payload) {
        print("➡ ID: ${item.value} | Name: ${item.text}");
      }

      setState(() {
        Unitlist = result.payload;
        UnitNames = result.payload.map((e) => e.text ?? "").toList();
        isLoading = false;
      });

      print("📌 Unitlist updated: ${Unitlist.length}");
      print("📌 UnitNames updated: $UnitNames");
    } else {
      print("❌ API Failed or status=false");
      setState(() {
        isLoading = false;
      });
    }

    print("🏁 Fetch type completed.\n");
  }

//

//Project
Future<void> fetchProject() async {
  if (selectedUnitnumber == null) {
    print("❌ Select Unit Number first!");
    return;
  }

  print("📌 Fetching Project for Unit ID ${selectedUnitnumber!.value}");

  final result = await Apiservice.getProject(
    selectedUnitnumber!.value.toString(),
  );

  if (result != null && result.success) {
    setState(() {
      projectlist = result.payload;
      projectNames = result.payload.map((e) => e.text ?? "").toList();
    });

    print("✅ Project Loaded: ${projectlist.length}");
  } else {
    print("❌ Project API Failed");
  }
}


//netsuiteform
Future<Map<String, dynamic>> submitServiceRequest() async {
  // 1️⃣ Prepare JSON dynamically from current field values
  final requestBody = {
    "subject": subjectController.text,
    "company": companynameController,
    "email": mailController.text,
    "phone": mobileController.text,
    "priority": selectedPriority?.internalId ,
    "unit": selectedUnitnumber?.value ,
    "project": selectedCompanyname?.value ,
    "category": selectedCategory?.internalId ,
    "subcategory": selectedSubCategory?.internalId ,
    "type": selectedCasetype?.internalId,
    "message": messageController.text,
  };

  try {
    final response = await Apiservice.netsuitepostcaseForm(requestBody);

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      return decoded; // Returns the parsed JSON
    } else {
      return {
        "success": false,
        "message": "Failed with status ${response.statusCode}"
      };
    }
  } catch (e) {
    return {"success": false, "message": "Exception: $e"};
  }
}




  void exitpopup() {
    AppUtils.pop(context);
  }
  
bool validateFields() {
  if (selectedUnitnumber == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Please select Unit Number")),
    );
    return false;
  }
  if (selectedCompanyname == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Please select Project")),
    );
    return false;
  }
  if (companynameController.text.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Company Name is required")),
    );
    return false;
  }
  if (mobileController.text.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Mobile Number is required")),
    );
    return false;
  }
  if (mailController.text.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Email is required")),
    );
    return false;
  }
  if (subjectController.text.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Subject is required")),
    );
    return false;
  }
  if (selectedCasetype == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Please select Case Type")),
    );
    return false;
  }
  if (selectedCategory == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Please select Category")),
    );
    return false;
  }
  if (selectedSubCategory == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Please select Subcategory")),
    );
    return false;
  }
  if (selectedPriority == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Please select Priority")),
    );
    return false;
  }
  if (messageController.text.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Message is required")),
    );
    return false;
  }

  return true; // All fields are filled
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        title: const Text(
          "Create Service Request",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),

            CustomDropdownWidget<Unitnumlist>(
              valArr: Unitlist,
              labelText: "Unit Number",
              selectedItem: selectedUnitnumber,
              labelField: (item) => item.text ?? "",
              onChanged: (value) async {
                setState(() {
                  selectedUnitnumber = value;
                  selectedProject = null;
                  projectlist.clear();
                });

                await fetchProject();
              },
            ),
            SizedBox(
              height: 24,
            ),

            CustomDropdownWidget<ProjectList>(
              valArr: projectlist,
              labelText: "Project",
              selectedItem: selectedCompanyname,
              labelField: (item) => item.text ?? "",
              onChanged: (value) {
                setState(() {
                  selectedCompanyname = value;
                });
              },
            ),
            SizedBox(
              height: 24,
            ),

           CustomRoundedTextField(
              width: double.infinity,
              control: companynameController,
              labelText: "Company Name",
              readOnly: true,
            ),
            SizedBox(
              height: 24,
            ),
            CustomRoundedTextField(
              width: double.infinity,
              control: mobileController,
              labelText: "Mobile Number",
               readOnly: true,
            ),
            SizedBox(
              height: 24,
            ),
            CustomRoundedTextField(
              width: double.infinity,
              control: mailController,
              labelText: "Email",
               readOnly: true,
            ),
            SizedBox(
              height: 24,
            ),
            CustomRoundedTextField(
              width: double.infinity,
              control: subjectController,
              labelText: "Subject",
            ),

            const SizedBox(height: 24),

            CustomDropdownWidget<typecaselist>(
              valArr: Typecaselist,
              labelText: "Case Type",
              selectedItem: selectedCasetype,
              onChanged: (value) {
                setState(() {
                  selectedCasetype = value;
                });
              },
              labelField: (item) => item.name ?? "", // <-- FIXED
            ),

            SizedBox(
              height: 24,
            ),

            CustomDropdownWidget<Categorylist>(
              valArr: categoryList,
              labelText: "Category",
              selectedItem: selectedCategory,
              labelField: (item) => item.name ?? "",
              onChanged: (value) async {
                setState(() {
                  selectedCategory = value;
                  selectedSubCategory = null;
                  subcategoryList.clear();
                });

                await fetchSubCategory();
              },
            ),

            SizedBox(
              height: 24,
            ),

            CustomDropdownWidget<Subcategorylist>(
              valArr: subcategoryList,
              labelText: "Sub Category",
              selectedItem: selectedSubCategory,
              labelField: (item) => item.name ?? "",
              onChanged: (value) {
                setState(() {
                  selectedSubCategory = value;
                });
              },
            ),

            const SizedBox(height: 24),
            CustomDropdownWidget<Typelist>(
              valArr: typelist,
              labelText: "Priority",
              selectedItem: selectedPriority,
              onChanged: (value) {
                setState(() {
                  selectedPriority = value;
                });
              },
              labelField: (item) => item.name ?? "", // <-- FIXED
            ),

            const SizedBox(height: 24),

            CustomRoundedTextField(
              width: double.infinity,
              control: messageController,
              labelText: "Message",
              verticalMargin: 16,
              lines: 4,
            ),

            const SizedBox(height: 30),

            // -------------------- SUBMIT BUTTON --------------------
            CustomButton(
              name: "Submit",
              circularvalue: 10,
              fontSize: 16,
              height: 50,
             onPressed: () async {
    if (!validateFields()) return; // 🔥 Stops if any field is empty

    setState(() => isLoading = true);

    final result = await submitServiceRequest();

    setState(() => isLoading = false);

    if (result["success"] == true) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Thankyouscreen()),
      );
      print("✅ Case created: ${result["caseId"]}");
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result["message"] ?? "Something went wrong")),
      );
    }}
            ),
          ],
        ),
      ),
    );
  }
}
