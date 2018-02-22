	TITLE	..\kernel\vsprintf.c
	.386P
include listing.inc
if @Version gt 510
.model FLAT
else
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
_DATA	SEGMENT DWORD USE32 PUBLIC 'DATA'
_DATA	ENDS
CONST	SEGMENT DWORD USE32 PUBLIC 'CONST'
CONST	ENDS
_BSS	SEGMENT DWORD USE32 PUBLIC 'BSS'
_BSS	ENDS
_TLS	SEGMENT DWORD USE32 PUBLIC 'TLS'
_TLS	ENDS
;	COMDAT _strcpy
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT _strcat
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT _strcmp
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT _strspn
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT _strcsrcpn
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT _strpbrk
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT _strstr
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT _strlen
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT _strtok
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT _memcpy
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT _memmove
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT _memcmp
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT _memchr
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT _memset
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT __do_div
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
FLAT	GROUP _DATA, CONST, _BSS
	ASSUME	CS: FLAT, DS: FLAT, SS: FLAT
endif
PUBLIC	__do_div
;	COMDAT __do_div
_TEXT	SEGMENT
_n$ = 8
_base$ = 12
___res$ = -4
__do_div PROC NEAR					; COMDAT

; 45   : {

	push	ebp
	mov	ebp, esp
	push	ecx
	push	ebx

; 46   : 	int __res;
; 47   : 	_asm mov ecx,n

	mov	ecx, DWORD PTR _n$[ebp]

; 48   : 	_asm mov eax,[ecx]

	mov	eax, DWORD PTR [ecx]

; 49   : 	_asm xor edx,edx

	xor	edx, edx

; 50   : 	_asm mov ebx,base

	mov	ebx, DWORD PTR _base$[ebp]

; 51   : 	_asm div ebx

	div	ebx

; 52   : 	_asm mov [ecx],eax

	mov	DWORD PTR [ecx], eax

; 53   : 	_asm mov __res,edx

	mov	DWORD PTR ___res$[ebp], edx

; 54   : 	return __res;

	mov	eax, DWORD PTR ___res$[ebp]
	pop	ebx

; 55   : }

	mov	esp, ebp
	pop	ebp
	ret	0
__do_div ENDP
_TEXT	ENDS
PUBLIC	_strcpy
;	COMDAT _strcpy
_TEXT	SEGMENT
_dest$ = 8
_src$ = 12
_strcpy	PROC NEAR					; COMDAT

; 33   : {

	push	ebp
	mov	ebp, esp
	push	esi
	push	edi

; 34   : 	_asm{
; 35   : 		pushf

	pushf

; 36   : 		mov esi,src

	mov	esi, DWORD PTR _src$[ebp]

; 37   : 		mov edi,dest

	mov	edi, DWORD PTR _dest$[ebp]

; 38   : 		cld		// 清方向位。

	cld
$l1$46:

; 39   : 	l1:	lodsb	// 加载DS:[esi]处1 字节->al，并更新esi。

	lodsb

; 40   : 		stosb		// 存储字节al->ES:[edi]，并更新edi。

	stosb

; 41   : 		test al,al	// 刚存储的字节是0？

	test	al, al

; 42   : 		jne l1	// 不是则跳转到标号l1 处，否则结束。

	jne	SHORT $l1$46

; 43   : 		popf

	popf

; 44   : 	}
; 45   : 	return dest;			// 返回目的字符串指针。

	mov	eax, DWORD PTR _dest$[ebp]

; 46   : }

	pop	edi
	pop	esi
	pop	ebp
	ret	0
_strcpy	ENDP
_TEXT	ENDS
PUBLIC	_strcat
;	COMDAT _strcat
_TEXT	SEGMENT
_dest$ = 8
_src$ = 12
_strcat	PROC NEAR					; COMDAT

; 104  : {

	push	ebp
	mov	ebp, esp
	push	esi
	push	edi

; 105  : 	_asm {
; 106  : 		pushf

	pushf

; 107  : 		mov esi,src

	mov	esi, DWORD PTR _src$[ebp]

; 108  : 		mov edi,dest

	mov	edi, DWORD PTR _dest$[ebp]

; 109  : 		xor al,al

	xor	al, al

; 110  : 		mov ecx,0xffffffff

	mov	ecx, -1

; 111  : 		cld		// 清方向位。

	cld

; 112  : 		repne scasb		// 比较al 与es:[edi]字节，并更新edi++，

	repnz	 scasb

; 113  : 						// 直到找到目的串中是0 的字节，此时edi 已经指向后1 字节。
; 114  : 		dec edi		// 让es:[edi]指向0 值字节。

	dec	edi
$l1$63:

; 115  : 	l1: lodsb	// 取源字符串字节ds:[esi]->al，并esi++。

	lodsb

; 116  : 		stosb		// 将该字节存到es:[edi]，并edi++。

	stosb

; 117  : 		test al,al	// 该字节是0？

	test	al, al

; 118  : 		jne l1	// 不是，则向后跳转到标号1 处继续拷贝，否则结束。

	jne	SHORT $l1$63

; 119  : 		popf

	popf

; 120  : 	}
; 121  : 	return dest;			// 返回目的字符串指针。

	mov	eax, DWORD PTR _dest$[ebp]

; 122  : }

	pop	edi
	pop	esi
	pop	ebp
	ret	0
_strcat	ENDP
_TEXT	ENDS
PUBLIC	_vsprintf
_TEXT	SEGMENT
_buf$ = 8
_fmt$ = 12
_args$ = 16
_len$ = -8
_str$ = -4
_s$ = -12
_flags$ = 16
_vsprintf PROC NEAR

