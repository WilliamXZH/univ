//--��������Ҫ�İ�
using System.IO;
using System.Text;
using System.Security.Cryptography;
public class test
{
	public static void main(String[] args){
		
	}
}
class DES
{
	public static string Key = "DKMAB5DE";//������Կ����Ϊ8λ
//�����㷨
	public static string MD5Encrypt(string pToEncrypt)
		 {
           DESCryptoServiceProvider des = new DESCryptoServiceProvider();
           byte[] inputByteArray = Encoding.Default.GetBytes(pToEncrypt);
           des.Key = ASCIIEncoding.ASCII.GetBytes(Key);
           des.IV = ASCIIEncoding.ASCII.GetBytes(Key);
           MemoryStream ms = new MemoryStream();
           CryptoStream cs = new CryptoStream(ms, des.CreateEncryptor(), CryptoStreamMode.Write);
           cs.Write(inputByteArray, 0, inputByteArray.Length);
           cs.FlushFinalBlock();
           StringBuilder ret = new StringBuilder();
           foreach (byte b in ms.ToArray())
           {
               ret.AppendFormat("{0:X2}", b);
           }
           ret.ToString();
           return ret.ToString();

       }


//�����㷨
	public static string MD5Decrypt(string pToDecrypt)
       {
           DESCryptoServiceProvider des = new DESCryptoServiceProvider();
           byte[] inputByteArray = new byte[pToDecrypt.Length / 2];
           for (int x = 0; x < pToDecrypt.Length / 2; x++)
           {
               int i = (Convert.ToInt32(pToDecrypt.Substring(x * 2, 2), 16));
               inputByteArray[x] = (byte)i;
           }
           des.Key = ASCIIEncoding.ASCII.GetBytes(Key);
           des.IV = ASCIIEncoding.ASCII.GetBytes(Key);
           MemoryStream ms = new MemoryStream();
           CryptoStream cs = new CryptoStream(ms, des.CreateDecryptor(), CryptoStreamMode.Write);
           cs.Write(inputByteArray, 0, inputByteArray.Length);
           cs.FlushFinalBlock();
           StringBuilder ret = new StringBuilder();
           return System.Text.Encoding.ASCII.GetString(ms.ToArray());

       }
}
class RSA
{
	//�����㷨
	public string RSAEncrypt(string encryptString)
    {
        CspParameters csp = new CspParameters();
        csp.KeyContainerName = "whaben";
        RSACryptoServiceProvider RSAProvider = new RSACryptoServiceProvider(csp);
        byte[] encryptBytes = RSAProvider.Encrypt(ASCIIEncoding.ASCII.GetBytes(encryptString), true);
        string str = "";
        foreach (byte b in encryptBytes)
        {
            str = str + string.Format("{0:x2}", b);
        }
        return str;
    }
	//�����㷨
	public string RSADecrypt(string decryptString)
    {
        CspParameters csp = new CspParameters();
        csp.KeyContainerName = "whaben";
        RSACryptoServiceProvider RSAProvider = new RSACryptoServiceProvider(csp);
        int length = (decryptString.Length / 2);
        byte[] decryptBytes = new byte[length];
        for (int index = 0; index < length; index++)
        {
            string substring = decryptString.Substring(index * 2, 2);
            decryptBytes[index] = Convert.ToByte(substring, 16);
        }
        decryptBytes = RSAProvider.Decrypt(decryptBytes, true);
        return ASCIIEncoding.ASCII.GetString(decryptBytes);
    }
}