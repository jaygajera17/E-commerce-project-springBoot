#include<bits/stdc++.h>
using namespace std;


bool func(const pair<int,int> &a,const pair<int,int>&b)
{
    return (a.second<b.second);
}

int main()
{
//--------------intialize------------------------------
    pair<int,int> pair1;    //1st method
    pair1.first=100;
    pair1.second=200;

    pair<string,string> pair2("jay","CE044");  //2nd method
    // cout<<pair1.first<<" ";
    // cout<<pair1.second<<" "<<endl;
cout<<endl;
    pair<string,int> pair3;      //3rd method
    pair3=make_pair("jay",44); 
    

//---------------SWAP------------------------

pair<int,int>p1=make_pair(2,3);
pair<int,int>p2=make_pair(4,5);
pair<int,int>p;
p={2,3};

p1.swap(p2);

//-------------VECTOR OF PAIRS------------

vector<pair<int,int> > v;
int arr1[]={4,3,2,1};
int arr2[]={2,3,6,5};
 int n = sizeof(arr1)/sizeof(arr1[0]);
for(int i=0;i<n;i++)
{
    v.push_back( make_pair(arr1[i],arr2[i]));
}
   sort(v.begin(),v.end());  //sort on basis of 1st element 

   sort(v.begin(),v.end(),func); //sort on basis of 2nd element 
    for(int i=0;i<n;i++)
    {
        cout<<v[i].first<<" "<<v[i].second<<endl;
    }



}