; 151  : {

	push	ebp
	mov	ebp, esp
	sub	esp, 16					; 00000010H

; 165  : 	int qualifier;		/* 'h', 'l', or 'L' for integer fields */
; 166  : /* 'h', 'l',或'L'用于整数字段 */
; 167  : // 首先将字符指针指向buf，然后扫描格式字符串，对各个格式转换指示进行相应的处理。
; 168  : 	for (str = buf; *fmt; ++fmt)

	mov	edx, DWORD PTR _fmt$[ebp]
	push	ebx
	push	esi
	push	edi
	mov	al, BYTE PTR [edx]
	mov	edi, DWORD PTR _buf$[ebp]
	test	al, al
	mov	DWORD PTR _str$[ebp], edi
	je	$L303
	mov	ecx, DWORD PTR _args$[ebp]
	lea	esi, DWORD PTR [ecx-4]
	jmp	SHORT $L301
$L497:
	mov	edx, DWORD PTR _fmt$[ebp]
$L301:

; 169  : 	{
; 170  : // 格式转换指示字符串均以'%'开始，这里从fmt 格式字符串中扫描'%'，寻找格式转换字符串的开始。
; 171  : // 不是格式指示的一般字符均被依次存入str。
; 172  : 		if (*fmt != '%')

	cmp	al, 37					; 00000025H
	je	SHORT $L304

; 173  : 		{
; 174  : 			*str++ = *fmt;

	mov	BYTE PTR [edi], al
	inc	edi
	mov	DWORD PTR _str$[ebp], edi

; 175  : 			continue;

	jmp	$L302
$L304:

; 176  : 		}
; 177  : 
; 178  : // 下面取得格式指示字符串中的标志域，并将标志常量放入flags 变量中。
; 179  : /* process flags */
; 180  : 		flags = 0;

	xor	ecx, ecx

; 181  : repeat:
; 182  : 		++fmt;			/* this also skips first '%' */

	inc	edx
	mov	DWORD PTR _fmt$[ebp], edx
	mov	DWORD PTR _flags$[ebp], ecx

; 183  : 		switch (*fmt)
; 184  : 		{

	movsx	eax, BYTE PTR [edx]
	add	eax, -32				; ffffffe0H
	cmp	eax, 16					; 00000010H
	ja	SHORT $L307
$repeat$305:
	xor	ebx, ebx
	mov	bl, BYTE PTR $L506[eax]
	jmp	DWORD PTR $L507[ebx*4]
$L310:

; 185  : 		case '-':
; 186  : 			flags |= LEFT;

	or	ecx, 16					; 00000010H

; 187  : 			goto repeat;		// 左靠齐调整。

	jmp	SHORT $L478
$L311:

; 188  : 		case '+':
; 189  : 			flags |= PLUS;

	or	ecx, 4

; 190  : 			goto repeat;		// 放加号。

	jmp	SHORT $L478
$L312:

; 191  : 		case ' ':
; 192  : 			flags |= SPACE;

	or	ecx, 8

; 193  : 			goto repeat;		// 放空格。

	jmp	SHORT $L478
$L313:

; 194  : 		case '#':
; 195  : 			flags |= SPECIAL;

	or	ecx, 32					; 00000020H

; 196  : 			goto repeat;		// 是特殊转换。

	jmp	SHORT $L478
$L314:

; 197  : 		case '0':
; 198  : 			flags |= ZEROPAD;

	or	ecx, 1
$L478:

; 181  : repeat:
; 182  : 		++fmt;			/* this also skips first '%' */

	inc	edx
	mov	DWORD PTR _fmt$[ebp], edx

; 183  : 		switch (*fmt)
; 184  : 		{

	movsx	eax, BYTE PTR [edx]
	add	eax, -32				; ffffffe0H
	cmp	eax, 16					; 00000010H
	jbe	SHORT $repeat$305
$L501:

; 185  : 		case '-':
; 186  : 			flags |= LEFT;

	mov	DWORD PTR _flags$[ebp], ecx
$L307:

; 199  : 			goto repeat;		// 要填零(即'0')。
; 200  : 		}
; 201  : 
; 202  : // 取当前参数字段宽度域值，放入field_width 变量中。如果宽度域中是数值则直接取其为宽度值。
; 203  : // 如果宽度域中是字符'*'，表示下一个参数指定宽度。因此调用va_arg 取宽度值。若此时宽度值
; 204  : // 小于0，则该负数表示其带有标志域'-'标志（左靠齐），因此还需在标志变量中添入该标志，并
; 205  : // 将字段宽度值取为其绝对值。
; 206  : /* get field width */
; 207  : 		field_width = -1;
; 208  : 		if (is_digit (*fmt))

	mov	al, BYTE PTR [edx]
	or	ebx, -1
	cmp	al, 48					; 00000030H
	jl	SHORT $L315
	cmp	al, 57					; 00000039H
	jg	SHORT $L315

; 209  : 			field_width = skip_atoi (&fmt);

	lea	edx, DWORD PTR _fmt$[ebp]
	push	edx
	call	_skip_atoi
	add	esp, 4
	mov	ebx, eax

; 210  : 		else if (*fmt == '*')

	jmp	SHORT $L327
$L315:
	cmp	al, 42					; 0000002aH
	jne	SHORT $L327

; 211  : 		{
; 212  : /* it's the next argument */
; 213  : 			field_width = va_arg (args, int);

	mov	ebx, DWORD PTR [esi+4]
	add	esi, 4

; 214  : 			if (field_width < 0)

	test	ebx, ebx
	jge	SHORT $L327

; 215  : 			{
; 216  : 				field_width = -field_width;

	neg	ebx

; 217  : 				flags |= LEFT;

	or	ecx, 16					; 00000010H
	mov	DWORD PTR _flags$[ebp], ecx
$L327:

; 218  : 			}
; 219  : 		}
; 220  : 
; 221  : // 下面这段代码，取格式转换串的精度域，并放入precision 变量中。精度域开始的标志是'.'。
; 222  : // 其处理过程与上面宽度域的类似。如果精度域中是数值则直接取其为精度值。如果精度域中是
; 223  : // 字符'*'，表示下一个参数指定精度。因此调用va_arg 取精度值。若此时宽度值小于0，则
; 224  : // 将字段精度值取为其绝对值。
; 225  : /* get the precision */
; 226  : 		precision = -1;
; 227  : 		if (*fmt == '.')

	mov	ecx, DWORD PTR _fmt$[ebp]
	or	edx, -1
	cmp	BYTE PTR [ecx], 46			; 0000002eH
	jne	SHORT $L341

; 228  : 		{
; 229  : 			++fmt;

	inc	ecx
	mov	DWORD PTR _fmt$[ebp], ecx

; 230  : 			if (is_digit (*fmt))

	mov	al, BYTE PTR [ecx]
	cmp	al, 48					; 00000030H
	jl	SHORT $L329
	cmp	al, 57					; 00000039H
	jg	SHORT $L329

; 231  : 				precision = skip_atoi (&fmt);

	lea	eax, DWORD PTR _fmt$[ebp]
	push	eax
	call	_skip_atoi
	add	esp, 4
	mov	edx, eax

; 232  : 			else if (*fmt == '*')

	jmp	SHORT $L331
$L329:
	cmp	al, 42					; 0000002aH
	jne	SHORT $L485

; 233  : 			{
; 234  : /* it's the next argument */
; 235  : 				precision = va_arg (args, int);

	mov	edx, DWORD PTR [esi+4]
	add	esi, 4
$L331:

; 236  : 			}
; 237  : 			if (precision < 0)

	mov	ecx, DWORD PTR _fmt$[ebp]
	test	edx, edx
	jge	SHORT $L341
$L485:

; 238  : 			precision = 0;

	xor	edx, edx
$L341:

; 239  : 		}
; 240  : 
; 241  : // 下面这段代码分析长度修饰符，并将其存入qualifer 变量。（h,l,L 的含义参见列表后的说明）。
; 242  : /* get the conversion qualifier */
; 243  : 		qualifier = -1;
; 244  : 		if (*fmt == 'h' || *fmt == 'l' || *fmt == 'L')

	mov	al, BYTE PTR [ecx]
	cmp	al, 104					; 00000068H
	je	SHORT $L343
	cmp	al, 108					; 0000006cH
	je	SHORT $L343
	cmp	al, 76					; 0000004cH
	jne	SHORT $L342
$L343:

; 245  : 		{
; 246  : 			qualifier = *fmt;
; 247  : 			++fmt;

	inc	ecx
	mov	DWORD PTR _fmt$[ebp], ecx
$L342:

; 248  : 		}
; 249  : 
; 250  : // 下面分析转换指示符。
; 251  : 		switch (*fmt)
; 252  : 		{

	movsx	eax, BYTE PTR [ecx]
	add	eax, -88				; ffffffa8H
	cmp	eax, 32					; 00000020H
	ja	$L443
	xor	ecx, ecx
	mov	cl, BYTE PTR $L508[eax]
	jmp	DWORD PTR $L509[ecx*4]
$L348:

; 253  : // 如果转换指示符是'c'，则表示对应参数应是字符。此时如果标志域表明不是左靠齐，则该字段前面
; 254  : // 放入宽度域值-1 个空格字符，然后再放入参数字符。如果宽度域还大于0，则表示为左靠齐，则在
; 255  : // 参数字符后面添加宽度值-1 个空格字符。
; 256  : 		case 'c':
; 257  : 			if (!(flags & LEFT))

	test	BYTE PTR _flags$[ebp], 16		; 00000010H
	jne	SHORT $L351

; 258  : 				while (--field_width > 0)

	dec	ebx
	test	ebx, ebx
	jle	SHORT $L351
	mov	ecx, ebx
	mov	eax, 538976288				; 20202020H
	mov	edx, ecx
	shr	ecx, 2
	rep stosd
	mov	ecx, edx
	and	ecx, 3
	rep stosb
	mov	eax, DWORD PTR _str$[ebp]
	add	eax, ebx
	xor	ebx, ebx
	mov	DWORD PTR _str$[ebp], eax
	mov	edi, eax
$L351:

; 259  : 					*str++ = ' ';
; 260  : 			*str++ = (unsigned char) va_arg (args, int);

	mov	al, BYTE PTR [esi+4]
	add	esi, 4
	mov	BYTE PTR [edi], al
	inc	edi

; 261  : 			while (--field_width > 0)

	dec	ebx
	mov	DWORD PTR _str$[ebp], edi
	test	ebx, ebx
	jle	$L302
	mov	ecx, ebx
	mov	eax, 538976288				; 20202020H
$L505:
	mov	edx, ecx
	shr	ecx, 2
	rep stosd
	mov	ecx, edx
	and	ecx, 3
	rep stosb
	mov	eax, DWORD PTR _str$[ebp]
	add	eax, ebx

; 262  : 				*str++ = ' ';
; 263  : 			break;

	jmp	$L504
$L366:

; 264  : 
; 265  : // 如果转换指示符是's'，则表示对应参数是字符串。首先取参数字符串的长度，若其超过了精度域值，
; 266  : // 则扩展精度域=字符串长度。此时如果标志域表明不是左靠齐，则该字段前放入(宽度值-字符串长度)
; 267  : // 个空格字符。然后再放入参数字符串。如果宽度域还大于0，则表示为左靠齐，则在参数字符串后面
; 268  : // 添加(宽度值-字符串长度)个空格字符。
; 269  : 		case 's':
; 270  : 			s = va_arg (args, char *);

	mov	eax, DWORD PTR [esi+4]
	add	esi, 4
	mov	DWORD PTR -16+[ebp], esi
	mov	DWORD PTR _s$[ebp], eax

; 152  : 	int len;
; 153  : 	int i;
; 154  : 	char *str;			// 用于存放转换过程中的字符串。

	pushf

; 155  : 	char *s;

	mov	edi, DWORD PTR _s$[ebp]

; 156  : 	int *ip;

	mov	ecx, -1

; 157  : 

	xor	al, al

; 158  : 	int flags;			/* flags to number() */

	cld

; 159  : /* number()函数使用的标志 */

	repnz	 scasb

; 160  : 	int field_width;		/* width of output field */

	not	ecx

; 161  : /* 输出字段宽度*/

	dec	ecx

; 162  : 	int precision;		/* min. # of digits for integers; max
; 163  : 				   number of chars for from string */

	mov	eax, ecx

; 164  : /* min. 整数数字个数；max. 字符串中字符个数 */

	popf

; 271  : 			len = strlen (s);
; 272  : 			if (precision < 0)

	test	edx, edx
	mov	DWORD PTR _len$[ebp], eax
	jl	SHORT $L378

; 273  : 				precision = len;
; 274  : 			else if (len > precision)

	cmp	eax, edx
	jle	SHORT $L378

; 275  : 				len = precision;

	mov	DWORD PTR _len$[ebp], edx
	mov	eax, edx
$L378:

; 276  : 
; 277  : 			if (!(flags & LEFT))

	test	BYTE PTR _flags$[ebp], 16		; 00000010H
	jne	SHORT $L382

; 278  : 				while (len < field_width--)

	mov	ecx, ebx
	dec	ebx
	cmp	eax, ecx
	jge	SHORT $L382
	mov	edx, ebx
	mov	edi, DWORD PTR _str$[ebp]
	sub	edx, eax
	mov	eax, 538976288				; 20202020H
	inc	edx
	mov	ecx, edx
	mov	esi, ecx
	shr	ecx, 2
	rep stosd
	mov	ecx, esi
	and	ecx, 3
	rep stosb
	add	DWORD PTR _str$[ebp], edx
$L381:
	dec	edx
	dec	ebx
	test	edx, edx
	ja	SHORT $L381
	mov	esi, DWORD PTR -16+[ebp]
	mov	eax, DWORD PTR _len$[ebp]
$L382:

; 279  : 					*str++ = ' ';
; 280  : 			for (i = 0; i < len; ++i)

	test	eax, eax
	jle	SHORT $L383
	mov	esi, DWORD PTR _s$[ebp]
	mov	edi, DWORD PTR _str$[ebp]
	mov	ecx, eax
	mov	edx, ecx
	shr	ecx, 2
	rep movsd
	mov	ecx, edx
	and	ecx, 3
	rep movsb
	mov	ecx, DWORD PTR _str$[ebp]
	mov	esi, DWORD PTR -16+[ebp]
	add	ecx, eax
	mov	DWORD PTR _str$[ebp], ecx
$L383:

; 281  : 				*str++ = *s++;
; 282  : 			while (len < field_width--)

	mov	ecx, ebx
	dec	ebx
	cmp	eax, ecx
	jge	SHORT $L491
	mov	edi, DWORD PTR _str$[ebp]
	sub	ebx, eax
	inc	ebx
	mov	eax, 538976288				; 20202020H
	mov	ecx, ebx

; 283  : 				*str++ = ' ';
; 284  : 			break;

	jmp	$L505
$L389:

; 285  : 
; 286  : // 如果格式转换符是'o'，表示需将对应的参数转换成八进制数的字符串。调用number()函数处理。
; 287  : 		case 'o':
; 288  : 			str = number (str, va_arg (args, unsigned long), 8,
; 289  : 									field_width, precision, flags);

	mov	eax, DWORD PTR _flags$[ebp]
	add	esi, 4
	push	eax
	push	edx
	push	ebx
	push	8
$L503:

; 307  : 		case 'X':
; 308  : 			str = number (str, va_arg (args, unsigned long), 16,
; 309  : 									field_width, precision, flags);

	mov	ecx, DWORD PTR [esi]
	push	ecx
	push	edi
	call	_number
	add	esp, 24					; 00000018H
$L504:
	mov	DWORD PTR _str$[ebp], eax
$L491:

; 338  : 				--fmt;

	mov	edi, DWORD PTR _str$[ebp]
$L302:

; 165  : 	int qualifier;		/* 'h', 'l', or 'L' for integer fields */
; 166  : /* 'h', 'l',或'L'用于整数字段 */
; 167  : // 首先将字符指针指向buf，然后扫描格式字符串，对各个格式转换指示进行相应的处理。
; 168  : 	for (str = buf; *fmt; ++fmt)

	mov	eax, DWORD PTR _fmt$[ebp]
	inc	eax
	mov	DWORD PTR _fmt$[ebp], eax
	mov	al, BYTE PTR [eax]
	test	al, al
	jne	$L497
$L303:

; 339  : 			break;
; 340  : 		}
; 341  : 	}
; 342  : 	*str = '\0';			// 最后在转换好的字符串结尾处添上null。
; 343  : 	return str - buf;		// 返回转换好的字符串长度值。

	mov	ecx, DWORD PTR _buf$[ebp]
	mov	BYTE PTR [edi], 0
	mov	eax, edi

; 344  : }

	pop	edi
	pop	esi
	sub	eax, ecx
	pop	ebx
	mov	esp, ebp
	pop	ebp
	ret	0
$L399:

; 290  : 			break;
; 291  : 
; 292  : // 如果格式转换符是'p'，表示对应参数的一个指针类型。此时若该参数没有设置宽度域，则默认宽度
; 293  : // 为8，并且需要添零。然后调用number()函数进行处理。
; 294  : 		case 'p':
; 295  : 			if (field_width == -1)

	cmp	ebx, -1
	jne	SHORT $L400

; 296  : 			{
; 297  : 				field_width = 8;
; 298  : 				flags |= ZEROPAD;

	mov	eax, DWORD PTR _flags$[ebp]
	mov	ebx, 8
	or	al, 1

; 307  : 		case 'X':
; 308  : 			str = number (str, va_arg (args, unsigned long), 16,
; 309  : 									field_width, precision, flags);

	add	esi, 4
	push	eax
	push	edx
	push	ebx
	mov	DWORD PTR _flags$[ebp], eax
	push	16					; 00000010H

; 310  : 			break;

	jmp	SHORT $L503
$L411:

; 299  : 			}
; 300  : 			str = number (str, (unsigned long) va_arg (args, void *), 16,
; 301  : 							field_width, precision, flags);
; 302  : 			break;
; 303  : 
; 304  : // 若格式转换指示是'x'或'X'，则表示对应参数需要打印成十六进制数输出。'x'表示用小写字母表示。
; 305  : 		case 'x':
; 306  : 			flags |= SMALL;

	mov	eax, DWORD PTR _flags$[ebp]
	or	al, 64					; 00000040H
	mov	DWORD PTR _flags$[ebp], eax
$L400:

; 307  : 		case 'X':
; 308  : 			str = number (str, va_arg (args, unsigned long), 16,
; 309  : 									field_width, precision, flags);

	mov	eax, DWORD PTR _flags$[ebp]
	add	esi, 4
	push	eax
	push	edx
	push	ebx
	push	16					; 00000010H

; 310  : 			break;

	jmp	SHORT $L503
$L422:

; 311  : 
; 312  : // 如果格式转换字符是'd','i'或'u'，则表示对应参数是整数，'d', 'i'代表符号整数，因此需要加上
; 313  : // 带符号标志。'u'代表无符号整数。
; 314  : 		case 'd':
; 315  : 		case 'i':
; 316  : 			flags |= SIGN;

	mov	eax, DWORD PTR _flags$[ebp]
	or	al, 2
	mov	DWORD PTR _flags$[ebp], eax
$L423:

; 317  : 		case 'u':
; 318  : 			str = number (str, va_arg (args, unsigned long), 10,
; 319  : 									field_width, precision, flags);

	mov	eax, DWORD PTR _flags$[ebp]
	add	esi, 4
	push	eax
	push	edx
	push	ebx
	push	10					; 0000000aH

; 320  : 			break;

	jmp	SHORT $L503
$L433:

; 321  : 
; 322  : // 若格式转换指示符是'n'，则表示要把到目前为止转换输出的字符数保存到对应参数指针指定的位置中。
; 323  : // 首先利用va_arg()取得该参数指针，然后将已经转换好的字符数存入该指针所指的位置。
; 324  : 		case 'n':
; 325  : 			ip = va_arg (args, int *);
; 326  : 			*ip = (str - buf);

	mov	eax, DWORD PTR _buf$[ebp]
	add	esi, 4
	mov	edx, edi
	sub	edx, eax
	mov	eax, DWORD PTR [esi]
	mov	DWORD PTR [eax], edx

; 327  : 			break;

	jmp	SHORT $L302
$L443:

; 328  : 
; 329  : // 若格式转换符不是'%'，则表示格式字符串有错，直接将一个'%'写入输出串中。
; 330  : // 如果格式转换符的位置处还有字符，则也直接将该字符写入输出串中，并返回到107 行继续处理
; 331  : // 格式字符串。否则表示已经处理到格式字符串的结尾处，则退出循环。
; 332  : 		default:
; 333  : 			if (*fmt != '%')

	mov	ecx, DWORD PTR _fmt$[ebp]
	cmp	BYTE PTR [ecx], 37			; 00000025H
	je	SHORT $L444

; 334  : 				*str++ = '%';

	mov	BYTE PTR [edi], 37			; 00000025H
	inc	edi
	mov	DWORD PTR _str$[ebp], edi
$L444:

; 335  : 			if (*fmt)

	mov	edx, DWORD PTR _fmt$[ebp]
	mov	al, BYTE PTR [edx]
	test	al, al
	je	SHORT $L445

; 336  : 				*str++ = *fmt;

	mov	BYTE PTR [edi], al
	inc	edi
	mov	DWORD PTR _str$[ebp], edi

; 337  : 			else

	jmp	$L302
$L445:

; 338  : 				--fmt;

	dec	DWORD PTR _fmt$[ebp]
	jmp	$L302

; 344  : }

	npad	2
