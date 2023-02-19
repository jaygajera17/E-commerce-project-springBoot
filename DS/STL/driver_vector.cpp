// { Driver Code Starts
#include <bits/stdc++.h>
using namespace std;

void add_to_vector(vector<int> &A,int x);


void sort_vector_asc(vector<int> &A);


void reverse_vector(vector<int> &A);

int size_of_vector(vector<int> &A);

void sort_vector_desc(vector<int> &A);

void print_vector(vector<int> &A);

int main() {
	// your code goes here
	int t;
	cin>>t;
	while(t--)
	{
		vector<int> A;
		int q;
		cin>>q;
		while(q--)
		{
			char c;
			cin>>c;
			if(c=='a')
			{
				int x;
				cin>>x;
				add_to_vector(A,x);
			}
			if(c=='b')
			{
				sort_vector_asc(A);
			}
			if(c=='c')
			{
				reverse_vector(A);
			}
			if(c=='d')
			{
				cout<<size_of_vector(A)<<" ";
			}
			if(c=='e')
			{
				print_vector(A);
				
			}
			if(c=='f')
			{
				sort_vector_desc(A);
			}
			
		}
cout<<endl;
	}
	return 0;
}// } Driver Code Ends


/*You are required to complete below methods*/

/*inserts an element x at 
the back of the vector A */
void add_to_vector(vector<int> &A,int x)
{
	//Your code here
	A.push_back(x);

}

/*sort the vector A in ascending order*/
void sort_vector_asc(vector<int> &A)
{
	//Your code here
	 sort(A.begin(),A.end());
	
}

/*reverses the vector A*/
void reverse_vector(vector<int> &A)
{
	//Your code here
	reverse(A.begin(),A.end());

	
}

/*returns the size of the vector  A */
int size_of_vector(vector<int> &A)
{
	//Your code here
 return A.size();

}

/*sorts the vector A in descending order*/
void sort_vector_desc(vector<int> &A)
{
	//Your code here
sort(A.rbegin(),A.rend());
	
}

/*prints space separated 
elements of vector A*/
void print_vector(vector<int> &A)
{
	//Your code here
	for(int i : A)
	{
	    cout<<i<<" ";
	}
}
