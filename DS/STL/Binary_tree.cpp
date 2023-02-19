#include <iostream>
#include <queue>
using namespace std;

class Node
{

public:
  int data;
  Node *left;
  Node *right;

  Node(int val)
  {
    data = val;
    left = NULL;
    right = NULL;
  }
};
void Postorder(Node *node)
{
  if (node == NULL)
    return;
  Postorder(node->left); // left-right-root
  Postorder(node->right);
  cout << node->data << " ";
}
void preorder(Node *node)
{
  if (node == NULL)
    return;
  cout << node->data << " "; // root-left-right
  preorder(node->left);
  preorder(node->right);
}
void inorder(Node *node)
{
  if (node == NULL)
    return; // left-root-right
  inorder(node->left);
  cout << node->data << " ";
  inorder(node->right);
}
bool maxvalue(Node *node, int val)
{
  if (node->data > val)
  { // root greater than left return 1
    return 1;
  }
  else
  {
    return 0;
  }
}
bool minvalue(Node *node, int val)
{
  if (node->data < val)
  { // root less than right return 1
    return 1;
  }
  else
  {
    return 0;
  }
}

void Nthinorder(Node *node, int n)
{
  static int count = 0;
  if (node == NULL)
    return;

  if (count <= n)
  {
    Nthinorder(node->left, n);
    count++;
    if (count == n)
    {
      cout << "nth node in INORDER is :- " << node->data << endl;
    }
    Nthinorder(node->right, n);
  }
}

void levelorder(Node* root)
{
   if(root==NULL)
   return;

   queue<Node*> q;
   q.push(root);

   while(q.empty()==false)
   {
     Node* node=q.front();
     cout<<node->data<<" ";
     q.pop();
     if(node->left!=NULL)
     {
       q.push(node->left);
     }
     if(node->right!=NULL)
     {
       q.push(node->right);
     }
   }
}
int isBST(Node *node)
{
  // here node is root

  if (node == NULL)
    return 1;

  /* false if the max of the left is > than us */
  if (node->left != NULL && maxvalue(node->left, node->data))
    return 0;

  /* false if the min of the right is <= than us */
  if (node->right != NULL && minvalue(node->right, node->data))
    return 0;

  /* false if, recursively, the left or right is not a BST */
  if (!isBST(node->left) || !isBST(node->right))
    return 0;

  /* passing all that, it's a BST */
  return 1;
}

int sum_BT(Node* root)
{
  if(root==NULL)
  return 0;

  return(root->data+sum_BT(root->left)+sum_BT(root->right));
}

int height(Node *node)
{
  // code here
  int depth = 0;

  queue<Node *> q;

  // Pushing first level element along with NULL
  q.push(node);
  q.push(NULL);
  while (!q.empty())
  {
    Node *temp = q.front();
    q.pop();

    // When NULL encountered, increment the value
    if (temp == NULL)
    {
      depth++;
    }

    // If NULL not encountered, keep moving
    if (temp != NULL)
    {
      if (temp->left)
      {
        q.push(temp->left);
      }
      if (temp->right)
      {
        q.push(temp->right);
      }
    }

    // If queue still have elements left,
    // push NULL again to the queue.
    else if (!q.empty())
    {
      q.push(NULL);
    }
  }
  return depth;
}

int search(Node *root, int key)
{

  if (root == NULL || root->data == key)
    return root->data;

  if (root->data < key)
    return search(root->right, key);

  if (root->data > key)
    return search(root->left, key);

  else
  {
    return 0;
  }
}

int countnodes(Node* root)
{
  if(root==NULL)
  {
    return 0;
  }
  return countnodes(root->left)+countnodes(root->right)+1;
}


// driver program

int main()
{
  //------------------------------------------insertion---------------------------------------------------
  Node *root = new Node(8);
  root->left = new Node(3);
  root->right = new Node(10);
  root->left->left = new Node(1);
  root->left->right = new Node(6);

  //-----------------------------------------traversel----------------------------------------------------
  cout << " postorder :- ";
  Postorder(root);
  cout << endl;
  cout << " preorder :- ";
  preorder(root);
  cout << endl;
  cout << " inorder :- ";
  inorder(root);
  cout << endl;

  //---------------------------------------- Nth node in inorder traversal------------------------
  int n = 2;
  Nthinorder(root, n);

  //---------------------------------------- Level order Traversel-------------------------
cout<<"level order traversel :- ";
  levelorder(root);
cout<<endl;
  //---------------------------------------- Sum Of all node ---------------------
 cout<<"sum of all node is :- " << sum_BT(root)<<endl;

  //----------------------------------------check it is BST or not ----------------------------------------
  if (isBST(root))
  {
    cout << " It is BST" << endl;
  }
  else
  {
    cout << " it is not BST" << endl;
  }

  //----------------------------------------find the height of Binary tree ----------------------------------
  int H = height(root);
  cout << " height of tree is " << H << endl;

  //----------------------------------------search the item in given BST-------------------------------------------
  int s = search(root, 10);
  if (s)
  {
    cout << "search item present  :- " << s << endl;
  }
  else
  {
    cout << "search item not found " << endl;
  }

  //---------------------------------------------count total nodes----------------------------------------
  cout<<"Count total Node is :- " << countnodes(root) <<endl;
}