$L507:
	DD	$L312
	DD	$L313
	DD	$L311
	DD	$L310
	DD	$L314
	DD	$L501
$L506:
	DB	0
	DB	5
	DB	5
	DB	1
	DB	5
	DB	5
	DB	5
	DB	5
	DB	5
	DB	5
	DB	5
	DB	2
	DB	5
	DB	3
	DB	5
	DB	5
	DB	4
	npad	3
$L509:
	DD	$L400
	DD	$L348
	DD	$L422
	DD	$L433
	DD	$L389
	DD	$L399
	DD	$L366
	DD	$L423
	DD	$L411
	DD	$L443
$L508:
	DB	0
	DB	9
	DB	9
	DB	9
	DB	9
	DB	9
	DB	9
	DB	9
	DB	9
	DB	9
	DB	9
	DB	1
	DB	2
	DB	9
	DB	9
	DB	9
	DB	9
	DB	2
	DB	9
	DB	9
	DB	9
	DB	9
	DB	3
	DB	4
	DB	5
	DB	9
	DB	9
	DB	6
	DB	9
	DB	7
	DB	9
	DB	9
	DB	8
_vsprintf ENDP
_s$ = 8
_skip_atoi PROC NEAR

; 24   : {

	push	ebp
	mov	ebp, esp
	push	esi

; 25   : 	int i = 0;
; 26   : 
; 27   : 	while (is_digit (**s))

	mov	esi, DWORD PTR _s$[ebp]
	xor	eax, eax
	mov	ecx, DWORD PTR [esi]
	cmp	BYTE PTR [ecx], 48			; 00000030H
	jl	SHORT $L216
$L215:
	mov	ecx, DWORD PTR [esi]
	mov	dl, BYTE PTR [ecx]
	cmp	dl, 57					; 00000039H
	jg	SHORT $L216

; 28   : 		i = i * 10 + *((*s)++) - '0';

	movsx	edx, dl
	lea	eax, DWORD PTR [eax+eax*4]
	inc	ecx
	mov	DWORD PTR [esi], ecx
	lea	eax, DWORD PTR [edx+eax*2-48]
	mov	dl, BYTE PTR [ecx]
	cmp	dl, 48					; 00000030H
	jge	SHORT $L215
$L216:
	pop	esi

; 29   : 	return i;
; 30   : }

	pop	ebp
	ret	0
