





import 'dart:convert';

import 'package:dugasta/presentation/module/landingpage/landingscreen.dart';
import 'package:dugasta/presentation/util/app_colors.dart';
import 'package:flutter/material.dart';
import '../../../../data/api_service.dart';
import '../../../../domain/pref.dart';
import '../../../../widgets/custom_dropdown.dart';
import '../../../../widgets/custom_textfield.dart';
import '../../../model/sales_feedbackgetlevelmodel.dart';
import '../../../model/sales_feedbackgetsuggestionmodel.dart';
import '../../../model/sales_projectmodel.dart';
import '../../../model/sales_unitnumbermodel.dart';
import '../../../util/app_utils.dart';
import '../../../utils/custom_button.dart';
import '../../homepage/homepage.dart';

class Customerfeedbackform extends StatefulWidget {
  const Customerfeedbackform({super.key});

  @override
  State<Customerfeedbackform> createState() => _CustomerfeedbackformState();
}

class _CustomerfeedbackformState extends State<Customerfeedbackform> {
  // Controllers
  final TextEditingController serviceRatingController = TextEditingController();
  final TextEditingController experienceController = TextEditingController();
  final TextEditingController additionalController1 = TextEditingController();
  final TextEditingController additionalController2 = TextEditingController();
  final TextEditingController additionalController3 = TextEditingController();

  bool loading = false;
    String? selectedProject;
   Unitnumlist? selectedUnitnumber;
  ProjectList? selectedCompanyname;
int overall = 0;
int presentation = 0;
int efficiency = 0;
int responsiveness = 0;
int paperwork = 0;
int support = 0;
  
 List<Unitnumlist> Unitlist = [];
  List<String> UnitNames = [];
  List<ProjectList> projectlist = [];
  List<String> projectNames = [];
  int recommendationRating = -1;
  bool isChecked1 = false;
  bool isChecked2 = false;

  // API suggestion list
  FeedbackGetSuggestionModel? Feedbacksuggestion;
  List<SuggestionList> feedbacklist = [];


  String? selectedRecommendationId;

  @override
  void initState() {
    super.initState();
    getSuggestion();
      fetchunitnumber();
    
  }


  //getSuggestion
void getSuggestion() async {
  setState(() {
    loading = true;
  });

  try {
    final response = await Apiservice.getSuggestionlist();

    debugPrint("Response status: ${response.statusCode}");
    debugPrint("Response body: ${response.body}");

    setState(() {
      loading = false;
    });

    if (response.statusCode == 200) {
      if (response.body.startsWith("{")) { // naive JSON check
        final data = jsonDecode(response.body);

        if (data["success"] == true) {
          Feedbacksuggestion = FeedbackGetSuggestionModel.fromJson(data);
          feedbacklist = Feedbacksuggestion!.payload
              .map((e) => SuggestionList(
                  internalId: e.internalId, name: e.name))
              .toList();
        } else {
          throw Exception(data["message"] ?? "Something went wrong");
        }
      } else {
        throw Exception("API did not return JSON. Check version or endpoint.");
      }
    } else {
      throw Exception("Server error: ${response.statusCode}");
    }
  } catch (e) {
    setState(() => loading = false);
    debugPrint("getSuggestion() error: $e");
  }
}

  //getlevel
  Feedbackgetlevelmodel? feedbackLevel;
List<levellist> feedbackLevelList = [];

void getLevel() async {
  setState(() => loading = true);

  try {
    final response = await Apiservice.getLevellist();

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data["success"] == true) {
        feedbackLevelList = List<levellist>.from(
          data["payload"].map((x) => levellist.fromJson(x)),
        );

        // Initialize default star ratings (for example)
        setState(() {
          overall = levelToStars("Excellent");
          presentation = levelToStars("Good");
          efficiency = levelToStars("Average");
          responsiveness = levelToStars("Excellent");
          paperwork = levelToStars("Good");
          support = levelToStars("Average");
        });
      }
    }
  } catch (e) {
    debugPrint("getLevel() error: $e");
  } finally {
    setState(() => loading = false);
  }
}

