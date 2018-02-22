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

; 38   : 		cld		// �巽��λ��

	cld
$l1$46:

; 39   : 	l1:	lodsb	// ����DS:[esi]��1 �ֽ�->al��������esi��

	lodsb

; 40   : 		stosb		// �洢�ֽ�al->ES:[edi]��������edi��

	stosb

; 41   : 		test al,al	// �մ洢���ֽ���0��

	test	al, al

; 42   : 		jne l1	// ��������ת�����l1 �������������

	jne	SHORT $l1$46

; 43   : 		popf

	popf

; 44   : 	}
; 45   : 	return dest;			// ����Ŀ���ַ���ָ�롣

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

; 111  : 		cld		// �巽��λ��

	cld

; 112  : 		repne scasb		// �Ƚ�al ��es:[edi]�ֽڣ�������edi++��

	repnz	 scasb

; 113  : 						// ֱ���ҵ�Ŀ�Ĵ�����0 ���ֽڣ���ʱedi �Ѿ�ָ���1 �ֽڡ�
; 114  : 		dec edi		// ��es:[edi]ָ��0 ֵ�ֽڡ�

	dec	edi
$l1$63:

; 115  : 	l1: lodsb	// ȡԴ�ַ����ֽ�ds:[esi]->al����esi++��

	lodsb

; 116  : 		stosb		// �����ֽڴ浽es:[edi]����edi++��

	stosb

; 117  : 		test al,al	// ���ֽ���0��

	test	al, al

; 118  : 		jne l1	// ���ǣ��������ת�����1 ���������������������

	jne	SHORT $l1$63

; 119  : 		popf

	popf

; 120  : 	}
; 121  : 	return dest;			// ����Ŀ���ַ���ָ�롣

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
; 166  : /* 'h', 'l',��'L'���������ֶ� */
; 167  : // ���Ƚ��ַ�ָ��ָ��buf��Ȼ��ɨ���ʽ�ַ������Ը�����ʽת��ָʾ������Ӧ�Ĵ���
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
; 170  : // ��ʽת��ָʾ�ַ�������'%'��ʼ�������fmt ��ʽ�ַ�����ɨ��'%'��Ѱ�Ҹ�ʽת���ַ����Ŀ�ʼ��
; 171  : // ���Ǹ�ʽָʾ��һ���ַ��������δ���str��
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
; 178  : // ����ȡ�ø�ʽָʾ�ַ����еı�־�򣬲�����־��������flags �����С�
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

; 187  : 			goto repeat;		// ���������

	jmp	SHORT $L478
$L311:

; 188  : 		case '+':
; 189  : 			flags |= PLUS;

	or	ecx, 4

; 190  : 			goto repeat;		// �żӺš�

	jmp	SHORT $L478
$L312:

; 191  : 		case ' ':
; 192  : 			flags |= SPACE;

	or	ecx, 8

; 193  : 			goto repeat;		// �ſո�

	jmp	SHORT $L478
$L313:

; 194  : 		case '#':
; 195  : 			flags |= SPECIAL;

	or	ecx, 32					; 00000020H

; 196  : 			goto repeat;		// ������ת����

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

; 199  : 			goto repeat;		// Ҫ����(��'0')��
; 200  : 		}
; 201  : 
; 202  : // ȡ��ǰ�����ֶο����ֵ������field_width �����С���������������ֵ��ֱ��ȡ��Ϊ���ֵ��
; 203  : // �������������ַ�'*'����ʾ��һ������ָ����ȡ���˵���va_arg ȡ���ֵ������ʱ���ֵ
; 204  : // С��0����ø�����ʾ����б�־��'-'��־�����룩����˻����ڱ�־����������ñ�־����
; 205  : // ���ֶο��ֵȡΪ�����ֵ��
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
; 221  : // ������δ��룬ȡ��ʽת�����ľ����򣬲�����precision �����С�������ʼ�ı�־��'.'��
; 222  : // �䴦�������������������ơ����������������ֵ��ֱ��ȡ��Ϊ����ֵ���������������
; 223  : // �ַ�'*'����ʾ��һ������ָ�����ȡ���˵���va_arg ȡ����ֵ������ʱ���ֵС��0����
; 224  : // ���ֶξ���ֵȡΪ�����ֵ��
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
; 241  : // ������δ�������������η������������qualifer ��������h,l,L �ĺ���μ��б���˵������
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
; 250  : // �������ת��ָʾ����
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