_skip_atoi ENDP
_TEXT	ENDS
_DATA	SEGMENT
$SG242	DB	'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ', 00H
	ORG $+3
$SG245	DB	'0123456789abcdefghijklmnopqrstuvwxyz', 00H
_DATA	ENDS
_TEXT	SEGMENT
_str$ = 8
_num$ = 12
_base$ = 16
_size$ = 20
_precision$ = 24
_type$ = 28
_c$ = -2
_sign$ = -1
_tmp$ = -52
_digits$ = -8
_i$ = 12
___res$520 = -12
$T522 = 20
_number	PROC NEAR

; 66   : {

	push	ebp
	mov	ebp, esp
	sub	esp, 52					; 00000034H
	push	ebx

; 74   : 	if (type & SMALL)

	mov	ebx, DWORD PTR _type$[ebp]
	test	bl, 64					; 00000040H
	push	edi
	mov	DWORD PTR _digits$[ebp], OFFSET FLAT:$SG242
	je	SHORT $L244

; 75   : 		digits = "0123456789abcdefghijklmnopqrstuvwxyz";

	mov	DWORD PTR _digits$[ebp], OFFSET FLAT:$SG245
$L244:

; 76   : 	if (type & LEFT)

	test	bl, 16					; 00000010H
	je	SHORT $L246

; 77   : 		type &= ~ZEROPAD;

	and	ebx, -2					; fffffffeH
	mov	DWORD PTR _type$[ebp], ebx
$L246:

; 78   : 	if (base < 2 || base > 36)

	mov	edi, DWORD PTR _base$[ebp]
	cmp	edi, 2
	jl	$L248
	cmp	edi, 36					; 00000024H
	jg	$L248

; 80   : // 如果类型指出要填零，则置字符变量c='0'（也即''），否则c 等于空格字符。
; 81   : // 如果类型指出是带符号数并且数值num 小于0，则置符号变量sign=负号，并使num 取绝对值。
; 82   : // 否则如果类型指出是加号，则置sign=加号，否则若类型带空格标志则sign=空格，否则置0。
; 83   : 	c = (type & ZEROPAD) ? '0' : ' ';

	mov	al, bl

; 84   : 	if (type & SIGN && num < 0)

	mov	edx, DWORD PTR _num$[ebp]
	and	al, 1
	push	esi
	or	al, 2
	shl	al, 4
	test	bl, 2
	mov	BYTE PTR _c$[ebp], al
	je	SHORT $L249
	test	edx, edx
	jge	SHORT $L249

; 94   : 		size--;

	mov	esi, DWORD PTR _size$[ebp]
	mov	BYTE PTR _sign$[ebp], 45		; 0000002dH
	neg	edx
	mov	DWORD PTR _num$[ebp], edx
	dec	esi
	jmp	SHORT $L251
$L249:

; 85   : 	{
; 86   : 		sign = '-';
; 87   : 		num = -num;
; 88   : 	}
; 89   : 	else
; 90   : 		sign = (type & PLUS) ? '+' : ((type & SPACE) ? ' ' : 0);

	test	bl, 4
	je	SHORT $L516

; 94   : 		size--;

	mov	esi, DWORD PTR _size$[ebp]
	mov	BYTE PTR _sign$[ebp], 43		; 0000002bH
	dec	esi
	jmp	SHORT $L251
$L516:

; 85   : 	{
; 86   : 		sign = '-';
; 87   : 		num = -num;
; 88   : 	}
; 89   : 	else
; 90   : 		sign = (type & PLUS) ? '+' : ((type & SPACE) ? ' ' : 0);

	mov	cl, bl
	and	cl, 8
	shl	cl, 2
	mov	BYTE PTR _sign$[ebp], cl

; 91   : // 若带符号，则宽度值减1。若类型指出是特殊转换，则对于十六进制宽度再减少2 位(用于0x)，
; 92   : // 对于八进制宽度减1（用于八进制转换结果前放一个零）。
; 93   : 	if (sign)

	je	SHORT $L544

; 94   : 		size--;

	mov	esi, DWORD PTR _size$[ebp]
	dec	esi
	jmp	SHORT $L251
$L544:
	mov	esi, DWORD PTR _size$[ebp]
$L251:

; 95   : 	if (type & SPECIAL)

	mov	ecx, ebx
	and	ecx, 32					; 00000020H
	mov	DWORD PTR -16+[ebp], ecx
	je	SHORT $L255

; 96   : 		if (base == 16)

	cmp	edi, 16					; 00000010H
	jne	SHORT $L253

; 97   : 			size -= 2;

	sub	esi, 2

; 98   : 		else if (base == 8)

	jmp	SHORT $L255
$L253:
	cmp	edi, 8
	jne	SHORT $L255

; 99   : 			size--;

	dec	esi
$L255:

; 100  : // 如果数值num 为0，则临时字符串='0'；否则根据给定的基数将数值num 转换成字符形式。
; 101  : 	i = 0;

	xor	edi, edi

; 102  : 	if (num == 0)

	test	edx, edx
	jne	SHORT $L538

; 103  : 		tmp[i++] = '0';

	mov	DWORD PTR _i$[ebp], 1

; 104  : 	else

	mov	edi, DWORD PTR _i$[ebp]
	mov	BYTE PTR _tmp$[ebp], 48			; 00000030H
	jmp	SHORT $L260
$L538:

; 105  : 		while (num != 0)
; 106  : 			tmp[i++] = digits[do_div (num, base)];

	lea	eax, DWORD PTR _num$[ebp]
	mov	DWORD PTR $T522[ebp], eax
$L259:

; 67   : 	char c, sign, tmp[36];
; 68   : 	const char *digits = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";

	mov	ecx, DWORD PTR $T522[ebp]

; 69   : 	int i;

	mov	eax, DWORD PTR [ecx]

; 70   : 

	xor	edx, edx

; 71   : // 如果类型type 指出用小写字母，则定义小写字母集。

	mov	ebx, DWORD PTR _base$[ebp]

; 72   : // 如果类型指出要左调整（靠左边界），则屏蔽类型中的填零标志。

	div	ebx

; 73   : // 如果进制基数小于2 或大于36，则退出处理，也即本程序只能处理基数在2-32 之间的数。

	mov	DWORD PTR [ecx], eax

; 74   : 	if (type & SMALL)

	mov	DWORD PTR ___res$520[ebp], edx

; 105  : 		while (num != 0)
; 106  : 			tmp[i++] = digits[do_div (num, base)];

	mov	ecx, DWORD PTR ___res$520[ebp]
	mov	edx, DWORD PTR _digits$[ebp]
	inc	edi
	mov	al, BYTE PTR [ecx+edx]
	mov	BYTE PTR _tmp$[ebp+edi-1], al
	mov	eax, DWORD PTR _num$[ebp]
	test	eax, eax
	jne	SHORT $L259
	mov	ebx, DWORD PTR _type$[ebp]
	mov	al, BYTE PTR _c$[ebp]
	mov	DWORD PTR _i$[ebp], edi
$L260:

; 107  : // 若数值字符个数大于精度值，则精度值扩展为数字个数值。
; 108  : // 宽度值size 减去用于存放数值字符的个数。
; 109  : 	if (i > precision)

	mov	ecx, DWORD PTR _precision$[ebp]
	cmp	edi, ecx
	jle	SHORT $L261

; 110  : 		precision = i;

	mov	ecx, edi
	mov	DWORD PTR _precision$[ebp], ecx
$L261:

; 111  : 	size -= precision;

	sub	esi, ecx

; 112  : // 从这里真正开始形成所需要的转换结果，并暂时放在字符串str 中。
; 113  : // 若类型中没有填零(ZEROPAD)和左靠齐（左调整）标志，则在str 中首先
; 114  : // 填放剩余宽度值指出的空格数。若需带符号位，则存入符号。
; 115  : 	if (!(type & (ZEROPAD + LEFT)))

	test	bl, 17					; 00000011H
	mov	DWORD PTR _size$[ebp], esi
	jne	SHORT $L545

; 116  : 		while (size-- > 0)

	mov	edx, esi
	dec	esi
	test	edx, edx
	mov	DWORD PTR _size$[ebp], esi
	jle	SHORT $L545
	lea	edx, DWORD PTR [esi+1]
	mov	esi, DWORD PTR _str$[ebp]
	mov	ecx, edx
	mov	eax, 538976288				; 20202020H
	mov	ebx, ecx
	mov	edi, esi
	shr	ecx, 2
	rep stosd
	mov	ecx, ebx
	and	ecx, 3
	add	esi, edx
	rep stosb
$L264:
	mov	ecx, DWORD PTR _size$[ebp]
	dec	edx
	dec	ecx
	test	edx, edx
	mov	DWORD PTR _size$[ebp], ecx
	ja	SHORT $L264
	mov	edi, DWORD PTR _i$[ebp]
	mov	al, BYTE PTR _c$[ebp]
	mov	ebx, DWORD PTR _type$[ebp]
	mov	ecx, DWORD PTR _precision$[ebp]
$L265:

; 117  : 			*str++ = ' ';
; 118  : 	if (sign)

	mov	dl, BYTE PTR _sign$[ebp]
	test	dl, dl
	je	SHORT $L266

; 119  : 		*str++ = sign;

	mov	BYTE PTR [esi], dl
	inc	esi
$L266:

; 120  : // 若类型指出是特殊转换，则对于八进制转换结果头一位放置一个'0'；而对于十六进制则存放'0x'。
; 121  : 	if (type & SPECIAL)

	mov	edx, DWORD PTR -16+[ebp]
	test	edx, edx
	je	SHORT $L270

; 122  : 		if (base == 8)

	mov	edx, DWORD PTR _base$[ebp]
	cmp	edx, 8
	jne	SHORT $L268

; 123  : 			*str++ = '0';

	mov	BYTE PTR [esi], 48			; 00000030H

; 124  : 		else if (base == 16)

	jmp	SHORT $L549
$L545:

; 116  : 		while (size-- > 0)

	mov	esi, DWORD PTR _str$[ebp]
	jmp	SHORT $L265
$L268:

; 124  : 		else if (base == 16)

	cmp	edx, 16					; 00000010H
	jne	SHORT $L270

; 125  : 		{
; 126  : 			*str++ = '0';
; 127  : 			*str++ = digits[33];	// 'X'或'x'

	mov	edx, DWORD PTR _digits$[ebp]
	mov	BYTE PTR [esi], 48			; 00000030H
	inc	esi
	mov	dl, BYTE PTR [edx+33]
	mov	BYTE PTR [esi], dl
$L549:
	inc	esi
$L270:

; 128  : 		}
; 129  : // 若类型中没有左调整（左靠齐）标志，则在剩余宽度中存放c 字符（'0'或空格），见51 行。
; 130  : 	if (!(type & LEFT))
; 131  : 		while (size-- > 0)

	mov	edx, DWORD PTR _size$[ebp]
	test	bl, 16					; 00000010H
	jne	SHORT $L527
	mov	ebx, edx
	dec	edx
	test	ebx, ebx
	mov	DWORD PTR _size$[ebp], edx
	jle	SHORT $L527
	mov	bl, al
	lea	ecx, DWORD PTR [edx+1]
	mov	bh, bl
	mov	DWORD PTR 28+[ebp], ecx
	mov	eax, ebx
	mov	edx, ecx
	shl	eax, 16					; 00000010H
	mov	edi, esi
	mov	ax, bx
	shr	ecx, 2
	rep stosd
	mov	ecx, edx
	and	ecx, 3
	rep stosb
	mov	eax, edx
	add	esi, eax
$L273:
	mov	edx, DWORD PTR _size$[ebp]
	dec	eax
	dec	edx
	test	eax, eax
	mov	DWORD PTR _size$[ebp], edx
	ja	SHORT $L273
	mov	edi, DWORD PTR _i$[ebp]
	mov	ecx, DWORD PTR _precision$[ebp]
$L527:

; 132  : 			*str++ = c;
; 133  : // 此时i 存有数值num 的数字个数。若数字个数小于精度值，则str 中放入（精度值-i）个'0'。
; 134  : 	while (i < precision--)

	mov	eax, ecx
	dec	ecx
	cmp	edi, eax
	jge	SHORT $L276
	sub	ecx, edi
	mov	eax, 808464432				; 30303030H
	inc	ecx
	mov	edi, esi
	mov	edx, ecx
	mov	ebx, ecx
	shr	ecx, 2
	rep stosd
	mov	ecx, ebx
	and	ecx, 3
	add	esi, edx
	mov	edx, DWORD PTR _size$[ebp]
	rep stosb
	mov	edi, DWORD PTR _i$[ebp]
$L276:

; 135  : 		*str++ = '0';
; 136  : // 将转数值换好的数字字符填入str 中。共i 个。
; 137  : 	while (i-- > 0)

	mov	ecx, edi
	dec	edi
	test	ecx, ecx
	jle	SHORT $L529
$L279:

; 138  : 		*str++ = tmp[i];

	mov	al, BYTE PTR _tmp$[ebp+edi]
	mov	ecx, edi
	mov	BYTE PTR [esi], al
	inc	esi
	dec	edi
	test	ecx, ecx
	jg	SHORT $L279
$L529:

; 139  : // 若宽度值仍大于零，则表示类型标志中有左靠齐标志标志。则在剩余宽度中放入空格。
; 140  : 	while (size-- > 0)

	mov	eax, edx
	dec	edx
	test	eax, eax
	jle	SHORT $L282
	inc	edx
	mov	eax, 538976288				; 20202020H
	mov	ecx, edx
	mov	edi, esi
	mov	ebx, ecx
	shr	ecx, 2
	rep stosd
	mov	ecx, ebx
	and	ecx, 3
	add	esi, edx
	rep stosb
$L282:

; 141  : 		*str++ = ' ';
; 142  : 	return str;			// 返回转换好的字符串。

	mov	eax, esi
	pop	esi
	pop	edi
	pop	ebx

; 143  : }

	mov	esp, ebp
	pop	ebp
	ret	0
