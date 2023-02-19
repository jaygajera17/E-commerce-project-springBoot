#include<iostream>
#include<vector>
#include<bits/stdc++.h>
using namespace std;

int main()
{
   // ----------------------intialize-----------------------------
    cout<<"print"<<endl;
    vector<int> v1={1,2,3,4,5}; //method1
    vector<int> v2{6,7,8,9,10}; //method2
    vector<int> v3(3,3);  // method 3

    //print
    for(int& i : v1)
    {
        cout<<i<<" ";
    }
    cout<<endl;
    for(int i :v2)
    {
        cout<<i<<"";
    }
    cout<<endl;
    for(auto i: v3)
    {
       cout<<i<<" ";
    }
cout<<endl;
cout<<endl;
    //---------------------------push_back:- insert element at end of the vector ---------------------------------------
    cout<<"push back operations "<<endl;
    v1.push_back(6);
    v1.push_back(7);

    for(int i:v1)
    {
        cout<<i<<" ";
    }
    
cout<<endl;
cout<<endl;
    //----------------------------------------pop back operations -------------------------------------------------------------
    cout<<"pop_back/delete  operation of v1={1,7}"<<endl;
     v1.pop_back();
     for(int i:v1)
     {
         cout<<i<<" ";
     }
cout<<endl;
    //-----------------------------------------access/print  nth element-------------------------------------
    cout<<endl;
    cout<<"print 0th and 1st element of v1"<<endl;
    cout<<v1.at(0)<< " " <<v1[1]<<endl;

//change 
 cout<<endl;
    cout<<"change /update "<<endl;

    v1.at(0)=9;
    for(int i:v1)
    {
        cout<<i<<" ";
    }
    v1.at(0)=1;

cout<<endl;
cout<<endl;
    //functions 

  cout<<"v1 size "<<v1.size()<<endl;
  cout<<"front element is " << v1.front()<<endl;
   cout<<"back element is " << v1.back()<<endl;
   cout<<"capacity is "<< v1.capacity()<<endl;
   
        cout<<endl;
        cout<<endl;

//---------------------------------------iterators---------------------------------------

vector<int> v5= {10,20,30,40,50};

//declare
vector<int>::iterator itr;
itr=v5.begin();
cout<<*itr<<" ";
itr=v5.begin()+2;
cout<<*itr<<" ";
itr=v5.end()-1;
cout<<*itr<<endl;
cout<<endl;
//using loop

for(itr=v5.begin();itr != v5.end();itr++)
{
   cout<<*itr<<" ";
}
cout<<endl;
cout<<endl;

// copy array's element  to vector

int arr[]={1,2,3,4,5};
int N=5;//size of array
vector<int> v6(arr,arr+N);

//sort
 sort(v1.begin(),v1.end());


//reverse sort 
 sort(v1.rbegin(),v1.rend());


 //copy
 vector<int> v8{1,2,3,4};
 vector<int> v9;
 v9 = v8; //


 
}