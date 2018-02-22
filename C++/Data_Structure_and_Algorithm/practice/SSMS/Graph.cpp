#include "Graph.h"
#include "Utils.h"

Graph::Graph(){
	initialized();
}
Graph::Graph(int nodesCount,int linesCount){
	this->nodesCount=nodesCount;
	this->linesCount=linesCount;
}
Graph::~Graph(){
}

int Graph::getLinesCount(){
	return this->linesCount;
}
int Graph::getNodesCount(){
	return this->nodesCount;
}
vector<Node> Graph::getNodes(){
	return this->nodes;
}
vector<Line> Graph::getLines(){
	return this->lines;
}

void Graph::setLinesCount(int linesCount){
	this->linesCount=linesCount;
}
void Graph::setNodesCount(int nodesCount){
	this->nodesCount=nodesCount;
}

void Graph::initialized(){
	nodesCount=0;
	linesCount=0;

	nodes.clear();
	lines.clear();
	srand(unsigned(time(0)));

	for(int i=0;i<MAXVEX;i++){
		for(int j=0;j<MAXVEX;j++){
			if(i==j)dis[i][j]=0;
			else dis[i][j]=SHRT_MAX;//why not is INT_MAX?
			//cout<<dis[i][j]<<" ";
		}
	}
	//cout<<"Value successful!"<<endl;
}
void Graph::addNode(string name){
	Node node=Node(name);

	int random1=rand();
	if(random1%17<13){
		node.setIfHaveToillet(true);
	}

	int random2=rand();
	if(random2%31<17){
		node.setIfHaveRestingArea(true);
	}
	
	int random=(int)rand();
	random=random*13%70+30;
	node.setPopularity(random);

	nodes.push_back(node);
	
//	cout<<node.getName()<<"\t"<<node.getIfHaveToillet()<<"\t" 
//		<<node.getIfHaveRestingArea()<<"\t"<<node.getPopularity()<<"\t"<<endl;

	nodesCount++;
}
void Graph::addLine(string from,string to,int distance){
	
	int row,col;

	isExist(from);
	isExist(to);
	
	row=getIndexOfNodes(from);
	col=getIndexOfNodes(to);
	dis[row][col]=distance;
	dis[col][row]=distance;

	linesCount++;
	
	lines.push_back(Line(from,to,distance));
}
bool Graph::isExist(Node node){
	return isExist(node.getName());
}
bool Graph::isExist(string name){
	//cout<<"test "<<name<<" if is exist or not."<<endl;
	if(getIndexOfNodes(name)>=0){
		//cout<<name<<" is exist, ok!"<<endl;
		return true;
	}else{
		//cout<<name<<" isn't exist."<<endl;
		return false;
	}
}
bool Graph::isEdge(string v1,string v2){
	//if(v1==v2)return false;

	int vn1=getIndexOfNodes(v1);
	int vn2=getIndexOfNodes(v2);

	return v1!=v2&&dis[vn1][vn2]!=SHRT_MAX;
}

