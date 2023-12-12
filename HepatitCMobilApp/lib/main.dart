import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Hepatit C Mobile App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final items=['Male','Female'];

  DropdownMenuItem<String> buildMenuItem(String item)=>DropdownMenuItem(
    value: item,
    child: Text(item),
  );
  String? value="Male";
  String? data = 'sonuç burada gösterilecek';

  var _formkey = GlobalKey<FormState>();
  TextEditingController _ALT_MAPController = TextEditingController();
  TextEditingController _AST_MAPController = TextEditingController();
  TextEditingController _ALP_MAPController = TextEditingController();
  TextEditingController _ALB_MAPController = TextEditingController();
  TextEditingController _BIL_MAPController = TextEditingController();
  TextEditingController _PROT_MAPController = TextEditingController();
  TextEditingController _GGT_MAPController = TextEditingController();
  TextEditingController _CREA_MAPController = TextEditingController();
  TextEditingController _CHOL_MAPController = TextEditingController();
  TextEditingController _CHE_MAPController = TextEditingController(); // Yeni kutucuk eklendi

  @override
  void initState() {
    super.initState();
  }
  getData() async {
    double alt_int=double.parse(_ALT_MAPController.text);
    double ast_int=double.parse(_AST_MAPController.text);
    double alp_int=double.parse(_ALP_MAPController.text);
    double alb_int=double.parse(_ALB_MAPController.text);
    double bil_int=double.parse(_BIL_MAPController.text);
    double prot_int=double.parse(_PROT_MAPController.text);
    double ggt_int=double.parse(_GGT_MAPController.text);
    double crea_int=double.parse(_CREA_MAPController.text);
    double chol_int=double.parse(_CHOL_MAPController.text);
    double che_int=double.parse(_CHE_MAPController.text);

    int alt=0,ast=0,alp=0,alb=0,bil=0,prot=0,ggt=0,crea=0,chol=0,che=0;
    if(alt_int>56)
      alt=1;
    if(alt_int<=56 && alt_int>=7)
      alt=0;
    if(alt_int<7)
      alt=1;

    if(ast_int>40)
      ast=1;
    if(ast_int<=40 && ast_int>=10)
      ast=0;
    if(ast_int<10)
      ast=1;

    if(alp_int>147)
      alp=1;
    if(alp_int<=147 && alp_int>=44)
      alp=0;
    if(alp_int<44)
      alp=1;

    if(alb_int>52)
      alb=1;
    if(alb_int<=52 && alb_int>=35)
      alb=0;
    if(alb_int<35)
      alb=1;

    if(bil_int>20.5)
      bil=1;
    if(bil_int<=20.5 && bil_int>=3.4)
      bil=0;
    if(bil_int<3.4)
      bil=1;

    if(prot_int>80)
      prot=1;
    if(prot_int<=80 && prot_int>=60)
      prot=0;
    if(prot_int<60)
      prot=1;

    if(ggt_int>48 && value=='Male')
      ggt=1;
    if(ggt_int<=48 && ggt_int>=9 && value=='Male')
      ggt=0;
    if(ggt_int<9 && value=='Male')
      ggt=1;
    if(ggt_int>32 && value=='Female')
      ggt=1;
    if(ggt_int<=32 && ggt_int>=9 && value=='Female')
      ggt=0;
    if(ggt_int<9 && value=='Female')
      ggt=1;

    if(crea_int<106 && value=='Male')
      crea=1;
    if(crea_int<=106 && crea_int>=53 && value=='Male')
      crea=0;
    if(crea_int<53 &&value=='Male')
      crea=1;
    if(crea_int>97 && value=='Female')
      crea=1;
    if(crea_int<=97 && crea_int>=44 && value=='Female')
      crea=0;
    if(crea_int<44 && value=='Female')
      crea=1;

    if(chol_int>5.2)
      chol=1;
    else
      chol=0;

    if(che_int>12)
      che=1;
    if(che_int<=12 && che_int>=5)
      che=0;
    if(che_int<5)
      che=1;


    var uri = Uri.parse('http://10.0.2.2:5000/tahmin');
    var response = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, int>{
        'ALT_MAP': alt,
        'AST_MAP':ast,
        'ALP_MAP': alp,
        'ALB_MAP': alb,
        'BIL_MAP': bil,
        'PROT_MAP': prot,
        'GGT_MAP': ggt,
        'CREA_MAP': crea,
        'CHOL_MAP':chol,
        'CHE_MAP': che, // Yeni kutucuktan alınan veri
      }),
    );

    var result = response.body.toString();
    var sonuc = int.parse(result);
    if (sonuc == 0) {
      data = 'Normal';
    } else if(sonuc==1) {
      data = 'Cirrhosis';
    } else if(sonuc==2){
      data='Fibrosis';
    } else {
      data='Hepatitis';
    }
    setState(() {
      data = data;
    });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(24),
          child: Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                    controller: _ALT_MAPController,
                    decoration: const InputDecoration(
                        labelText: 'ALT_MAP', border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'ALT_MAP değeri boş geçilemez!';
                      }
                      return null;
                    }),
                const SizedBox(height: 15),
                TextFormField(
                    controller: _AST_MAPController,
                    decoration: const InputDecoration(
                        labelText: 'AST_MAP', border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'AST_MAP değeri boş geçilemez!';
                      }
                      return null;
                    }),
                const SizedBox(height: 15),
                TextFormField(
                    controller: _ALP_MAPController,
                    decoration: const InputDecoration(
                        labelText: 'ALP_MAP', border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'ALP_MAP değeri boş geçilemez!';
                      }
                      return null;
                    }),
                const SizedBox(height: 15),
                TextFormField(
                    controller: _ALB_MAPController,
                    decoration: const InputDecoration(
                        labelText: 'ALB_MAP', border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'ALB_MAP değeri boş geçilemez!';
                      }
                      return null;
                    }),
                const SizedBox(height: 15),
                TextFormField(
                    controller: _BIL_MAPController,
                    decoration: const InputDecoration(
                        labelText: 'BIL_MAP', border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'BIL_MAP değeri boş geçilemez!';
                      }
                      return null;
                    }),
                const SizedBox(height: 15),
                TextFormField(
                    controller: _PROT_MAPController,
                    decoration: const InputDecoration(
                        labelText: 'PROT_MAP', border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'PROT_MAP değeri boş geçilemez!';
                      }
                      return null;
                    }),
                const SizedBox(height: 15),
                TextFormField(
                    controller: _GGT_MAPController,
                    decoration: const InputDecoration(
                        labelText: 'GGT_MAP', border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'GGT_MAP değeri boş geçilemez!';
                      }
                      return null;
                    }),
                const SizedBox(height: 15),
                TextFormField(
                    controller: _CREA_MAPController,
                    decoration: const InputDecoration(
                        labelText: 'CREA_MAP', border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'CREA_MAP değeri boş geçilemez!';
                      }
                      return null;
                    }),
                const SizedBox(height: 15),
                TextFormField(
                    controller: _CHOL_MAPController,
                    decoration: const InputDecoration(
                        labelText: 'CHOL_MAP', border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'CHOL_MAP değeri boş geçilemez!';
                      }
                      return null;
                    }),
                const SizedBox(height: 15),
                TextFormField(
                    controller: _CHE_MAPController,
                    decoration: const InputDecoration(
                        labelText: 'CHE_MAP', border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'CHE_MAP değeri boş geçilemez!';
                      }
                      return null;
                    }),
                const SizedBox(height: 15),
                DropdownButton<String>(
                    value: value,
                    iconSize: 36,
                    icon: Icon(Icons.arrow_drop_down,color:Colors.black),
                    isExpanded: true,
                    items: items.map(buildMenuItem).toList(), onChanged: (value)=>setState(()=>this.value=value)),
                const SizedBox(height: 15),
                ElevatedButton(
                  onPressed: () {
                    bool? isValid = _formkey.currentState?.validate();
                    if (isValid == true)
                      getData();
                    else
                      return null;
                  },
                  child: const Text('Gönder'),
                ),
                Text(
                  data.toString(),
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 255, 0, 0)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