; 253  : // ���ת��ָʾ����'c'�����ʾ��Ӧ����Ӧ���ַ�����ʱ�����־������������룬����ֶ�ǰ��
; 254  : // ��������ֵ-1 ���ո��ַ���Ȼ���ٷ�������ַ����������򻹴���0�����ʾΪ���룬����
; 255  : // �����ַ�������ӿ��ֵ-1 ���ո��ַ���
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
; 265  : // ���ת��ָʾ����'s'�����ʾ��Ӧ�������ַ���������ȡ�����ַ����ĳ��ȣ����䳬���˾�����ֵ��
; 266  : // ����չ������=�ַ������ȡ���ʱ�����־������������룬����ֶ�ǰ����(���ֵ-�ַ�������)
; 267  : // ���ո��ַ���Ȼ���ٷ�������ַ������������򻹴���0�����ʾΪ���룬���ڲ����ַ�������
; 268  : // ���(���ֵ-�ַ�������)���ո��ַ���
; 269  : 		case 's':
; 270  : 			s = va_arg (args, char *);

	mov	eax, DWORD PTR [esi+4]
	add	esi, 4
	mov	DWORD PTR -16+[ebp], esi
	mov	DWORD PTR _s$[ebp], eax

; 152  : 	int len;
; 153  : 	int i;
; 154  : 	char *str;			// ���ڴ��ת�������е��ַ�����

	pushf

; 155  : 	char *s;

	mov	edi, DWORD PTR _s$[ebp]

; 156  : 	int *ip;

	mov	ecx, -1

; 157  : 

	xor	al, al

; 158  : 	int flags;			/* flags to number() */

	cld

; 159  : /* number()����ʹ�õı�־ */

	repnz	 scasb

; 160  : 	int field_width;		/* width of output field */

	not	ecx

; 161  : /* ����ֶο��*/

	dec	ecx

; 162  : 	int precision;		/* min. # of digits for integers; max
; 163  : 				   number of chars for from string */

	mov	eax, ecx

; 164  : /* min. �������ָ�����max. �ַ������ַ����� */

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
; 286  : // �����ʽת������'o'����ʾ�轫��Ӧ�Ĳ���ת���ɰ˽��������ַ���������number()��������
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
; 166  : /* 'h', 'l',��'L'���������ֶ� */
; 167  : // ���Ƚ��ַ�ָ��ָ��buf��Ȼ��ɨ���ʽ�ַ������Ը�����ʽת��ָʾ������Ӧ�Ĵ���
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
; 342  : 	*str = '\0';			// �����ת���õ��ַ�����β������null��
; 343  : 	return str - buf;		// ����ת���õ��ַ�������ֵ��

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
; 292  : // �����ʽת������'p'����ʾ��Ӧ������һ��ָ�����͡���ʱ���ò���û�����ÿ������Ĭ�Ͽ��
; 293  : // Ϊ8��������Ҫ���㡣Ȼ�����number()�������д���
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
; 304  : // ����ʽת��ָʾ��'x'��'X'�����ʾ��Ӧ������Ҫ��ӡ��ʮ�������������'x'��ʾ��Сд��ĸ��ʾ��
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
; 312  : // �����ʽת���ַ���'d','i'��'u'�����ʾ��Ӧ������������'d', 'i'������������������Ҫ����
; 313  : // �����ű�־��'u'�����޷���������
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
; 322  : // ����ʽת��ָʾ����'n'�����ʾҪ�ѵ�ĿǰΪֹת��������ַ������浽��Ӧ����ָ��ָ����λ���С�
; 323  : // ��������va_arg()ȡ�øò���ָ�룬Ȼ���Ѿ�ת���õ��ַ��������ָ����ָ��λ�á�
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
; 329  : // ����ʽת��������'%'�����ʾ��ʽ�ַ����д�ֱ�ӽ�һ��'%'д��������С�
; 330  : // �����ʽת������λ�ô������ַ�����Ҳֱ�ӽ����ַ�д��������У������ص�107 �м�������
; 331  : // ��ʽ�ַ����������ʾ�Ѿ�������ʽ�ַ����Ľ�β�������˳�ѭ����
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