$L248:
	pop	edi

; 79   : 		return 0;

	xor	eax, eax
	pop	ebx

; 143  : }

	mov	esp, ebp
	pop	ebp
	ret	0
_number	ENDP
_TEXT	ENDS
PUBLIC	_strcmp
;	COMDAT _strcmp
_TEXT	SEGMENT
_csrc$ = 8
_ct$ = 12
_strcmp	PROC NEAR					; COMDAT

; 194  : {

	push	ebp
	mov	ebp, esp
	push	esi
	push	edi

; 195  : //  register int __res;	// __res 是寄存器变量(eax)。
; 196  :   _asm{
; 197  : 	  pushf

	pushf

; 198  : 	  mov edi,csrc

	mov	edi, DWORD PTR _csrc$[ebp]

; 199  : 	  mov esi,ct

	mov	esi, DWORD PTR _ct$[ebp]

; 200  : 	  cld		// 清方向位。

	cld
$l1$80:

; 201  :   l1: lodsb	// 取字符串2 的字节ds:[esi]??al，并且esi++。

	lodsb

; 202  : 	  scasb		// al 与字符串1 的字节es:[edi]作比较，并且edi++。

	scasb

; 203  : 	  jne l2		// 如果不相等，则向前跳转到标号2。

	jne	SHORT $l2$81

; 204  : 	  test al,al	// 该字节是0 值字节吗（字符串结尾）？

	test	al, al

; 205  : 	  jne l1		// 不是，则向后跳转到标号1，继续比较。

	jne	SHORT $l1$80

; 206  : 	  xor eax,eax	// 是，则返回值eax 清零，

	xor	eax, eax

; 207  : 	  jmp l3		// 向前跳转到标号3，结束。

	jmp	SHORT $l3$82
$l2$81:

; 208  :   l2: mov eax,1	// eax 中置1。

	mov	eax, 1

; 209  : 	  jl l3		// 若前面比较中串2 字符<串1 字符，则返回正值，结束。

	jl	SHORT $l3$82

; 210  : 	  neg eax	// 否则eax = -eax，返回负值，结束。

	neg	eax
$l3$82:

; 211  : //  l3: mov __res,eax
; 212  :   l3: popf

	popf

; 213  :   }
; 214  : //  return __res;			// 返回比较结果。
; 215  : }

	pop	edi
	pop	esi
	pop	ebp
	ret	0
_strcmp	ENDP
_TEXT	ENDS
PUBLIC	_strspn
;	COMDAT _strspn
_TEXT	SEGMENT
_csrc$ = 8
_ct$ = 12
___res$ = -4
_strspn	PROC NEAR					; COMDAT

