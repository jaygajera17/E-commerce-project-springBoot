#include<bits/stdc++.h>
using namespace std;


int main()
{
   string plaintext="",ciphertext="";
   int key;
   cout<<"Enter Plain Text : "<<endl;
   cin>>plaintext;
   cout<<"Enter Key : "<<endl;
   cin>>key;


   int prevkey=key;
   for(int i=0;i<plaintext.size();i++)
   {
       int mapping = plaintext[i]-97;
       ciphertext += char((((mapping+prevkey)%26)+97));
       prevkey=mapping;
   }
   cout<<"Cipher Text : "<<ciphertext<<endl;


   plaintext="";  
   prevkey=key;
   for(int i=0;i<ciphertext.size();i++)
   {
       prevkey = ((((ciphertext[i]-97)-prevkey)%26));
       if(prevkey<0)
           prevkey+=26;
      
       plaintext+=char(prevkey+97);
   }
   cout<<"Plain Text : "<<plaintext<<endl;
   return 0;
}
