using System;
namespace _44
{
	class program
	{
		static void Main(string[] args){
			//int:
			int iMax=int.MaxValue;
			int pVal=int.Parse("100");
			short i16=50;
			int i32=i16;
			i16=i32;//����
			i16=(short)i32;
			//decimal:
			decimal iRate=3.9834M;
			iRate=decimal.Round(iRate,2);//��������
			iRate=decimal.Remainder(512.0M,51.0M);
			//bool:
			bool bt=(bool)1;//����
			//char:
			string pattern="123abcd?";
			bool bt;
			bt=char.IsLetter(pattern,3);
			bt=char.IsNumber(pattern,3);
			bt.char.IsLower(pattern,3);
			bt=char.IsPunctuation(pattern,7);
			bt=char.IsLetterOrDigit(pattern,3);
			//single,double
			float f=24567.66f;
			double d=124.45;
			if(Single.IsNaN(1/0)){}
			//ʹ��Parseת�������ַ���
			short shParse=Int16.Parse("100");
			int iParse=Int32.Parse("100");
			long shParse=Int64.Parse("100");
			decimal dParse=decimal.Parse("99.99");
			float sParse=float.Parse("99.99");
			double dParse=double.Parse("99.99");
			//�ַ���ֱ����
			string path;
			path=@"C:\note.txt";
			path="C:\\note.txt";
			//�ַ�������
				//�����ַ����еĵ����ַ�
				string str="abcd";
				char c=str[0];
				//�ַ�������
				string s1="My age=";
				int myAge=28;
				string cat=s1+myAge;
				//��ȡ�Ͷ�λ�Ӵ�
				string poem="In Xanadu did Kubla Khan";
				string poem=poem.Substring(10);
				poemSeg=poem.Substring(0,9);
				int index=poem.IndexOf("I");
				index=poem.LastIndexOf("n");
				//�Ƚ��ַ���
				bool isMatch;
				string title="Ancient Mariner";
				isMatch=(title=="ANCIENT AMRINER");
				isMatch=(title.ToUpper()=="ANCIENT MARINER");
				isMatch=title.Equals("Ancient Mariner");
				//
				//
		}
	}
}