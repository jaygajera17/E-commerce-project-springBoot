#include<bits/stdc++.h>
using namespace std;

int main()
{  //----------------------------------intialize-------------------------------------
    map<int,string> s;
    map<int,int> map{ {1,2},{2,3},{3,4}};



    //----------------------------------insert---------------------------------------------
    s.insert(pair<int,string>(44,"jay"));
    s.insert(make_pair(33,"abc"));
    s.insert({4,"friend"});
    s[100]="abcd";


   //------------------------------------print--------------------------------------------
    for(auto itr = s.begin();itr!=s.end();itr++)
    {
        cout<<(*itr).first<<" "<<itr->second<<endl;

    }
    
    //------------------------------------find---------------------------------------------
    std::map<int,string>::iterator it=s.find(44);

    if (it !=s.end())
    {
        cout<<s.find(44)->second<<endl;
    }
    cout<<endl;
    cout<<s.at(1);
    }