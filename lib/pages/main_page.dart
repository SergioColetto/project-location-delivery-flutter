import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:happy_postcode_flutter/components/app_theme.dart';
import 'package:happy_postcode_flutter/pages/destinations_page.dart';
import 'package:happy_postcode_flutter/pages/favourites_page.dart';
import 'package:happy_postcode_flutter/pages/myroutes_page.dart';
import 'package:happy_postcode_flutter/providers/address_provider.dart';
import 'package:happy_postcode_flutter/routes/routes.dart';
import 'package:happy_postcode_flutter/search/search_delegate.dart';
import 'package:provider/provider.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AddressProvider>(
      builder: (context, provider, child) => Scaffold(
        body: DefaultTabController(
          length: 3,
          child: Scaffold(
            drawer: _MenuPrincipal(),
            appBar: AppBar(
              bottom: TabBar(
                tabs: [
                  Tab(text: "DESTINATIONS"),
                  Tab(text: "MY ROUTES"),
                  Tab(text: "FAVOURITES"),
                ],
              ),
              title: Row(
                children: <Widget>[
                  Expanded(
                    child: Center(
                      child: Text("Location Delivery"),
                    ),
                  ),
                  IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        showSearch(context: context, delegate: DataSearch());
                      })
                ],
              ),
            ),
            body: Column(
              children: <Widget>[
                Expanded(
                  child: TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      DestinationsPage(),
                      MyRoutesPage(),
                      FavouritesPage()
                    ],
                  ),
                ),
                // provider.totalInRoute > 0 ? NavigateButton() : Container()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ListaOpciones extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<ThemeChanger>(context).currentTheme;

    return ListView.separated(
      physics: BouncingScrollPhysics(),
      separatorBuilder: (context, i) => Divider(
        color: appTheme.primaryColorLight,
      ),
      itemCount: pageRoutes.length,
      itemBuilder: (context, i) => ListTile(
        leading: FaIcon(pageRoutes[i].icon, color: appTheme.accentColor),
        title: Text(pageRoutes[i].titulo),
        trailing: Icon(Icons.chevron_right, color: appTheme.accentColor),
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => pageRoutes[i].page));
        },
      ),
    );
  }
}

class _MenuPrincipal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<ThemeChanger>(context);
    final accentColor = appTheme.currentTheme.accentColor;

    return Drawer(
      child: Container(
        child: Column(
          children: <Widget>[
            Expanded(child: _ListaOpciones()),
            SafeArea(
              child: Expanded(
                child: ListTile(
                  leading: Icon(Icons.lightbulb_outline, color: accentColor),
                  title: Text('Dark Mode'),
                  trailing: Switch.adaptive(
                      value: appTheme.darkTheme,
                      activeColor: accentColor,
                      onChanged: (value) => appTheme.darkTheme = value),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
