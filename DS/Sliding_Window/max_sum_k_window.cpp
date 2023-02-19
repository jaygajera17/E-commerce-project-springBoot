
/* O(n*k)*/

#include<bits/stdc++.h>
using namespace std;
int main(){
    int n;
    int arr[]={1,2,3,4,5};
    int k=3;
    int sum=0;
    int maxsum=0;
    for(int i=0;i<3;i++)
    {
      for(int j=i;j<i+3;j++)
      {
        sum=sum+arr[j];
      }
      if(sum>maxsum) maxsum=sum;
      sum=0;
    }
    cout<<maxsum;

}

/* O(n)*/
#include<bits/stdc++.h>
using namespace std;
int main(){
    int n=9;
    int arr[]={1, 4, 2, 10, 2, 3, 1, 0, 20};
    int k=4;
    int j=0;
    //int sum=0;
    int maxsum=0;
    
    for(int i=0;i<k;i++)
    {
        maxsum+=arr[i];
    }
   int sum=maxsum;
    
    for(int i=k;i<n;i++)
    {
        sum=sum+arr[i]-arr[i-k];
        maxsum=max(sum,maxsum);
        cout<<"maxsum is"<<maxsum<<endl;
    }
    cout<<maxsum<<endl;

}


/*  Problem:- https://practice.geeksforgeeks.org/problems/max-sum-subarray-of-size-k5313/1*/

long maximumSumSubarray(int k, vector<int> &arr , int n){
        // code here 
       long long int sum=0;
        for(int i=0;i<k;i++)
        {
            sum=sum+arr[i];
        }
        long long int maxsum=sum;
        for(int i=k;i<n;i++)
        {
            sum=sum+arr[i]-arr[i-k];
             maxsum=max(sum,maxsum);
            
        }
        return maxsum;
    }

// Using 2 Pointers (O(N^2)))

long maximumSumSubarray(int k, vector<int> &arr , int n){
        // code here 
       long long int sum=0;
       int j=0;
       long long int maxsum=0;
       int i=0;
       while(j<n)
        {
            sum=sum+arr[j];
           if(j-i+1<k)
           {
               
               j++;
           }
          else if(j-i+1==k)
           {
               maxsum=max(sum,maxsum);
               sum=sum-arr[i];
               i++;
               j++;
           }
        }
        return maxsum;
    }

