
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/model/search_restaurant.dart';
import 'package:restaurant_app/page/detail_page.dart';
import 'package:restaurant_app/page/home_page.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/service/api_service.dart';


class SearchPage extends StatefulWidget {
  static const routeName = '/search';

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String queries = '';
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body:Column(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => const HomePage()),
                              (route) => false);
                    },
                    icon: const Icon(Icons.arrow_left),
                  ),
                  const Text(
                    'Cari Restaurant',
                  ),
                ],
              ),
              const SizedBox(height: 8,),
              ChangeNotifierProvider(
                create: (_) => SearchRestaurantProvider(searchApiService: SearchApiService()),
                child: Consumer<SearchRestaurantProvider>(
                  builder: (context, state, _) {
                    return ListTile(
                      leading: const Icon(
                        Icons.search,
                        size: 30,
                      ),
                      title: TextField(
                        controller: _controller,
                        onChanged: (String value) {
                          setState(() {
                            queries = value;
                          });
                          if (value != '') {
                            state.feacthSearchRestaurant(value);
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
                          if (queries != '') {
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
                ),
              ),
              const SizedBox(height: 30,),
              Expanded(
                child:Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: _cari(),
                ),
              ),
            ],
          ),
        ),
    );
  }
  Widget _cari(){
    return ChangeNotifierProvider<SearchRestaurantProvider>(
      create: (_) => SearchRestaurantProvider(searchApiService: SearchApiService()),
      child: Consumer<SearchRestaurantProvider>(
        builder: (context, state, _) {
          if(state.restaurantState == RestaurantState.Loading){
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  LinearProgressIndicator(
                    minHeight: 5,
                    color: Colors.blue,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text('Loading....'),
                ],
              ),
            );
          } else if(state.restaurantState == RestaurantState.HasData){
            state.feacthSearchRestaurant(queries);
            return Container(
              margin: const EdgeInsets.only(left: 16, right: 16),
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: state.searchResto?.restaurants.length,
                itemBuilder: (context, index){
                  var restaurant = state.searchResto?.restaurants[index];
                  return _searchRest(context, restaurant!);
                },
              ),
            );
          } else if(state.restaurantState == RestaurantState.NoData){
            state.feacthSearchRestaurant(queries);
            return Center(child: Text(state.message),);
          } else if(state.restaurantState == RestaurantState.Error){
            return Center(child: Text(state.message),);
          } else {
            return Center(child: Text(''),);
          }
        },
      ),
    );
  }

  Widget _searchRest(BuildContext context, SearchRestaurant restaurant) {
    return Material(
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        leading: Hero(
          tag: Image.network('https://restaurant-api.dicoding.dev/images/medium/${restaurant.pictureId}'),
          child: Image.network(
            'https://restaurant-api.dicoding.dev/images/medium/${restaurant.pictureId}',
            width: 100,
          ),
        ),
        title: Text(
          restaurant.name,
          style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        subtitle: Column(
          children: <Widget>[
            const SizedBox(height: 4.0,),
            Row(
              children: <Widget>[
                const Icon(
                  Icons.location_on,
                  color: Colors.grey,
                ),
                Text(restaurant.city),
              ],
            ),
            const SizedBox(height: 4.0,),
            Row(
              children: <Widget>[
                const Icon(
                  Icons.star_rate,
                  color: Colors.yellow,
                ),
                Text(restaurant.rating.toString()),
              ],
            ),
          ],
        ),
        onTap: () {
          Navigator.pushNamed(context, DetailPage.routeName, arguments: restaurant);
        },
      ),
    );
  }
}