int Graph::getIndexOfNodes(string name){
	if(nodes.empty()) return -1;
	else{
		int size=nodes.size();
		/*
		vector<Node>::iterator end=nodes.end();
		for(vector<Node>::iterator i=nodes.begin();i!=end;i++){
			(*i)...
		}

		for_each(nodes.begin(),nodes.end(),function_name);
		*/
/*		for(Node node : nodes.iterator){
			if(node.equals(name))return true;
		}*/


		for(int i=0;i<size;i++){
			if(nodes[i].equals(name))return i;
		}
	}
	return -1;
}
/* 1.Auto create a graph which is similar to the example of experiment working instruction. */
void Graph::autoCreateGraph(){
	initialized();
	//setNodesCount(8);
	//setLinesCount(9);
	
	addNode("北门");
	addNode("狮子山");
	addNode("仙云石");
	addNode("一线天");
	addNode("飞流瀑");
	addNode("仙武湖");
	addNode("九曲桥");
	addNode("观云台");
	addNode("花卉园");
	addNode("红叶亭");
	addNode("碧水亭");
	addNode("碧水潭");
	addNode("朝日峰");

	addLine("北门","仙云石",8);
	addLine("北门","狮子山",9);
	addLine("狮子山","飞流瀑",6);
	addLine("狮子山","一线天",7);
	addLine("仙云石","九曲桥",5);
	addLine("仙云石","仙武湖",4);
	addLine("仙武湖","九曲桥",7);
	addLine("一线天","观云台",11);
	addLine("飞流瀑","观云台",3);
	addLine("一线天","花卉园",10);
	addLine("观云台","红叶亭",15);
	addLine("花卉园","红叶亭",9);
	addLine("观云台","碧水亭",16);
	addLine("仙武湖","碧水亭",20);
	addLine("朝日峰","碧水潭",17);
	addLine("朝日峰","红叶亭",10);
	addLine("九曲桥","朝日峰",20);
	
}
/* 1.To create a graph by your input */
void Graph::CreateGraph(){
	bool flag=true;
	int nodesNum,linesNum;
	initialized();
	do{
		string input1,input2;
		cout<<"请输入顶点数和边数：";
		cin>>input1>>input2;
		nodesNum=parseInt(input1);
		linesNum=parseInt(input2);
		
			
		//cin>>nodesNum>>linesNum;
		//fflush(stdin);
		//cin.clear();
		cin.sync();
		if(nodesNum>=2&&linesNum>=1&&linesNum<=nodesNum*(nodesNum-1)/2){
			//setNodesCount(nodesNum);
			//setLinesCount(linesNum);
			flag=false;
		}else{
			cout<<"顶点数或边数不合理，请重新输入..."<<endl;
		}
	}while(flag);
	cout<<endl;
	cout<<"\"请输入顶点的信息\""<<endl;
	cout<<endl;
	cout<<"请输入个顶点的名字："<<endl;
	for(int i=0;i<nodesNum;){
		cout<<"第"<<i+1<<"个顶点：";
		string name;
		cin>>name;
		cin.sync();
		//fflush(stdin);
		if(isExist(name)){
			cout<<"此景点已存在,请重新输入!"<<endl;
		}else{
			cout<<"prepare to add Node:"<<name<<endl;
			addNode(name);
			//nodes.insert(nodes.begin()+i,new Node(name));
			i++;
		}
	}
	//cin.clear();
	for(int j=0;j<linesNum;){
		string from,to,weight;
		cout<<"请输入第"<<j+1<<"条边的两个顶点以及该边的权值：";
		cin>>from>>to>>weight;
		
        /* avoid the irregular input */
		if(parseInt(weight)<0){//cin.fail()||
			cout<<from<<"_"<<to<<"_"<<weight<<":Input error, please input retry!"<<endl;
		}else if(!isExist(from)){
			cout<<from<<" is not exist!Please input a valid vertex!"<<endl;
		}else if(!isExist(to)){
			cout<<to<<" is not exist!Please input a valid vertex!"<<endl;
		}else if(dis[getIndexOfNodes(from)][getIndexOfNodes(to)]==0){
			cout<<"Two place cannot be the same."<<endl;
		}else if(dis[getIndexOfNodes(from)][getIndexOfNodes(to)]!=SHRT_MAX){
			cout<<"Two place had been setted."<<endl;
		}else{
			j++;
			addLine(from,to,parseInt(weight));
		}
		fflush(stdin);
		cin.clear();
	}
}

/* 2.Output the whole graph by a adjacency matrix */
void Graph::OutputGraph(){
	int size=nodes.size();
	if(size==0){
		cout<<"The graph is empty. Please create first!"<<endl;
		return;
	}
	cout<<"\t";
	for(int i=0;i<size;i++){
		cout<<nodes[i].getName()<<"\t";
	}
	cout<<endl;
	
	for(int j=0;j<size;j++){
		//cout<<dis[j][j+1]<<endl;
		cout<<nodes[j].getName()<<"\t";
		for(int k=0;k<size;k++){
			cout<<dis[j][k]<<"\t";
		}
		cout<<endl;
	}
}


