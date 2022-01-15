import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';

class SearchWidget extends StatefulWidget {
  @override
  State<SearchWidget> createState() => _SeacrhWidgetState();
}

class _SeacrhWidgetState extends State<SearchWidget> {
  String queries = '';
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchRestaurantProvider>(
      builder: (context, state, _) {
        return ListTile(
          leading: const Icon(
            Icons.search,
            size: 30,
          ),
          title: TextField(
            controller: _controller,
            onChanged: (String query) {
              if(query.isNotEmpty){
                setState(() {
                  queries = query;
                });
                state.feacthSearchRestaurant(query);
              }
            },
            cursorColor: Colors.black,
            decoration: const InputDecoration(
              hintText: 'Cari Resto',
              border: InputBorder.none,
            ),
          ),
          trailing: IconButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onPressed: () {
              if (queries.isNotEmpty) {
                _controller.clear();
                setState(() {
                  queries = '';
                });
              }
            },
            icon: const Icon(
              Icons.close,
              size: 30,
            ),
          ),
        );
      },
    );
  }
}