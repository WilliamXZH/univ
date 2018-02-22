int matching(string &exp) {
//exp is a pointer to a string to check
  int state = 1,i=0; 
  char e;  
  stack<char> s;
  while ( i<exp.length() && state ) 
     switch (exp[i]) {
        case '[':
        case '(': 
             s.push(exp[i]);      
              //push the open character onto stack
              i++;  
              break; 
        case ')':
             if ( !s.empty() && s.top() == '(') { 
		s.pop();  i++; }                    
             else 
	         state = 0;                               //an error occurs
             break; 
        case ']': 
            if ( !s.empty() && s.top() == '['){
	       s.pop();  i++; }
            else 
	       state = 0;                               // an error occurs
            break; 
        default:
            i++; break; 
  }     //end of while

  if ( state && s.empty() )  return 1;    
  else  return 0; 
}
