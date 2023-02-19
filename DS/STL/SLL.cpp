#include <bits/stdtr1c++.h>
using namespace std;

class Node
{
public:
    int data;
    Node *next;
};

void push(Node** head_ref, int data)
{
    
    Node *new_node = new Node(); //allocate node
    new_node->data = data;     //data allocate
    new_node->next = (*head_ref); // next node is  what head points before
    (*head_ref) = new_node; //head now point to the new node
}

void insertAfter(Node* prev_node,int new_data)
{
    if(prev_node==NULL)
    {
        cout<<"previous node can't be a Null";
        return;
    }
    Node* new_node = new Node();
    new_node->data=new_data;
    new_node->next=prev_node->next;
    prev_node->next=new_node;
}  

void append(Node** head_ref,int new_data)
{
    Node* new_node= new Node();
    Node *last=*head_ref;
    new_node->data=new_data;
    new_node->next=NULL;

    if(*head_ref==NULL) //if LL empty then create new node
    {
        *head_ref=new_node;
        return;
    }
    while(last->next!=NULL) //else travels to the end of LL
    {
        last=last->next;
    }
    last->next=new_node;
    return;

}

void printlist(Node *n)
{
    while (n != NULL)
    {
        cout << n->data << endl;
        n = n->next;
    }
}
int main()
{
    /*------------------initialize-----------------------*/
    Node *head = NULL;
    Node *second = NULL;
    Node *third = NULL;

    head = new Node();
    second = new Node();
    third = new Node();
    
    /*-----------------data and connections --------------*/
    head->data = 1;
    head->next = second;

    second->data = 2;
    second->next = third;

    third->data = 3;
    third->next = NULL;
   
   /*---------------push at front ------------------*/
    push(&head, 2);
    push(&head, 1);
    
   /* ---insert given position ------------*/
    insertAfter(head->next, 8);

   /*----insert at end --------------*/
   append(&head, 10);


    /*--------------print-------------*/
    printlist(head);

    return 0;
}