/* A travel way according to the depth first, 
which is called by the function CreateTourSortGraph(). */
void Graph::depthFirstSearch(int cur,int flag[MAXVEX]){
	int size=nodes.size();
	cout<<"-->"<<nodes[cur].getName();
	flag[cur]=1;
	for(int i=0;i<size;i++){
		if(dis[cur][i]!=0&&dis[cur][i]!=SHRT_MAX&&flag[i]!=1){
			depthFirstSearch(i,flag);
			for(int j=0;j<size;j++){
				if(flag[j]!=1){					
					cout<<"-->"<<nodes[cur].getName();
					break;
				}
			}
		}
	}
}
/* 3.The function is to build a route map of tour guide.
In design specification, it is said should use the travel of depth first 
which is satisfy the tourist's psychological, however, 
I don't think this is a good way to design a traveling route. */
void Graph::CreateTourSortGraph(){
	int flag[MAXVEX];
	
	if(nodes.empty()||lines.empty()){
		cout<<"The graph is empty. Please create first!"<<endl;
		return;
	}

	memset(flag,0,sizeof(flag));
	cout<<"The route map of the tour guide is:"<<endl;
	depthFirstSearch(0,flag);
	cout<<endl;
}


/* print a loop. */
void Graph::printLoop(int from,int cur,int father[MAXVEX]){
	//cout<<"print loop start!"<<from<<":"<<cur<<endl;
	if(cur==from){
		cout<<nodes[cur].getName();
	}else{
		printLoop(from,father[cur],father);
		cout<<"-->"<<nodes[cur].getName();
	}

}
void Graph::dfsTravel(int cur,int father[MAXVEX],int loop[MAXVEX]){
	int size=nodes.size();
	//cout<<"Now is in "<<nodes[cur].getName()<<endl;
	for(int i=0;i<size;i++){
		//cout<<"test from "<<nodes[cur].getName()<<" to "<<nodes[i].getName()<<endl;
		if(dis[cur][i]!=0&&dis[cur][i]!=SHRT_MAX&&father[cur]!=i&&loop[cur]!=i){
			//cout<<"test is ok."<<endl;
			if(father[i]!=i||i==0){	
				loop[i]=cur;

			/*	cout<<"print loop."<<endl;
				
				for(int k=0;k<size;k++)cout<<nodes[k].getName()<<"\t";
				cout<<endl;
				for(int j=0;j<size;j++)cout<<father[j]<<"\t";
				cout<<endl;*/
				printLoop(i,cur,father);
				cout<<"-->"<<nodes[i].getName()<<endl;
			}else{
				father[i]=cur;
				//cout<<nodes[i].getName()<<"'s father is "<<nodes[cur].getName()<<endl;
				dfsTravel(i,father,loop);
			}
		}
	}
}
/* 4.This is a way to search the loop in the graph, but can't to see all of the loop.
That is to say, when it comes to see the loops which are same to '8', the function just can see two loops. */
void Graph::loopSearch(){
	int father[MAXVEX],loop[MAXVEX];
	//memset(father,0,sizeof(father));
	for(int i=0;i<nodes.size();i++){
		father[i]=i;
		loop[i]=-1;
	}
	dfsTravel(0,father,loop);
	

}

