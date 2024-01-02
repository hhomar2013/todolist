abstract class AppStatus {}
class AppInitialStat extends AppStatus{ }//Starting point
class AppChangeBottomNavBarState extends AppStatus{} //change index
class AppCreateDataBaseState extends AppStatus{}// create or open database
class AppGetDataBaseState extends AppStatus {}
class AppGetDataBaseLoadingState extends AppStatus{}
class AppInsertDataBaseState extends AppStatus{}
class AppChangeBottomSheetState extends AppStatus{}
class AppUpdateDatabaseState extends AppStatus{}
class AppDeleteDatabaseState extends AppStatus{}