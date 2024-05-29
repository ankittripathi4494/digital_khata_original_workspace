// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';

class BusinessTypeScreen extends StatefulWidget {
   late Map<String, dynamic> argus;
  BusinessTypeScreen({super.key, required this.argus});

  @override
  State<BusinessTypeScreen> createState() => _BusinessTypeScreenState();
}

class _BusinessTypeScreenState extends State<BusinessTypeScreen> {
  List<Map<String, dynamic>> dataList = [];
  @override
  void initState() {
    super.initState();

    for (int i = 0; i < 10; i++) {
      dataList.add({"title": "Item $i", "isChecked": false});
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              size: 30,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
               Navigator.pushReplacementNamed(context, '/add-new-business');
             
            },
          ),
          title: const Text(
            'Business Type',
            style: TextStyle(color: Colors.white, fontSize: 25),
          ),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        style: const TextStyle(
                          color: Color.fromARGB(255, 31, 1, 102),
                        ),
                        cursorColor: const Color.fromARGB(255, 31, 1, 102),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 0.0),
                          hintText: 'Search or add new',
                          hintStyle: const TextStyle(color: Colors.grey),
                          prefixIcon: const Icon(
                            Icons.search,
                            size: 35,
                            color: Colors.grey,
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                color: Color.fromARGB(255, 31, 1, 102),
                              )),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                color: Color.fromARGB(255, 31, 1, 102),
                              )),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: screenSize.width * 0.01,
                    ),
                    Card(
                      color: const Color.fromARGB(255, 31, 1, 102),
                      // margin:
                      //     EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                      // padding:
                      //     EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
                      // decoration: BoxDecoration(color: Colors.blue),
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 45,
                      ),
                    )
                  ],
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: dataList.length,
                itemBuilder: (context, index) => CheckboxListTile(
                  value: dataList[index]["isChecked"],
                  onChanged: (value) {
                    setState(() {
                      dataList[index]["isChecked"] = value!;
                    });
                  },
                  title: Text(
                    dataList[index]["title"],
                    style: const TextStyle(color: Colors.black87, fontSize: 18),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 40.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    minimumSize: const Size(380, 60),
                    backgroundColor: const Color.fromARGB(255, 31, 1, 102),
                  ),
                  onPressed: () {
                     Navigator.pushNamed(context, '/add-new-business');
                  },
                  child: const Text(
                    'SAVE',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
