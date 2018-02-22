package pers.william.reference.version_of_1;

import java.util.ArrayList;
import java.util.List;
 
public class Node {
    private List<Integer> nodesCheckSum = new ArrayList<Integer>();
    private int leftPeo;
    private int rightPeo;
    private int leftSavage;
    private int rightSavage;
    private int CURR_STATE = 0;
    private int onBoatPeoNum = 0;
    private int onBoatSavageNum = 0;
    private final int STATE_BOAT_LEFT = 0;
    private final int STATE_BOAT_RIGHT = 1;
    public Node(int leftPeo, int leftSavage, int rightPeo, int rightSavage, int state, List checkSumList, int onBoatPeoNum, int onBoatSavageNum) {
        this.CURR_STATE = state;
        this.leftPeo = leftPeo;
        this.leftSavage = leftSavage;
        this.rightPeo = rightPeo;
        this.rightSavage = rightSavage;
        this.nodesCheckSum.addAll(checkSumList);
        this.onBoatPeoNum = onBoatPeoNum;
        this.onBoatSavageNum = onBoatSavageNum;
    }
    public int getLeftPeo() {
        return leftPeo;
    }
    public void setLeftPeo(int leftPeo) {
        this.leftPeo = leftPeo;
    }
    public int getRightPeo() {
        return rightPeo;
    }
    public void setRightPeo(int rightPeo) {
        this.rightPeo = rightPeo;
    }
    public int getLeftSavage() {
        return leftSavage;
    }
    public void setLeftSavage(int leftSavage) {
        this.leftSavage = leftSavage;
    }
    public int getRightSavage() {
        return rightSavage;
    }
    public void setRightSavage(int rightSavage) {
        this.rightSavage = rightSavage;
    }
    @Override
    public String toString() {
        return leftPeo+","+leftSavage+","+rightPeo+","+rightSavage+","+CURR_STATE;
    }
    public int getCURR_STATE() {
        return CURR_STATE;
    }
    public void setCURR_STATE(int cURR_STATE) {
        CURR_STATE = cURR_STATE;
    }
    public int getStateBoatLeft() {
        return STATE_BOAT_LEFT;
    }
    public int getStateBoatRight() {
        return STATE_BOAT_RIGHT;
    }
    public int calcCheckSum() {
        return 1*getCURR_STATE()+10*getLeftPeo()+100*getLeftSavage()+1000*getRightPeo()+10000*getRightSavage();
    }
    public void addCheckSum() {
        int checkSum = calcCheckSum();
        nodesCheckSum.add(checkSum);
    }
    public boolean hasVisited() {
        int sum = calcCheckSum();
        for (Integer checkSum : nodesCheckSum) {
            if(checkSum==sum) return true;
        }
        return false;
    }
    public List<Integer> getNodesCheckSum() {
        return nodesCheckSum;
    }
    public int getOnBoatPeoNum() {
        return onBoatPeoNum;
    }
    public void setOnBoatPeoNum(int onBoatPeoNum) {
        this.onBoatPeoNum = onBoatPeoNum;
    }
    public int getOnBoatSavageNum() {
        return onBoatSavageNum;
    }
    public void setOnBoatSavageNum(int onBoatSavageNum) {
        this.onBoatSavageNum = onBoatSavageNum;
    }
     
}