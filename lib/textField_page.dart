import 'package:flutter/material.dart';

class TextFieldInputDataShowRecipe extends StatefulWidget {
  const TextFieldInputDataShowRecipe({super.key});

  @override
  _TextFieldInputDataShowRecipeState createState() =>
      _TextFieldInputDataShowRecipeState();
}

class _TextFieldInputDataShowRecipeState
    extends State<TextFieldInputDataShowRecipe> {
  final TextEditingController cmntEdtContr = TextEditingController();
  final TextEditingController unitQtyEdtContr = TextEditingController();
  final TextEditingController refillEdtContr = TextEditingController();
  final TextEditingController expireEdtController = TextEditingController();
  final TextEditingController mfgAtEdtContr = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Commodity Entry Form'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFieldFormWidget(
                  labelText: 'Quantity',
                  edtTxtCntr: unitQtyEdtContr,
                ),
                TextFieldFormWidget(
                  labelText: 'Refill Date',
                  edtTxtCntr: refillEdtContr,
                ),
                TextFieldFormWidget(
                  labelText: 'MFG Date',
                  edtTxtCntr: mfgAtEdtContr,
                ),
                TextFieldFormWidget(
                  labelText: 'Expiration Date',
                  edtTxtCntr: expireEdtController,
                ),
                TextFieldFormWidget(
                  labelText: 'Comments',
                  edtTxtCntr: cmntEdtContr,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _showConfirmationDialog(context);
                    }
                  },
                  child: const Text('Review & Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 0),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(0.0))),
          title: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'রসিদ কপি',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          content: SizedBox(
            height: 450,
            width: MediaQuery.of(context).size.width * 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                _containerRow(
                    sizedBoxWidth: 0,
                    borderWidth: null,
                    titleOne: "কমোডিটির নাম",
                    subTitleOne: "আপন (বড়ি)",
                    titleTwo: '',
                    subTitleTwo: ''),
                _containerRow(
                    sizedBoxWidth: 65,
                    borderWidth: 0,
                    titleOne: "কমোডিটির পরিমান",
                    subTitleOne: unitQtyEdtContr.text,
                    titleTwo: "রিফিল তারিখ",
                    subTitleTwo: refillEdtContr.text),
                _containerRow(
                    sizedBoxWidth: 65,
                    borderWidth: 0,
                    titleOne: "মেয়াদ উত্তীর্ণ তারিখ",
                    subTitleOne: expireEdtController.text,
                    titleTwo: "উৎপাদন তারিখ",
                    subTitleTwo: mfgAtEdtContr.text),
                _containerRow(
                    sizedBoxWidth: 0,
                    borderWidth: null,
                    titleOne: "আপনার মন্তব্য",
                    subTitleOne: cmntEdtContr.text,
                    titleTwo: '',
                    subTitleTwo: ''),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Edit'),
            ),
            TextButton(
              onPressed: () {
                _submitData();
                Navigator.of(context).pop();
              },
              child: const Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  Widget _containerRow({
    String? titleOne,
    String? subTitleOne,
    String? titleTwo,
    String? subTitleTwo,
    double? borderWidth,
    double? sizedBoxWidth,
  }) {
    return Column(
      children: [
        Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titleOne!,
                  style: const TextStyle(fontSize: 15),
                ),
                Text(
                  subTitleOne!,
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(
              width: sizedBoxWidth,
            ),
            borderWidth != null
                ? Container(
                    width: borderWidth,
                    height: 30,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 0.5)),
                  )
                : Container(),
            SizedBox(
              width: sizedBoxWidth,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titleTwo!,
                  style: const TextStyle(fontSize: 15),
                ),
                Text(
                  subTitleTwo!,
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w900),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 25,
        ),
        Container(
          width: double.infinity,
          height: 1,
          decoration:
              BoxDecoration(border: Border.all(color: Colors.grey, width: 0.5)),
        ),
        const SizedBox(
          height: 25,
        ),
      ],
    );
  }

  void _submitData() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Form submitted successfully!'),
      ),
    );
    unitQtyEdtContr.clear();
    cmntEdtContr.clear();
    refillEdtContr.clear();
    expireEdtController.clear();
    mfgAtEdtContr.clear();
  }
}

class TextFieldFormWidget extends StatelessWidget {
  final String labelText;
  final TextEditingController edtTxtCntr;

  const TextFieldFormWidget({
    super.key,
    required this.labelText,
    required this.edtTxtCntr,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: edtTxtCntr,
        decoration: InputDecoration(
          labelText: labelText,
          border: const OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $labelText';
          }
          return null;
        },
      ),
    );
  }
}