/* the algorithm of dijkstra which is a kind of greedy algorithm. 
The function is called by MiniDistance(). */
void Graph::Dijkstra(int from,int cur,int to,int last[MAXVEX],int dis2[MAXVEX]){
	//if(cur==to)return;
	
	/* Add a insertion sort to be standard dijkstra algorithm. */

	int size=nodes.size();
	for(int i=0;i<size;i++){
		if(i==cur||i==from)continue;
		if(dis2[i]==0||dis2[cur]+dis[cur][i]<dis2[i]){
			last[i]=cur;
			dis2[i]=dis2[cur]+dis[cur][i];
			Dijkstra(from,i,to,last,dis2);
		}
	}

}
/* According to the algorithm we can get a shortest road. */
void Graph::outputRoad(int cur,int last[MAXVEX]){
	if(last[cur]==cur){
		cout<<nodes[cur].getName();
		return;
	}
	outputRoad(last[cur],last);
	cout<<"-->"<<nodes[cur].getName();
}
/* 5.Give a depature and a destination, 
and you will get a shortest distance and a shortest road.  */
void Graph::MiniDistance(){
	int vex1,vex2;
	string place1,place2;	
	
	if(nodes.empty()||lines.empty()){
		cout<<"The graph is empty. Please create first!"<<endl;
		return;
	}
	do{	
		cout<<"Please input two place."<<endl;
		cin>>place1>>place2;
		if(!isExist(place1)){			
			cout<<place1<<" is not exist!"<<endl;
		}else if(!isExist(place2)){
			cout<<place2<<" is not exist!"<<endl;
		}else{
			vex1=getIndexOfNodes(place1);
			vex2=getIndexOfNodes(place2);
			break;
		}
	}while(true);
	
	int last[MAXVEX];
	int dis2[MAXVEX];

	last[vex1]=vex1;
	
	memset(dis2,0,sizeof(dis2));
/*	for(int i=0;i<nodes.size();i++){
		for(int j=0;j<nodes.size();j++){
			dis2[i][j]=SHRT_MAX;
			cout<<dis2[i][j]<<"\t";
		}
		cout<<endl;
	}*/
	Dijkstra(vex1,vex1,vex2,last,dis2);
	
	cout<<"The shortest path is:"<<endl;
	outputRoad(vex2,last);
	cout<<"\nTotal minimum distance is "<<dis2[vex2]<<endl;

}


/* Rapid sort function which is called by MiniSpanTree(). */
void Graph::sort(int i,int j,int x[MAXVEX],int y[MAXVEX],int z[MAXVEX]){
	if(i>=j)return;
	int m,n,k,t;
	m=i,n=j;
	k=z[(i+j)>>1];

/*	for(int iter=0;iter<lines.size();iter++){
		cout<<z[iter]<<" ";
	}
	cout<<endl;*/
	
	//cout<<"sort:"<<m<<"\t"<<n<<"\t"<<k<<endl;
	while(m<=n){
		while(z[m]<k){
			m++;
		}
		while(z[n]>k){
			n--;
		}
		if(m<=n){
			t=x[m];
			x[m]=x[n];
			x[n]=t;
			t=y[m];
			y[m]=y[n];
			y[n]=t;
			t=z[m];
			z[m]=z[n];
			z[n]=t;
			m++;
			n--;
		}
		//cout<<m<<"\t"<<n<<endl;
	}
	//cout<<"sort:"<<i<<"\t"<<n<<endl;
	sort(i,n,x,y,z);

	//cout<<"sort:"<<m<<"\t"<<j<<endl;
	sort(m,j,x,y,z);
}
int Graph::getfather(int x,int dad[MAXVEX]){
	//cout<<x<<"?"<<dad[x]<<endl;
/*	for(int i=0;i<lines.size();i++){
		cout<<dad[i]<<" ";
	}
	cout<<endl;*/

	if(x==dad[x])return x;
	
	return getfather(dad[x],dad);

	//dad[x]=getfather(dad[x],dad);
	//return dad[x];
}
/* A kind of algorithm of minimum spanning three. */
void Graph::kruskal(int n,int e,int x[MAXVEX],int y[MAXVEX],int z[MAXVEX],int dad[MAXVEX]){
	int i,p,ans;
	for(i=0;i<n;i++){
		dad[i]=i;
	}
	p=1;ans=0;
	
/*	for(i=0;i<e;i++){
		cout<<x[i]<<"\t";
	}
	cout<<endl;
	for(i=0;i<e;i++){
		cout<<y[i]<<"\t";
	}	
	cout<<endl;
	for(i=0;i<e;i++){
		cout<<z[i]<<"\t";
	}
	cout<<endl;*/

	for(i=0;i<e;i++){
		//cout<<dad[i]<<endl;
		if(getfather(x[i],dad)!=getfather(y[i],dad)){
			//cout<<i<<endl;
			ans+=z[i];
			dad[x[i]]=y[i];
			p++;
			cout<<"从"<<nodes[x[i]].getName()<<"到"<<nodes[y[i]].getName()
				<<"修一条路.Length of the road is "<<dis[x[i]][y[i]]<<endl;
			if(p==n){
				cout<<"Total length is "<<ans<<"\n";
				break;
			}
		}
	}
/*	for(i=0;i<n;i++)
		cout<<dad[i]<<" ";
	cout<<endl;*/
}
/* 6.The function is to build a minimum spanning tree. */
void Graph::MiniSpanTree(){
	int e=0;
	int n=nodes.size();
	int x[MAXVEX],y[MAXVEX],z[MAXVEX],dad[MAXVEX];	
	
	if(nodes.empty()||lines.empty()){
		cout<<"The graph is empty. Please create first!"<<endl;
		return;
	}
	for(int i=0;i<n;i++){
		for(int j=0;j<i;j++){
			if(dis[i][j]!=0&&dis[i][j]!=SHRT_MAX){
				x[e]=i;
				y[e]=j;
				z[e]=dis[i][j];
				e++;
			}
		}
	}
	
	sort(0,e-1,x,y,z);
	//cout<<"???"<<n<<"\t"<<e<<"\t"<<x[n-1]<<"\t"<<y[n-1]<<"\t"<<endl;
	kruskal(n,e,x,y,z,dad);
	//cout<<"!!!"<<endl;
/*	for(int k=0;k<n;k++){
		if(dad[k]!=k){
			cout<<"从"<<nodes[k].getName()<<"到"<<nodes[dad[k]].getName()<<"修一条路"<<endl;
		}
	}*/
}

