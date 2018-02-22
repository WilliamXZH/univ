class StringIterator {
    
private:
    int loc=0;
    int size=0;
    char str[1000];
    int num[1000];
public:
    StringIterator(string compressedString) {
        int length = compressedString.length();
        
        for(int i=0;i<length;){
            str[size] = compressedString[i];
            int l = 0;
            num[size]=0;
            
            
            for(i++;compressedString[i]>='0'&&compressedString[i]<='9';i++){
                l = l*10 +compressedString[i]-'0';
            }
            num[size] = l;
            
            size++;
            
        }
        str[size] = ' ';
        num[size] = 1;
    }
    
    char next() {
        if(loc<size){
            if(num[loc]>0){
                num[loc]--;
            }else{
                loc++;
                num[loc]--;
            }
            return str[loc];
        }else{
            return ' ';
        }
    }
    
    bool hasNext() {
        return num[loc]>0||num[loc]==0&&loc<size-1;
    }
};

/**
 * Your StringIterator object will be instantiated and called as such:
 * StringIterator obj = new StringIterator(compressedString);
 * char param_1 = obj.next();
 * bool param_2 = obj.hasNext();
 */