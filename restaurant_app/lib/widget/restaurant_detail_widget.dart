import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';

class DetailRestaurantWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<DetailRestaurantProvider>(
      builder: (context, state, _) {
        if(state.restaurantState == RestaurantState.Loading){
          return Center(child: CircularProgressIndicator(),);
        } else if(state.restaurantState == RestaurantState.HasData){
          return Material(
            child: NestedScrollView(
                headerSliverBuilder: (context, isScrolled) {
                  return [
                    SliverAppBar(
                      pinned: true,
                      expandedHeight: 200,
                      flexibleSpace: FlexibleSpaceBar(
                        background: Hero(
                          tag: Image.network('https://restaurant-api.dicoding.dev/images/large/${state.detailResto.restaurants.pictureId}'),
                          child: Image.network(
                            'https://restaurant-api.dicoding.dev/images/large/${state.detailResto.restaurants.pictureId}',
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ),
                    )
                  ];
                },
                body: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            state.detailResto.restaurants.name,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                          const SizedBox(height: 4.0,),
                          Row(
                            children: <Widget>[
                              const Icon(
                                Icons.location_on,
                                color: Colors.grey,
                              ),
                              Text(
                                state.detailResto.restaurants.city,
                                style: const TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8.0,),
                          Text(
                            state.detailResto.restaurants.description,
                            style: TextStyle(fontSize: 14),
                          ),
                          const Divider(color: Colors.grey,),

                        ],
                      ),
                    ),
                  ],
                ),
              ),
          );
        } else if(state.restaurantState == RestaurantState.NoData){
          return Center(child: Text(state.message));
        } else if(state.restaurantState == RestaurantState.Error){
          return Center(child: Text(state.message));
        } else {
          return Center(child: Text(''));
        }
      },
    );
  }
}