; 80   : // �������ָ��Ҫ���㣬�����ַ�����c='0'��Ҳ��''��������c ���ڿո��ַ���
; 81   : // �������ָ���Ǵ�������������ֵnum С��0�����÷��ű���sign=���ţ���ʹnum ȡ����ֵ��
; 82   : // �����������ָ���ǼӺţ�����sign=�Ӻţ����������ʹ��ո��־��sign=�ո񣬷�����0��
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

; 91   : // �������ţ�����ֵ��1��������ָ��������ת���������ʮ�����ƿ���ټ���2 λ(����0x)��
; 92   : // ���ڰ˽��ƿ�ȼ�1�����ڰ˽���ת�����ǰ��һ���㣩��
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

; 100  : // �����ֵnum Ϊ0������ʱ�ַ���='0'��������ݸ����Ļ�������ֵnum ת�����ַ���ʽ��
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

; 71   : // �������type ָ����Сд��ĸ������Сд��ĸ����

	mov	ebx, DWORD PTR _base$[ebp]

; 72   : // �������ָ��Ҫ�����������߽磩�������������е������־��

	div	ebx

; 73   : // ������ƻ���С��2 �����36�����˳�����Ҳ��������ֻ�ܴ��������2-32 ֮�������

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

; 107  : // ����ֵ�ַ��������ھ���ֵ���򾫶�ֵ��չΪ���ָ���ֵ��
; 108  : // ���ֵsize ��ȥ���ڴ����ֵ�ַ��ĸ�����
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

; 112  : // ������������ʼ�γ�����Ҫ��ת�����������ʱ�����ַ���str �С�
; 113  : // ��������û������(ZEROPAD)�����루���������־������str ������
; 114  : // ���ʣ����ֵָ���Ŀո��������������λ���������š�
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

; 120  : // ������ָ��������ת��������ڰ˽���ת�����ͷһλ����һ��'0'��������ʮ����������'0x'��
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
; 127  : 			*str++ = digits[33];	// 'X'��'x'

	mov	edx, DWORD PTR _digits$[ebp]
	mov	BYTE PTR [esi], 48			; 00000030H
	inc	esi
	mov	dl, BYTE PTR [edx+33]
	mov	BYTE PTR [esi], dl
$L549:
	inc	esi
$L270:

; 128  : 		}
; 129  : // ��������û������������룩��־������ʣ�����д��c �ַ���'0'��ո񣩣���51 �С�
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
; 133  : // ��ʱi ������ֵnum �����ָ����������ָ���С�ھ���ֵ����str �з��루����ֵ-i����'0'��
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
; 136  : // ��ת��ֵ���õ������ַ�����str �С���i ����
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

; 139  : // �����ֵ�Դ����㣬���ʾ���ͱ�־���������־��־������ʣ�����з���ո�
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
; 142  : 	return str;			// ����ת���õ��ַ�����

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

; 195  : //  register int __res;	// __res �ǼĴ�������(eax)��
; 196  :   _asm{
; 197  : 	  pushf

	pushf

; 198  : 	  mov edi,csrc

	mov	edi, DWORD PTR _csrc$[ebp]

; 199  : 	  mov esi,ct

	mov	esi, DWORD PTR _ct$[ebp]

; 200  : 	  cld		// �巽��λ��

	cld
$l1$80:

; 201  :   l1: lodsb	// ȡ�ַ���2 ���ֽ�ds:[esi]??al������esi++��

	lodsb

; 202  : 	  scasb		// al ���ַ���1 ���ֽ�es:[edi]���Ƚϣ�����edi++��

	scasb

; 203  : 	  jne l2		// �������ȣ�����ǰ��ת�����2��

	jne	SHORT $l2$81

; 204  : 	  test al,al	// ���ֽ���0 ֵ�ֽ����ַ�����β����

	test	al, al

; 205  : 	  jne l1		// ���ǣ��������ת�����1�������Ƚϡ�

	jne	SHORT $l1$80

; 206  : 	  xor eax,eax	// �ǣ��򷵻�ֵeax ���㣬

	xor	eax, eax

; 207  : 	  jmp l3		// ��ǰ��ת�����3��������

	jmp	SHORT $l3$82
$l2$81:

; 208  :   l2: mov eax,1	// eax ����1��

	mov	eax, 1

; 209  : 	  jl l3		// ��ǰ��Ƚ��д�2 �ַ�<��1 �ַ����򷵻���ֵ��������

	jl	SHORT $l3$82

; 210  : 	  neg eax	// ����eax = -eax�����ظ�ֵ��������

	neg	eax
$l3$82:

; 211  : //  l3: mov __res,eax
; 212  :   l3: popf

	popf

; 213  :   }
; 214  : //  return __res;			// ���رȽϽ����
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

