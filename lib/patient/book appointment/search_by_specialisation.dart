import 'package:flutter/material.dart';
import 'package:ooadproject/patient/book%20appointment/doc_profile.dart';
import 'package:ooadproject/welcome.dart';

class search_spec extends StatelessWidget {
  search_spec(
      {super.key,
      required this.patient,
      required this.doc,
      required this.searchTerms});
  Patient patient;
  Doctor doc;
  List<Doctor> searchTerms;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 216, 240, 209),
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text(
          "Search doctor by specialisation",
          // style: TextStyle(fontSize: 15),
        ),
        actions: [
          IconButton(
            onPressed: () {
              // method to show the search bar
              showSearch(
                  context: context,
                  // delegate to customize the search bar
                  delegate: CustomSearchDelegate(
                      patient: patient, searchTerms: searchTerms));
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  CustomSearchDelegate(
      {Key? key, required this.patient, required this.searchTerms});
  // Doctor doc;
  Patient patient;
  List<Doctor> searchTerms;
  // Demo list to show querying

  // first overwrite to
  // clear the search text
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }

  // second overwrite to pop out of search menu
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  // third overwrite to show query result
  @override
  Widget buildResults(BuildContext context) {
    List<Doctor> matchQuery = [];
    for (var doc in searchTerms) {
      if (doc.Specialisation.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(doc);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        viewDocProfile(doc: result, patient: patient)));
          },
          leading: result.prfl,
          title:
              Text(result.name, style: const TextStyle(color: Colors.black87)),
          subtitle: Text(result.Specialisation),
        );
      },
    );
  }

  // last overwrite to show the
  // querying process at the runtime
  @override
  Widget buildSuggestions(BuildContext context) {
    List<Doctor> matchQuery = [];
    for (var doc in searchTerms) {
      if (doc.Specialisation.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(doc);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          tileColor: Color.fromARGB(255, 216, 240, 209),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        viewDocProfile(patient: patient, doc: result)));
          },
          leading: result.prfl,
          title:
              Text(result.name, style: const TextStyle(color: Colors.black87)),
          subtitle: Text(result.Specialisation),
        );
      },
    );
  }
}
