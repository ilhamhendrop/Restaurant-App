import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/db/database_helper.dart';
import 'package:restaurant_app/provider/database_provider.dart';
import 'package:restaurant_app/widget/list_widget.dart';

class FavoritPage extends StatelessWidget {
  static const routeName = '/favorit';

  const FavoritPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorit'),
      ),
      body: SafeArea(
        child: Consumer<DatabaseProvider>(
          builder: (context, state, _){
            if(state.state == RestaurantState.hasData){
              return ListView.builder(
                shrinkWrap: true,
                itemCount: state.favorit.length,
                itemBuilder: (context, index){
                  var favorit = state.favorit[index];
                  return ListWidget(restaurant: favorit);
                },
              );
            } else {
              return Center(
                child: Text(state.message),
              );
            }
          },
        ),
      )
    );
  }
}