; 383  :   register char *__res;	// __res �ǼĴ�������(esi)��
; 384  :   _asm{
; 385  : 	  pushf

	pushf

; 386  : 	  xor al,al

	xor	al, al

; 387  : 	  mov ebx,ct

	mov	ebx, DWORD PTR _ct$[ebp]

; 388  : 	  mov edi,ebx	// ���ȼ��㴮2 �ĳ��ȡ���2 ָ�����edi �С�

	mov	edi, ebx

; 389  : 	  mov ecx,0xffffffff

	mov	ecx, -1

; 390  : 	  cld		// �巽��λ��

	cld

; 391  : 	  repne scasb// �Ƚ�al(0)�봮2 �е��ַ���es:[edi]������edi++���������Ⱦͼ����Ƚ�(ecx �𲽵ݼ�)��

	repnz	 scasb

; 392  : 	  not ecx	// ecx ��ÿλȡ����

	not	ecx

; 393  : 	  dec ecx	// ecx--���ô�2 �ĳ���ֵ��-> ecx

	dec	ecx

; 394  : 	  mov edx,ecx	// ����2 �ĳ���ֵ�ݷ���edx �С�

	mov	edx, ecx

; 395  : 	  mov esi,csrc

	mov	esi, DWORD PTR _csrc$[ebp]
$l1$118:

; 396  :   l1: lodsb	// ȡ��1 �ַ�ds:[esi]->al������esi++��

	lodsb

; 397  : 	  test al,al	// ���ַ�����0 ֵ�𣨴�1 ��β����

	test	al, al

; 398  : 	  je l2		// ����ǣ�����ǰ��ת�����2 ����

	je	SHORT $l2$119

; 399  : 	  mov edi,ebx	// ȡ��2 ͷָ�����edi �С�

	mov	edi, ebx

; 400  : 	  mov ecx,edx	// �ٽ���2 �ĳ���ֵ����ecx �С�

	mov	ecx, edx

; 401  : 	  repne scasb	// �Ƚ�al �봮2 ���ַ�es:[edi]������edi++���������Ⱦͼ����Ƚϡ�

	repnz	 scasb

; 402  : 	  je l1		// �����ȣ��������ת�����1 ����

	je	SHORT $l1$118
$l2$119:

; 403  :   l2: dec esi	// esi--��ָ�����һ�������ڴ�2 �е��ַ���

	dec	esi

; 404  : 	  mov __res,esi

	mov	DWORD PTR ___res$[ebp], esi

; 405  : 	  popf

	popf

; 406  :   }
; 407  :   return __res - csrc;		// �����ַ����еĳ���ֵ��

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

; 441  :   register char *__res;	// __res �ǼĴ�������(esi)��
; 442  : 	_asm{
; 443  : 		pushf

	pushf

; 444  : 		xor al,al

	xor	al, al

; 445  : 		mov ecx,0xffffffff

	mov	ecx, -1

; 446  : 		mov ebx,ct

	mov	ebx, DWORD PTR _ct$[ebp]

; 447  : 		mov edi,ebx	// ���ȼ��㴮2 �ĳ��ȡ���2 ָ�����edi �С�

	mov	edi, ebx

; 448  : 		cld		// �巽��λ��

	cld

; 449  : 		repne scasb// �Ƚ�al(0)�봮2 �е��ַ���es:[edi]������edi++���������Ⱦͼ����Ƚ�(ecx �𲽵ݼ�)��

	repnz	 scasb

; 450  : 		not ecx	// ecx ��ÿλȡ����

	not	ecx

; 451  : 		dec ecx	// ecx--���ô�2 �ĳ���ֵ��

	dec	ecx

; 452  : 		mov edx,ecx	// ����2 �ĳ���ֵ�ݷ���edx �С�

	mov	edx, ecx

; 453  : 		mov esi,csrc

	mov	esi, DWORD PTR _csrc$[ebp]
$l1$127:

; 454  : 	l1: lodsb	// ȡ��1 �ַ�ds:[esi]->al������esi++��

	lodsb

; 455  : 		test al,al	// ���ַ�����0 ֵ�𣨴�1 ��β����

	test	al, al

; 456  : 		je l2		// ����ǣ�����ǰ��ת�����2 ����

	je	SHORT $l2$128

; 457  : 		mov edi,ebx	// ȡ��2 ͷָ�����edi �С�

	mov	edi, ebx

; 458  : 		mov ecx,edx 	// �ٽ���2 �ĳ���ֵ����ecx �С�

	mov	ecx, edx

; 459  : 		repne scasb	// �Ƚ�al �봮2 ���ַ�es:[edi]������edi++���������Ⱦͼ����Ƚϡ�

	repnz	 scasb

; 460  : 		jne l1		// �������ȣ��������ת�����1 ����

	jne	SHORT $l1$127
$l2$128:

; 461  : 	l2: dec esi

	dec	esi

; 462  : 		mov __res,esi	// esi--��ָ�����һ�������ڴ�2 �е��ַ���

	mov	DWORD PTR ___res$[ebp], esi

; 463  : 		popf

	popf

; 464  : 	}
; 465  :   return __res - csrc;		// �����ַ����еĳ���ֵ��

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