; 382  : {

	push	ebp
	mov	ebp, esp
	push	ecx
	push	ebx
	push	esi
	push	edi

; 383  :   register char *__res;	// __res 是寄存器变量(esi)。
; 384  :   _asm{
; 385  : 	  pushf

	pushf

; 386  : 	  xor al,al

	xor	al, al

; 387  : 	  mov ebx,ct

	mov	ebx, DWORD PTR _ct$[ebp]

; 388  : 	  mov edi,ebx	// 首先计算串2 的长度。串2 指针放入edi 中。

	mov	edi, ebx

; 389  : 	  mov ecx,0xffffffff

	mov	ecx, -1

; 390  : 	  cld		// 清方向位。

	cld

; 391  : 	  repne scasb// 比较al(0)与串2 中的字符（es:[edi]），并edi++。如果不相等就继续比较(ecx 逐步递减)。

	repnz	 scasb

; 392  : 	  not ecx	// ecx 中每位取反。

	not	ecx

; 393  : 	  dec ecx	// ecx--，得串2 的长度值。-> ecx

	dec	ecx

; 394  : 	  mov edx,ecx	// 将串2 的长度值暂放入edx 中。

	mov	edx, ecx

; 395  : 	  mov esi,csrc

	mov	esi, DWORD PTR _csrc$[ebp]
$l1$118:

; 396  :   l1: lodsb	// 取串1 字符ds:[esi]->al，并且esi++。

	lodsb

; 397  : 	  test al,al	// 该字符等于0 值吗（串1 结尾）？

	test	al, al

; 398  : 	  je l2		// 如果是，则向前跳转到标号2 处。

	je	SHORT $l2$119

; 399  : 	  mov edi,ebx	// 取串2 头指针放入edi 中。

	mov	edi, ebx

; 400  : 	  mov ecx,edx	// 再将串2 的长度值放入ecx 中。

	mov	ecx, edx

; 401  : 	  repne scasb	// 比较al 与串2 中字符es:[edi]，并且edi++。如果不相等就继续比较。

	repnz	 scasb

; 402  : 	  je l1		// 如果相等，则向后跳转到标号1 处。

	je	SHORT $l1$118
$l2$119:

; 403  :   l2: dec esi	// esi--，指向最后一个包含在串2 中的字符。

	dec	esi

; 404  : 	  mov __res,esi

	mov	DWORD PTR ___res$[ebp], esi

; 405  : 	  popf

	popf

; 406  :   }
; 407  :   return __res - csrc;		// 返回字符序列的长度值。

	mov	eax, DWORD PTR ___res$[ebp]
	mov	ecx, DWORD PTR _csrc$[ebp]

; 408  : }

	pop	edi
	pop	esi
	sub	eax, ecx
	pop	ebx
	mov	esp, ebp
	pop	ebp
	ret	0
_strspn	ENDP
_TEXT	ENDS
PUBLIC	_strcsrcpn
;	COMDAT _strcsrcpn
_TEXT	SEGMENT
_csrc$ = 8
_ct$ = 12
___res$ = -4
_strcsrcpn PROC NEAR					; COMDAT

; 440  : {

	push	ebp
	mov	ebp, esp
	push	ecx
	push	ebx
	push	esi
	push	edi

; 441  :   register char *__res;	// __res 是寄存器变量(esi)。
; 442  : 	_asm{
; 443  : 		pushf

	pushf

; 444  : 		xor al,al

	xor	al, al

; 445  : 		mov ecx,0xffffffff

	mov	ecx, -1

; 446  : 		mov ebx,ct

	mov	ebx, DWORD PTR _ct$[ebp]

; 447  : 		mov edi,ebx	// 首先计算串2 的长度。串2 指针放入edi 中。

	mov	edi, ebx

; 448  : 		cld		// 清方向位。

	cld

; 449  : 		repne scasb// 比较al(0)与串2 中的字符（es:[edi]），并edi++。如果不相等就继续比较(ecx 逐步递减)。

	repnz	 scasb

; 450  : 		not ecx	// ecx 中每位取反。

	not	ecx

; 451  : 		dec ecx	// ecx--，得串2 的长度值。

	dec	ecx

; 452  : 		mov edx,ecx	// 将串2 的长度值暂放入edx 中。

	mov	edx, ecx

; 453  : 		mov esi,csrc

	mov	esi, DWORD PTR _csrc$[ebp]
$l1$127:

; 454  : 	l1: lodsb	// 取串1 字符ds:[esi]->al，并且esi++。

	lodsb

; 455  : 		test al,al	// 该字符等于0 值吗（串1 结尾）？

	test	al, al

; 456  : 		je l2		// 如果是，则向前跳转到标号2 处。

	je	SHORT $l2$128

; 457  : 		mov edi,ebx	// 取串2 头指针放入edi 中。

	mov	edi, ebx

; 458  : 		mov ecx,edx 	// 再将串2 的长度值放入ecx 中。

	mov	ecx, edx

; 459  : 		repne scasb	// 比较al 与串2 中字符es:[edi]，并且edi++。如果不相等就继续比较。

	repnz	 scasb

; 460  : 		jne l1		// 如果不相等，则向后跳转到标号1 处。

	jne	SHORT $l1$127
$l2$128:

; 461  : 	l2: dec esi

	dec	esi

; 462  : 		mov __res,esi	// esi--，指向最后一个包含在串2 中的字符。

	mov	DWORD PTR ___res$[ebp], esi

; 463  : 		popf

	popf

; 464  : 	}
; 465  :   return __res - csrc;		// 返回字符序列的长度值。

	mov	eax, DWORD PTR ___res$[ebp]
	mov	ecx, DWORD PTR _csrc$[ebp]

; 466  : }

	pop	edi
	pop	esi
	sub	eax, ecx
	pop	ebx
	mov	esp, ebp
	pop	ebp
	ret	0
_strcsrcpn ENDP
_TEXT	ENDS
PUBLIC	_strpbrk
;	COMDAT _strpbrk
_TEXT	SEGMENT
_csrc$ = 8
_ct$ = 12
_strpbrk PROC NEAR					; COMDAT

; 498  : {

	push	ebp
	mov	ebp, esp
	push	ebx
	push	esi
	push	edi

; 499  : //  register char *__res;	// __res 是寄存器变量(esi)。
; 500  : 	_asm{
; 501  : 		pushf

	pushf

; 502  : 		xor al,al

	xor	al, al

; 503  : 		mov ebx,ct

	mov	ebx, DWORD PTR _ct$[ebp]

; 504  : 		mov edi,ebx	// 首先计算串2 的长度。串2 指针放入edi 中。

	mov	edi, ebx

; 505  : 		mov ecx,0xffffffff

	mov	ecx, -1

; 506  : 		cld		// 清方向位。

	cld

; 507  : 		repne scasb// 比较al(0)与串2 中的字符（es:[edi]），并edi++。如果不相等就继续比较(ecx 逐步递减)。

	repnz	 scasb

; 508  : 		not ecx	// ecx 中每位取反。

	not	ecx

; 509  : 		dec ecx	// ecx--，得串2 的长度值。

	dec	ecx

; 510  : 		mov edx,ecx	// 将串2 的长度值暂放入edx 中。

	mov	edx, ecx

; 511  : 		mov esi,csrc

	mov	esi, DWORD PTR _csrc$[ebp]
$l1$135:

; 512  : 	l1: lodsb	// 取串1 字符ds:[esi]??al，并且esi++。

	lodsb

; 513  : 		test al,al	// 该字符等于0 值吗（串1 结尾）？

	test	al, al

; 514  : 		je l2		// 如果是，则向前跳转到标号2 处。

	je	SHORT $l2$136

; 515  : 		mov edi,ebx	// 取串2 头指针放入edi 中。

	mov	edi, ebx

; 516  : 		mov ecx,edx	// 再将串2 的长度值放入ecx 中。

	mov	ecx, edx

; 517  : 		repne scasb		// 比较al 与串2 中字符es:[edi]，并且edi++。如果不相等就继续比较。

	repnz	 scasb

; 518  : 		jne l1	// 如果不相等，则向后跳转到标号1 处。

	jne	SHORT $l1$135

; 519  : 		dec esi	// esi--，指向一个包含在串2 中的字符。

	dec	esi

; 520  : 		jmp l3		// 向前跳转到标号3 处。

	jmp	SHORT $l3$137
$l2$136:

; 521  : 	l2: xor esi,esi	// 没有找到符合条件的，将返回值为NULL。

	xor	esi, esi
$l3$137:

; 522  : //	l3: mov __res,esi
; 523  : 	l3: mov eax,esi

	mov	eax, esi

; 524  : 		popf

	popf

; 525  : 	}
; 526  : //  return __res;			// 返回指针值。
; 527  : }

	pop	edi
	pop	esi
	pop	ebx
	pop	ebp
	ret	0
_strpbrk ENDP
_TEXT	ENDS
PUBLIC	_strstr
;	COMDAT _strstr
_TEXT	SEGMENT
_csrc$ = 8
_ct$ = 12
_strstr	PROC NEAR					; COMDAT

