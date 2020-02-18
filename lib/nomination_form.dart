import 'package:flutter/material.dart';
import 'main.dart';
import 'buttons.dart';


class NominationForm extends StatefulWidget {
  final String pageName;

  NominationForm({
    Key key,
    this.pageName,
  }): super(key: key);

  @override
  _NominationFormState createState() => _NominationFormState();
}

class _NominationFormState extends State<NominationForm> {
  final TextStyle labelTextSize = TextStyle(fontSize: 18);
  double _inputHeight = 50;
  final TextEditingController _textEditingController_1 = TextEditingController();
  final TextEditingController _textEditingController_2 = TextEditingController();
  final FocusNode _focusNode_1 = FocusNode();
  final FocusNode _focusNode_2 = FocusNode();
  String newName,
  newDescription = "";
  String localName,
  localDescription;
  bool showDescription;
  int nameLength,
  descriptionLength = 0;

  @override
  void initState(){
    super.initState();
    String globalName = nomineeNames[widget.pageName+'Name'];
    String globalDescription = nomineeDescription[widget.pageName+'Description'];

    nameLength = globalName.toString().length;
    if (nameLength>0) {
      newName = globalName.toString();
    } else{
      newName = "";
    }

    if(globalName==null){
      _textEditingController_2.text = "";
      showDescription = false;
    }else if(globalName.toString().length!=0){
      _textEditingController_2.text = globalName.toString();
      showDescription = true;
    }else{
      showDescription = false;
    }

    if(globalDescription==null){
      _textEditingController_1.text = "";
    }else{
      _textEditingController_1.text = globalDescription.toString();
    }
    _focusNode_2.addListener(_checkForEnteredName);
    _focusNode_1.addListener(_checkForEnteredDescription);

    _textEditingController_1.addListener(_checkInputHeight);
  }

  @override
  void dispose(){
    _textEditingController_1.dispose();
    _textEditingController_2.dispose();
    _focusNode_1.dispose();
    _focusNode_2.dispose();
    super.dispose();
  }

  void _checkForEnteredName(){
    setState(() {
      nameLength = _textEditingController_2.text.length;
      newName = _textEditingController_2.text;
      nomineeNames[widget.pageName+'Name'] = newName;
      showDescription = nameLength>0?true:false;
      // print(globalName);
    });
  }

  void _checkForEnteredDescription(){
    setState(() {
      newDescription = _textEditingController_1.text;
      nomineeDescription[widget.pageName+'Description'] = newDescription;
      // print(globalName);
    });
  }
  void _checkInputHeight(){
    int count = _textEditingController_1.text.split('\n').length;

    if (count == 0 && _inputHeight == 50.0) {
      return;
    }
    if (count <= 5) {  // use a maximum height of 6 rows 
    // height values can be adapted based on the font size
      var newHeight = count == 0 ? 50.0 : 28.0 + (count * 18.0);
      setState(() {
        _inputHeight = newHeight;
        // print(_inputHeight);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // print(newName);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(widget.pageName),
      ),
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(24),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: _textEditingController_2,
                    focusNode: _focusNode_2,
                    // initialValue: null,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide()
                      ),
                      // contentPadding: EdgeInsets.only(top: 50, bottom: -20, left: 12, right: 16),
                      hintText: 'Employee Name',
                      labelText: 'Deserving Nominee',
                      labelStyle: labelTextSize,
                      fillColor: Colors.white,
                    ),
                  ),
                  Container(
                    // opacity: showDescription,
                    child: showDescription?
                      Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 24.0, bottom: 8),
                          child: Text(
                            "Why do you think "+newName+" is a "+widget.pageName+"?",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                        TextField(
                          controller: _textEditingController_1,
                          focusNode: _focusNode_1,
                          textInputAction: TextInputAction.newline,
                          keyboardType: TextInputType.multiline,
                          maxLines: 10,
                          style: TextStyle(
                            fontSize: 18,
                          ),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(),
                            ),
                            hintText: 'Long descriptive answer',
                            fillColor: Colors.white,
                          ),
                        ),
                      ],
                    ): null,
                  ),
                ],
              ),
            ),
          ),
          Container(
            child: showDescription?
              Padding(
              padding: EdgeInsets.only(
                bottom: 80,
                // top: screenHeight - 200,
              ),
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: RectangularButton(buttonName: "Nominate",),
              ),
            ): null,
          )
        ],
      ),
    );
  }
}
