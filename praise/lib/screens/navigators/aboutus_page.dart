// ignore_for_file: camel_case_types, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:praise/utils/constants/constants.dart';
import 'package:praise/utils/funtions/common_functions.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({Key? key}) : super(key: key);

  @override
  _AboutUsPageState createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  var htmlData = r"""<html>
    <body>
        <h1 style="text-align: center; color: red">GLORY TO GOD</h1>
        <br>
        <br>
        <p>இந்த செயலியை உருவாக்கவும் உருவாக்கவும், வெளியிடவும், ஞானத்தையும், பெலனையும், 
            கிருபையையும் தந்த தேவனுக்கு ஸ்தோத்திரம். இந்த செயலியின் மூலம் நீங்கள் தேவனை துதித்து 
            நன்மை பெறுவீர்கள் என்று நம்பி தேவனை துதிக்கிறோம்.</p>
        <p>இந்த செயலியில் குறைவுகள் இருந்தால் <span><a href="mailto:smith@example.org?subject=News&body=New%20plugin">jesuschilds2022@gmail.com</a></span>
            என்ற mail id யில் தெரிவிக்கலாம். </p>
        <p>இன்னும் வேதத்தை தியானிப்பதற்கு ஏதுவாக வேதத்தின் விளக்கங்கள், கத்தோலிக்க மொழிபெயர்ப்பு வேதாகமம், 
            பொது மொழிபெயர்ப்பு வேதாகமம், ஆங்கில மொழிபெயர்ப்பு வேதாகமம், கடினமான சொற்களுக்குரிய விளக்கங்கள் 
            இவைகளை இணைத்து ஒரு செயலியாகவும், வேதாகம விளையாட்டுகள் என்று ஒரு செயலியையும் வெளியிட உள்ளோம்.
            அதற்கான வேலைகள் நடந்துக்கொண்டுள்ளது. 
            அதற்காக உங்கள் ஜெபத்தின் மூலமும், காணிக்கைகள் மூலமும் தாங்கும்படி அன்புடன் கேட்டுக்கொள்கிறோம்.</p>
        <p style="text-align: right; font-size: 20px; font-weight: 600; color: red;">By</p>
        <p style="text-align: right; font-size: 20px; font-weight: 800; color: green;">Jesus child’s</p>
    </body>

</html>""";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("About Us"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              const SizedBox(
                height: 25,
              ),
              Image.asset(
                'assets/images/jesuschildslogo.jpg',
                width: 150,
              ),
              HtmlWidget(
                htmlData,
                onTapUrl: (url) async {
                  CommonFunctions.makeEmail(StringUrls.supportEmail);
                  return true;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
