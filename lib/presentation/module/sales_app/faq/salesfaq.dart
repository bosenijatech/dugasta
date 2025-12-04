


import 'package:flutter/material.dart';
import '../../../../data/api_service.dart';
import '../../../model/sales_faqmodel.dart';
import '../../../util/app_colors.dart';

class SalesFaqPage extends StatefulWidget {
  const SalesFaqPage({super.key});

  @override
  State<SalesFaqPage> createState() => _SalesFaqPageState();
}

class _SalesFaqPageState extends State<SalesFaqPage> {
  bool isLoading = true;
  List<SlaesFaqList> faqList = [];

  @override
  void initState() {
    super.initState();
    fetchFaqs();
  }

  Future<void> fetchFaqs() async {
    final result = await Apiservice.getSaleFaq();
    if (result != null && result.status) {
      setState(() {
        faqList = result.message;
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.lightCream,
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        title: const Text(
          "Sales FAQs",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
      ),

      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : faqList.isEmpty
              ? const Center(child: Text("No FAQs available"))
              : ListView.builder(
                  itemCount: faqList.length,
                  itemBuilder: (context, index) {
                    final faq = faqList[index];

                    return Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),

                      child: Theme(
                        data: Theme.of(context).copyWith(
                          dividerColor: Colors.transparent,
                        ),

                        child: Card(
                          elevation: 0.5,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),

                          child: ExpansionTile(
                            tilePadding: const EdgeInsets.symmetric(horizontal: 16),
                            collapsedIconColor: Colors.black87,
                            iconColor: AppColor.primary,
                            childrenPadding: EdgeInsets.zero,

                            // -----------------------------------------
                            // ✅ ONLY TICK BEFORE HEADING (NO RIGHT ICON)
                            // -----------------------------------------
                            title: Row(
                              children: [
                                Icon(
                                  faq.active == Active.Y
                                      ? Icons.check_circle
                                      : Icons.cancel,
                                  size: 18,
                                  color: faq.active == Active.Y
                                      ? Colors.green
                                      : Colors.red,
                                ),
                                const SizedBox(width: 10),

                                Expanded(
                                  child: Text(
                                    faq.name.toString(),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            // -----------------------------------------

                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 12),
                                child: Text(
                                  faq.ans.toString(),
                                  style: const TextStyle(
                                    fontSize: 14,
                                    height: 1.4,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