int levelToStars(String? level) {
  switch (level) {
    case "Excellent":
      return 5;
    case "Good":
      return 4;
    case "Average":
      return 3;
    case "Poor":
      return 2;
    case "Very Poor":
      return 1;
    default:
      return 0;
  }
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
        loading = false;
      });

      print("📌 Unitlist updated: ${Unitlist.length}");
      print("📌 UnitNames updated: $UnitNames");
    } else {
      print("❌ API Failed or status=false");
      setState(() {
        loading = false;
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
void netsuiteFeedback() async {
  var body = {
    "customer": Prefs.getCustomerId("CustomerID").toString(),
    "unit": selectedUnitnumber?.value,
    "property": selectedCompanyname?.value,
    "overallExperience": overall,
    "pqRepresentation": presentation,
    "spEfficiency": efficiency,
    "communication": responsiveness,
    "documentation": paperwork,
    "postSale": support,
    "abExperience": additionalController1.text,
    "wcwImprove": additionalController2.text,
    "testimonial": additionalController3.text,
    "permission": isChecked1,
    "rocOthers": selectedRecommendationId,
    "rating": recommendationRating,
  };

  print(jsonEncode(body));

  setState(() {
    loading = true;
  });

  Apiservice.netsuiteFeedback(body).then((response) {
    setState(() {
      loading = false;
    });

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);

      if (json['status'].toString() == "true") {
        // 🔥 SUCCESS → SHOW POPUP → GO HOME
   showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text("Success"),
                  content: const Text("Feedback created successfully!"),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context); // Close popup
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LandingScreenPage()),
                          (route) => false,
                        );
                      },
                      child: const Text("OK"),
                    ),
                  ],
                );
                  },
            );
      } else {
        // ❌ FAILURE → only show popup, no navigation
        AppUtils.showSingleDialogPopup(
          context,
          json['message'].toString(),
          "Ok",
          () {
            Navigator.pop(context); // close popup only
          },
        );
      }
    } else {
      throw Exception("Server Error");
    }
  }).catchError((e) {
    setState(() {
      loading = false;
    });

    AppUtils.showSingleDialogPopup(
      context,
      e.toString(),
      "Ok",
      () => Navigator.pop(context),
    );
  });
}

  void exitpopup() {
    AppUtils.pop(context);
  }

  void onrefresh() {
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
  return true;}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.lightCream,
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        title: const Text("Customer Feedback",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Property & Transaction Details",
                    style: const TextStyle(
                        fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 24),
                      CustomDropdownWidget<Unitnumlist>(
              valArr: Unitlist,
              labelText: "Unit Name",
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
              labelText: "Property name",
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

                  const SizedBox(height: 12),
                  const Text(
                    "Your Experience",
                    style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Please rate the following aspects of your experience\n(1 = Poor, 5 = Excellent)",
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 12),
               buildRatingSection("Overall Experience", overall, (val) {
  setState(() => overall = val);
}),
buildRatingSection("Property Quality & Presentation", presentation, (val) {
  setState(() => presentation = val);
}),
buildRatingSection("Sales Process Efficiency", efficiency, (val) {
  setState(() => efficiency = val);
}),
buildRatingSection("Communication & Responsiveness", responsiveness, (val) {
  setState(() => responsiveness = val);
}),
buildRatingSection("Documentation & Paperwork", paperwork, (val) {
  setState(() => paperwork = val);
}),
buildRatingSection("Post-Sale Support", support, (val) {
  setState(() => support = val);
}),


     
 
  
                  const SizedBox(height: 24),
                  const Text(
                    "Tell Us More",
                    style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text('What did you like most about your experience?'),
                  const SizedBox(height: 16),
                  _buildTextField(additionalController1, 3),
                  const SizedBox(height: 24),
                  const Text('What could we improve?'),
                  const SizedBox(height: 16),
                  _buildTextField(additionalController2, 3),
                  const SizedBox(height: 24),
                  const Text('Would you like to provide a testimonial?'),
                  const SizedBox(height: 16),
                  _buildTextField(additionalController3, 3),
                  const SizedBox(height: 30),
                  buildCheckbox(
                      isChecked1,
                      'I give permission to use my feedback publicly for marketing purposes',
                      (val) {
                    setState(() {
                      isChecked1 = val;
                    });
                  }),
                  const SizedBox(height: 24),
                  const Text(
                    "Recommendations",
                    style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                      const SizedBox(height: 16),
                      const Text('Would you recommend our services to others?'),
              
                  const SizedBox(height: 12),
                  if (feedbacklist.isEmpty)
                    const Text("Loading options...")
                  else
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: feedbacklist.map((item) {
                        return RadioListTile<String>(
                          title: Text(item.name),
                          value: item.internalId,
                          groupValue: selectedRecommendationId,
                          fillColor: MaterialStateProperty.all(AppColor.accentColor),
                          onChanged: (val) {
                            setState(() {
                              selectedRecommendationId = val;
                            });
                          },
                        );
                      }).toList(),
                    ),
                  const SizedBox(height: 12),
                  const Text(
                    "Please rate the following aspects of your experience\n(1 = Poor, 5 = Excellent)",
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 12),
                  ratingBoxSelector(
                    selectedValue: recommendationRating,
                    onSelect: (value) {
                      setState(() {
                        recommendationRating = value;
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  Text(
                    recommendationRating == -1
                        ? "No rating selected"
                        : "Selected Rating: $recommendationRating",
                    style: const TextStyle(
                        fontSize: 14, color: AppColor.accentColor, fontWeight: FontWeight.w600),
                  ),
             
                  const SizedBox(height: 30),
              CustomButton(
  onPressed: isChecked1
      ? () {
          debugPrint("Recommendation Id: $selectedRecommendationId");

         
          if (!validateFields()) return;

          // 🔥 Call API only if valid
          netsuiteFeedback();
            Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LandingScreenPage()),
            (route) => false,
          );
        }
      : null,
  name: 'Submit',
  circularvalue: 10,
  isEnabled: isChecked1,
)


                ],
              ),
            ),
    );
  }

  Widget _buildTextField(
    dynamic arg1,
    dynamic arg2, [
    dynamic arg3,
    double? verticalMargin,
  ]) {
    String hint = "";
    String label = "";
    TextEditingController controller;
    int lines = 1;

    if (arg1 is String) {
      hint = arg1;
      label = arg1;
      controller = arg2;
      lines = arg3 ?? 1;
    } else {
      controller = arg1;
      lines = arg2 ?? 1;
    }

    return CustomRoundedTextField(
      control: controller,
      lines: lines,
      width: double.infinity,
      title: hint.isNotEmpty ? hint : null,
      labelText: label.isNotEmpty ? label : null,
      verticalMargin: verticalMargin ?? 14.0,
    );
  }

  Widget buildRatingSection(String title, int rating, Function(int) onSelect) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
          ),
          const SizedBox(height: 12),
          buildStarRating(
            currentRating: rating,
            
            onRatingSelected: onSelect,
            color: AppColor.accentColor,
            size: 40,
          ),
        ],
      ),
    );
  }



  Widget buildCheckbox(bool isChecked, String label, Function(bool) onChanged) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => onChanged(!isChecked),
          child: Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: isChecked ? AppColor.accentColor : Colors.transparent,
              border: Border.all(color: isChecked ? Colors.transparent : Colors.grey),
              borderRadius: BorderRadius.circular(4),
            ),
            child: isChecked
                ? const Icon(Icons.check, size: 20, color: Colors.white)
                : null,
          ),
        ),
        const SizedBox(width: 14),
        Expanded(child: Text(label, style: const TextStyle(fontSize: 14))),
      ],
    );
  }
}

