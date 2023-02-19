/* https://practice.geeksforgeeks.org/problems/count-occurences-of-anagrams5839/1 */

int search(string p, string s) {
	    // code here
	    int n=s.length();
	    int m=p.length();
	    vector<int>mt(26,0);
	    vector<int>mp(26,0);
	    int count=0;
	    for(int i=0;i<m;i++)
	    {
	        mp[p[i]-'a']++;
	        mt[s[i]-'a']++;
	    }
	    int left=0;
	    int right=m-1;
	    while(right<n)
	   {
	       if(mt==mp) count++;
	       
	       right++;
	       if(right!=n)
	       {
	           mt[s[right]-'a']++;
	           mt[s[left++]-'a']--;
	       }
	   }
	   return count;
    }