package pers.william.reference.version_of_1;

import java.util.ArrayList;
import java.util.List;
 
public class CrossRiverQuestion {
    public static void main(String[] args) {
        CrossRiverQuestion q = new CrossRiverQuestion(5, 4);
        q.solveQuestion();
    }
    private int peoNum;
    private int savageNum;
    private List<Node> resultList = new ArrayList<Node>();
    public List<Node> solveQuestion() {
        Node n = new Node(peoNum,savageNum,0,0,0,new ArrayList<Integer>(),0,0);
        boolean dfsResult = dfs(n);
        if(dfsResult) {
            resultList.add(0,n);
            for(Node node : resultList) {
                System.out.println("左岸传教士："+node.getLeftPeo()+"左岸野人： "+node.getLeftSavage()+" 右岸传教士： "+node.getRightPeo()+"右岸野人："+node.getRightSavage()+"船上传教士："+node.getOnBoatPeoNum()+"船上野人："+node.getOnBoatSavageNum());
            }
            return resultList;
        }
        return null;
    }
     
    public CrossRiverQuestion(int peoNum, int savageNum) {
        super();
        this.peoNum = peoNum;
        this.savageNum = savageNum;
    }
 
    private boolean dfs(Node n) {
        if(n.hasVisited()) return false;
        n.addCheckSum();
        if(n.getLeftPeo()==0&&n.getLeftSavage()==0) return true;
        if(n.getLeftPeo()<0||n.getRightPeo()<0||n.getLeftSavage()<0||n.getRightSavage()<0) {
            return false;
        }
        if(n.getLeftPeo()<n.getLeftSavage()&&n.getLeftPeo()>0) return false;
        if(n.getRightPeo()<n.getRightSavage()&&n.getRightPeo()>0) return false;
        if(n.getCURR_STATE()==n.getStateBoatLeft()) {
            Node n1 = new Node(n.getLeftPeo()-1,n.getLeftSavage()-1,n.getRightPeo()+1,n.getRightSavage()+1,n.getStateBoatRight(),n.getNodesCheckSum(),1,1);
            if(dfs(n1)) {
                resultList.add(0,n1);
                return true;
            }
            Node n4 = new Node(n.getLeftPeo()-2,n.getLeftSavage(),n.getRightPeo()+2,n.getRightSavage(),n.getStateBoatRight(),n.getNodesCheckSum(),2,0);
            if(dfs(n4)) {
                resultList.add(0,n4);
                return true;
            }
            Node n5 = new Node(n.getLeftPeo(),n.getLeftSavage()-2,n.getRightPeo(),n.getRightSavage()+2,n.getStateBoatRight(),n.getNodesCheckSum(),0,2);
            if(dfs(n5))  {
                resultList.add(0,n5);
                return true;
            }
        } 
        else {
            Node n6 = new Node(n.getLeftPeo(),n.getLeftSavage()+1,n.getRightPeo(),n.getRightSavage()-1,n.getStateBoatLeft(),n.getNodesCheckSum(),0,1);
            if(dfs(n6)) {
                resultList.add(0,n6);
                return true;
            }
            Node n7 = new Node(n.getLeftPeo()+1,n.getLeftSavage(),n.getRightPeo()-1,n.getRightSavage(),n.getStateBoatLeft(),n.getNodesCheckSum(),1,0);
            if(dfs(n7)) {
                resultList.add(0,n7);
                return true;
            }
            Node n1 = new Node(n.getLeftPeo()+1,n.getLeftSavage()+1,n.getRightPeo()-1,n.getRightSavage()-1,n.getStateBoatLeft(),n.getNodesCheckSum(),1,1);
            if(dfs(n1)) {
                resultList.add(0,n1);
                return true;
            }
            Node n4 = new Node(n.getLeftPeo()+2,n.getLeftSavage(),n.getRightPeo()-2,n.getRightSavage(),n.getStateBoatLeft(),n.getNodesCheckSum(),2,0);
            if(dfs(n4)) {
                resultList.add(0,n4);
                return true;
            }
            Node n5 = new Node(n.getLeftPeo(),n.getLeftSavage()+2,n.getRightPeo(),n.getRightSavage()-2,n.getStateBoatLeft(),n.getNodesCheckSum(),0,2);
            if(dfs(n5))  {
                resultList.add(0,n5);
                return true;
            }
        }
        return false;
    }
    public List<Node> getResultList() {
        return resultList;
    }
     
}