/* 7.1 search information according to you input */
void Graph::SearchByInput(){
	bool search=true;

	string input;

	cout<<"Please input a keyword:";
	cin>>input;

	int size=nodes.size();
	for(int i=0;i<size;i++){
		string filename=nodes[i].getName();
		ifstream in(filename.c_str());
		if(!in){
			ofstream out(nodes[i].getName().c_str());
			out<<"This is a beautiful area, and it's name is "<<
				filename<<".\n";
			for(int j=0;j<size;j++){
				if(j!=i&&dis[i][j]!=0&&dis[i][j]!=SHRT_MAX){
					out<<"It is adjacent with of the "<<nodes[j].getName()<<". And the distance between them is "<<dis[i][j]<<".\n";
				}
			}
			out<<"There will be a lot of people come here, just for the wonderful nature."<<"\n";
			//out<<fflush;
			out.close();

			cout<<"Error is occur when the file "<<filename<<" is opened!"<<endl;
		}else{
			stringstream buffer;
			buffer<<in.rdbuf();
			string contents(buffer.str());

			if(filename.find(input)!=string::npos||contents.find(input)!=string::npos){
				search=false;
				cout<<filename<<":"<<endl;
				cout<<contents<<endl;
			}
		}
		in.close();
	}

	if(search){
		cout<<"Not found relative information about "<<input<<"."<<endl;
	}

}
/* 7.2.1  */
void Graph::BubbleSortByNeed(int seq,int needs[MAXVEX],int cities[MAXVEX]){
	int size=nodes.size();

	for(int i=0;i<size;i++){
		for(int j=i+1;j<size;j++){
			if(seq==1?needs[j]<needs[i]:needs[j]>needs[i]){
				int temp=needs[j];
				needs[j]=needs[i];
				needs[i]=temp;
				temp=cities[j];
				cities[j]=cities[i];
				cities[i]=temp;
			}
		}
	}
}
/* 7.2.1 */
void Graph::QuickSortByNeed(int i,int j,int seq,int needs[MAXVEX],int cities[MAXVEX]){
	if(i>=j)return;

	int m,n,t,k;
	m=i,n=j;
	k=needs[(i+j)>>1];
	while(m<=n){
		while(seq==1?needs[m]<k:needs[m]>k){
			m++;
		}

		while(seq==1?needs[n]>k:needs[n]<k){
			n--;
		}

		if(m<=n){
			t=needs[m];
			needs[m]=needs[n];
			needs[n]=t;

			t=cities[m];
			cities[m]=cities[n];
			cities[n]=t;

			m++;
			n--;
		}
	}
	QuickSortByNeed(i,n,seq,needs,cities);
	QuickSortByNeed(m,j,seq,needs,cities);

}
/* 7.2.3 */
void Graph::InsertionByNeed(int seq,int needs[MAXVEX],int cities[MAXVEX]){
	int total=0;
	int size=nodes.size();
	int tNeeds[MAXVEX],tCities[MAXVEX];
	memset(tCities,0,sizeof(tCities));
	
	for(int i=0;i<size;i++){
		tNeeds[i]=seq==1?INT_MAX:INT_MIN;
		for(int j=0;j<=i;j++){
			if(seq==1?needs[i]<tNeeds[j]:needs[i]>tNeeds[j]){
				for(int k=i;k>j;k--){
					tNeeds[k]=tNeeds[k-1];
					tCities[k]=tCities[k-1];
				}
				tNeeds[j]=needs[i];
				tCities[j]=cities[i];
				break;
			}
		}
	}

	PrintSortResult(tNeeds,tCities);
}
void Graph::PrintSortResult(int needs[MAXVEX],int cities[MAXVEX]){
	int size=nodes.size();
	for(int i=0;i<size;i++){
		cout<<nodes[cities[i]].getName()<<"\t";
	}
	cout<<endl;
	
	for(int j=0;j<size;j++){
		cout<<needs[j]<<"\t";
	}
	cout<<endl;
}
/* 7.2 */
void Graph::SortByNeed(){
	int need,sort,seq;
	int needs[MAXVEX];
	int cities[MAXVEX];
	int size=nodes.size();

	cout<<"请输入三个数，分别代表需求、算法和顺序,例<1 1 1>"<<endl;
	cout<<"No.1:1景点欢迎度\t2景点岔路数"<<endl;
	cout<<"No.2:1冒泡\t快速\t插入"<<endl;
	cout<<"No.3:1从小到大\t2从大到小"<<endl;
	cin>>need>>sort>>seq;

	if(cin.fail()||need<1||need>2||sort<1||sort>3||seq<1||seq>2){
		cout<<"Error input, please input correctly."<<endl;
		cin.clear();
		cin.sync();
		//fflush(stdin);
		return;
	}else if(need==1){
		for(int i=0;i<size;i++){
			needs[i]=nodes[i].getPopularity();
		}
	}else if(need==2){
		for(int i=0;i<size;i++){
			int temp=0;
			for(int j=0;j<size;j++){
				if(dis[i][j]!=0&&dis[i][j]!=SHRT_MAX){
					temp++;
				}
			}
			needs[i]=temp;
		}
	}
	

	for(int iter=0;iter<size;iter++){
		cities[iter]=iter;
	}

	if(sort==1){		
		BubbleSortByNeed(seq,needs,cities);
		PrintSortResult(needs,cities);
	}else if(sort==2){
		QuickSortByNeed(0,size-1,seq,needs,cities);
		PrintSortResult(needs,cities);
	}else if(sort==3){
		InsertionByNeed(seq,needs,cities);
	}
}
/* 7.3 */
/* 7.To Manage the scenic spot  */
void Graph::ScenicManage(){
	bool flag=true;
	int choose;
	while(flag){			
		cout<<"===============景点管理系统==============="<<endl;
		cout<<"1、查找功能"<<endl;
		cout<<"2、排序功能"<<endl;
		cout<<"3、信息修改<未完成>"<<endl;
		cout<<"0、返回"<<endl;
		cin>>choose;
		if(cin.fail()){
			cout<<"Input error, Please input again."<<endl;
			cin.clear();	
			cin.sync();
			continue;
		}
		fflush(stdin);

		switch(choose){
		case 0:
			flag=false;
			break;
		case 1:
			SearchByInput();
			break;
		case 2:
			SortByNeed();
			break;
		//case 3:break;
		default:
			cout<<"Invalid input, Please input a valid choose."<<endl;
			break;
		}

	}
}