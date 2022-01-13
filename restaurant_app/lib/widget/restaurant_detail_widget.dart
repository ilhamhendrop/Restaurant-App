import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';

class DetailRestaurantWidget extends StatelessWidget {
  const DetailRestaurantWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DetailRestaurantProvider>(
      builder: (context, state, _) {
        if(state.restaurantState == RestaurantState.Loading){
          return const Center(child: CircularProgressIndicator(),);
        } else if(state.restaurantState == RestaurantState.HasData){
          var resto = state.detailResto.restaurants;
          return Material(
            child: NestedScrollView(
                headerSliverBuilder: (context, isScrolled) {
                  return [
                    SliverAppBar(
                      pinned: true,
                      expandedHeight: 200,
                      flexibleSpace: FlexibleSpaceBar(
                        background: Hero(
                          tag: Image.network('https://restaurant-api.dicoding.dev/images/large/${resto.pictureId}'),
                          child: Image.network(
                            'https://restaurant-api.dicoding.dev/images/large/${resto.pictureId}',
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
                            resto.name,
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
                                resto.address,
                                style: const TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8.0,),
                          Text(
                            resto.description,
                            style: const TextStyle(fontSize: 14),
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
          return const Center(child: Text(''));
        }
      },
    );
  }
}