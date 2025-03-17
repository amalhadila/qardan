import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qardan/core/theme/color_app.dart';
import 'package:qardan/core/theme/styles.dart';
import 'package:qardan/features/home/presentation/views/capture_view.dart';
import 'package:qardan/features/home/presentation/views/home_view.dart';
import 'package:qardan/features/home/presentation/views/notification_view.dart';
import 'package:qardan/features/home/presentation/views/widgets/tasks_view_body.dart';
import 'package:qardan/features/profile/presentation/views/profile_view.dart';

class BottomBarViewDart extends StatefulWidget {
  const BottomBarViewDart({super.key, this.lat, this.long});
final double? lat;
  final double? long;
  
  
  @override
  State<BottomBarViewDart> createState() => _BottomBarViewDartState();
}

class _BottomBarViewDartState extends State<BottomBarViewDart> {
    
   int currentindex =0;

     bool _isSearchActive = false;

       TextEditingController _searchController = TextEditingController();
        static  List<Widget> _pages =[];


      String  search_text='';

    @override
  void initState() {
    super.initState();
    _pages = [
     HomeView(lat: widget.lat,long: widget.long,),
    TasksViewBody(),
    CaptureView(),
    NotificationView(),
    ProfileView(lat: widget.lat,long: widget.long,),
    ];
  }

  Widget build(BuildContext context) {
    return  Scaffold(
      
      body: _pages[currentindex],
      bottomNavigationBar: BottomNavigationBar(  
        backgroundColor: Colors.white,    
         type: BottomNavigationBarType.fixed,
        elevation: 0,
      onTap: (value){        
        setState(() {
          currentindex=value;
        });
      },
      currentIndex: currentindex,
      selectedItemColor:  ColorApp.primaryColor,
      unselectedItemColor:Color(0xff8E8E8E),
      items: const [
       BottomNavigationBarItem(icon: Icon(Icons.home), label: 'رئيسية'),
          BottomNavigationBarItem(icon: Icon(Icons.article), label: 'تقارير'),
          BottomNavigationBarItem(icon: Icon(Icons.camera_enhance_outlined), label: 'كاميرا'),
          BottomNavigationBarItem(icon: Icon(Icons.notifications_active), label: 'اشعارات'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'انا'),
    ],
     
    ),
    ) ;
  }
}