; 499  : //  register char *__res;	// __res �ǼĴ�������(esi)��
; 500  : 	_asm{
; 501  : 		pushf

	pushf

; 502  : 		xor al,al

	xor	al, al

; 503  : 		mov ebx,ct

	mov	ebx, DWORD PTR _ct$[ebp]

; 504  : 		mov edi,ebx	// ���ȼ��㴮2 �ĳ��ȡ���2 ָ�����edi �С�

	mov	edi, ebx

; 505  : 		mov ecx,0xffffffff

	mov	ecx, -1

; 506  : 		cld		// �巽��λ��

	cld

; 507  : 		repne scasb// �Ƚ�al(0)�봮2 �е��ַ���es:[edi]������edi++���������Ⱦͼ����Ƚ�(ecx �𲽵ݼ�)��

	repnz	 scasb

; 508  : 		not ecx	// ecx ��ÿλȡ����

	not	ecx

; 509  : 		dec ecx	// ecx--���ô�2 �ĳ���ֵ��

	dec	ecx

; 510  : 		mov edx,ecx	// ����2 �ĳ���ֵ�ݷ���edx �С�

	mov	edx, ecx

; 511  : 		mov esi,csrc

	mov	esi, DWORD PTR _csrc$[ebp]
$l1$135:

; 512  : 	l1: lodsb	// ȡ��1 �ַ�ds:[esi]??al������esi++��

	lodsb

; 513  : 		test al,al	// ���ַ�����0 ֵ�𣨴�1 ��β����

	test	al, al

; 514  : 		je l2		// ����ǣ�����ǰ��ת�����2 ����

	je	SHORT $l2$136

; 515  : 		mov edi,ebx	// ȡ��2 ͷָ�����edi �С�

	mov	edi, ebx

; 516  : 		mov ecx,edx	// �ٽ���2 �ĳ���ֵ����ecx �С�

	mov	ecx, edx

; 517  : 		repne scasb		// �Ƚ�al �봮2 ���ַ�es:[edi]������edi++���������Ⱦͼ����Ƚϡ�

	repnz	 scasb

; 518  : 		jne l1	// �������ȣ��������ת�����1 ����

	jne	SHORT $l1$135

; 519  : 		dec esi	// esi--��ָ��һ�������ڴ�2 �е��ַ���

	dec	esi

; 520  : 		jmp l3		// ��ǰ��ת�����3 ����

	jmp	SHORT $l3$137
$l2$136:

; 521  : 	l2: xor esi,esi	// û���ҵ����������ģ�������ֵΪNULL��

	xor	esi, esi
$l3$137:

; 522  : //	l3: mov __res,esi
; 523  : 	l3: mov eax,esi

	mov	eax, esi

; 524  : 		popf

	popf

; 525  : 	}
; 526  : //  return __res;			// ����ָ��ֵ��
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

