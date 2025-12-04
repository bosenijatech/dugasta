import 'package:dugasta/presentation/module/sales_app/servicerequest/salessevicerequest.dart';
import 'package:dugasta/presentation/util/app_colors.dart';
import 'package:flutter/material.dart';

class Thankyouscreen extends StatefulWidget {
  const Thankyouscreen({super.key});

  @override
  State<Thankyouscreen> createState() => _ThankyouscreenState();
}

class _ThankyouscreenState extends State<Thankyouscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: AppColor.lightCream,

     

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 90),

                    // ✔ Green Tick + Thank You
                    Column(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: const BoxDecoration(
                            color: Color(0xFF007605),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.check, color: Colors.white, size: 32),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          "Thank You",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const SizedBox(
                          width: 320,
                          child: Text(
                            "Your service request has been successfully submitted to our team.",
                            style: TextStyle(fontSize: 15, color: Colors.black),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 30),

                    // ✔ Details Card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.black54),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          // Left Labels
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Case Number",
                                  style: TextStyle(color: Colors.grey, fontSize: 14)),
                              SizedBox(height: 10),
                              Text("Date submitted",
                                  style: TextStyle(color: Colors.grey, fontSize: 14)),
                              SizedBox(height: 10),
                              Text("Subject",
                                  style: TextStyle(color: Colors.grey, fontSize: 14)),
                            ],
                          ),

                          // Right Values
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("22",
                                  style: TextStyle(
                                      fontSize: 14, fontWeight: FontWeight.w600)),
                              SizedBox(height: 10),
                              Text("14 Nov 2025",
                                  style: TextStyle(
                                      fontSize: 14, fontWeight: FontWeight.w600)),
                              SizedBox(height: 10),
                              Text("Test",
                                  style: TextStyle(
                                      fontSize: 14, fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 25),

                    // ✔ Footer Text
                    const SizedBox(
                      width: 320,
                      child: Text(
                        "A confirmation email has been sent to your registered email id. Our support team will review your request & respond shortly.",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),

            // ✔ Bottom Button
            GestureDetector(
              onTap: () {
            Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(
    builder: (context) => SalesSevicerequest(),
  ),
  (route) => false, // remove all previous routes
);

              },
              child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: AppColor.accentColor,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    )
                  ],
                ),
                child: const Center(
                  child: Text(
                    "Submit Another Case",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