Widget buildStarRating({
  required int currentRating,
  required Function(int) onRatingSelected,
  Color color = AppColor.accentColor,
  double size = 28,
}) {
  return Row(
    children: List.generate(5, (index) {
      return GestureDetector(
        // onTap: () => onRatingSelected(index + 1),
           onTap: () {
          int selected = index + 1;
          onRatingSelected(selected);
          debugPrint("⭐ Star Selected = $selected");
          // debugPrint("➡ internalId = ${ratingToInternalId[selected]}");
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: Row(
            children: [
              Icon(index < currentRating ? Icons.star : Icons.star_border,
                  color: color, size: size),
              const SizedBox(width: 20),
            ],
          ),
        ),
      );
    }),
  );
}

Widget ratingBoxSelector({
  required int selectedValue,
  required Function(int) onSelect,
}) {
  return Wrap(
    spacing: 8,
    runSpacing: 8,
    children: List.generate(11, (index) {
      bool isSelected = index == selectedValue;

      return InkWell(
        onTap: () => onSelect(index),
        child: Container(
          width: 40,
          height: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? AppColor.accentColor : Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isSelected ? AppColor.accentColor : Colors.grey.shade400,
              width: 1.5,
            ),
          ),
          child: Text(
            index.toString(),
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ),
      );
    }),
  );
}