; 562  : //  register char *__res;	// __res �ǼĴ�������(eax)��
; 563  : 	_asm {
; 564  : 		pushf

	pushf

; 565  : 		mov ebx,ct

	mov	ebx, DWORD PTR _ct$[ebp]

; 566  : 		mov edi,ebx	// ���ȼ��㴮2 �ĳ��ȡ���2 ָ�����edi �С�

	mov	edi, ebx

; 567  : 		mov ecx,0xffffffff

	mov	ecx, -1

; 568  : 		xor al,al	// al = 0

	xor	al, al

; 569  : 		cld 		// �巽��λ��

	cld

; 570  : 		repne scasb// �Ƚ�al(0)�봮2 �е��ַ���es:[edi]������edi++���������Ⱦͼ����Ƚ�(ecx �𲽵ݼ�)��

	repnz	 scasb

; 571  : 		not ecx	// ecx ��ÿλȡ����

	not	ecx

; 572  : 		dec ecx

	dec	ecx

; 573  : // ע�⣡���������Ϊ�գ�������Z ��־ // �ô�2 �ĳ���ֵ��
; 574  : 		mov edx,ecx	// ����2 �ĳ���ֵ�ݷ���edx �С�

	mov	edx, ecx

; 575  : 		mov esi,csrc

	mov	esi, DWORD PTR _csrc$[ebp]
$l1$144:

; 576  : 	l1: mov edi,ebx	// ȡ��2 ͷָ�����edi �С�

	mov	edi, ebx

; 577  : 		mov ecx,edx	// �ٽ���2 �ĳ���ֵ����ecx �С�

	mov	ecx, edx

; 578  : 		mov eax,esi	// ����1 ��ָ�븴�Ƶ�eax �С�

	mov	eax, esi

; 579  : 		repe cmpsb// �Ƚϴ�1 �ʹ�2 �ַ�(ds:[esi],es:[edi])��esi++,edi++������Ӧ�ַ���Ⱦ�һֱ�Ƚ���ȥ��

	rep	 cmpsb

; 580  : 		je l2

	je	SHORT $l2$145

; 581  : // �Կմ�ͬ����Ч�������� // ��ȫ��ȣ���ת�����2��
; 582  : 		xchg esi,eax	// ��1 ͷָ��->esi���ȽϽ���Ĵ�1 ָ��->eax��

	xchg	esi, eax

; 583  : 		inc esi	// ��1 ͷָ��ָ����һ���ַ���

	inc	esi

; 584  : 		cmp [eax-1],0	// ��1 ָ��(eax-1)��ָ�ֽ���0 ��

	cmp	BYTE PTR [eax-1], 0

; 585  : 		jne l1	// ��������ת�����1�������Ӵ�1 �ĵ�2 ���ַ���ʼ�Ƚϡ�

	jne	SHORT $l1$144

; 586  : 		xor eax,eax	// ��eax����ʾû���ҵ�ƥ�䡣

	xor	eax, eax
$l2$145:

; 587  : //	l2: mov __res,eax
; 588  : 	l2:	popf

	popf

; 589  : 	}
; 590  : //  return __res;			// ���رȽϽ����
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

; 628  : //  register int __res;	// __res �ǼĴ�������(ecx)��
; 629  : 	_asm{
; 630  : 		pushf

	pushf

; 631  : 		mov edi,s

	mov	edi, DWORD PTR _s$[ebp]

; 632  : 		mov ecx,0xffffffff

	mov	ecx, -1

; 633  : 		xor al,al

	xor	al, al

; 634  : 		cld		// �巽��λ��

	cld

; 635  : 		repne scasb		// al(0)���ַ������ַ�es:[edi]�Ƚϣ�������Ⱦ�һֱ�Ƚϡ�

	repnz	 scasb

; 636  : 		not ecx	// ecx ȡ����

	not	ecx

; 637  : 		dec ecx		// ecx--�����ַ����ó���ֵ��

	dec	ecx

; 638  : //		mov __res,ecx
; 639  : 		mov eax,ecx

	mov	eax, ecx

; 640  : 		popf

	popf

; 641  : 	}
; 642  : //  return __res;			// �����ַ�������ֵ��
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

; 676  : 		test esi,esi	// ���Ȳ���esi(�ַ���1 ָ��s)�Ƿ���NULL��

	test	esi, esi

; 677  : 		jne l1		// ������ǣ���������״ε��ñ���������ת���1��

	jne	SHORT $l1$157

; 678  : 		mov ebx,strtok

	mov	ebx, DWORD PTR _strtok

; 679  : 		test ebx,ebx	// �����NULL�����ʾ�˴��Ǻ������ã���ebx(__strtok)��

	test	ebx, ebx

; 680  : 		je l8		// ���ebx ָ����NULL�����ܴ�����ת������

	je	SHORT $l8$158

; 681  : 		mov esi,ebx	// ��ebx ָ�븴�Ƶ�esi��

	mov	esi, ebx
