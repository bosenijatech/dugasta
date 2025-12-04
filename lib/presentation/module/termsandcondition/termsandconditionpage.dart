import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class Termsandconditionpage extends StatefulWidget {
  const Termsandconditionpage({super.key});

  @override
  State<Termsandconditionpage> createState() => _TermsandconditionpageState();
}

class _TermsandconditionpageState extends State<Termsandconditionpage> {
  var htmldata = "";
  @override
  void initState() {
    htmldata = r"""
<!DOCTYPE html>
<html>
	<head>
		<title>Codebeautify.org Text to HTML Converter</title>
	</head>
	<body>
		<p><b>Mobile App Terms & Conditionsare a legal agreement that users will agree to when using your app. </b><br><br/>
 
This is the Prelaunch app! <br><br/>
 
In this agreement, you'll be able to keep control over some aspects of the use of your app. <br/>
 
Note that a Terms and Conditions agreement is also known as a Terms of Use or Terms of Service. You may even see it called an End User Service Agreement (EUSA) but this isn't so common. 
 
When you make your mobile app available to the public, you're letting users interact with your app in a number of ways. <br><br/>
 
Some of these ways include: 
 <ul>
<li> Presenting users with your business branding and your own unique content </li>
 
<li> Letting users sign up for accounts and interact with others on your app </li>
 
<li> Generate their own content on or with your app </li>
 </ul>
When you have this relationship between your app and those who use it, you're going to want to have some sort of <b>control over the use of your app</b>. That's where your mobile app Terms & Conditions agreement comes in. 
 
You can include: 
 <ul>
<li>Rules users must adhere to  </li>
 
<li> Restrictions on the use of your app  </li>
 
<li> Other important guidelines  </li>
 </ul>
You can also <b> maintain your rights including the right to exclude abusive users from your app, ownership rights in your content and legal rights against liability.</b><br></br></br> 
 
Not only does a Terms & Conditions agreement come with benefits to you, but it can also benefit your mobile app users. The agreement lets them know what you expect from them, what rights they have, and practical information like how to send payments, cancel an account, etc.<br></br></br> 
 
Kindly note that this is prelaunch app, If you notice any discrepancies or mismatches in the amount or digit displayed, kindly reconfirm with SS Lootah Real Estate Management.</p>
	</body>
</html>
""";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Terms and Conditions',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: Html(data: htmldata),
            ),
          ],
        ));
  }
}
