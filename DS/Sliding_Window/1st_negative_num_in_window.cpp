
/* https://practice.geeksforgeeks.org/problems/first-negative-integer-in-every-window-of-size-k3345 */

vector<long long> printFirstNegativeInteger(long long int arr[],
                                             long long int n, long long int k) {
            vector<long long>v;                                     
            for(int i=0;i<n-k+1;i++)
            {
                for(int j=i;j<i+k;j++)
                {
                    if(arr[j]<0)
                 {   v.push_back(arr[j]);
                    break;
                 }
                 if(j==i+k-1)
                 {
                     v.push_back(0);
                 }
                }
            }
            return v;
                                                 
 }

 /*  USING QUEUE O(N)*/
vector<long long> printFirstNegativeInteger(long long int arr[],
                                             long long int n, long long int k) {
            vector<long long>v;
            deque<long long int>q;
           long long int j=0,i=0;

               while(j<n)
               { if(arr[j]<0) q.push_back(arr[j]);
                   if(j-i+1<k) j++;
                   else if(j-i+1==k) 
                   {
                       if(q.empty())
                        { 
                           v.push_back(0);
                         }
                       else  
                       {
                          v.push_back(q.front());
                          if(arr[i]==q.front())
                          q.pop_front();
                          
                       }

                       i++;
                       j++;
                   }
                  
                  
               }
            
            return v;
                                                 
 }