$l1$157:

; 682  : 	l1: xor ebx,ebx	// ��ebx ָ�롣

	xor	ebx, ebx

; 683  : 		mov edi,ct	// �������ַ���2 �ĳ��ȡ�edi ָ���ַ���2��

	mov	edi, DWORD PTR _ct$[ebp]

; 684  : 		mov ecx,0xffffffff 	// ��ecx = 0xffffffff��

	mov	ecx, -1

; 685  : 		xor eax,eax	// ����eax��

	xor	eax, eax

; 686  : 		cld

	cld

; 687  : 		repne scasb// ��al(0)��es:[edi]�Ƚϣ�����edi++��ֱ���ҵ��ַ���2 �Ľ���null �ַ��������ecx==0��

	repnz	 scasb

; 688  : 		not ecx	// ��ecx ȡ����

	not	ecx

; 689  : 		dec ecx	// ecx--���õ��ַ���2 �ĳ���ֵ��

	dec	ecx

; 690  : 		je l7	// �ָ���ַ����� // ����2 ����Ϊ0����ת���7��

	je	SHORT $l7$159

; 691  : 		mov edx,ecx	// ����2 �����ݴ���edx��

	mov	edx, ecx
$l2$160:

; 692  : 	l2: lodsb	// ȡ��1 ���ַ�ds:[esi]->al������esi++��

	lodsb

; 693  : 		test al,al	// ���ַ�Ϊ0 ֵ��(��1 ����)��

	test	al, al

; 694  : 		je l7		// ����ǣ�����ת���7��

	je	SHORT $l7$159

; 695  : 		mov edi,ct	// edi �ٴ�ָ��2 �ס�

	mov	edi, DWORD PTR _ct$[ebp]

; 696  : 		mov ecx,edx	// ȡ��2 �ĳ���ֵ���������ecx��

	mov	ecx, edx

; 697  : 		repne scasb// ��al �д�1 ���ַ��봮2 �������ַ��Ƚϣ��жϸ��ַ��Ƿ�Ϊ�ָ����

	repnz	 scasb

; 698  : 		je l2		// �����ڴ�2 ���ҵ���ͬ�ַ����ָ����������ת���2��

	je	SHORT $l2$160

; 699  : 		dec esi	// �����Ƿָ������1 ָ��esi ָ���ʱ�ĸ��ַ���

	dec	esi

; 700  : 		cmp [esi],0	// ���ַ���NULL �ַ���

	cmp	BYTE PTR [esi], 0

; 701  : 		je l7		// ���ǣ�����ת���7 ����

	je	SHORT $l7$159

; 702  : 		mov ebx,esi	// �����ַ���ָ��esi �����ebx��

	mov	ebx, esi
$l3$161:

; 703  : 	l3: lodsb	// ȡ��1 ��һ���ַ�ds:[esi]->al������esi++��

	lodsb

; 704  : 		test al,al	// ���ַ���NULL �ַ���

	test	al, al

; 705  : 		je l5		// ���ǣ���ʾ��1 ��������ת�����5��

	je	SHORT $l5$162

; 706  : 		mov edi,ct	// edi �ٴ�ָ��2 �ס�

	mov	edi, DWORD PTR _ct$[ebp]

; 707  : 		mov ecx,edx	// ��2 ����ֵ���������ecx��

	mov	ecx, edx

; 708  : 		repne scasb // ��al �д�1 ���ַ��봮2 ��ÿ���ַ��Ƚϣ�����al �ַ��Ƿ��Ƿָ����

	repnz	 scasb

; 709  : 		jne l3		// �����Ƿָ������ת���3����⴮1 ����һ���ַ���

	jne	SHORT $l3$161

; 710  : 		dec esi	// ���Ƿָ������esi--��ָ��÷ָ���ַ���

	dec	esi

; 711  : 		cmp [esi],0	// �÷ָ����NULL �ַ���

	cmp	BYTE PTR [esi], 0

; 712  : 		je l5		// ���ǣ�����ת�����5��

	je	SHORT $l5$162

; 713  : 		mov [esi],0	// �����ǣ��򽫸÷ָ����NULL �ַ��滻����

	mov	BYTE PTR [esi], 0

; 714  : 		inc esi	// esi ָ��1 ����һ���ַ���Ҳ��ʣ�മ�ס�

	inc	esi

; 715  : 		jmp l6		// ��ת���6 ����

	jmp	SHORT $l6$163
