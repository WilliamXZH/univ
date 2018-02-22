#include<iostream>
using namespace std;

struct TreeNode {
     int val;
     TreeNode *left;
     TreeNode *right;
     TreeNode(int x) : val(x), left(NULL), right(NULL) {}
};
 

TreeNode* mergeTrees(TreeNode* t1, TreeNode* t2) {
        
  	TreeNode * t;
    	
	if(t1==NULL){
		if(t2==NULL){
			t = NULL;
		
		}else{
			t->val = t2->val;
			t->left = mergeTrees(NULL,t2->left);
			t->right = mergeTrees(NULL,t2->right);
		}
	}else{
		if(t2==NULL){
			t->val = t1->val;
			t->left = mergeTrees(t1->left,NULL);
			t->right = mergeTrees(t1->right,NULL);
		}else{
			t->val = t1->val+t2->val;

			t = new TreeNode(t1->val+t2->val);
	
			t->left = mergeTrees(t1->left,t2->left);
			t->right = mergeTrees(t2->right,t2->right);
		}
	}
    	
    return t;
}

int main(){
	typedef TreeNode* node;

	node t1,t2;
	mergeTrees(t1,t2);
}