; 561  : {

	push	ebp
	mov	ebp, esp
	push	ebx
	push	esi
	push	edi

; 562  : //  register char *__res;	// __res 是寄存器变量(eax)。
; 563  : 	_asm {
; 564  : 		pushf

	pushf

; 565  : 		mov ebx,ct

	mov	ebx, DWORD PTR _ct$[ebp]

; 566  : 		mov edi,ebx	// 首先计算串2 的长度。串2 指针放入edi 中。

	mov	edi, ebx

; 567  : 		mov ecx,0xffffffff

	mov	ecx, -1

; 568  : 		xor al,al	// al = 0

	xor	al, al

; 569  : 		cld 		// 清方向位。

	cld

; 570  : 		repne scasb// 比较al(0)与串2 中的字符（es:[edi]），并edi++。如果不相等就继续比较(ecx 逐步递减)。

	repnz	 scasb

; 571  : 		not ecx	// ecx 中每位取反。

	not	ecx

; 572  : 		dec ecx

	dec	ecx

; 573  : // 注意！如果搜索串为空，将设置Z 标志 // 得串2 的长度值。
; 574  : 		mov edx,ecx	// 将串2 的长度值暂放入edx 中。

	mov	edx, ecx

; 575  : 		mov esi,csrc

	mov	esi, DWORD PTR _csrc$[ebp]
$l1$144:

; 576  : 	l1: mov edi,ebx	// 取串2 头指针放入edi 中。

	mov	edi, ebx

; 577  : 		mov ecx,edx	// 再将串2 的长度值放入ecx 中。

	mov	ecx, edx

; 578  : 		mov eax,esi	// 将串1 的指针复制到eax 中。

	mov	eax, esi

; 579  : 		repe cmpsb// 比较串1 和串2 字符(ds:[esi],es:[edi])，esi++,edi++。若对应字符相等就一直比较下去。

	rep	 cmpsb

; 580  : 		je l2

	je	SHORT $l2$145

; 581  : // 对空串同样有效，见上面 // 若全相等，则转到标号2。
; 582  : 		xchg esi,eax	// 串1 头指针->esi，比较结果的串1 指针->eax。

	xchg	esi, eax

; 583  : 		inc esi	// 串1 头指针指向下一个字符。

	inc	esi

; 584  : 		cmp [eax-1],0	// 串1 指针(eax-1)所指字节是0 吗？

	cmp	BYTE PTR [eax-1], 0

; 585  : 		jne l1	// 不是则跳转到标号1，继续从串1 的第2 个字符开始比较。

	jne	SHORT $l1$144

; 586  : 		xor eax,eax	// 清eax，表示没有找到匹配。

	xor	eax, eax
$l2$145:

; 587  : //	l2: mov __res,eax
; 588  : 	l2:	popf

	popf

; 589  : 	}
; 590  : //  return __res;			// 返回比较结果。
; 591  : }

	pop	edi
	pop	esi
	pop	ebx
	pop	ebp
	ret	0
_strstr	ENDP
_TEXT	ENDS
PUBLIC	_strlen
;	COMDAT _strlen
_TEXT	SEGMENT
_s$ = 8
_strlen	PROC NEAR					; COMDAT

; 627  : {

	push	ebp
	mov	ebp, esp
	push	edi

; 628  : //  register int __res;	// __res 是寄存器变量(ecx)。
; 629  : 	_asm{
; 630  : 		pushf

	pushf

; 631  : 		mov edi,s

	mov	edi, DWORD PTR _s$[ebp]

; 632  : 		mov ecx,0xffffffff

	mov	ecx, -1

; 633  : 		xor al,al

	xor	al, al

; 634  : 		cld		// 清方向位。

	cld

; 635  : 		repne scasb		// al(0)与字符串中字符es:[edi]比较，若不相等就一直比较。

	repnz	 scasb

; 636  : 		not ecx	// ecx 取反。

	not	ecx

; 637  : 		dec ecx		// ecx--，得字符串得长度值。

	dec	ecx

; 638  : //		mov __res,ecx
; 639  : 		mov eax,ecx

	mov	eax, ecx

; 640  : 		popf

	popf

; 641  : 	}
; 642  : //  return __res;			// 返回字符串长度值。
; 643  : }

	pop	edi
	pop	ebp
	ret	0
_strlen	ENDP
_TEXT	ENDS
PUBLIC	_strtok
;	COMDAT _strtok
_TEXT	SEGMENT
_s$ = 8
_ct$ = 12
_strtok	PROC NEAR					; COMDAT

; 671  : {

	push	ebp
	mov	ebp, esp
	push	ebx
	push	esi
	push	edi

; 672  : //  register char *__res;
; 673  : 	_asm {
; 674  : 		pushf

	pushf

; 675  : 		mov esi,s

	mov	esi, DWORD PTR _s$[ebp]

; 676  : 		test esi,esi	// 首先测试esi(字符串1 指针s)是否是NULL。

	test	esi, esi

; 677  : 		jne l1		// 如果不是，则表明是首次调用本函数，跳转标号1。

	jne	SHORT $l1$157

; 678  : 		mov ebx,strtok

	mov	ebx, DWORD PTR _strtok

; 679  : 		test ebx,ebx	// 如果是NULL，则表示此次是后续调用，测ebx(__strtok)。

	test	ebx, ebx

; 680  : 		je l8		// 如果ebx 指针是NULL，则不能处理，跳转结束。

	je	SHORT $l8$158

; 681  : 		mov esi,ebx	// 将ebx 指针复制到esi。

	mov	esi, ebx
$l1$157:

; 682  : 	l1: xor ebx,ebx	// 清ebx 指针。

	xor	ebx, ebx

; 683  : 		mov edi,ct	// 下面求字符串2 的长度。edi 指向字符串2。

	mov	edi, DWORD PTR _ct$[ebp]

; 684  : 		mov ecx,0xffffffff 	// 置ecx = 0xffffffff。

	mov	ecx, -1

; 685  : 		xor eax,eax	// 清零eax。

	xor	eax, eax

; 686  : 		cld

	cld

; 687  : 		repne scasb// 将al(0)与es:[edi]比较，并且edi++。直到找到字符串2 的结束null 字符，或计数ecx==0。

	repnz	 scasb

; 688  : 		not ecx	// 将ecx 取反，

	not	ecx

; 689  : 		dec ecx	// ecx--，得到字符串2 的长度值。

	dec	ecx

; 690  : 		je l7	// 分割符字符串空 // 若串2 长度为0，则转标号7。

	je	SHORT $l7$159

; 691  : 		mov edx,ecx	// 将串2 长度暂存入edx。

	mov	edx, ecx
$l2$160:

; 692  : 	l2: lodsb	// 取串1 的字符ds:[esi]->al，并且esi++。

	lodsb

; 693  : 		test al,al	// 该字符为0 值吗(串1 结束)？

	test	al, al

; 694  : 		je l7		// 如果是，则跳转标号7。

	je	SHORT $l7$159

; 695  : 		mov edi,ct	// edi 再次指向串2 首。

	mov	edi, DWORD PTR _ct$[ebp]

; 696  : 		mov ecx,edx	// 取串2 的长度值置入计数器ecx。

	mov	ecx, edx

; 697  : 		repne scasb// 将al 中串1 的字符与串2 中所有字符比较，判断该字符是否为分割符。

	repnz	 scasb

; 698  : 		je l2		// 若能在串2 中找到相同字符（分割符），则跳转标号2。

	je	SHORT $l2$160

; 699  : 		dec esi	// 若不是分割符，则串1 指针esi 指向此时的该字符。

	dec	esi

; 700  : 		cmp [esi],0	// 该字符是NULL 字符吗？

	cmp	BYTE PTR [esi], 0

; 701  : 		je l7		// 若是，则跳转标号7 处。

	je	SHORT $l7$159

; 702  : 		mov ebx,esi	// 将该字符的指针esi 存放在ebx。

	mov	ebx, esi
$l3$161:

; 703  : 	l3: lodsb	// 取串1 下一个字符ds:[esi]->al，并且esi++。

	lodsb

; 704  : 		test al,al	// 该字符是NULL 字符吗？

	test	al, al

; 705  : 		je l5		// 若是，表示串1 结束，跳转到标号5。

	je	SHORT $l5$162

; 706  : 		mov edi,ct	// edi 再次指向串2 首。

	mov	edi, DWORD PTR _ct$[ebp]

; 707  : 		mov ecx,edx	// 串2 长度值置入计数器ecx。

	mov	ecx, edx

; 708  : 		repne scasb // 将al 中串1 的字符与串2 中每个字符比较，测试al 字符是否是分割符。

	repnz	 scasb

; 709  : 		jne l3		// 若不是分割符则跳转标号3，检测串1 中下一个字符。

	jne	SHORT $l3$161

; 710  : 		dec esi	// 若是分割符，则esi--，指向该分割符字符。

	dec	esi

; 711  : 		cmp [esi],0	// 该分割符是NULL 字符吗？

	cmp	BYTE PTR [esi], 0

; 712  : 		je l5		// 若是，则跳转到标号5。

	je	SHORT $l5$162

; 713  : 		mov [esi],0	// 若不是，则将该分割符用NULL 字符替换掉。

	mov	BYTE PTR [esi], 0

; 714  : 		inc esi	// esi 指向串1 中下一个字符，也即剩余串首。

	inc	esi

; 715  : 		jmp l6		// 跳转标号6 处。

	jmp	SHORT $l6$163
$l5$162:

; 716  : 	l5: xor esi,esi	// esi 清零。

	xor	esi, esi
$l6$163:

; 717  : 	l6: cmp [ebx],0	// ebx 指针指向NULL 字符吗？

	cmp	BYTE PTR [ebx], 0

; 718  : 		jne l7	// 若不是，则跳转标号7。

	jne	SHORT $l7$159

; 719  : 		xor ebx,ebx	// 若是，则让ebx=NULL。

	xor	ebx, ebx
$l7$159:

; 720  : 	l7: test ebx,ebx	// ebx 指针为NULL 吗？

	test	ebx, ebx

; 721  : 		jne l8	// 若不是则跳转8，结束汇编代码。

	jne	SHORT $l8$158

; 722  : 		mov esi,ebx	// 将esi 置为NULL。

	mov	esi, ebx
$l8$158:

; 723  : //	l8: mov __res,esi
; 724  : 	l8: mov eax,esi

	mov	eax, esi

; 725  : 		popf

	popf

; 726  : 	}
; 727  : //  return __res;			// 返回指向新token 的指针。
; 728  : }

	pop	edi
	pop	esi
	pop	ebx
	pop	ebp
	ret	0
