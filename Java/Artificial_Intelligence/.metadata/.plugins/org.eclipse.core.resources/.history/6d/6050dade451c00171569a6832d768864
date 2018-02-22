/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package wild_man_and_chuanjiaoshi;
//用于计算各种


import java.util.ArrayList;
import java.util.List;
import javax.swing.JOptionPane;

/**
 *
 * @author 郭昊然
 */
public class jisuan {
    int people_num;
    int ship_num;
    boolean error=false;
    public jisuan(int peo,int ship)
    {
        this.people_num=peo;
        this.ship_num=ship;
    }
    public int get_peo_num()
    {
        return people_num;
    }
    public void set_peo_num(int peo)
    {
        this.people_num=peo;
    }
    public int get_ship_num()
    {
        return ship_num;
    }
    public void set_ship_num(int ship)
    {
        this.ship_num=ship;
    }
    public String addPeonum()//增加人数
    {
        if(people_num<15)//最大为15
        {
             people_num++;
        }else
        {
            JOptionPane.showMessageDialog(null,"最多为15个传教士和15个野人", "信息提示", JOptionPane.ERROR_MESSAGE);
        }
        return people_num+"";
       
    }
     public String jianPeonum()//减少人数
    {
        if(people_num>2)//最少为2
        {
             people_num--;
        }else
        {
             JOptionPane.showMessageDialog(null,"最少为2个传教士和2个野人", "信息提示", JOptionPane.ERROR_MESSAGE);
        }
        return people_num+"";
    }
     public String addshipnum()//增加船的数量
     {
        if(ship_num<15)//最多15
        {
             ship_num++;
        }else
        {
            JOptionPane.showMessageDialog(null,"船载客最多为15", "信息提示", JOptionPane.ERROR_MESSAGE);
        }
        return ship_num+"";
     }
     public String jianshipnum()
     {
          if(ship_num>2)//最少为2
        {
             ship_num--;
        }else
        {
            JOptionPane.showMessageDialog(null,"船载客最少为2", "信息提示", JOptionPane.ERROR_MESSAGE);
        }
        return ship_num+"";
     }
     List<int[]> move=new ArrayList<int[]>();
     public String Axing_jisuan()//使用A*算法计算
     {
         move.clear();//清空元素重新计算
         error=false;
         //int[] a=new int[3];//0,1分别为野人，传教士移动人数，2为向左移还是向右移（0向右移，1向左移）
         int yeren=0,chuanjiao=0;//左边野人和传教士
          StringBuilder a=new StringBuilder("");
          yeren=people_num;
          chuanjiao=people_num;
          a.append("    初始：左岸:"+"【野人"+yeren+"人，传教士"+chuanjiao+"人】---右岸："+"【野人"+(people_num-yeren)+"人，传教士"+(people_num-chuanjiao)+"人】\n");
        // try
         //{
            yunxing(people_num,people_num,true,0);
           
            for(int i=move.size()-1;i>=0;i--)
            {
                if(move.get(i)[2]==0)//向右移
                {
                    a.append("*第"+(move.size()-i)+"步:将 "+move.get(i)[0]+" 个野人和 "+move.get(i)[1]+" 个传教士移动到右岸。--->\n");
                    yeren-=move.get(i)[0];
                    chuanjiao-=move.get(i)[1];
                    a.append("    更新：左岸:"+"【野人"+yeren+"人，传教士"+chuanjiao+"人】---右岸："+"【野人"+(people_num-yeren)+"人，传教士"+(people_num-chuanjiao)+"人】\n");
                }else//向左移
                {
                    a.append("*第"+(move.size()-i)+"步:将 "+move.get(i)[0]+" 个野人和 "+move.get(i)[1]+" 个传教士移动到左岸。<---\n");
                    yeren+=move.get(i)[0];
                    chuanjiao+=move.get(i)[1];
                    a.append("    更新：左岸:"+"【野人"+yeren+"人，传教士"+chuanjiao+"人】---右岸："+"【野人"+(people_num-yeren)+"人，传教士"+(people_num-chuanjiao)+"人】\n");
                }
            }
            // return a.toString();
//         }catch(Exception x)
//         {
                if(error)
                {
                     a=new StringBuilder("无解情况！\n"+people_num+"个野人或传教士 和载荷为"+ship_num+"的船这种匹配无解。\n请调整野人传教士数量或船的载荷!");
                }
            
              return a.toString();
          //  return people_num+"个野人或传教士和载荷为"+ship_num+"的船这种匹配无解。\n请调整野人传教士数量或船的载荷!" ;
//         }
        
         //yunzou(people_num,people_num,true,0,2,0);
         
         
      // return move.size()+"";
     }
     
     
     private void yunxing(int zuoye,int zuoch,boolean xiangyou,int step)//直接找出可以运行的答案  截取yunzou方法的一部分 即第一次向右运的情况
     {
        if(zuoye+zuoch<=ship_num)//剩下的可以直接运过去了
        {
            int[] x=new int[3];
            x[0]=zuoye;//野人数目
            x[1]=zuoch;//传教士数目
            x[2]=0;//向右移
            move.add(x);
            return;
        }else
        {
            for(int allnum=ship_num;allnum>0;allnum--)//向右运则从大向小运
            {
                for(int ye=zuoye;ye>=0;ye--)//运走的野人数
                {
                    for(int ch=zuoch;ch>=0;ch--)//运走的传教士数
                    {
                        if(ye+ch==allnum)//等于当前允许载荷
                        {
                            if((zuoch-ch)>=(zuoye-ye)||((zuoch-ch)==0&&(zuoye-ye)>0))//左岸运走后，传教士人数仍大于野人人数或者只剩下野人
                            {
                                if(ch>=ye||(ch==0&&ye>0))//船上传教士人数大于等于野人或者只是野人
                                {
                                    if((people_num-zuoch+ch)>=(people_num-zuoye+ye)||((people_num-zuoch+ch)==0&&(people_num-zuoye+ye)>0))//右岸符合条件
                                    {
                                        //if(yun_ye!=ye||yun_chuan!=ch)//保证和上次的不同
                                        {
                                           if(yunzou(zuoye,zuoch,true,step++,ye,ch)==true)//否则要多几趟运走
                                           {
                                               int[] x=new int[3];
                                               x[0]=ye;//野人数目
                                               x[1]=ch;//传教士数目
                                               x[2]=0;//向右移
                                               move.add(x);
                                               return;
                                           }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }  
        } 
        //error=true;
     }
     //people_num人数  ship_num船的载荷
     //fn=gn+hn;gn为当前已经走的步数，hn为剩下没运走的人数
     //由于算法采用左岸边总人数越少越好，所以不需要特意列出所有情况来根据fn越小来选择，而是直接排列从小到大的fn，依次查看符合的情况下运走人就可以
     //当前zuocye和zuoch 并且xiangyou方向 运yun_ye野人和yun_chuan传教士这种情况是可以的吗？
     
     private boolean yunzou(int zuoye,int zuoch,boolean xiangyou,int step,int yun_ye,int yun_chuan)//运走人方法，左面->右面 xiangyou运是可以的嘛？  左面野人数量，左面传教士数量 船向右运行吗？ 步数（其实没什么用） 运走的野人，运走的传教士
     {
         if(step>100)
         {
             error=true;
             return true;
         }
              // List list = new ArrayList();
        // aaa.add(3);
         //List<dd> b=new List<d>();
         int fn=0;//
         int gn=step;
         int hn=0;
         //运走符合的条件：左岸剩下的传教士大于等于野人数量或者只剩下野人 右岸、船上同理
         //运走的总人数小于船的载荷
         //运走的总人数大于0 因为至少一个人划船
         //运走的方式和上次运来的不能相同
         //运走后
         if(xiangyou)//要向右运动，则多运人使得fn越小越好 向右运动是可以的吗
         {
            for(int allnum=1;allnum<=ship_num;allnum++)//向左运则从小到大  如果向右运后可以向左运 则可以向右运
            {
                for(int ye=0;ye<=people_num-zuoye+yun_ye&&ye<=allnum;ye++)//运走的野人数
                {
                    for(int ch=0;ch<=people_num-zuoch+yun_chuan&&ch<=allnum;ch++)//运走的传教士数
                    {
                        if(ye+ch==allnum)//等于当前允许载荷
                        {
                            if(((zuoch-yun_chuan+ch)>=(zuoye-yun_ye+ye))||((zuoch-yun_chuan+ch)==0&&(zuoye-yun_ye+ye)>0))//右岸运走后，左岸传教士人数仍大于野人人数或者只剩下野人
                            {
                                if((ch>=ye)||(ch==0&&ye>0))//船上传教士人数大于等于野人或者只是野人
                                {
                                    if((people_num-zuoch+yun_chuan-ch)>=(people_num-zuoye+yun_ye-ye)||((people_num-zuoch+yun_chuan-ch)==0&&(people_num-zuoye+yun_ye-ye)>0))//右岸剩下的符合条件
                                    {
                                        if(yun_ye!=ye||yun_chuan!=ch)//保证和上次的不同
                                        {
                                           if(yunzou(zuoye-yun_ye,zuoch-yun_chuan,false,step++,ye,ch)==true)//
                                           {
                                               int[] x=new int[3];
                                               x[0]=ye;//野人数目
                                               x[1]=ch;//传教士数目
                                               x[2]=1;//向左移
                                               move.add(x);
                                               return true;
                                           }
                                        } 
                                    }
                                }
                            }
                        }
                    }
                }
            }
         }else//要向左运动，则少运人使得fn越小越好 向左运动可以吗？
         {
            if(zuoye+yun_ye+zuoch+yun_chuan<=ship_num)//剩下的可以直接运过去了
            {
                int[] x=new int[3];
                x[0]=zuoye+yun_ye;//野人数目
                x[1]=zuoch+yun_chuan;//传教士数目
                x[2]=0;//向右移
                move.add(x);
                return true;
            }else
            {
               for(int allnum=ship_num;allnum>0;allnum--)//向右运则从大向小运
                {
                    for(int ye=zuoye+yun_ye;ye>=0;ye--)//运走的野人数
                    {
                        for(int ch=zuoch+yun_chuan;ch>=0;ch--)//运走的传教士数
                        {
                            if(ye+ch==allnum)//等于当前允许载荷
                            {
                                if((zuoch+yun_chuan-ch)>=(zuoye+yun_ye-ye)||((zuoch+yun_chuan-ch)==0&&(zuoye+yun_ye-ye)>0))//左岸运走后，传教士人数仍大于野人人数或者只剩下野人
                                {
                                    if(ch>=ye||(ch==0&&ye>0))//船上传教士人数大于等于野人或者只是野人
                                    {
                                        if((people_num-zuoch-yun_chuan+ch)>=(people_num-zuoye-yun_ye+ye)||((people_num-zuoch-yun_chuan+ch)==0&&(people_num-zuoye-yun_ye+ye)>0))//右岸符合条件
                                        {
                                            if(yun_ye!=ye||yun_chuan!=ch)//保证和上次的不同
                                            {
                                               //if(yunzou(zuoye+yun_ye-ye,zuoch+yun_chuan-ch,true,step++,ye,ch)==true)//否则要多几趟运走
                                               if(yunzou(zuoye+yun_ye,zuoch+yun_chuan,true,step++,ye,ch)==true)//否则要多几趟运走
                                               {
                                                   int[] x=new int[3];
                                                   x[0]=ye;//野人数目
                                                   x[1]=ch;//传教士数目
                                                   x[2]=0;//向右移
                                                   move.add(x);
                                                   return true;
                                               }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                } 
            }
             
         }
         return false;//默认必须返回不可达到
     }
}