$l5$162:

; 716  : 	l5: xor esi,esi	// esi ���㡣

	xor	esi, esi
$l6$163:

; 717  : 	l6: cmp [ebx],0	// ebx ָ��ָ��NULL �ַ���

	cmp	BYTE PTR [ebx], 0

; 718  : 		jne l7	// �����ǣ�����ת���7��

	jne	SHORT $l7$159

; 719  : 		xor ebx,ebx	// ���ǣ�����ebx=NULL��

	xor	ebx, ebx
$l7$159:

; 720  : 	l7: test ebx,ebx	// ebx ָ��ΪNULL ��

	test	ebx, ebx

; 721  : 		jne l8	// ����������ת8�����������롣

	jne	SHORT $l8$158

; 722  : 		mov esi,ebx	// ��esi ��ΪNULL��

	mov	esi, ebx
$l8$158:

; 723  : //	l8: mov __res,esi
; 724  : 	l8: mov eax,esi

	mov	eax, esi

; 725  : 		popf

	popf

; 726  : 	}
; 727  : //  return __res;			// ����ָ����token ��ָ�롣
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

; 799  : 		cld		// �巽��λ��

	cld

; 800  : 		rep movsb	// �ظ�ִ�и���ecx ���ֽڣ���ds:[esi]��es:[edi]��esi++��edi++��

	rep	 movsb

; 801  : 		popf

	popf

; 802  : 	}
; 803  : 	return dest;			// ����Ŀ�ĵ�ַ��

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

; 829  : 		cld		// �巽��λ��

	cld

; 830  : 		rep movsb// ��ds:[esi]��es:[edi]������esi++��edi++���ظ�ִ�и���ecx �ֽڡ�

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

; 841  : 		std		// �÷���λ����ĩ�˿�ʼ���ơ�

	std

; 842  : 		rep movsb// ��ds:[esi]��es:[edi]������esi--��edi--������ecx ���ֽڡ�

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

; 871  : //  register int __res; //__asm__ ("ax")	 __res �ǼĴ���������
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

; 878  : 		cld		// �巽��λ��

	cld

; 879  : 		repe cmpsb// �Ƚ�ds:[esi]��es:[edi]�����ݣ�����esi++��edi++�����������ظ���

	rep	 cmpsb

; 880  : 		je l1		// �������ͬ������ת�����1������0(eax)ֵ

	je	SHORT $l1$190

; 881  : 		mov eax,1	// ����eax ��1��

	mov	eax, 1

; 882  : 		jl l1		// ���ڴ��2 ���ݵ�ֵ<�ڴ��1������ת���1��

	jl	SHORT $l1$190

; 883  : 		neg eax	// ����eax = -eax��

	neg	eax
$l1$190:

; 884  : //	l1: mov __res,eax
; 885  : 	l1:	popf

	popf

; 886  : 	}
; 887  : //  return __res;			// ���رȽϽ����
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

; 912  : //  register void *__res;	// __res �ǼĴ���������
; 913  :   if (!count)			// ����ڴ�鳤��==0���򷵻�NULL��û���ҵ���

	mov	eax, DWORD PTR _count$[ebp]
	push	edi
	test	eax, eax
	jne	SHORT $L199

; 914  :     return NULL;

	xor	eax, eax

; 928  : 	}
; 929  : //  return __res;			// �����ַ�ָ�롣
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

; 920  : 		cld		// �巽��λ��

	cld

; 921  : 		repne scasb// al ���ַ���es:[edi]�ַ����Ƚϣ�����edi++�������������ظ�ִ��������䣬

	repnz	 scasb

; 922  : 		je l1		// ����������ǰ��ת�����1 ����

	je	SHORT $l1$200

; 923  : 		mov edi,1	// ����edi ����1��

	mov	edi, 1
$l1$200:

; 924  : 	l1: dec edi	// ��edi ָ���ҵ����ַ�������NULL����

	dec	edi

; 925  : //		mov __res,edi
; 926  : 		mov eax,edi

	mov	eax, edi

; 927  : 		popf

	popf

; 928  : 	}
; 929  : //  return __res;			// �����ַ�ָ�롣
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

; 958  : 		cld		// �巽��λ��

	cld

; 959  : 		rep stosb// ��al ���ַ�����es:[edi]�У�����edi++���ظ�ecx ָ���Ĵ�����ִ��

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