_strtok	ENDP
_TEXT	ENDS
PUBLIC	_memcpy
;	COMDAT _memcpy
_TEXT	SEGMENT
_dest$ = 8
_src$ = 12
_n$ = 16
_memcpy	PROC NEAR					; COMDAT

; 793  : {

	push	ebp
	mov	ebp, esp
	push	esi
	push	edi

; 794  : 	_asm{
; 795  : 		pushf

	pushf

; 796  : 		mov esi,src

	mov	esi, DWORD PTR _src$[ebp]

; 797  : 		mov edi,dest

	mov	edi, DWORD PTR _dest$[ebp]

; 798  : 		mov ecx,n

	mov	ecx, DWORD PTR _n$[ebp]

; 799  : 		cld		// 清方向位。

	cld

; 800  : 		rep movsb	// 重复执行复制ecx 个字节，从ds:[esi]到es:[edi]，esi++，edi++。

	rep	 movsb

; 801  : 		popf

	popf

; 802  : 	}
; 803  : 	return dest;			// 返回目的地址。

	mov	eax, DWORD PTR _dest$[ebp]

; 804  : }

	pop	edi
	pop	esi
	pop	ebp
	ret	0
_memcpy	ENDP
_TEXT	ENDS
PUBLIC	_memmove
;	COMDAT _memmove
_TEXT	SEGMENT
_dest$ = 8
_src$ = 12
_n$ = 16
_memmove PROC NEAR					; COMDAT

; 822  : {

	push	ebp
	mov	ebp, esp

; 823  : 	if (dest < src) 

	mov	eax, DWORD PTR _dest$[ebp]
	mov	ecx, DWORD PTR _src$[ebp]
	push	esi
	cmp	eax, ecx
	push	edi
	jae	SHORT $L180

; 824  : 	{_asm {
; 825  : 		pushf

	pushf

; 826  : 		mov esi,src

	mov	esi, DWORD PTR _src$[ebp]

; 827  : 		mov edi,dest

	mov	edi, DWORD PTR _dest$[ebp]

; 828  : 		mov ecx,n

	mov	ecx, DWORD PTR _n$[ebp]

; 829  : 		cld		// 清方向位。

	cld

; 830  : 		rep movsb// 从ds:[esi]到es:[edi]，并且esi++，edi++，重复执行复制ecx 字节。

	rep	 movsb

; 831  : 		popf

	popf

; 844  : 	}}
; 845  :   return dest;
; 846  : }

	pop	edi
	pop	esi
	pop	ebp
	ret	0
$L180:

; 832  : 	}}else{_asm {
; 833  : 		pushf

	pushf

; 834  : //		mov esi,src + n - 1
; 835  : 		mov esi,src

	mov	esi, DWORD PTR _src$[ebp]

; 836  : 		add esi,n - 1

	add	esi, DWORD PTR 16+[ebp-1]

; 837  : //		mov edi,dest + n - 1
; 838  : 		mov edi,dest

	mov	edi, DWORD PTR _dest$[ebp]

; 839  : 		add edi,n - 1

	add	edi, DWORD PTR 16+[ebp-1]

; 840  : 		mov ecx,n

	mov	ecx, DWORD PTR _n$[ebp]

; 841  : 		std		// 置方向位，从末端开始复制。

	std

; 842  : 		rep movsb// 从ds:[esi]到es:[edi]，并且esi--，edi--，复制ecx 个字节。

	rep	 movsb

; 843  : 		popf

	popf

; 844  : 	}}
; 845  :   return dest;
; 846  : }

	pop	edi
	pop	esi
	pop	ebp
	ret	0
_memmove ENDP
_TEXT	ENDS
PUBLIC	_memcmp
;	COMDAT _memcmp
_TEXT	SEGMENT
_csrc$ = 8
_ct$ = 12
_count$ = 16
_memcmp	PROC NEAR					; COMDAT

; 870  : {

	push	ebp
	mov	ebp, esp
	push	esi
	push	edi

; 871  : //  register int __res; //__asm__ ("ax")	 __res 是寄存器变量。
; 872  : 	_asm {
; 873  : 		pushf

	pushf

; 874  : 		mov edi,csrc

	mov	edi, DWORD PTR _csrc$[ebp]

; 875  : 		mov esi,ct

	mov	esi, DWORD PTR _ct$[ebp]

; 876  : 		xor eax,eax // eax = 0

	xor	eax, eax

; 877  : 		mov ecx,count

	mov	ecx, DWORD PTR _count$[ebp]

; 878  : 		cld		// 清方向位。

	cld

; 879  : 		repe cmpsb// 比较ds:[esi]与es:[edi]的内容，并且esi++，edi++。如果相等则重复，

	rep	 cmpsb

; 880  : 		je l1		// 如果都相同，则跳转到标号1，返回0(eax)值

	je	SHORT $l1$190

; 881  : 		mov eax,1	// 否则eax 置1，

	mov	eax, 1

; 882  : 		jl l1		// 若内存块2 内容的值<内存块1，则跳转标号1。

	jl	SHORT $l1$190

; 883  : 		neg eax	// 否则eax = -eax。

	neg	eax
$l1$190:

; 884  : //	l1: mov __res,eax
; 885  : 	l1:	popf

	popf

; 886  : 	}
; 887  : //  return __res;			// 返回比较结果。
; 888  : }

	pop	edi
	pop	esi
	pop	ebp
	ret	0
_memcmp	ENDP
_TEXT	ENDS
PUBLIC	_memchr
;	COMDAT _memchr
_TEXT	SEGMENT
_csrc$ = 8
_c$ = 12
_count$ = 16
_memchr	PROC NEAR					; COMDAT

; 911  : {

	push	ebp
	mov	ebp, esp

; 912  : //  register void *__res;	// __res 是寄存器变量。
; 913  :   if (!count)			// 如果内存块长度==0，则返回NULL，没有找到。

	mov	eax, DWORD PTR _count$[ebp]
	push	edi
	test	eax, eax
	jne	SHORT $L199

; 914  :     return NULL;

	xor	eax, eax

; 928  : 	}
; 929  : //  return __res;			// 返回字符指针。
; 930  : }

	pop	edi
	pop	ebp
	ret	0
$L199:

; 915  : 	_asm {
; 916  : 		pushf

	pushf

; 917  : 		mov edi,csrc

	mov	edi, DWORD PTR _csrc$[ebp]

; 918  : 		mov ecx,count

	mov	ecx, DWORD PTR _count$[ebp]

; 919  : 		mov al,c

	mov	al, BYTE PTR _c$[ebp]

; 920  : 		cld		// 清方向位。

	cld

; 921  : 		repne scasb// al 中字符与es:[edi]字符作比较，并且edi++，如果不相等则重复执行下面语句，

	repnz	 scasb

; 922  : 		je l1		// 如果相等则向前跳转到标号1 处。

	je	SHORT $l1$200

; 923  : 		mov edi,1	// 否则edi 中置1。

	mov	edi, 1
$l1$200:

; 924  : 	l1: dec edi	// 让edi 指向找到的字符（或是NULL）。

	dec	edi

; 925  : //		mov __res,edi
; 926  : 		mov eax,edi

	mov	eax, edi

; 927  : 		popf

	popf

; 928  : 	}
; 929  : //  return __res;			// 返回字符指针。
; 930  : }

	pop	edi
	pop	ebp
	ret	0
_memchr	ENDP
_TEXT	ENDS
PUBLIC	_memset
;	COMDAT _memset
_TEXT	SEGMENT
_s$ = 8
_c$ = 12
_count$ = 16
_memset	PROC NEAR					; COMDAT

; 952  : {

	push	ebp
	mov	ebp, esp
	push	edi

; 953  : 	_asm {
; 954  : 		pushf

	pushf

; 955  : 		mov edi,s

	mov	edi, DWORD PTR _s$[ebp]

; 956  : 		mov ecx,count

	mov	ecx, DWORD PTR _count$[ebp]

; 957  : 		mov al,c

	mov	al, BYTE PTR _c$[ebp]

; 958  : 		cld		// 清方向位。

	cld

; 959  : 		rep stosb// 将al 中字符存入es:[edi]中，并且edi++。重复ecx 指定的次数，执行

	rep	 stosb

; 960  : 		popf

	popf

; 961  : 	}
; 962  :   return s;

	mov	eax, DWORD PTR _s$[ebp]

; 963  : }

	pop	edi
	pop	ebp
	ret	0
_memset	ENDP
_TEXT	ENDS
END
