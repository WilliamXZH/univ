	TITLE	..\fs\namei.c
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
;	COMDAT __INC_PIPE
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT _switch_to
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT __set_base
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT __set_limit
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT __get_base
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT _get_limit
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT _get_fs_byte
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT _get_fs_word
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT _get_fs_long
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT _put_fs_byte
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT _put_fs_word
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT _put_fs_long
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT _get_fs
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT _get_ds
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT _set_fs
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
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
FLAT	GROUP _DATA, CONST, _BSS
	ASSUME	CS: FLAT, DS: FLAT, SS: FLAT
endif
PUBLIC	__INC_PIPE
;	COMDAT __INC_PIPE
_TEXT	SEGMENT
_head$ = 8
__INC_PIPE PROC NEAR					; COMDAT

; 85   : extern _inline void _INC_PIPE(unsigned long *head) {

	push	ebp
	mov	ebp, esp
	push	ebx

; 86   : 	_asm mov ebx,head

	mov	ebx, DWORD PTR _head$[ebp]

; 87   : 	_asm inc dword ptr [ebx]

	inc	DWORD PTR [ebx]

; 88   : 	_asm and dword ptr [ebx],4095

	and	DWORD PTR [ebx], 4095			; 00000fffH
	pop	ebx

; 89   : }

	pop	ebp
	ret	0
__INC_PIPE ENDP
_TEXT	ENDS
PUBLIC	_switch_to
EXTRN	_task:BYTE
EXTRN	_last_task_used_math:DWORD
EXTRN	_current:DWORD
;	COMDAT _switch_to
_TEXT	SEGMENT
_n$ = 8
___tmp$ = -4
_switch_to PROC NEAR					; COMDAT

; 268  : {

	push	ebp
	mov	ebp, esp
	push	ecx
	push	ebx
	push	esi
	push	edi

; 269  : 	unsigned short __tmp;
; 270  : 	__tmp = (unsigned short)_TSS(n);

	mov	eax, DWORD PTR _n$[ebp]
	shl	eax, 4
	add	eax, 32					; 00000020H
	mov	WORD PTR ___tmp$[ebp], ax

; 271  : 
; 272  : 	_asm {
; 273  : 		mov ebx, offset task

	mov	ebx, OFFSET FLAT:_task

; 274  : 		mov eax, n

	mov	eax, DWORD PTR _n$[ebp]

; 275  : 		mov ecx, [ebx+eax*4]

	mov	ecx, DWORD PTR [ebx+eax*4]

; 276  : 		cmp ecx, current/* ����n �ǵ�ǰ������?(current ==task[n]?) */ 

	cmp	ecx, DWORD PTR _current

; 277  : 		je l1 /* �ǣ���ʲô���������˳���*/ 

	je	SHORT $l1$499

; 278  : 		xchg ecx,current/* current = task[n]�� */

	xchg	ecx, DWORD PTR _current

; 279  : 		/*ִ�г���ת����������л� (ͷ���˺ܳ�ʱ�䣬������)*/
; 280  : 		mov ax, __tmp

	mov	ax, WORD PTR ___tmp$[ebp]

; 281  : 		mov word ptr ds:[lcs],ax

	mov	WORD PTR ds:$lcs$500, ax

; 282  : 		_emit 0xea

	DB	-22					; ffffffeaH

; 283  : 		_emit 0		// ip

	DB	0

; 284  : 		_emit 0 

	DB	0

; 285  : 		_emit 0 

	DB	0

; 286  : 		_emit 0

	DB	0
$lcs$500:

; 287  : lcs:	_emit 0		// cs

	DB	0

; 288  : 		_emit 0

	DB	0

; 289  : // �������л�������Ż����ִ���������䡣
; 290  : 		cmp last_task_used_math,ecx /* �������ϴ�ʹ�ù�Э��������*/

	cmp	DWORD PTR _last_task_used_math, ecx

; 291  : 		jne l1

	jne	SHORT $l1$499

; 292  : 		clts/* �������ϴ�ʹ�ù�Э������������cr0 ��TS ��־��*/

	clts
$l1$499:

; 293  : 	}
; 294  : l1: ;
; 295  : }

	pop	edi
	pop	esi
	pop	ebx
	mov	esp, ebp
	pop	ebp
	ret	0
_switch_to ENDP
_TEXT	ENDS
PUBLIC	__set_base
;	COMDAT __set_base
_TEXT	SEGMENT
_addr$ = 8
_base$ = 12
__set_base PROC NEAR					; COMDAT

; 319  : { 

	push	ebp
	mov	ebp, esp
	push	ebx

; 320  : /*	addr[1] = base;
; 321  : 	((char*)addr)[4] = base >> 16;
; 322  : 	((char*)addr)[7] = base >> 8;*/
; 323  : 	_asm mov ebx,addr

	mov	ebx, DWORD PTR _addr$[ebp]

; 324  : 	_asm mov edx,base 

	mov	edx, DWORD PTR _base$[ebp]

; 325  : 	_asm mov word ptr [ebx+2],dx // ��ַbase ��16 λ(λ15-0)->[addr+2]��

	mov	WORD PTR [ebx+2], dx

; 326  : 	_asm ror edx,16 // edx �л�ַ��16 λ(λ31-16) -> dx�� 

	ror	edx, 16					; 00000010H

; 327  : 	_asm mov byte ptr [ebx+4],dl // ��ַ��16 λ�еĵ�8 λ(λ23-16)->[addr+4]��

	mov	BYTE PTR [ebx+4], dl

; 328  : 	_asm mov byte ptr [ebx+7],dh // ��ַ��16 λ�еĸ�8 λ(λ31-24)->[addr+7]��

	mov	BYTE PTR [ebx+7], dh
	pop	ebx

; 329  : }

	pop	ebp
	ret	0
__set_base ENDP
_TEXT	ENDS
PUBLIC	__set_limit
;	COMDAT __set_limit
_TEXT	SEGMENT
_addr$ = 8
_limit$ = 12
__set_limit PROC NEAR					; COMDAT

; 340  : {

	push	ebp
	mov	ebp, esp
	push	ebx

; 341  : /*	addr[0] = limit;
; 342  : 	((char*)addr)[6] = ((char*)addr)[6] & 0xf0 + (limit >> 16) & 0x0f;*/
; 343  : 	_asm mov ebx,addr

	mov	ebx, DWORD PTR _addr$[ebp]

; 344  : 	_asm mov edx,limit 

	mov	edx, DWORD PTR _limit$[ebp]

; 345  : 	_asm mov word ptr [ebx],dx // �γ�limit ��16 λ(λ15-0)->[addr]��

	mov	WORD PTR [ebx], dx

; 346  : 	_asm ror edx,16 // edx �еĶγ���4 λ(λ19-16)->dl��

	ror	edx, 16					; 00000010H

; 347  : 	_asm mov dh,byte ptr [ebx+6] // ȡԭ[addr+6]�ֽ�->dh�����и�4 λ��Щ��־��

	mov	dh, BYTE PTR [ebx+6]

; 348  : 	_asm and dh,0f0h // ��dh �ĵ�4 λ(����Ŷγ���λ19-16)��

	and	dh, -16					; fffffff0H

; 349  : 	_asm or dl,dh // ��ԭ��4 λ��־�Ͷγ��ĸ�4 λ(λ19-16)�ϳ�1 �ֽڣ�

	or	dl, dh

; 350  : 	_asm mov byte ptr [ebx+6],dl // ���Ż�[addr+6]����

	mov	BYTE PTR [ebx+6], dl
	pop	ebx

; 351  : }

	pop	ebp
	ret	0
__set_limit ENDP
_TEXT	ENDS
PUBLIC	__get_base
;	COMDAT __get_base
_TEXT	SEGMENT
_addr$ = 8
__get_base PROC NEAR					; COMDAT

; 374  : {

	push	ebp
	mov	ebp, esp
	push	ebx

; 375  : //	unsigned long __base; 
; 376  : 	_asm { 
; 377  : 		_asm mov ebx,addr

	mov	ebx, DWORD PTR _addr$[ebp]

; 378  : 		_asm mov ah,byte ptr [ebx+7] // ȡ[addr+7]����ַ��16 λ�ĸ�8 λ(λ31-24)->dh��

	mov	ah, BYTE PTR [ebx+7]

; 379  : 		_asm mov al,byte ptr [ebx+4] // ȡ[addr+4]����ַ��16 λ�ĵ�8 λ(λ23-16)->dl��

	mov	al, BYTE PTR [ebx+4]

; 380  : 		_asm shl eax,16 // ����ַ��16 λ�Ƶ�edx �и�16 λ����

	shl	eax, 16					; 00000010H

; 381  : 		_asm mov ax,word ptr [ebx+2] // ȡ[addr+2]����ַ��16 λ(λ15-0)->dx��

	mov	ax, WORD PTR [ebx+2]
	pop	ebx

; 382  : //		_asm mov __base,eax 
; 383  : 		} 
; 384  : //	return __base; 
; 385  : }

	pop	ebp
	ret	0
__get_base ENDP
_TEXT	ENDS
PUBLIC	_get_limit
;	COMDAT _get_limit
_TEXT	SEGMENT
_segment$ = 8
_get_limit PROC NEAR					; COMDAT

; 400  : extern _inline unsigned long get_limit(unsigned long segment) { 

	push	ebp
	mov	ebp, esp

; 401  : //	unsigned long __limit; 
; 402  : 	_asm { 
; 403  : 		mov eax,segment 

	mov	eax, DWORD PTR _segment$[ebp]

; 404  : 		lsl eax,eax 

	lsl	eax, eax

; 405  : //		mov __limit,eax 
; 406  : 	} 
; 407  : //	return __limit; 
; 408  : }

	pop	ebp
	ret	0
_get_limit ENDP
_TEXT	ENDS
PUBLIC	_get_fs_byte
;	COMDAT _get_fs_byte
_TEXT	SEGMENT
_addr$ = 8
_get_fs_byte PROC NEAR					; COMDAT

; 7    : {

	push	ebp
	mov	ebp, esp
	push	ebx

; 8    : //  unsigned register char _v;
; 9    : 
; 10   : // __asm__ ("movb %%fs:%1,%0": "=r" (_v):"m" (*addr));
; 11   :   _asm mov ebx,addr

	mov	ebx, DWORD PTR _addr$[ebp]

; 12   :   _asm mov al,byte ptr fs:[ebx];

	mov	al, BYTE PTR fs:[ebx]
	pop	ebx

; 13   : //  _asm mov _v,al;
; 14   : //  return _v;
; 15   : }

	pop	ebp
	ret	0
_get_fs_byte ENDP
_TEXT	ENDS
PUBLIC	_get_fs_word
;	COMDAT _get_fs_word
_TEXT	SEGMENT
_addr$ = 8
_get_fs_word PROC NEAR					; COMDAT

; 23   : {

	push	ebp
	mov	ebp, esp
	push	ebx

; 24   : //  unsigned short _v;
; 25   : 
; 26   : //__asm__ ("movw %%fs:%1,%0": "=r" (_v):"m" (*addr));
; 27   :   _asm mov ebx,addr

	mov	ebx, DWORD PTR _addr$[ebp]

; 28   :   _asm mov ax,word ptr fs:[ebx];

	mov	ax, WORD PTR fs:[ebx]
	pop	ebx

; 29   : //  _asm mov _v,ax;
; 30   : //  return _v;
; 31   : }

	pop	ebp
	ret	0
_get_fs_word ENDP
_TEXT	ENDS
PUBLIC	_get_fs_long
;	COMDAT _get_fs_long
_TEXT	SEGMENT
_addr$ = 8
_get_fs_long PROC NEAR					; COMDAT

; 39   : {

	push	ebp
	mov	ebp, esp
	push	ebx

; 40   : //  unsigned long _v;
; 41   : 
; 42   : //__asm__ ("movl %%fs:%1,%0": "=r" (_v):"m" (*addr));
; 43   :   _asm mov ebx,addr

	mov	ebx, DWORD PTR _addr$[ebp]

; 44   :   _asm mov eax,dword ptr fs:[ebx];

	mov	eax, DWORD PTR fs:[ebx]
	pop	ebx

; 45   : //  _asm mov _v,eax;
; 46   : //  return _v;
; 47   : }

	pop	ebp
	ret	0
_get_fs_long ENDP
_TEXT	ENDS
PUBLIC	_put_fs_byte
;	COMDAT _put_fs_byte
_TEXT	SEGMENT
_val$ = 8
_addr$ = 12
_put_fs_byte PROC NEAR					; COMDAT

; 54   : {

	push	ebp
	mov	ebp, esp
	push	ebx

; 55   : //  __asm__ ("movb %0,%%fs:%1"::"r" (val), "m" (*addr));
; 56   : 	_asm mov ebx,addr

	mov	ebx, DWORD PTR _addr$[ebp]

; 57   : 	_asm mov al,val;

	mov	al, BYTE PTR _val$[ebp]

; 58   : 	_asm mov byte ptr fs:[ebx],al;

	mov	BYTE PTR fs:[ebx], al
	pop	ebx

; 59   : }

	pop	ebp
	ret	0
_put_fs_byte ENDP
_TEXT	ENDS
PUBLIC	_put_fs_word
;	COMDAT _put_fs_word
_TEXT	SEGMENT
_val$ = 8
_addr$ = 12
_put_fs_word PROC NEAR					; COMDAT

; 66   : {

	push	ebp
	mov	ebp, esp
	push	ebx

; 67   : //  __asm__ ("movw %0,%%fs:%1"::"r" (val), "m" (*addr));
; 68   : 	_asm mov ebx,addr

	mov	ebx, DWORD PTR _addr$[ebp]

; 69   : 	_asm mov ax,val;

	mov	ax, WORD PTR _val$[ebp]

; 70   : 	_asm mov word ptr fs:[ebx],ax;

	mov	WORD PTR fs:[ebx], ax
	pop	ebx

; 71   : }

	pop	ebp
	ret	0
_put_fs_word ENDP
_TEXT	ENDS
PUBLIC	_put_fs_long
;	COMDAT _put_fs_long
_TEXT	SEGMENT
_val$ = 8
_addr$ = 12
_put_fs_long PROC NEAR					; COMDAT

; 78   : {

	push	ebp
	mov	ebp, esp
	push	ebx

; 79   : //  __asm__ ("movl %0,%%fs:%1"::"r" (val), "m" (*addr));
; 80   : 	_asm mov ebx,addr

	mov	ebx, DWORD PTR _addr$[ebp]

; 81   : 	_asm mov eax,val;

	mov	eax, DWORD PTR _val$[ebp]

; 82   : 	_asm mov dword ptr fs:[ebx],eax;

	mov	DWORD PTR fs:[ebx], eax
	pop	ebx

; 83   : }

	pop	ebp
	ret	0
_put_fs_long ENDP
_TEXT	ENDS
PUBLIC	_get_fs
;	COMDAT _get_fs
_TEXT	SEGMENT
_get_fs	PROC NEAR					; COMDAT

; 97   : //  unsigned short _v;
; 98   : //__asm__ ("mov %%fs,%%ax": "=a" (_v):);
; 99   :   _asm mov ax,fs;

	mov	ax, fs

; 100  : //  _asm mov _v,ax;
; 101  : //  return _v;
; 102  : }

	ret	0
_get_fs	ENDP
_TEXT	ENDS
PUBLIC	_get_ds
;	COMDAT _get_ds
_TEXT	SEGMENT
_get_ds	PROC NEAR					; COMDAT

; 109  : //  unsigned short _v;
; 110  : //__asm__ ("mov %%ds,%%ax": "=a" (_v):);
; 111  :   _asm mov ax,fs;

	mov	ax, fs

; 112  : //  _asm mov _v,ax;
; 113  : //  return _v;
; 114  : }

	ret	0
_get_ds	ENDP
_TEXT	ENDS
PUBLIC	_set_fs
;	COMDAT _set_fs
_TEXT	SEGMENT
_val$ = 8
_set_fs	PROC NEAR					; COMDAT

; 120  : {

	push	ebp
	mov	ebp, esp

; 121  : //  __asm__ ("mov %0,%%fs"::"a" ((unsigned short) val));
; 122  : 	_asm mov eax,val;

	mov	eax, DWORD PTR _val$[ebp]

; 123  : 	_asm mov fs,ax;

	mov	fs, ax

; 124  : }

	pop	ebp
	ret	0
_set_fs	ENDP
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
$l1$598:

; 39   : 	l1:	lodsb	// ����DS:[esi]��1 �ֽ�->al��������esi��

	lodsb

; 40   : 		stosb		// �洢�ֽ�al->ES:[edi]��������edi��

	stosb

; 41   : 		test al,al	// �մ洢���ֽ���0��

	test	al, al

; 42   : 		jne l1	// ��������ת�����l1 �������������

	jne	SHORT $l1$598

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
$l1$615:

; 115  : 	l1: lodsb	// ȡԴ�ַ����ֽ�ds:[esi]->al����esi++��

	lodsb

; 116  : 		stosb		// �����ֽڴ浽es:[edi]����edi++��

	stosb

; 117  : 		test al,al	// ���ֽ���0��

	test	al, al

; 118  : 		jne l1	// ���ǣ��������ת�����1 ���������������������

	jne	SHORT $l1$615

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
PUBLIC	_namei
EXTRN	_iput:NEAR
EXTRN	_iget:NEAR
EXTRN	_brelse:NEAR
EXTRN	_jiffies:DWORD
EXTRN	_startup_time:DWORD
_TEXT	SEGMENT
_pathname$ = 8
_basename$ = -8
_namelen$ = -4
_dir$ = 8
_de$ = -12
_namei	PROC NEAR

; 404  : {

	push	ebp
	mov	ebp, esp
	sub	esp, 12					; 0000000cH

; 405  : 	const char * basename;
; 406  : 	int inr,dev,namelen;
; 407  : 	struct m_inode * dir;
; 408  : 	struct buffer_head * bh;
; 409  : 	struct dir_entry * de;
; 410  : 
; 411  : // ���Ȳ���ָ��·�������Ŀ¼��Ŀ¼������i �ڵ㣬�������ڣ��򷵻�NULL���˳���
; 412  : 	if (!(dir = dir_namei(pathname,&namelen,&basename)))

	mov	edx, DWORD PTR _pathname$[ebp]
	lea	eax, DWORD PTR _basename$[ebp]
	lea	ecx, DWORD PTR _namelen$[ebp]
	push	eax
	push	ecx
	push	edx
	call	_dir_namei
	add	esp, 12					; 0000000cH
	mov	DWORD PTR _dir$[ebp], eax
	test	eax, eax
	jne	SHORT $L987

; 438  : }

	mov	esp, ebp
	pop	ebp
	ret	0
$L987:

; 413  : 		return NULL;
; 414  : // ������ص�������ֵĳ�����0�����ʾ��·������һ��Ŀ¼��Ϊ���һ�
; 415  : 	if (!namelen)			/* ��Ӧ��'/usr/'����� */

	mov	ecx, DWORD PTR _namelen$[ebp]
	test	ecx, ecx

; 416  : 		return dir;

	je	$L979

; 417  : // �ڷ��صĶ���Ŀ¼��Ѱ��ָ���ļ�����Ŀ¼���i �ڵ㡣��Ϊ������Ҳ��һ��Ŀ¼���������û
; 418  : // �м�'/'���򲻻᷵�ظ����Ŀ¼��i �ڵ㣡���磺/var/log/httpd����ֻ����log/Ŀ¼��i �ڵ㡣
; 419  : // ���dir_namei()������'/'���������һ�����ֵ���һ���ļ��������������������Ҫ����������
; 420  : // ���ʹ��Ѱ��Ŀ¼��i �ڵ㺯��find_entry()���д���
; 421  : 	bh = find_entry(&dir,basename,namelen,&de);

	lea	eax, DWORD PTR _de$[ebp]
	lea	edx, DWORD PTR _dir$[ebp]
	push	eax
	push	ecx
	mov	ecx, DWORD PTR _basename$[ebp]
	push	ecx
	push	edx
	call	_find_entry
	add	esp, 16					; 00000010H

; 422  : 	if (!bh) {

	test	eax, eax
	jne	SHORT $L989

; 423  : 		iput(dir);

	mov	eax, DWORD PTR _dir$[ebp]
	push	eax
	call	_iput
	add	esp, 4

; 424  : 		return NULL;

	xor	eax, eax

; 438  : }

	mov	esp, ebp
	pop	ebp
	ret	0
$L989:

; 425  : 	}
; 426  : // ȡ��Ŀ¼���i �ڵ�ź�Ŀ¼���豸�ţ����ͷŰ�����Ŀ¼��ĸ��ٻ������Լ�Ŀ¼i �ڵ㡣
; 427  : 	inr = de->inode;

	mov	ecx, DWORD PTR _de$[ebp]

; 428  : 	dev = dir->i_dev;

	mov	edx, DWORD PTR _dir$[ebp]
	push	esi
	push	edi
	xor	esi, esi
	xor	edi, edi
	mov	si, WORD PTR [ecx]
	mov	di, WORD PTR [edx+44]

; 429  : 	brelse(bh);

	push	eax
	call	_brelse

; 430  : 	iput(dir);

	mov	eax, DWORD PTR _dir$[ebp]
	push	eax
	call	_iput

; 431  : // ȡ��Ӧ�ںŵ�i �ڵ㣬�޸��䱻����ʱ��Ϊ��ǰʱ�䣬�������޸ı�־����󷵻ظ�i �ڵ�ָ�롣
; 432  : 	dir=iget(dev,inr);

	push	esi
	push	edi
	call	_iget
	add	esp, 16					; 00000010H
	mov	ecx, eax

; 433  : 	if (dir) {

	test	ecx, ecx
	pop	edi
	mov	DWORD PTR _dir$[ebp], ecx
	pop	esi
	je	SHORT $L990

; 434  : 		dir->i_atime=CURRENT_TIME;

	mov	edx, DWORD PTR _jiffies
	mov	eax, 1374389535				; 51eb851fH
	imul	edx
	sar	edx, 5
	mov	eax, edx
	shr	eax, 31					; 0000001fH
	add	edx, eax
	mov	eax, DWORD PTR _startup_time
	add	edx, eax
	mov	DWORD PTR [ecx+36], edx

; 435  : 		dir->i_dirt=1;

	mov	ecx, DWORD PTR _dir$[ebp]
	mov	BYTE PTR [ecx+51], 1
	mov	ecx, DWORD PTR _dir$[ebp]
$L990:

; 436  : 	}
; 437  : 	return dir;

	mov	eax, ecx
$L979:

; 438  : }

	mov	esp, ebp
	pop	ebp
	ret	0
_namei	ENDP
_TEXT	ENDS
EXTRN	_bmap:NEAR
EXTRN	_bread:NEAR
EXTRN	_get_super:NEAR
_TEXT	SEGMENT
$T1225 = 8
_dir$ = 8
_name$ = 12
_namelen$ = 16
_res_dir$ = 20
_entries$ = -4
_find_entry PROC NEAR

; 127  : {

	push	ebp
	mov	ebp, esp
	push	ecx

; 133  : 
; 134  : // ���������NO_TRUNCATE�������ļ������ȳ�����󳤶�NAME_LEN���򷵻ء�
; 135  : #ifdef NO_TRUNCATE
; 136  : 	if (namelen > NAME_LEN)
; 137  : 		return NULL;
; 138  : //���û�ж���NO_TRUNCATE�������ļ������ȳ�����󳤶�NAME_LEN����ض�֮��
; 139  : #else
; 140  : 	if (namelen > NAME_LEN)

	mov	ecx, DWORD PTR _namelen$[ebp]
	cmp	ecx, 14					; 0000000eH
	jle	SHORT $L870

; 141  : 		namelen = NAME_LEN;

	mov	DWORD PTR _namelen$[ebp], 14		; 0000000eH
	mov	ecx, DWORD PTR _namelen$[ebp]
$L870:
	push	ebx
	push	esi
	push	edi

; 142  : #endif
; 143  : // ���㱾Ŀ¼��Ŀ¼������entries���ÿշ���Ŀ¼��ṹָ�롣
; 144  : 	entries = (*dir)->i_size / (sizeof (struct dir_entry));

	mov	edi, DWORD PTR _dir$[ebp]

; 145  : 	*res_dir = NULL;

	mov	edx, DWORD PTR _res_dir$[ebp]
	mov	eax, DWORD PTR [edi]
	mov	DWORD PTR [edx], 0
	mov	eax, DWORD PTR [eax+4]
	shr	eax, 4

; 146  : // ����ļ������ȵ���0���򷵻�NULL���˳���
; 147  : 	if (!namelen)

	test	ecx, ecx
	mov	DWORD PTR _entries$[ebp], eax

; 148  : 		return NULL;

	je	$L1231

; 149  : /* ���Ŀ¼��'..'����Ϊ������Ҫ�����ر��� */
; 150  : 	if (namelen==2 && get_fs_byte(name)=='.' && get_fs_byte(name+1)=='.') {

	cmp	ecx, 2
	jne	SHORT $L877

; 128  : 	int entries;
; 129  : 	int block,i;
; 130  : 	struct buffer_head * bh;
; 131  : 	struct dir_entry * de;

	mov	ebx, DWORD PTR _name$[ebp]

; 132  : 	struct super_block * sb;

	mov	al, BYTE PTR fs:[ebx]

; 149  : /* ���Ŀ¼��'..'����Ϊ������Ҫ�����ر��� */
; 150  : 	if (namelen==2 && get_fs_byte(name)=='.' && get_fs_byte(name+1)=='.') {

	cmp	al, 46					; 0000002eH
	jne	SHORT $L877
	mov	eax, DWORD PTR _name$[ebp]
	inc	eax
	mov	DWORD PTR $T1225[ebp], eax

; 128  : 	int entries;
; 129  : 	int block,i;
; 130  : 	struct buffer_head * bh;
; 131  : 	struct dir_entry * de;

	mov	ebx, DWORD PTR $T1225[ebp]

; 132  : 	struct super_block * sb;

	mov	al, BYTE PTR fs:[ebx]

; 149  : /* ���Ŀ¼��'..'����Ϊ������Ҫ�����ر��� */
; 150  : 	if (namelen==2 && get_fs_byte(name)=='.' && get_fs_byte(name+1)=='.') {

	cmp	al, 46					; 0000002eH
	jne	SHORT $L877

; 151  : /* α���е�'..'��ͬһ����'.'(ֻ��ı����ֳ���) */
; 152  : // �����ǰ���̵ĸ��ڵ�ָ�뼴��ָ����Ŀ¼�����ļ����޸�Ϊ'.'��
; 153  : 		if ((*dir) == current->root)

	mov	ecx, DWORD PTR _current
	mov	eax, DWORD PTR [edi]
	cmp	eax, DWORD PTR [ecx+628]
	jne	SHORT $L874

; 154  : 			namelen=1;

	mov	DWORD PTR _namelen$[ebp], 1

; 155  : // ���������Ŀ¼��i �ڵ�ŵ���ROOT_INO(1)�Ļ���˵�����ļ�ϵͳ���ڵ㡣��ȡ�ļ�ϵͳ�ĳ����顣
; 156  : 		else if ((*dir)->i_num == ROOT_INO) {

	jmp	SHORT $L877
$L874:
	cmp	WORD PTR [eax+46], 1
	jne	SHORT $L877

; 157  : /* ��һ����װ���ϵ�'..'������Ŀ¼��������װ���ļ�ϵͳ��Ŀ¼i �ڵ㡣
; 158  :    ע�⣡����������mounted ��־����������ܹ�ȡ������Ŀ¼ */
; 159  : 			sb=get_super((*dir)->i_dev);

	xor	edx, edx
	mov	dx, WORD PTR [eax+44]
	push	edx
	call	_get_super

; 160  : // �������װ����i �ڵ���ڣ������ͷ�ԭi �ڵ㣬Ȼ��Ա���װ����i �ڵ���д���
; 161  : // ��*dir ָ��ñ���װ����i �ڵ㣻��i �ڵ����������1��
; 162  : 			if (sb->s_imount) {

	mov	esi, DWORD PTR [eax+92]
	add	esp, 4
	test	esi, esi
	je	SHORT $L877

; 163  : 				iput(*dir);

	mov	eax, DWORD PTR [edi]
	push	eax
	call	_iput
	add	esp, 4

; 164  : 				(*dir)=sb->s_imount;
; 165  : 				(*dir)->i_count++;

	inc	WORD PTR [esi+48]
	mov	DWORD PTR [edi], esi
$L877:

; 166  : 			}
; 167  : 		}
; 168  : 	}
; 169  : // �����i �ڵ���ָ��ĵ�һ��ֱ�Ӵ��̿��Ϊ0���򷵻�NULL���˳���
; 170  : 	if (!(block = (*dir)->i_zone[0]))

	mov	ecx, DWORD PTR [edi]
	xor	eax, eax
	mov	DWORD PTR 8+[ebp], ecx
	mov	ax, WORD PTR [ecx+14]
	test	eax, eax

; 171  : 		return NULL;

	je	$L1231

; 172  : // �ӽڵ������豸��ȡָ����Ŀ¼�����ݿ飬������ɹ����򷵻�NULL���˳���
; 173  : 	if (!(bh = bread((*dir)->i_dev,block)))

	xor	edx, edx
	push	eax
	mov	dx, WORD PTR [ecx+44]
	push	edx
	call	_bread
	mov	esi, eax
	add	esp, 8
	test	esi, esi

; 174  : 		return NULL;

	je	$L1231

; 175  : // ��Ŀ¼�����ݿ�������ƥ��ָ���ļ�����Ŀ¼�������de ָ�����ݿ飬���ڲ�����Ŀ¼��Ŀ¼����
; 176  : // �������£�ѭ��ִ��������
; 177  : 	i = 0;
; 178  : 	de = (struct dir_entry *) bh->b_data;
; 179  : 	while (i < entries) {

	mov	eax, DWORD PTR _entries$[ebp]
	mov	ebx, DWORD PTR [esi]
	xor	edi, edi
	test	eax, eax
	jle	$L883
$L882:

; 180  : // �����ǰĿ¼�����ݿ��Ѿ������꣬��û���ҵ�ƥ���Ŀ¼����ͷŵ�ǰĿ¼�����ݿ顣
; 181  : 		if ((char *)de >= BLOCK_SIZE+bh->b_data) {

	mov	eax, DWORD PTR [esi]
	add	eax, 1024				; 00000400H
	cmp	ebx, eax
	jb	SHORT $L885

; 182  : 			brelse(bh);

	push	esi
	call	_brelse

; 183  : 			bh = NULL;
; 184  : // �ڶ�����һĿ¼�����ݿ顣�����Ϊ�գ���ֻҪ��û��������Ŀ¼�е�����Ŀ¼��������ÿ飬
; 185  : // ��������һĿ¼�����ݿ顣���ÿ鲻�գ�����de ָ���Ŀ¼�����ݿ飬����������
; 186  : 			if (!(block = bmap(*dir,i/DIR_ENTRIES_PER_BLOCK)) ||
; 187  : 			    !(bh = bread((*dir)->i_dev,block))) {

	mov	edx, DWORD PTR 8+[ebp]
	mov	ecx, edi
	shr	ecx, 6
	push	ecx
	push	edx
	xor	esi, esi
	call	_bmap
	add	esp, 12					; 0000000cH
	test	eax, eax
	je	SHORT $L888
	mov	ecx, DWORD PTR 8+[ebp]
	push	eax
	xor	eax, eax
	mov	ax, WORD PTR [ecx+44]
	push	eax
	call	_bread
	mov	esi, eax
	add	esp, 8
	test	esi, esi
	je	SHORT $L888

; 190  : 			}
; 191  : 			de = (struct dir_entry *) bh->b_data;

	mov	ebx, DWORD PTR [esi]
$L885:

; 192  : 		}
; 193  : // ����ҵ�ƥ���Ŀ¼��Ļ����򷵻ظ�Ŀ¼��ṹָ��͸�Ŀ¼�����ݿ�ָ�룬�˳���
; 194  : 		if (match(namelen,name,de)) {

	mov	edx, DWORD PTR _name$[ebp]
	mov	eax, DWORD PTR _namelen$[ebp]
	push	ebx
	push	edx
	push	eax
	call	_match
	add	esp, 12					; 0000000cH
	test	eax, eax
	jne	SHORT $L1228

; 197  : 		}
; 198  : // ���������Ŀ¼�����ݿ��бȽ���һ��Ŀ¼�
; 199  : 		de++;

	add	ebx, 16					; 00000010H

; 200  : 		i++;

	inc	edi
$L1229:
	cmp	edi, DWORD PTR _entries$[ebp]
	jl	SHORT $L882

; 201  : 	}
; 202  : // ��ָ��Ŀ¼�е�����Ŀ¼������껹û���ҵ���Ӧ��Ŀ¼����ͷ�Ŀ¼�����ݿ飬����NULL��
; 203  : 	brelse(bh);

	push	esi
	call	_brelse
	add	esp, 4

; 204  : 	return NULL;

	xor	eax, eax
	pop	edi
	pop	esi
	pop	ebx

; 205  : }

	mov	esp, ebp
	pop	ebp
	ret	0
$L888:

; 188  : 				i += DIR_ENTRIES_PER_BLOCK;

	add	edi, 64					; 00000040H

; 189  : 				continue;

	jmp	SHORT $L1229
$L1228:

; 195  : 			*res_dir = de;

	mov	ecx, DWORD PTR _res_dir$[ebp]

; 196  : 			return bh;

	mov	eax, esi
	pop	edi
	pop	esi
	mov	DWORD PTR [ecx], ebx
	pop	ebx

; 205  : }

	mov	esp, ebp
	pop	ebp
	ret	0
$L883:

; 201  : 	}
; 202  : // ��ָ��Ŀ¼�е�����Ŀ¼������껹û���ҵ���Ӧ��Ŀ¼����ͷ�Ŀ¼�����ݿ飬����NULL��
; 203  : 	brelse(bh);

	push	esi
	call	_brelse
	add	esp, 4
$L1231:
	pop	edi
	pop	esi

; 204  : 	return NULL;

	xor	eax, eax
	pop	ebx

; 205  : }

	mov	esp, ebp
	pop	ebp
	ret	0
_find_entry ENDP
_len$ = 8
_name$ = 12
_de$ = 16
_same$ = -4
_de_name$ = 16
_match	PROC NEAR

; 75   : {

	push	ebp
	mov	ebp, esp
	push	ecx

; 76   : 	register int same; //__asm__("ax")
; 77   : 	char *de_name;
; 78   : 
; 79   : // ���Ŀ¼��ָ��գ�����Ŀ¼��i �ڵ����0������Ҫ�Ƚϵ��ַ������ȳ����ļ������ȣ��򷵻�0��
; 80   : 	if (!de || !de->inode || len > NAME_LEN)

	mov	ecx, DWORD PTR _de$[ebp]
	push	esi
	test	ecx, ecx
	push	edi
	je	SHORT $L852
	cmp	WORD PTR [ecx], 0
	je	SHORT $L852
	mov	eax, DWORD PTR _len$[ebp]
	cmp	eax, 14					; 0000000eH
	jg	SHORT $L852

; 81   : 		return 0;
; 82   : // ���Ҫ�Ƚϵĳ���len С��NAME_LEN������Ŀ¼�����ļ������ȳ���len���򷵻�0��
; 83   : 	if (len < NAME_LEN && de->name[len])

	jge	SHORT $L853
	mov	dl, BYTE PTR [eax+ecx+2]
	test	dl, dl

; 84   : 		return 0;

	jne	SHORT $L852
$L853:

; 85   : // ����Ƕ������䣬���û����ݿռ�(fs)ִ���ַ����ıȽϲ�����
; 86   : // %0 - eax(�ȽϽ��same)��%1 - eax(eax ��ֵ0)��%2 - esi(����ָ��)��%3 - edi(Ŀ¼����ָ��)��
; 87   : // %4 - ecx(�Ƚϵ��ֽڳ���ֵlen)��
; 88   : /*	__asm__("cld\n\t"				// �巽��λ��
; 89   : 		"fs ; repe ; cmpsb\n\t"		// �û��ռ�ִ��ѭ���Ƚ�[esi++]��[edi++]������
; 90   : 		"setz %%al"					// ���ȽϽ��һ��(z=0)������al=1(same=eax)��
; 91   : 		:"=a" (same)
; 92   : 		:"0" (0),"S" ((long) name),"D" ((long) de->name),"c" (len)
; 93   : 		:"cx","di","si");*/
; 94   : 	de_name = de->name;

	add	ecx, 2
	mov	DWORD PTR _de_name$[ebp], ecx

; 95   : 	_asm{
; 96   : 		pushf

	pushf

; 97   : 		xor eax,eax

	xor	eax, eax

; 98   : 		mov esi,name

	mov	esi, DWORD PTR _name$[ebp]

; 99   : 		mov edi,de_name

	mov	edi, DWORD PTR _de_name$[ebp]

; 100  : 		mov ecx,len

	mov	ecx, DWORD PTR _len$[ebp]

; 101  : 		cld		// �巽��λ��

	cld

; 102  : 		// �û��ռ�ִ��ѭ���Ƚ�[esi++]��[edi++]������
; 103  : 		repe cmps byte ptr fs:[edi],[esi]

	rep	 cmps	 BYTE PTR fs:[edi], BYTE PTR [esi]

; 104  : 		//�����Ӧ���Ǵ���ģ����Ҳ�֪����ô�ġ�����ϵͳ��������:)
; 105  : 		setz al			// ���ȽϽ��һ��(z=0)������al=1(same=eax)��

	sete	al

; 106  : 		mov same,eax

	mov	DWORD PTR _same$[ebp], eax

; 107  : 		popf

	popf

; 108  : 	}
; 109  : 	return same;			// ���رȽϽ����

	mov	eax, DWORD PTR _same$[ebp]

; 110  : }

	pop	edi
	pop	esi
	mov	esp, ebp
	pop	ebp
	ret	0
$L852:
	pop	edi
	xor	eax, eax
	pop	esi
	mov	esp, ebp
	pop	ebp
	ret	0
_match	ENDP
$T1237 = 8
_pathname$ = 8
_namelen$ = 12
_name$ = 16
_dir_namei PROC NEAR

; 375  : {

	push	ebp
	mov	ebp, esp
	push	esi

; 381  : 	if (!(dir = get_dir(pathname)))

	mov	esi, DWORD PTR _pathname$[ebp]
	push	esi
	call	_get_dir
	mov	edx, eax
	add	esp, 4
	test	edx, edx
	jne	SHORT $L972
	pop	esi

; 392  : }

	pop	ebp
	ret	0
$L972:
	push	ebx
$L1240:

; 382  : 		return NULL;
; 383  : // ��·����pathname ����������⣬�鴦���һ��'/'����������ַ����������䳤�ȣ��������
; 384  : // ��Ŀ¼��i �ڵ�ָ�롣
; 385  : 	basename = pathname;

	mov	ecx, esi
$L974:

; 386  : 	while (c=get_fs_byte(pathname++))

	mov	DWORD PTR $T1237[ebp], esi
	inc	esi

; 376  : 	char c;
; 377  : 	const char * basename;
; 378  : 	struct m_inode * dir;
; 379  : 

	mov	ebx, DWORD PTR $T1237[ebp]

; 380  : // ȡָ��·�������Ŀ¼��i �ڵ㣬�������򷵻�NULL���˳���

	mov	al, BYTE PTR fs:[ebx]

; 386  : 	while (c=get_fs_byte(pathname++))

	test	al, al
	je	SHORT $L975

; 387  : 		if (c=='/')

	cmp	al, 47					; 0000002fH
	jne	SHORT $L974

; 388  : 			basename=pathname;
; 389  : 	*namelen = pathname-basename-1;

	jmp	SHORT $L1240
$L975:
	mov	eax, DWORD PTR _namelen$[ebp]
	sub	esi, ecx
	dec	esi
	pop	ebx
	mov	DWORD PTR [eax], esi

; 390  : 	*name = basename;

	mov	eax, DWORD PTR _name$[ebp]
	pop	esi
	mov	DWORD PTR [eax], ecx

; 391  : 	return dir;

	mov	eax, edx

; 392  : }

	pop	ebp
	ret	0
_dir_namei ENDP
_TEXT	ENDS
EXTRN	_panic:NEAR
_DATA	SEGMENT
$SG942	DB	'No root inode', 00H
	ORG $+2
$SG945	DB	'No cwd inode', 00H
_DATA	ENDS
_TEXT	SEGMENT
$T1249 = 8
_pathname$ = 8
_inode$ = -4
_de$ = -8
_get_dir PROC NEAR

; 307  : {

	push	ebp
	mov	ebp, esp
	sub	esp, 8

; 313  : 	struct dir_entry * de;
; 314  : 
; 315  : // �������û���趨��i �ڵ㣬���߸ý��̸�i �ڵ������Ϊ0����ϵͳ����������
; 316  : 	if (!current->root || !current->root->i_count)

	mov	eax, DWORD PTR _current
	mov	eax, DWORD PTR [eax+628]
	test	eax, eax
	je	SHORT $L941
	cmp	WORD PTR [eax+48], 0
	jne	SHORT $L940
$L941:

; 317  : 		panic("No root inode");

	push	OFFSET FLAT:$SG942
	call	_panic
	add	esp, 4
$L940:

; 318  : // ������̵ĵ�ǰ����Ŀ¼ָ��Ϊ�գ����߸õ�ǰĿ¼i �ڵ�����ü���Ϊ0��Ҳ��ϵͳ�����⣬������
; 319  : 	if (!current->pwd || !current->pwd->i_count)

	mov	ecx, DWORD PTR _current
	mov	eax, DWORD PTR [ecx+624]
	test	eax, eax
	je	SHORT $L944
	cmp	WORD PTR [eax+48], 0
	jne	SHORT $L943
$L944:

; 320  : 		panic("No cwd inode");

	push	OFFSET FLAT:$SG945
	call	_panic
	add	esp, 4
$L943:
	push	ebx
	push	esi
	push	edi

; 308  : 	char c;
; 309  : 	const char * thisname;
; 310  : 	struct m_inode * inode;
; 311  : 	struct buffer_head * bh;

	mov	ebx, DWORD PTR _pathname$[ebp]

; 312  : 	int namelen,inr,idev;

	mov	al, BYTE PTR fs:[ebx]

; 321  : // ����û�ָ����·�����ĵ�1 ���ַ���'/'����˵��·�����Ǿ���·��������Ӹ�i �ڵ㿪ʼ������
; 322  : 	if ((c=get_fs_byte(pathname))=='/') {

	cmp	al, 47					; 0000002fH
	jne	SHORT $L946

; 323  : 		inode = current->root;

	mov	edx, DWORD PTR _current

; 324  : 		pathname++;

	mov	edi, DWORD PTR _pathname$[ebp]
	inc	edi
	mov	eax, DWORD PTR [edx+628]
	mov	DWORD PTR _inode$[ebp], eax

; 325  : // ��������һ���ַ��������ַ������ʾ�����������·������Ӧ�ӽ��̵ĵ�ǰ����Ŀ¼��ʼ������
; 326  : // ��ȡ���̵�ǰ����Ŀ¼��i �ڵ㡣
; 327  : 	} else if (c)

	jmp	SHORT $L949
$L946:
	test	al, al
	je	$L1256

; 328  : 		inode = current->pwd;

	mov	eax, DWORD PTR _current
	mov	edi, DWORD PTR _pathname$[ebp]
	mov	eax, DWORD PTR [eax+624]
	mov	DWORD PTR _inode$[ebp], eax
$L949:

; 329  : // �����ʾ·����Ϊ�գ���������NULL���˳���
; 330  : 	else
; 331  : 		return NULL;	/* �յ�·�����Ǵ���� */
; 332  : // ��ȡ�õ�i �ڵ����ü�����1��
; 333  : 	inode->i_count++;

	inc	WORD PTR [eax+48]
	mov	eax, DWORD PTR _inode$[ebp]
$L951:

; 335  : // ����i �ڵ㲻��Ŀ¼�ڵ㣬����û�пɽ���ķ�����ɣ����ͷŸ�i �ڵ㣬����NULL���˳���
; 336  : 		thisname = pathname;
; 337  : 		if (!S_ISDIR(inode->i_mode) || !permission(inode,MAY_EXEC)) {

	mov	cx, WORD PTR [eax]
	mov	esi, edi
	and	ecx, 61440				; 0000f000H
	cmp	ecx, 16384				; 00004000H
	jne	$L954
	push	1
	push	eax
	call	_permission
	add	esp, 8
	test	eax, eax
	je	$L1257

; 339  : 			return NULL;
; 340  : 		}
; 341  : // ��·������ʼ����������ַ���ֱ���ַ����ǽ�β��(NULL)������'/'����ʱnamelen �����ǵ�ǰ����
; 342  : // Ŀ¼���ĳ��ȡ�������Ҳ��һ��Ŀ¼���������û�м�'/'���򲻻᷵�ظ����Ŀ¼��i �ڵ㣡
; 343  : // ���磺/var/log/httpd����ֻ����log/Ŀ¼��i �ڵ㡣
; 344  : 		for(namelen=0;(c=get_fs_byte(pathname++))&&(c!='/');namelen++)

	xor	ecx, ecx
$L955:
	mov	DWORD PTR $T1249[ebp], edi
	inc	edi

; 308  : 	char c;
; 309  : 	const char * thisname;
; 310  : 	struct m_inode * inode;
; 311  : 	struct buffer_head * bh;

	mov	ebx, DWORD PTR $T1249[ebp]

; 312  : 	int namelen,inr,idev;

	mov	al, BYTE PTR fs:[ebx]

; 339  : 			return NULL;
; 340  : 		}
; 341  : // ��·������ʼ����������ַ���ֱ���ַ����ǽ�β��(NULL)������'/'����ʱnamelen �����ǵ�ǰ����
; 342  : // Ŀ¼���ĳ��ȡ�������Ҳ��һ��Ŀ¼���������û�м�'/'���򲻻᷵�ظ����Ŀ¼��i �ڵ㣡
; 343  : // ���磺/var/log/httpd����ֻ����log/Ŀ¼��i �ڵ㡣
; 344  : 		for(namelen=0;(c=get_fs_byte(pathname++))&&(c!='/');namelen++)

	test	al, al
	je	SHORT $L1254
	cmp	al, 47					; 0000002fH
	je	SHORT $L957
	inc	ecx
	jmp	SHORT $L955
$L957:

; 349  : // ���ò���ָ��Ŀ¼���ļ�����Ŀ¼������ڵ�ǰ����Ŀ¼��Ѱ����Ŀ¼����û���ҵ���
; 350  : // ���ͷŸ�i �ڵ㣬������NULL���˳���
; 351  : 		if (!(bh = find_entry(&inode,thisname,namelen,&de))) {

	lea	edx, DWORD PTR _de$[ebp]
	lea	eax, DWORD PTR _inode$[ebp]
	push	edx
	push	ecx
	push	esi
	push	eax
	call	_find_entry
	add	esp, 16					; 00000010H
	test	eax, eax
	je	SHORT $L1255

; 353  : 			return NULL;
; 354  : 		}
; 355  : // ȡ����Ŀ¼���i �ڵ��inr ���豸��idev���ͷŰ�����Ŀ¼��ĸ��ٻ����͸�i �ڵ㡣
; 356  : 		inr = de->inode;

	mov	ecx, DWORD PTR _de$[ebp]

; 357  : 		idev = inode->i_dev;

	mov	edx, DWORD PTR _inode$[ebp]
	xor	esi, esi
	xor	ebx, ebx
	mov	si, WORD PTR [ecx]
	mov	bx, WORD PTR [edx+44]

; 358  : 		brelse(bh);

	push	eax
	call	_brelse

; 359  : 		iput(inode);

	mov	eax, DWORD PTR _inode$[ebp]
	push	eax
	call	_iput

; 360  : // ȡ�ڵ��inr ��i �ڵ���Ϣ����ʧ�ܣ��򷵻�NULL���˳�����������Ը���Ŀ¼��i �ڵ���в�����
; 361  : 		if (!(inode = iget(idev,inr)))

	push	esi
	push	ebx
	call	_iget
	add	esp, 16					; 00000010H
	mov	DWORD PTR _inode$[ebp], eax
	test	eax, eax
	je	SHORT $L1256

; 334  : 	while (1) {

	jmp	$L951
$L1254:

; 345  : 			/* nothing */ ;
; 346  : // ���ַ��ǽ�β��NULL��������Ѿ�����ָ��Ŀ¼���򷵻ظ�i �ڵ�ָ�룬�˳���
; 347  : 		if (!c)
; 348  : 			return inode;

	mov	eax, DWORD PTR _inode$[ebp]
	pop	edi
	pop	esi
	pop	ebx

; 363  : 	}
; 364  : }

	mov	esp, ebp
	pop	ebp
	ret	0
$L1255:

; 352  : 			iput(inode);

	mov	ecx, DWORD PTR _inode$[ebp]
	push	ecx
	call	_iput
	add	esp, 4
	xor	eax, eax
	pop	edi
	pop	esi
	pop	ebx

; 363  : 	}
; 364  : }

	mov	esp, ebp
	pop	ebp
	ret	0
$L1257:

; 362  : 			return NULL;

	mov	eax, DWORD PTR _inode$[ebp]
$L954:

; 338  : 			iput(inode);

	push	eax
	call	_iput
	add	esp, 4
$L1256:
	pop	edi
	pop	esi
	xor	eax, eax
	pop	ebx

; 363  : 	}
; 364  : }

	mov	esp, ebp
	pop	ebp
	ret	0
_get_dir ENDP
_inode$ = 8
_mask$ = 12
_permission PROC NEAR

; 46   : {

	push	ebp
	mov	ebp, esp

; 47   : 	int mode = inode->i_mode;// �ļ���������

	mov	ecx, DWORD PTR _inode$[ebp]
	xor	eax, eax
	push	esi

; 48   : 
; 49   : /* �����������ʹ�ǳ����û�(root)Ҳ���ܶ�/дһ���ѱ�ɾ�����ļ� */
; 50   : // ���i �ڵ��ж�Ӧ���豸������i �ڵ������������0���򷵻ء�
; 51   : 	if (inode->i_dev && !inode->i_nlinks)

	cmp	WORD PTR [ecx+44], 0
	mov	ax, WORD PTR [ecx]
	je	SHORT $L834
	mov	dl, BYTE PTR [ecx+13]
	test	dl, dl
	jne	SHORT $L834

; 52   : 		return 0;

	xor	eax, eax
	pop	esi

; 63   : }

	pop	ebp
	ret	0
$L834:

; 53   : // ����������̵���Ч�û�id(euid)��i �ڵ���û�id ��ͬ����ȡ�ļ��������û�����Ȩ�ޡ�
; 54   : 	else if (current->euid==inode->i_uid)

	mov	edx, DWORD PTR _current
	mov	si, WORD PTR [edx+578]
	cmp	si, WORD PTR [ecx+2]
	jne	SHORT $L836

; 55   : 		mode >>= 6;

	sar	eax, 6

; 56   : // ����������̵���Ч��id(egid)��i �ڵ����id ��ͬ����ȡ���û��ķ���Ȩ�ޡ�
; 57   : 	else if (current->egid==inode->i_gid)

	jmp	SHORT $L838
$L836:
	movzx	cx, BYTE PTR [ecx+12]
	cmp	WORD PTR [edx+584], cx
	jne	SHORT $L838

; 58   : 		mode >>= 3;

	sar	eax, 3
$L838:

; 59   : // ���������ȡ�ĵķ���Ȩ������������ͬ�������ǳ����û����򷵻�1�����򷵻�0��
; 60   : 	if (((mode & mask & 0007) == mask) || suser()) // suser()��linux/kernel.h��

	mov	ecx, DWORD PTR _mask$[ebp]
	and	eax, ecx
	and	eax, 7
	cmp	eax, ecx
	je	SHORT $L840
	test	si, si
	je	SHORT $L840

; 62   : 	return 0;

	xor	eax, eax
	pop	esi

; 63   : }

	pop	ebp
	ret	0
$L840:

; 61   : 		return 1;

	mov	eax, 1
	pop	esi

; 63   : }

	pop	ebp
	ret	0
_permission ENDP
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
$l1$632:

; 201  :   l1: lodsb	// ȡ�ַ���2 ���ֽ�ds:[esi]??al������esi++��

	lodsb

; 202  : 	  scasb		// al ���ַ���1 ���ֽ�es:[edi]���Ƚϣ�����edi++��

	scasb

; 203  : 	  jne l2		// �������ȣ�����ǰ��ת�����2��

	jne	SHORT $l2$633

; 204  : 	  test al,al	// ���ֽ���0 ֵ�ֽ����ַ�����β����

	test	al, al

; 205  : 	  jne l1		// ���ǣ��������ת�����1�������Ƚϡ�

	jne	SHORT $l1$632

; 206  : 	  xor eax,eax	// �ǣ��򷵻�ֵeax ���㣬

	xor	eax, eax

; 207  : 	  jmp l3		// ��ǰ��ת�����3��������

	jmp	SHORT $l3$634
$l2$633:

; 208  :   l2: mov eax,1	// eax ����1��

	mov	eax, 1

; 209  : 	  jl l3		// ��ǰ��Ƚ��д�2 �ַ�<��1 �ַ����򷵻���ֵ��������

	jl	SHORT $l3$634

; 210  : 	  neg eax	// ����eax = -eax�����ظ�ֵ��������

	neg	eax
$l3$634:

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
PUBLIC	_open_namei
EXTRN	_truncate:NEAR
EXTRN	_new_inode:NEAR
_DATA	SEGMENT
	ORG $+3
$SG1022	DB	04H, 02H, 06H, 0ffH, 00H
_DATA	ENDS
_TEXT	SEGMENT
_pathname$ = 8
_flag$ = 12
_mode$ = 16
_res_inode$ = 20
_basename$ = -4
_namelen$ = 8
_dir$ = 12
_de$ = 16
_open_namei PROC NEAR

; 450  : {

	push	ebp
	mov	ebp, esp
	push	ecx
	push	ebx

; 451  : 	const char * basename;
; 452  : 	int inr,dev,namelen;
; 453  : 	struct m_inode * dir, *inode;
; 454  : 	struct buffer_head * bh;
; 455  : 	struct dir_entry * de;
; 456  : 
; 457  : // ����ļ��������ģʽ��־��ֻ��(0)�����ļ���0 ��־O_TRUNC ȴ��λ�ˣ����Ϊֻд��־��
; 458  : 	if ((flag & O_TRUNC) && !(flag & O_ACCMODE))

	mov	ebx, DWORD PTR _flag$[ebp]
	push	esi
	push	edi
	test	bh, 2
	je	SHORT $L1008
	test	bl, 3
	jne	SHORT $L1008

; 459  : 		flag |= O_WRONLY;

	or	ebx, 1
$L1008:

; 460  : // ʹ�ý��̵��ļ�������������룬���ε�����ģʽ�е���Ӧλ����������ͨ�ļ���־��
; 461  : 	mode &= 0777 & ~current->umask;
; 462  : 	mode |= I_REGULAR;

	mov	eax, DWORD PTR _current
	mov	ecx, DWORD PTR _mode$[ebp]

; 463  : // ����·����Ѱ�ҵ���Ӧ��i �ڵ㣬�Լ�����ļ������䳤�ȡ�
; 464  : 	if (!(dir = dir_namei(pathname,&namelen,&basename)))

	lea	edx, DWORD PTR _namelen$[ebp]
	mov	di, WORD PTR [eax+620]
	mov	eax, DWORD PTR _pathname$[ebp]
	not	edi
	and	edi, ecx
	lea	ecx, DWORD PTR _basename$[ebp]
	push	ecx
	and	edi, 511				; 000001ffH
	push	edx
	push	eax
	or	edi, 32768				; 00008000H
	call	_dir_namei
	add	esp, 12					; 0000000cH
	mov	DWORD PTR _dir$[ebp], eax
	test	eax, eax
	jne	SHORT $L1009
	pop	edi
	pop	esi

; 465  : 		return -ENOENT;

	mov	eax, -2					; fffffffeH
	pop	ebx

; 547  : }

	mov	esp, ebp
	pop	ebp
	ret	0
$L1009:

; 466  : // �������ļ�������Ϊ0(����'/usr/'����·���������)����ô���򿪲������Ǵ�������0��
; 467  : // ���ʾ��һ��Ŀ¼����ֱ�ӷ��ظ�Ŀ¼��i �ڵ㣬���˳���
; 468  : 	if (!namelen) {			/* special case: '/usr/' etc */

	mov	ecx, DWORD PTR _namelen$[ebp]
	test	ecx, ecx
	jne	SHORT $L1010

; 469  : 		if (!(flag & (O_ACCMODE|O_CREAT|O_TRUNC))) {

	test	ebx, 579				; 00000243H
	jne	SHORT $L1011

; 470  : 			*res_inode=dir;

	mov	ecx, DWORD PTR _res_inode$[ebp]
	pop	edi
	pop	esi
	pop	ebx
	mov	DWORD PTR [ecx], eax

; 546  : 	return 0;

	xor	eax, eax

; 547  : }

	mov	esp, ebp
	pop	ebp
	ret	0
$L1011:

; 471  : 			return 0;
; 472  : 		}
; 473  : // �����ͷŸ�i �ڵ㣬���س����롣
; 474  : 		iput(dir);

	push	eax
	call	_iput
	add	esp, 4

; 475  : 		return -EISDIR;

	mov	eax, -21				; ffffffebH
	pop	edi
	pop	esi
	pop	ebx

; 547  : }

	mov	esp, ebp
	pop	ebp
	ret	0
$L1010:

; 476  : 	}
; 477  : // ��dir �ڵ��Ӧ��Ŀ¼��ȡ�ļ�����Ӧ��Ŀ¼��ṹde �͸�Ŀ¼�����ڵĸ��ٻ�������
; 478  : 	bh = find_entry(&dir,basename,namelen,&de);

	mov	eax, DWORD PTR _basename$[ebp]
	lea	edx, DWORD PTR _de$[ebp]
	push	edx
	push	ecx
	lea	ecx, DWORD PTR _dir$[ebp]
	push	eax
	push	ecx
	call	_find_entry
	add	esp, 16					; 00000010H

; 479  : // ����ø��ٻ���ָ��ΪNULL�����ʾû���ҵ���Ӧ�ļ�����Ŀ¼����ֻ�����Ǵ����ļ�������
; 480  : 	if (!bh) {

	test	eax, eax
	jne	$L1012

; 481  : // ������Ǵ����ļ������ͷŸ�Ŀ¼��i �ڵ㣬���س�����˳���
; 482  : 		if (!(flag & O_CREAT)) {

	test	bl, 64					; 00000040H
	jne	SHORT $L1013

; 483  : 			iput(dir);

	mov	edx, DWORD PTR _dir$[ebp]
	push	edx
	call	_iput
	add	esp, 4

; 484  : 			return -ENOENT;

	mov	eax, -2					; fffffffeH
	pop	edi
	pop	esi
	pop	ebx

; 547  : }

	mov	esp, ebp
	pop	ebp
	ret	0
$L1013:

; 485  : 		}
; 486  : // ����û��ڸ�Ŀ¼û��д��Ȩ�������ͷŸ�Ŀ¼��i �ڵ㣬���س�����˳���
; 487  : 		if (!permission(dir,MAY_WRITE)) {

	mov	eax, DWORD PTR _dir$[ebp]
	push	2
	push	eax
	call	_permission
	add	esp, 8
	test	eax, eax
	jne	SHORT $L1014

; 488  : 			iput(dir);

	mov	ecx, DWORD PTR _dir$[ebp]
	push	ecx
	call	_iput
	add	esp, 4

; 489  : 			return -EACCES;

	mov	eax, -13				; fffffff3H
	pop	edi
	pop	esi
	pop	ebx

; 547  : }

	mov	esp, ebp
	pop	ebp
	ret	0
$L1014:

; 490  : 		}
; 491  : // ��Ŀ¼�ڵ��Ӧ���豸������һ����i �ڵ㣬��ʧ�ܣ����ͷ�Ŀ¼��i �ڵ㣬������û�пռ�����롣
; 492  : 		inode = new_inode(dir->i_dev);

	mov	eax, DWORD PTR _dir$[ebp]
	xor	edx, edx
	mov	dx, WORD PTR [eax+44]
	push	edx
	call	_new_inode
	mov	esi, eax
	add	esp, 4

; 493  : 		if (!inode) {

	test	esi, esi
	jne	SHORT $L1015

; 494  : 			iput(dir);

	mov	ecx, DWORD PTR _dir$[ebp]
	push	ecx
	call	_iput
	add	esp, 4

; 495  : 			return -ENOSPC;

	mov	eax, -28				; ffffffe4H
	pop	edi
	pop	esi
	pop	ebx

; 547  : }

	mov	esp, ebp
	pop	ebp
	ret	0
$L1015:

; 496  : 		}
; 497  : // ����ʹ�ø���i �ڵ㣬������г�ʼ���ã��ýڵ���û�id����Ӧ�ڵ����ģʽ�������޸ı�־��
; 498  : 		inode->i_uid = current->euid;

	mov	edx, DWORD PTR _current

; 499  : 		inode->i_mode = mode;

	mov	WORD PTR [esi], di

; 500  : 		inode->i_dirt = 1;

	mov	BYTE PTR [esi+51], 1

; 501  : // Ȼ����ָ��Ŀ¼dir �����һ��Ŀ¼�
; 502  : 		bh = add_entry(dir,basename,namelen,&de);

	lea	ecx, DWORD PTR _de$[ebp]
	mov	ax, WORD PTR [edx+578]
	push	ecx
	mov	WORD PTR [esi+2], ax
	mov	edx, DWORD PTR _namelen$[ebp]
	mov	eax, DWORD PTR _basename$[ebp]
	mov	ecx, DWORD PTR _dir$[ebp]
	push	edx
	push	eax
	push	ecx
	call	_add_entry
	add	esp, 16					; 00000010H

; 503  : // ������ص�Ӧ�ú�����Ŀ¼��ĸ��ٻ�����ָ��ΪNULL�����ʾ���Ŀ¼�����ʧ�ܡ����ǽ���
; 504  : // ��i �ڵ���������Ӽ�����1�����ͷŸ�i �ڵ���Ŀ¼��i �ڵ㣬���س����룬�˳���
; 505  : 		if (!bh) {

	test	eax, eax
	jne	SHORT $L1016

; 506  : 			inode->i_nlinks--;

	mov	bl, BYTE PTR [esi+13]

; 507  : 			iput(inode);

	push	esi
	dec	bl
	mov	BYTE PTR [esi+13], bl
	call	_iput

; 508  : 			iput(dir);

	mov	edx, DWORD PTR _dir$[ebp]
	push	edx
	call	_iput
	add	esp, 8

; 509  : 			return -ENOSPC;

	mov	eax, -28				; ffffffe4H
	pop	edi
	pop	esi
	pop	ebx

; 547  : }

	mov	esp, ebp
	pop	ebp
	ret	0
$L1016:

; 510  : 		}
; 511  : // ��ʼ���ø���Ŀ¼���i �ڵ��Ϊ�����뵽��i �ڵ�ĺ��룻���ø��ٻ��������޸ı�־��Ȼ��
; 512  : // �ͷŸø��ٻ��������ͷ�Ŀ¼��i �ڵ㡣������Ŀ¼���i �ڵ�ָ�룬�˳���
; 513  : 		de->inode = inode->i_num;

	mov	edx, DWORD PTR _de$[ebp]
	mov	cx, WORD PTR [esi+46]

; 514  : 		bh->b_dirt = 1;
; 515  : 		brelse(bh);

	push	eax
	mov	BYTE PTR [eax+11], 1
	mov	WORD PTR [edx], cx
	call	_brelse

; 516  : 		iput(dir);

	mov	eax, DWORD PTR _dir$[ebp]
	push	eax
	call	_iput

; 544  : // ��󷵻ظ�Ŀ¼��i �ڵ��ָ�룬������0���ɹ�����
; 545  : 	*res_inode = inode;

	mov	ecx, DWORD PTR _res_inode$[ebp]
	add	esp, 8

; 546  : 	return 0;

	xor	eax, eax
	mov	DWORD PTR [ecx], esi
	pop	edi
	pop	esi
	pop	ebx

; 547  : }

	mov	esp, ebp
	pop	ebp
	ret	0
$L1012:

; 517  : 		*res_inode = inode;
; 518  : 		return 0;
; 519  : 	}
; 520  : // ��������Ŀ¼��ȡ�ļ�����Ӧ��Ŀ¼��ṹ�����ɹ�(Ҳ��bh ��ΪNULL)��ȡ����Ŀ¼���i �ڵ��
; 521  : // �������ڵ��豸�ţ����ͷŸø��ٻ������Լ�Ŀ¼��i �ڵ㡣
; 522  : 	inr = de->inode;

	mov	edx, DWORD PTR _de$[ebp]

; 523  : 	dev = dir->i_dev;

	mov	ecx, DWORD PTR _dir$[ebp]
	xor	esi, esi
	xor	edi, edi
	mov	si, WORD PTR [edx]
	mov	di, WORD PTR [ecx+44]

; 524  : 	brelse(bh);

	push	eax
	call	_brelse

; 525  : 	iput(dir);

	mov	edx, DWORD PTR _dir$[ebp]
	push	edx
	call	_iput
	add	esp, 8

; 526  : // �����ռʹ�ñ�־O_EXCL ��λ���򷵻��ļ��Ѵ��ڳ����룬�˳���
; 527  : 	if (flag & O_EXCL)

	test	bl, -128				; ffffff80H
	je	SHORT $L1017
	pop	edi
	pop	esi

; 528  : 		return -EEXIST;

	mov	eax, -17				; ffffffefH
	pop	ebx

; 547  : }

	mov	esp, ebp
	pop	ebp
	ret	0
$L1017:

; 529  : // ���ȡ��Ŀ¼���Ӧi �ڵ�Ĳ���ʧ�ܣ��򷵻ط��ʳ����룬�˳���
; 530  : 	if (!(inode=iget(dev,inr)))

	push	esi
	push	edi
	call	_iget
	mov	esi, eax
	add	esp, 8
	test	esi, esi
	jne	SHORT $L1018
	pop	edi
	pop	esi

; 531  : 		return -EACCES;

	mov	eax, -13				; fffffff3H
	pop	ebx

; 547  : }

	mov	esp, ebp
	pop	ebp
	ret	0
$L1018:

; 532  : // ����i �ڵ���һ��Ŀ¼�Ľڵ㲢�ҷ���ģʽ��ֻ����ֻд������û�з��ʵ����Ȩ�ޣ����ͷŸ�i
; 533  : // �ڵ㣬���ط���Ȩ�޳����룬�˳���
; 534  : 	if ((S_ISDIR(inode->i_mode) && (flag & O_ACCMODE)) ||
; 535  : 	    !permission(inode,ACC_MODE(flag))) {

	mov	ax, WORD PTR [esi]
	and	eax, 61440				; 0000f000H
	cmp	eax, 16384				; 00004000H
	jne	SHORT $L1021
	test	bl, 3
	jne	SHORT $L1020
$L1021:
	mov	ecx, ebx
	and	ecx, 3
	movsx	edx, BYTE PTR $SG1022[ecx]
	push	edx
	push	esi
	call	_permission
	add	esp, 8
	test	eax, eax
	jne	SHORT $L1019
$L1020:

; 536  : 		iput(inode);

	push	esi
	call	_iput
	add	esp, 4

; 537  : 		return -EPERM;

	or	eax, -1
	pop	edi
	pop	esi
	pop	ebx

; 547  : }

	mov	esp, ebp
	pop	ebp
	ret	0
$L1019:

; 538  : 	}
; 539  : // ���¸�i �ڵ�ķ���ʱ���ֶ�Ϊ��ǰʱ�䡣
; 540  : 	inode->i_atime = CURRENT_TIME;

	mov	ecx, DWORD PTR _jiffies
	mov	eax, 1374389535				; 51eb851fH
	imul	ecx
	mov	ecx, DWORD PTR _startup_time
	sar	edx, 5
	mov	eax, edx
	shr	eax, 31					; 0000001fH
	add	edx, eax
	add	edx, ecx

; 541  : // ��������˽�0 ��־���򽫸�i �ڵ���ļ����Ƚ�Ϊ0��
; 542  : 	if (flag & O_TRUNC)

	test	bh, 2
	mov	DWORD PTR [esi+36], edx
	je	SHORT $L1023

; 543  : 		truncate(inode);

	push	esi
	call	_truncate
	add	esp, 4
$L1023:

; 544  : // ��󷵻ظ�Ŀ¼��i �ڵ��ָ�룬������0���ɹ�����
; 545  : 	*res_inode = inode;

	mov	ecx, DWORD PTR _res_inode$[ebp]
	pop	edi

; 546  : 	return 0;

	xor	eax, eax
	mov	DWORD PTR [ecx], esi
	pop	esi
	pop	ebx

; 547  : }

	mov	esp, ebp
	pop	ebp
	ret	0
_open_namei ENDP
_TEXT	ENDS
EXTRN	_create_block:NEAR
_TEXT	SEGMENT
$T1269 = 8
$T1270 = 12
_dir$ = 8
_name$ = 12
_namelen$ = 16
_res_dir$ = 20
_i$ = 8
_bh$ = -8
_add_entry PROC NEAR

; 222  : {

	push	ebp
	mov	ebp, esp
	sub	esp, 8

; 227  : 	*res_dir = NULL;

	mov	eax, DWORD PTR _res_dir$[ebp]
	push	ebx
	xor	ebx, ebx
	push	esi
	mov	DWORD PTR [eax], ebx

; 228  : // ���������NO_TRUNCATE�������ļ������ȳ�����󳤶�NAME_LEN���򷵻ء�
; 229  : #ifdef NO_TRUNCATE
; 230  : 	if (namelen > NAME_LEN)
; 231  : 		return NULL;
; 232  : //���û�ж���NO_TRUNCATE�������ļ������ȳ�����󳤶�NAME_LEN����ض�֮��
; 233  : #else
; 234  : 	if (namelen > NAME_LEN)

	mov	eax, DWORD PTR _namelen$[ebp]
	cmp	eax, 14					; 0000000eH
	push	edi
	jle	SHORT $L906

; 235  : 		namelen = NAME_LEN;

	mov	DWORD PTR _namelen$[ebp], 14		; 0000000eH
$L907:

; 240  : // �����Ŀ¼i �ڵ���ָ��ĵ�һ��ֱ�Ӵ��̿��Ϊ0���򷵻�NULL �˳���
; 241  : 	if (!(block = dir->i_zone[0]))

	mov	esi, DWORD PTR _dir$[ebp]
	xor	eax, eax
	mov	ax, WORD PTR [esi+14]
	cmp	eax, ebx
	jne	SHORT $L908
	pop	edi
	pop	esi

; 242  : 		return NULL;

	xor	eax, eax
	pop	ebx

; 291  : 	}
; 292  : // ִ�в������Ҳ��Linus ��д��δ���ʱ���ȸ���������find_entry()�Ĵ��룬�����޸ĵ�:)
; 293  : 	brelse(bh);
; 294  : 	return NULL;
; 295  : }

	mov	esp, ebp
	pop	ebp
	ret	0
$L906:

; 236  : #endif
; 237  : // ����ļ������ȵ���0���򷵻�NULL���˳���
; 238  : 	if (!namelen)

	cmp	eax, ebx
	jne	SHORT $L907
	pop	edi
	pop	esi

; 239  : 		return NULL;

	xor	eax, eax
	pop	ebx

; 291  : 	}
; 292  : // ִ�в������Ҳ��Linus ��д��δ���ʱ���ȸ���������find_entry()�Ĵ��룬�����޸ĵ�:)
; 293  : 	brelse(bh);
; 294  : 	return NULL;
; 295  : }

	mov	esp, ebp
	pop	ebp
	ret	0
$L908:

; 243  : // �����ȡ�ô��̿�ʧ�ܣ��򷵻�NULL ���˳���
; 244  : 	if (!(bh = bread(dir->i_dev,block)))

	xor	ecx, ecx
	push	eax
	mov	cx, WORD PTR [esi+44]
	push	ecx
	call	_bread
	add	esp, 8
	cmp	eax, ebx
	mov	DWORD PTR _bh$[ebp], eax
	jne	SHORT $L909
$L1273:
	pop	edi
	pop	esi

; 245  : 		return NULL;

	xor	eax, eax
	pop	ebx

; 291  : 	}
; 292  : // ִ�в������Ҳ��Linus ��д��δ���ʱ���ȸ���������find_entry()�Ĵ��룬�����޸ĵ�:)
; 293  : 	brelse(bh);
; 294  : 	return NULL;
; 295  : }

	mov	esp, ebp
	pop	ebp
	ret	0
$L909:

; 246  : // ��Ŀ¼�����ݿ���ѭ���������δʹ�õ�Ŀ¼�������Ŀ¼��ṹָ��de ָ����ٻ�������ݿ�
; 247  : // ��ʼ����Ҳ����һ��Ŀ¼�
; 248  : 	i = 0;
; 249  : 	de = (struct dir_entry *) bh->b_data;

	mov	edi, DWORD PTR [eax]
	mov	DWORD PTR _i$[ebp], ebx
	mov	DWORD PTR -4+[ebp], ebx
	mov	ebx, 16					; 00000010H
$L912:

; 250  : 	while (1) {
; 251  : // �����ǰ�б��Ŀ¼���Ѿ�������ǰ���ݿ飬���ͷŸ����ݿ飬��������һ����̿�block�����
; 252  : // ����ʧ�ܣ��򷵻�NULL���˳���
; 253  : 		if ((char *)de >= BLOCK_SIZE+bh->b_data) {

	mov	eax, DWORD PTR _bh$[ebp]
	mov	edx, DWORD PTR [eax]
	add	edx, 1024				; 00000400H
	cmp	edi, edx
	jb	SHORT $L915

; 254  : 			brelse(bh);

	push	eax
	call	_brelse

; 255  : 			bh = NULL;
; 256  : 			block = create_block(dir,i/DIR_ENTRIES_PER_BLOCK);

	mov	eax, DWORD PTR _i$[ebp]
	shr	eax, 6
	push	eax
	push	esi
	call	_create_block
	add	esp, 12					; 0000000cH

; 257  : 			if (!block)

	test	eax, eax
	je	SHORT $L1273

; 258  : 				return NULL;
; 259  : // �����ȡ���̿鷵�ص�ָ��Ϊ�գ��������ÿ������
; 260  : 			if (!(bh = bread(dir->i_dev,block))) {

	xor	ecx, ecx
	push	eax
	mov	cx, WORD PTR [esi+44]
	push	ecx
	call	_bread
	add	esp, 8
	mov	DWORD PTR _bh$[ebp], eax
	test	eax, eax
	jne	SHORT $L918

; 261  : 				i += DIR_ENTRIES_PER_BLOCK;

	mov	edx, DWORD PTR _i$[ebp]
	mov	ecx, DWORD PTR -4+[ebp]
	add	edx, 64					; 00000040H
	add	ecx, 1024				; 00000400H
	mov	DWORD PTR _i$[ebp], edx
	mov	DWORD PTR -4+[ebp], ecx
	add	ebx, 1024				; 00000400H

; 262  : 				continue;

	jmp	SHORT $L912
$L918:

; 263  : 			}
; 264  : // ������Ŀ¼��ṹָ��de ־��ÿ�ĸ��ٻ������ݿ鿪ʼ����
; 265  : 			de = (struct dir_entry *) bh->b_data;

	mov	edi, DWORD PTR [eax]
$L915:

; 266  : 		}
; 267  : // �����ǰ��������Ŀ¼�����i*Ŀ¼�ṹ��С�Ѿ������˸�Ŀ¼��ָ���Ĵ�Сi_size����˵���õ�i
; 268  : // ��Ŀ¼�δʹ�ã����ǿ���ʹ���������ǶԸ�Ŀ¼���������(�ø�Ŀ¼���i �ڵ�ָ��Ϊ��)����
; 269  : // ���¸�Ŀ¼�ĳ���ֵ(����һ��Ŀ¼��ĳ��ȣ�����Ŀ¼��i �ڵ����޸ı�־���ٸ��¸�Ŀ¼�ĸı�ʱ
; 270  : // ��Ϊ��ǰʱ�䡣
; 271  : 		if (i*sizeof(struct dir_entry) >= dir->i_size) {

	mov	edx, DWORD PTR -4+[ebp]
	mov	eax, DWORD PTR [esi+4]
	cmp	edx, eax
	jb	SHORT $L922

; 272  : 			de->inode=0;

	mov	WORD PTR [edi], 0

; 273  : 			dir->i_size = (i+1)*sizeof(struct dir_entry);

	mov	DWORD PTR [esi+4], ebx

; 274  : 			dir->i_dirt = 1;

	mov	BYTE PTR [esi+51], 1

; 275  : 			dir->i_ctime = CURRENT_TIME;

	mov	ecx, DWORD PTR _jiffies
	mov	eax, 1374389535				; 51eb851fH
	imul	ecx
	sar	edx, 5
	mov	eax, edx
	shr	eax, 31					; 0000001fH
	add	edx, eax
	mov	eax, DWORD PTR _startup_time
	add	edx, eax
	mov	DWORD PTR [esi+40], edx
$L922:

; 276  : 		}
; 277  : // ����Ŀ¼���i �ڵ�Ϊ�գ����ʾ�ҵ�һ����δʹ�õ�Ŀ¼����Ǹ���Ŀ¼���޸�ʱ��Ϊ��ǰʱ�䡣
; 278  : // �����û������������ļ�������Ŀ¼����ļ����ֶΣ�����Ӧ�ĸ��ٻ�������޸ı�־�����ظ�Ŀ¼
; 279  : // ���ָ���Լ��ø��ٻ�������ָ�룬�˳���
; 280  : 		if (!de->inode) {

	cmp	WORD PTR [edi], 0
	je	SHORT $L1274

; 286  : 			return bh;
; 287  : 		}
; 288  : // �����Ŀ¼���Ѿ���ʹ�ã�����������һ��Ŀ¼�
; 289  : 		de++;
; 290  : 		i++;

	mov	edx, DWORD PTR _i$[ebp]
	mov	ecx, DWORD PTR -4+[ebp]
	add	edi, 16					; 00000010H
	inc	edx
	add	ecx, 16					; 00000010H
	mov	DWORD PTR _i$[ebp], edx
	mov	DWORD PTR -4+[ebp], ecx
	add	ebx, 16					; 00000010H
	jmp	$L912
$L1274:

; 281  : 			dir->i_mtime = CURRENT_TIME;

	mov	ecx, DWORD PTR _jiffies
	mov	eax, 1374389535				; 51eb851fH
	imul	ecx
	mov	eax, DWORD PTR _startup_time
	sar	edx, 5
	mov	ecx, edx
	shr	ecx, 31					; 0000001fH
	add	edx, ecx
	add	edx, eax

; 282  : 			for (i=0; i < NAME_LEN ; i++)

	xor	ecx, ecx
	mov	DWORD PTR [esi+8], edx
	mov	edx, DWORD PTR _name$[ebp]
$L925:

; 283  : 				de->name[i]=(i<namelen)?get_fs_byte(name+i):0;

	cmp	ecx, DWORD PTR _namelen$[ebp]
	jge	SHORT $L1264
	lea	eax, DWORD PTR [ecx+edx]
	mov	DWORD PTR $T1269[ebp], eax

; 223  : 	int block,i;
; 224  : 	struct buffer_head * bh;
; 225  : 	struct dir_entry * de;
; 226  : 

	mov	ebx, DWORD PTR $T1269[ebp]

; 227  : 	*res_dir = NULL;

	mov	al, BYTE PTR fs:[ebx]

; 283  : 				de->name[i]=(i<namelen)?get_fs_byte(name+i):0;

	mov	BYTE PTR $T1270[ebp], al
	mov	eax, DWORD PTR $T1270[ebp]
	and	eax, 255				; 000000ffH
	jmp	SHORT $L1265
$L1264:
	xor	eax, eax
$L1265:
	mov	BYTE PTR [edi+ecx+2], al
	inc	ecx
	cmp	ecx, 14					; 0000000eH
	jl	SHORT $L925

; 284  : 			bh->b_dirt = 1;
; 285  : 			*res_dir = de;

	mov	ecx, DWORD PTR _res_dir$[ebp]
	mov	eax, DWORD PTR _bh$[ebp]
	mov	DWORD PTR [ecx], edi
	pop	edi
	pop	esi
	mov	BYTE PTR [eax+11], 1
	pop	ebx

; 291  : 	}
; 292  : // ִ�в������Ҳ��Linus ��д��δ���ʱ���ȸ���������find_entry()�Ĵ��룬�����޸ĵ�:)
; 293  : 	brelse(bh);
; 294  : 	return NULL;
; 295  : }

	mov	esp, ebp
	pop	ebp
	ret	0
_add_entry ENDP
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
$l1$670:

; 396  :   l1: lodsb	// ȡ��1 �ַ�ds:[esi]->al������esi++��

	lodsb

; 397  : 	  test al,al	// ���ַ�����0 ֵ�𣨴�1 ��β����

	test	al, al

; 398  : 	  je l2		// ����ǣ�����ǰ��ת�����2 ����

	je	SHORT $l2$671

; 399  : 	  mov edi,ebx	// ȡ��2 ͷָ�����edi �С�

	mov	edi, ebx

; 400  : 	  mov ecx,edx	// �ٽ���2 �ĳ���ֵ����ecx �С�

	mov	ecx, edx

; 401  : 	  repne scasb	// �Ƚ�al �봮2 ���ַ�es:[edi]������edi++���������Ⱦͼ����Ƚϡ�

	repnz	 scasb

; 402  : 	  je l1		// �����ȣ��������ת�����1 ����

	je	SHORT $l1$670
$l2$671:

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
$l1$679:

; 454  : 	l1: lodsb	// ȡ��1 �ַ�ds:[esi]->al������esi++��

	lodsb

; 455  : 		test al,al	// ���ַ�����0 ֵ�𣨴�1 ��β����

	test	al, al

; 456  : 		je l2		// ����ǣ�����ǰ��ת�����2 ����

	je	SHORT $l2$680

; 457  : 		mov edi,ebx	// ȡ��2 ͷָ�����edi �С�

	mov	edi, ebx

; 458  : 		mov ecx,edx 	// �ٽ���2 �ĳ���ֵ����ecx �С�

	mov	ecx, edx

; 459  : 		repne scasb	// �Ƚ�al �봮2 ���ַ�es:[edi]������edi++���������Ⱦͼ����Ƚϡ�

	repnz	 scasb

; 460  : 		jne l1		// �������ȣ��������ת�����1 ����

	jne	SHORT $l1$679
$l2$680:

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
PUBLIC	_sys_mknod
_TEXT	SEGMENT
_filename$ = 8
_mode$ = 12
_dev$ = 16
_basename$ = -8
_namelen$ = -4
_dir$ = 8
_de$ = -12
_sys_mknod PROC NEAR

; 554  : {

	push	ebp
	mov	ebp, esp
	sub	esp, 12					; 0000000cH

; 555  : 	const char * basename;
; 556  : 	int namelen;
; 557  : 	struct m_inode * dir, * inode;
; 558  : 	struct buffer_head * bh;
; 559  : 	struct dir_entry * de;
; 560  : 	
; 561  : // ������ǳ����û����򷵻ط�����ɳ����롣
; 562  : 	if (!suser())

	mov	eax, DWORD PTR _current
	push	esi
	push	edi
	cmp	WORD PTR [eax+578], 0
	je	SHORT $L1038
	pop	edi

; 563  : 		return -EPERM;

	or	eax, -1
	pop	esi

; 617  : }

	mov	esp, ebp
	pop	ebp
	ret	0
$L1038:

; 564  : // ����Ҳ�����Ӧ·����Ŀ¼��i �ڵ㣬�򷵻س����롣
; 565  : 	if (!(dir = dir_namei(filename,&namelen,&basename)))

	mov	eax, DWORD PTR _filename$[ebp]
	lea	ecx, DWORD PTR _basename$[ebp]
	lea	edx, DWORD PTR _namelen$[ebp]
	push	ecx
	push	edx
	push	eax
	call	_dir_namei
	add	esp, 12					; 0000000cH
	mov	DWORD PTR _dir$[ebp], eax
	test	eax, eax
	jne	SHORT $L1039
	pop	edi

; 566  : 		return -ENOENT;

	mov	eax, -2					; fffffffeH
	pop	esi

; 617  : }

	mov	esp, ebp
	pop	ebp
	ret	0
$L1039:

; 567  : // �����˵��ļ�������Ϊ0����˵��������·�������û��ָ���ļ������ͷŸ�Ŀ¼i �ڵ㣬����
; 568  : // �����룬�˳���
; 569  : 	if (!namelen) {

	mov	ecx, DWORD PTR _namelen$[ebp]
	test	ecx, ecx
	jne	SHORT $L1040

; 570  : 		iput(dir);

	push	eax
	call	_iput
	add	esp, 4

; 571  : 		return -ENOENT;

	mov	eax, -2					; fffffffeH
	pop	edi
	pop	esi

; 617  : }

	mov	esp, ebp
	pop	ebp
	ret	0
$L1040:

; 572  : 	}
; 573  : // ����ڸ�Ŀ¼��û��д��Ȩ�ޣ����ͷŸ�Ŀ¼��i �ڵ㣬���ط�����ɳ����룬�˳���
; 574  : 	if (!permission(dir,MAY_WRITE)) {

	push	2
	push	eax
	call	_permission
	add	esp, 8
	test	eax, eax
	jne	SHORT $L1041

; 575  : 		iput(dir);

	mov	ecx, DWORD PTR _dir$[ebp]
	push	ecx
	call	_iput
	add	esp, 4

; 576  : 		return -EPERM;

	or	eax, -1
	pop	edi
	pop	esi

; 617  : }

	mov	esp, ebp
	pop	ebp
	ret	0
$L1041:

; 577  : 	}
; 578  : // �����Ӧ·�����������ļ�����Ŀ¼���Ѿ����ڣ����ͷŰ�����Ŀ¼��ĸ��ٻ��������ͷ�Ŀ¼
; 579  : // ��i �ڵ㣬�����ļ��Ѿ����ڳ����룬�˳���
; 580  : 	bh = find_entry(&dir,basename,namelen,&de);

	mov	eax, DWORD PTR _namelen$[ebp]
	mov	ecx, DWORD PTR _basename$[ebp]
	lea	edx, DWORD PTR _de$[ebp]
	push	edx
	push	eax
	lea	edx, DWORD PTR _dir$[ebp]
	push	ecx
	push	edx
	call	_find_entry
	add	esp, 16					; 00000010H

; 581  : 	if (bh) {

	test	eax, eax
	je	SHORT $L1042

; 582  : 		brelse(bh);

	push	eax
	call	_brelse

; 583  : 		iput(dir);

	mov	eax, DWORD PTR _dir$[ebp]
	push	eax
	call	_iput
	add	esp, 8

; 584  : 		return -EEXIST;

	mov	eax, -17				; ffffffefH
	pop	edi
	pop	esi

; 617  : }

	mov	esp, ebp
	pop	ebp
	ret	0
$L1042:

; 585  : 	}
; 586  : // ����һ���µ�i �ڵ㣬������ɹ������ͷ�Ŀ¼��i �ڵ㣬�����޿ռ�����룬�˳���
; 587  : 	inode = new_inode(dir->i_dev);

	mov	edx, DWORD PTR _dir$[ebp]
	xor	ecx, ecx
	mov	cx, WORD PTR [edx+44]
	push	ecx
	call	_new_inode
	mov	esi, eax
	add	esp, 4

; 588  : 	if (!inode) {

	test	esi, esi
	jne	SHORT $L1043

; 589  : 		iput(dir);

	mov	eax, DWORD PTR _dir$[ebp]
	push	eax
	call	_iput
	add	esp, 4

; 590  : 		return -ENOSPC;

	mov	eax, -28				; ffffffe4H
	pop	edi
	pop	esi

; 617  : }

	mov	esp, ebp
	pop	ebp
	ret	0
$L1043:

; 591  : 	}
; 592  : // ���ø�i �ڵ������ģʽ�����Ҫ�������ǿ��豸�ļ��������ַ��豸�ļ�������i �ڵ��ֱ�ӿ�
; 593  : // ָ��0 �����豸�š�
; 594  : 	inode->i_mode = mode;

	mov	eax, DWORD PTR _mode$[ebp]
	mov	WORD PTR [esi], ax

; 595  : 	if (S_ISBLK(mode) || S_ISCHR(mode))

	and	eax, 61440				; 0000f000H
	cmp	eax, 24576				; 00006000H
	je	SHORT $L1045
	cmp	eax, 8192				; 00002000H
	jne	SHORT $L1044
$L1045:

; 596  : 		inode->i_zone[0] = dev;

	mov	cx, WORD PTR _dev$[ebp]
	mov	WORD PTR [esi+14], cx
$L1044:

; 597  : // ���ø�i �ڵ���޸�ʱ�䡢����ʱ��Ϊ��ǰʱ�䡣
; 598  : 	inode->i_mtime = inode->i_atime = CURRENT_TIME;

	mov	ecx, DWORD PTR _jiffies
	mov	eax, 1374389535				; 51eb851fH
	imul	ecx
	mov	ecx, DWORD PTR _startup_time

; 599  : 	inode->i_dirt = 1;

	mov	BYTE PTR [esi+51], 1
	sar	edx, 5
	mov	eax, edx
	shr	eax, 31					; 0000001fH
	add	edx, eax
	lea	eax, DWORD PTR [edx+ecx]

; 600  : // ��Ŀ¼�������һ��Ŀ¼����ʧ��(������Ŀ¼��ĸ��ٻ�����ָ��ΪNULL)�����ͷ�Ŀ¼��
; 601  : // i �ڵ㣻�������i �ڵ��������Ӽ�����λ�����ͷŸ�i �ڵ㡣���س����룬�˳���
; 602  : 	bh = add_entry(dir,basename,namelen,&de);

	lea	edx, DWORD PTR _de$[ebp]
	mov	DWORD PTR [esi+36], eax
	mov	DWORD PTR [esi+8], eax
	mov	eax, DWORD PTR _namelen$[ebp]
	mov	ecx, DWORD PTR _basename$[ebp]
	push	edx
	mov	edx, DWORD PTR _dir$[ebp]
	push	eax
	push	ecx
	push	edx
	call	_add_entry
	mov	edi, eax
	add	esp, 16					; 00000010H

; 603  : 	if (!bh) {

	test	edi, edi
	jne	SHORT $L1046

; 604  : 		iput(dir);

	mov	eax, DWORD PTR _dir$[ebp]
	push	eax
	call	_iput

; 605  : 		inode->i_nlinks=0;
; 606  : 		iput(inode);

	push	esi
	mov	BYTE PTR [esi+13], 0
	call	_iput
	add	esp, 8

; 607  : 		return -ENOSPC;

	mov	eax, -28				; ffffffe4H
	pop	edi
	pop	esi

; 617  : }

	mov	esp, ebp
	pop	ebp
	ret	0
$L1046:

; 608  : 	}
; 609  : // ���Ŀ¼���i �ڵ��ֶε�����i �ڵ�ţ��ø��ٻ��������޸ı�־���ͷ�Ŀ¼���µ�i �ڵ㣬
; 610  : // �ͷŸ��ٻ���������󷵻�0(�ɹ�)��
; 611  : 	de->inode = inode->i_num;

	mov	edx, DWORD PTR _de$[ebp]
	mov	cx, WORD PTR [esi+46]

; 612  : 	bh->b_dirt = 1;

	mov	BYTE PTR [edi+11], 1
	mov	WORD PTR [edx], cx

; 613  : 	iput(dir);

	mov	eax, DWORD PTR _dir$[ebp]
	push	eax
	call	_iput

; 614  : 	iput(inode);

	push	esi
	call	_iput

; 615  : 	brelse(bh);

	push	edi
	call	_brelse
	add	esp, 12					; 0000000cH

; 616  : 	return 0;

	xor	eax, eax
	pop	edi
	pop	esi

; 617  : }

	mov	esp, ebp
	pop	ebp
	ret	0
_sys_mknod ENDP
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
$l1$687:

; 512  : 	l1: lodsb	// ȡ��1 �ַ�ds:[esi]??al������esi++��

	lodsb

; 513  : 		test al,al	// ���ַ�����0 ֵ�𣨴�1 ��β����

	test	al, al

; 514  : 		je l2		// ����ǣ�����ǰ��ת�����2 ����

	je	SHORT $l2$688

; 515  : 		mov edi,ebx	// ȡ��2 ͷָ�����edi �С�

	mov	edi, ebx

; 516  : 		mov ecx,edx	// �ٽ���2 �ĳ���ֵ����ecx �С�

	mov	ecx, edx

; 517  : 		repne scasb		// �Ƚ�al �봮2 ���ַ�es:[edi]������edi++���������Ⱦͼ����Ƚϡ�

	repnz	 scasb

; 518  : 		jne l1	// �������ȣ��������ת�����1 ����

	jne	SHORT $l1$687

; 519  : 		dec esi	// esi--��ָ��һ�������ڴ�2 �е��ַ���

	dec	esi

; 520  : 		jmp l3		// ��ǰ��ת�����3 ����

	jmp	SHORT $l3$689
$l2$688:

; 521  : 	l2: xor esi,esi	// û���ҵ����������ģ�������ֵΪNULL��

	xor	esi, esi
$l3$689:

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
$l1$696:

; 576  : 	l1: mov edi,ebx	// ȡ��2 ͷָ�����edi �С�

	mov	edi, ebx

; 577  : 		mov ecx,edx	// �ٽ���2 �ĳ���ֵ����ecx �С�

	mov	ecx, edx

; 578  : 		mov eax,esi	// ����1 ��ָ�븴�Ƶ�eax �С�

	mov	eax, esi

; 579  : 		repe cmpsb// �Ƚϴ�1 �ʹ�2 �ַ�(ds:[esi],es:[edi])��esi++,edi++������Ӧ�ַ���Ⱦ�һֱ�Ƚ���ȥ��

	rep	 cmpsb

; 580  : 		je l2

	je	SHORT $l2$697

; 581  : // �Կմ�ͬ����Ч�������� // ��ȫ��ȣ���ת�����2��
; 582  : 		xchg esi,eax	// ��1 ͷָ��->esi���ȽϽ���Ĵ�1 ָ��->eax��

	xchg	esi, eax

; 583  : 		inc esi	// ��1 ͷָ��ָ����һ���ַ���

	inc	esi

; 584  : 		cmp [eax-1],0	// ��1 ָ��(eax-1)��ָ�ֽ���0 ��

	cmp	BYTE PTR [eax-1], 0

; 585  : 		jne l1	// ��������ת�����1�������Ӵ�1 �ĵ�2 ���ַ���ʼ�Ƚϡ�

	jne	SHORT $l1$696

; 586  : 		xor eax,eax	// ��eax����ʾû���ҵ�ƥ�䡣

	xor	eax, eax
$l2$697:

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
PUBLIC	_sys_mkdir
EXTRN	_new_block:NEAR
EXTRN	_free_block:NEAR
_DATA	SEGMENT
	ORG $+3
$SG1069	DB	'.', 00H
	ORG $+2
$SG1070	DB	'..', 00H
_DATA	ENDS
_TEXT	SEGMENT
_pathname$ = 8
_mode$ = 12
_basename$ = -12
_namelen$ = -8
_dir$ = 8
_de$ = -4
$T1290 = -16
$T1295 = -16
_sys_mkdir PROC NEAR

; 623  : {

	push	ebp
	mov	ebp, esp
	sub	esp, 16					; 00000010H

; 631  : 	if (!suser())

	mov	eax, DWORD PTR _current
	push	ebx
	push	esi
	push	edi
	cmp	WORD PTR [eax+578], 0
	je	SHORT $L1060

; 632  : 		return -EPERM;

	or	eax, -1

; 720  : }

	pop	edi
	pop	esi
	pop	ebx
	mov	esp, ebp
	pop	ebp
	ret	0
$L1060:

; 634  : 	if (!(dir = dir_namei(pathname,&namelen,&basename)))

	mov	eax, DWORD PTR _pathname$[ebp]
	lea	ecx, DWORD PTR _basename$[ebp]
	lea	edx, DWORD PTR _namelen$[ebp]
	push	ecx
	push	edx
	push	eax
	call	_dir_namei
	add	esp, 12					; 0000000cH
	mov	DWORD PTR _dir$[ebp], eax
	test	eax, eax
	jne	SHORT $L1061

; 635  : 		return -ENOENT;

	mov	eax, -2					; fffffffeH

; 720  : }

	pop	edi
	pop	esi
	pop	ebx
	mov	esp, ebp
	pop	ebp
	ret	0
$L1061:

; 636  : // �����˵��ļ�������Ϊ0����˵��������·�������û��ָ���ļ������ͷŸ�Ŀ¼i �ڵ㣬����
; 637  : // �����룬�˳���
; 638  : 	if (!namelen) {

	mov	ecx, DWORD PTR _namelen$[ebp]
	test	ecx, ecx
	jne	SHORT $L1062

; 639  : 		iput(dir);

	push	eax
	call	_iput
	add	esp, 4

; 640  : 		return -ENOENT;

	mov	eax, -2					; fffffffeH

; 720  : }

	pop	edi
	pop	esi
	pop	ebx
	mov	esp, ebp
	pop	ebp
	ret	0
$L1062:

; 641  : 	}
; 642  : // ����ڸ�Ŀ¼��û��д��Ȩ�ޣ����ͷŸ�Ŀ¼��i �ڵ㣬���ط�����ɳ����룬�˳���
; 643  : 	if (!permission(dir,MAY_WRITE)) {

	push	2
	push	eax
	call	_permission
	add	esp, 8
	test	eax, eax
	jne	SHORT $L1063

; 644  : 		iput(dir);

	mov	ecx, DWORD PTR _dir$[ebp]
	push	ecx
	call	_iput
	add	esp, 4

; 645  : 		return -EPERM;

	or	eax, -1

; 720  : }

	pop	edi
	pop	esi
	pop	ebx
	mov	esp, ebp
	pop	ebp
	ret	0
$L1063:

; 646  : 	}
; 647  : // �����Ӧ·�����������ļ�����Ŀ¼���Ѿ����ڣ����ͷŰ�����Ŀ¼��ĸ��ٻ��������ͷ�Ŀ¼
; 648  : // ��i �ڵ㣬�����ļ��Ѿ����ڳ����룬�˳���
; 649  : 	bh = find_entry(&dir,basename,namelen,&de);

	mov	eax, DWORD PTR _namelen$[ebp]
	mov	ecx, DWORD PTR _basename$[ebp]
	lea	edx, DWORD PTR _de$[ebp]
	push	edx
	push	eax
	lea	edx, DWORD PTR _dir$[ebp]
	push	ecx
	push	edx
	call	_find_entry
	add	esp, 16					; 00000010H

; 650  : 	if (bh) {

	test	eax, eax
	je	SHORT $L1064

; 651  : 		brelse(bh);

	push	eax
	call	_brelse

; 652  : 		iput(dir);

	mov	eax, DWORD PTR _dir$[ebp]
	push	eax
	call	_iput
	add	esp, 8

; 653  : 		return -EEXIST;

	mov	eax, -17				; ffffffefH

; 720  : }

	pop	edi
	pop	esi
	pop	ebx
	mov	esp, ebp
	pop	ebp
	ret	0
$L1064:

; 654  : 	}
; 655  : // ����һ���µ�i �ڵ㣬������ɹ������ͷ�Ŀ¼��i �ڵ㣬�����޿ռ�����룬�˳���
; 656  : 	inode = new_inode(dir->i_dev);

	mov	edx, DWORD PTR _dir$[ebp]
	xor	ecx, ecx
	mov	cx, WORD PTR [edx+44]
	push	ecx
	call	_new_inode
	mov	ebx, eax
	add	esp, 4

; 657  : 	if (!inode) {

	test	ebx, ebx
	jne	SHORT $L1065

; 658  : 		iput(dir);

	mov	eax, DWORD PTR _dir$[ebp]
	push	eax
	call	_iput
	add	esp, 4

; 659  : 		return -ENOSPC;

	mov	eax, -28				; ffffffe4H

; 720  : }

	pop	edi
	pop	esi
	pop	ebx
	mov	esp, ebp
	pop	ebp
	ret	0
$L1065:

; 660  : 	}
; 661  : // �ø���i �ڵ��Ӧ���ļ�����Ϊ32(һ��Ŀ¼��Ĵ�С)���ýڵ����޸ı�־���Լ��ڵ���޸�ʱ��
; 662  : // �ͷ���ʱ�䡣
; 663  : 	inode->i_size = 32;

	mov	DWORD PTR [ebx+4], 32			; 00000020H

; 664  : 	inode->i_dirt = 1;

	mov	BYTE PTR [ebx+51], 1

; 665  : 	inode->i_mtime = inode->i_atime = CURRENT_TIME;

	mov	ecx, DWORD PTR _jiffies
	mov	eax, 1374389535				; 51eb851fH
	imul	ecx
	mov	eax, DWORD PTR _startup_time

; 666  : // Ϊ��i �ڵ�����һ���̿飬����ڵ��һ��ֱ�ӿ�ָ����ڸÿ�š��������ʧ�ܣ����ͷŶ�ӦĿ¼
; 667  : // ��i �ڵ㣻��λ�������i �ڵ����Ӽ������ͷŸ��µ�i �ڵ㣬����û�пռ�����룬�˳���
; 668  : 	if (!(inode->i_zone[0]=new_block(inode->i_dev))) {

	xor	esi, esi
	mov	si, WORD PTR [ebx+44]
	sar	edx, 5
	mov	ecx, edx
	push	esi
	shr	ecx, 31					; 0000001fH
	add	edx, ecx
	add	eax, edx
	mov	DWORD PTR [ebx+36], eax
	mov	DWORD PTR [ebx+8], eax
	call	_new_block
	add	esp, 4
	mov	WORD PTR [ebx+14], ax
	test	ax, ax
	jne	SHORT $L1066

; 669  : 		iput(dir);

	mov	ecx, DWORD PTR _dir$[ebp]
	push	ecx
	call	_iput

; 670  : 		inode->i_nlinks--;

	mov	dl, BYTE PTR [ebx+13]

; 671  : 		iput(inode);

	push	ebx
	dec	dl
	mov	BYTE PTR [ebx+13], dl
	call	_iput
	add	esp, 8

; 672  : 		return -ENOSPC;

	mov	eax, -28				; ffffffe4H

; 720  : }

	pop	edi
	pop	esi
	pop	ebx
	mov	esp, ebp
	pop	ebp
	ret	0
$L1066:

; 673  : 	}
; 674  : // �ø��µ�i �ڵ����޸ı�־��
; 675  : 	inode->i_dirt = 1;
; 676  : // ��������Ĵ��̿顣���������ͷŶ�ӦĿ¼��i �ڵ㣻�ͷ�����Ĵ��̿飻��λ�������i �ڵ�
; 677  : // ���Ӽ������ͷŸ��µ�i �ڵ㣬����û�пռ�����룬�˳���
; 678  : 	if (!(dir_block=bread(inode->i_dev,inode->i_zone[0]))) {

	mov	edi, eax
	mov	BYTE PTR [ebx+51], 1
	and	edi, 65535				; 0000ffffH
	push	edi
	push	esi
	call	_bread
	mov	ecx, eax
	add	esp, 8
	test	ecx, ecx
	jne	SHORT $L1067

; 679  : 		iput(dir);

	mov	edx, DWORD PTR _dir$[ebp]
	push	edx
	call	_iput

; 680  : 		free_block(inode->i_dev,inode->i_zone[0]);

	push	edi
	push	esi
	call	_free_block

; 681  : 		inode->i_nlinks--;

	mov	dl, BYTE PTR [ebx+13]

; 682  : 		iput(inode);

	push	ebx
	dec	dl
	mov	BYTE PTR [ebx+13], dl
	call	_iput
	add	esp, 16					; 00000010H

; 683  : 		return -ERROR;

	mov	eax, -99				; ffffff9dH

; 720  : }

	pop	edi
	pop	esi
	pop	ebx
	mov	esp, ebp
	pop	ebp
	ret	0
$L1067:

; 684  : 	}
; 685  : // ��de ָ��Ŀ¼�����ݿ飬�ø�Ŀ¼���i �ڵ���ֶε����������i �ڵ�ţ������ֶε���"."��
; 686  : 	de = (struct dir_entry *) dir_block->b_data;

	mov	eax, DWORD PTR [ecx]
	mov	DWORD PTR _de$[ebp], eax

; 687  : 	de->inode=inode->i_num;

	mov	dx, WORD PTR [ebx+46]
	mov	WORD PTR [eax], dx

; 688  : 	strcpy(de->name,".");

	mov	eax, DWORD PTR _de$[ebp]
	add	eax, 2
	mov	DWORD PTR $T1290[ebp], eax

; 624  : 	const char * basename;
; 625  : 	int namelen;

	pushf

; 626  : 	struct m_inode * dir, * inode;

	mov	esi, OFFSET FLAT:$SG1069

; 627  : 	struct buffer_head * bh, *dir_block;

	mov	edi, DWORD PTR $T1290[ebp]

; 628  : 	struct dir_entry * de;

	cld
$l1$1289:

; 629  : 

	lodsb

; 630  : // ������ǳ����û����򷵻ط�����ɳ����롣

	stosb

; 631  : 	if (!suser())

	test	al, al

; 632  : 		return -EPERM;

	jne	SHORT $l1$1289

; 633  : // ����Ҳ�����Ӧ·����Ŀ¼��i �ڵ㣬�򷵻س����롣

	popf

; 689  : // Ȼ��de ָ����һ��Ŀ¼��ṹ���ýṹ���ڴ���ϼ�Ŀ¼�Ľڵ�ź�����".."��
; 690  : 	de++;

	mov	eax, DWORD PTR _de$[ebp]

; 691  : 	de->inode = dir->i_num;

	mov	edx, DWORD PTR _dir$[ebp]
	add	eax, 16					; 00000010H
	mov	DWORD PTR _de$[ebp], eax
	mov	dx, WORD PTR [edx+46]
	mov	WORD PTR [eax], dx

; 692  : 	strcpy(de->name,"..");

	mov	eax, DWORD PTR _de$[ebp]
	add	eax, 2
	mov	DWORD PTR $T1295[ebp], eax

; 624  : 	const char * basename;
; 625  : 	int namelen;

	pushf

; 626  : 	struct m_inode * dir, * inode;

	mov	esi, OFFSET FLAT:$SG1070

; 627  : 	struct buffer_head * bh, *dir_block;

	mov	edi, DWORD PTR $T1295[ebp]

; 628  : 	struct dir_entry * de;

	cld
$l1$1294:

; 629  : 

	lodsb

; 630  : // ������ǳ����û����򷵻ط�����ɳ����롣

	stosb

; 631  : 	if (!suser())

	test	al, al

; 632  : 		return -EPERM;

	jne	SHORT $l1$1294

; 633  : // ����Ҳ�����Ӧ·����Ŀ¼��i �ڵ㣬�򷵻س����롣

	popf

; 693  : 	inode->i_nlinks = 2;
; 694  : // Ȼ�����øø��ٻ��������޸ı�־�����ͷŸû�������
; 695  : 	dir_block->b_dirt = 1;
; 696  : 	brelse(dir_block);

	push	ecx
	mov	BYTE PTR [ebx+13], 2
	mov	BYTE PTR [ecx+11], 1
	call	_brelse

; 697  : // ��ʼ��������i �ڵ��ģʽ�ֶΣ����ø�i �ڵ����޸ı�־��
; 698  : 	inode->i_mode = I_DIRECTORY | (mode & 0777 & ~current->umask);

	mov	ecx, DWORD PTR _current
	mov	eax, DWORD PTR _mode$[ebp]

; 699  : 	inode->i_dirt = 1;

	mov	BYTE PTR [ebx+51], 1
	mov	dx, WORD PTR [ecx+620]
	not	dx
	and	edx, eax

; 700  : // ��Ŀ¼�������һ��Ŀ¼����ʧ��(������Ŀ¼��ĸ��ٻ�����ָ��ΪNULL)�����ͷ�Ŀ¼��
; 701  : // i �ڵ㣻�������i �ڵ��������Ӽ�����λ�����ͷŸ�i �ڵ㡣���س����룬�˳���
; 702  : 	bh = add_entry(dir,basename,namelen,&de);

	lea	eax, DWORD PTR _de$[ebp]
	and	edx, 511				; 000001ffH
	push	eax
	or	dh, 64					; 00000040H
	mov	WORD PTR [ebx], dx
	mov	ecx, DWORD PTR _namelen$[ebp]
	mov	edx, DWORD PTR _basename$[ebp]
	mov	eax, DWORD PTR _dir$[ebp]
	push	ecx
	push	edx
	push	eax
	call	_add_entry
	mov	esi, eax
	add	esp, 20					; 00000014H

; 703  : 	if (!bh) {

	test	esi, esi
	jne	SHORT $L1071

; 704  : 		iput(dir);

	mov	ecx, DWORD PTR _dir$[ebp]
	push	ecx
	call	_iput

; 705  : 		free_block(inode->i_dev,inode->i_zone[0]);

	xor	edx, edx
	xor	eax, eax
	mov	dx, WORD PTR [ebx+14]
	mov	ax, WORD PTR [ebx+44]
	push	edx
	push	eax
	call	_free_block

; 706  : 		inode->i_nlinks=0;
; 707  : 		iput(inode);

	push	ebx
	mov	BYTE PTR [ebx+13], 0
	call	_iput
	add	esp, 16					; 00000010H

; 708  : 		return -ENOSPC;

	mov	eax, -28				; ffffffe4H

; 720  : }

	pop	edi
	pop	esi
	pop	ebx
	mov	esp, ebp
	pop	ebp
	ret	0
$L1071:

; 709  : 	}
; 710  : // ���Ŀ¼���i �ڵ��ֶε�����i �ڵ�ţ��ø��ٻ��������޸ı�־���ͷ�Ŀ¼���µ�i �ڵ㣬�ͷ�
; 711  : // ���ٻ���������󷵻�0(�ɹ�)��
; 712  : 	de->inode = inode->i_num;

	mov	edx, DWORD PTR _de$[ebp]
	mov	cx, WORD PTR [ebx+46]

; 713  : 	bh->b_dirt = 1;

	mov	BYTE PTR [esi+11], 1
	mov	WORD PTR [edx], cx

; 714  : 	dir->i_nlinks++;

	mov	eax, DWORD PTR _dir$[ebp]
	mov	cl, BYTE PTR [eax+13]
	inc	cl
	mov	BYTE PTR [eax+13], cl

; 715  : 	dir->i_dirt = 1;

	mov	eax, DWORD PTR _dir$[ebp]
	mov	BYTE PTR [eax+51], 1

; 716  : 	iput(dir);

	mov	ecx, DWORD PTR _dir$[ebp]
	push	ecx
	call	_iput

; 717  : 	iput(inode);

	push	ebx
	call	_iput

; 718  : 	brelse(bh);

	push	esi
	call	_brelse
	add	esp, 12					; 0000000cH

; 719  : 	return 0;

	xor	eax, eax

; 720  : }

	pop	edi
	pop	esi
	pop	ebx
	mov	esp, ebp
	pop	ebp
	ret	0
_sys_mkdir ENDP
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

	jne	SHORT $l1$709

; 678  : 		mov ebx,strtok

	mov	ebx, DWORD PTR _strtok

; 679  : 		test ebx,ebx	// �����NULL�����ʾ�˴��Ǻ������ã���ebx(__strtok)��

	test	ebx, ebx

; 680  : 		je l8		// ���ebx ָ����NULL�����ܴ�����ת������

	je	SHORT $l8$710

; 681  : 		mov esi,ebx	// ��ebx ָ�븴�Ƶ�esi��

	mov	esi, ebx
$l1$709:

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

	je	SHORT $l7$711

; 691  : 		mov edx,ecx	// ����2 �����ݴ���edx��

	mov	edx, ecx
$l2$712:

; 692  : 	l2: lodsb	// ȡ��1 ���ַ�ds:[esi]->al������esi++��

	lodsb

; 693  : 		test al,al	// ���ַ�Ϊ0 ֵ��(��1 ����)��

	test	al, al

; 694  : 		je l7		// ����ǣ�����ת���7��

	je	SHORT $l7$711

; 695  : 		mov edi,ct	// edi �ٴ�ָ��2 �ס�

	mov	edi, DWORD PTR _ct$[ebp]

; 696  : 		mov ecx,edx	// ȡ��2 �ĳ���ֵ���������ecx��

	mov	ecx, edx

; 697  : 		repne scasb// ��al �д�1 ���ַ��봮2 �������ַ��Ƚϣ��жϸ��ַ��Ƿ�Ϊ�ָ����

	repnz	 scasb

; 698  : 		je l2		// �����ڴ�2 ���ҵ���ͬ�ַ����ָ����������ת���2��

	je	SHORT $l2$712

; 699  : 		dec esi	// �����Ƿָ������1 ָ��esi ָ���ʱ�ĸ��ַ���

	dec	esi

; 700  : 		cmp [esi],0	// ���ַ���NULL �ַ���

	cmp	BYTE PTR [esi], 0

; 701  : 		je l7		// ���ǣ�����ת���7 ����

	je	SHORT $l7$711

; 702  : 		mov ebx,esi	// �����ַ���ָ��esi �����ebx��

	mov	ebx, esi
$l3$713:

; 703  : 	l3: lodsb	// ȡ��1 ��һ���ַ�ds:[esi]->al������esi++��

	lodsb

; 704  : 		test al,al	// ���ַ���NULL �ַ���

	test	al, al

; 705  : 		je l5		// ���ǣ���ʾ��1 ��������ת�����5��

	je	SHORT $l5$714

; 706  : 		mov edi,ct	// edi �ٴ�ָ��2 �ס�

	mov	edi, DWORD PTR _ct$[ebp]

; 707  : 		mov ecx,edx	// ��2 ����ֵ���������ecx��

	mov	ecx, edx

; 708  : 		repne scasb // ��al �д�1 ���ַ��봮2 ��ÿ���ַ��Ƚϣ�����al �ַ��Ƿ��Ƿָ����

	repnz	 scasb

; 709  : 		jne l3		// �����Ƿָ������ת���3����⴮1 ����һ���ַ���

	jne	SHORT $l3$713

; 710  : 		dec esi	// ���Ƿָ������esi--��ָ��÷ָ���ַ���

	dec	esi

; 711  : 		cmp [esi],0	// �÷ָ����NULL �ַ���

	cmp	BYTE PTR [esi], 0

; 712  : 		je l5		// ���ǣ�����ת�����5��

	je	SHORT $l5$714

; 713  : 		mov [esi],0	// �����ǣ��򽫸÷ָ����NULL �ַ��滻����

	mov	BYTE PTR [esi], 0

; 714  : 		inc esi	// esi ָ��1 ����һ���ַ���Ҳ��ʣ�മ�ס�

	inc	esi

; 715  : 		jmp l6		// ��ת���6 ����

	jmp	SHORT $l6$715
$l5$714:

; 716  : 	l5: xor esi,esi	// esi ���㡣

	xor	esi, esi
$l6$715:

; 717  : 	l6: cmp [ebx],0	// ebx ָ��ָ��NULL �ַ���

	cmp	BYTE PTR [ebx], 0

; 718  : 		jne l7	// �����ǣ�����ת���7��

	jne	SHORT $l7$711

; 719  : 		xor ebx,ebx	// ���ǣ�����ebx=NULL��

	xor	ebx, ebx
$l7$711:

; 720  : 	l7: test ebx,ebx	// ebx ָ��ΪNULL ��

	test	ebx, ebx

; 721  : 		jne l8	// ����������ת8�����������롣

	jne	SHORT $l8$710

; 722  : 		mov esi,ebx	// ��esi ��ΪNULL��

	mov	esi, ebx
$l8$710:

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
	jae	SHORT $L732

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
$L732:

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

	je	SHORT $l1$742

; 881  : 		mov eax,1	// ����eax ��1��

	mov	eax, 1

; 882  : 		jl l1		// ���ڴ��2 ���ݵ�ֵ<�ڴ��1������ת���1��

	jl	SHORT $l1$742

; 883  : 		neg eax	// ����eax = -eax��

	neg	eax
$l1$742:

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
	jne	SHORT $L751

; 914  :     return NULL;

	xor	eax, eax

; 928  : 	}
; 929  : //  return __res;			// �����ַ�ָ�롣
; 930  : }

	pop	edi
	pop	ebp
	ret	0
$L751:

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

	je	SHORT $l1$752

; 923  : 		mov edi,1	// ����edi ����1��

	mov	edi, 1
$l1$752:

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
PUBLIC	_sys_rmdir
EXTRN	_printk:NEAR
_DATA	SEGMENT
	ORG $+1
$SG1126	DB	'empty directory has nlink!=2 (%d)', 00H
_DATA	ENDS
_TEXT	SEGMENT
_name$ = 8
_basename$ = -12
_namelen$ = -4
_dir$ = 8
_de$ = -8
_sys_rmdir PROC NEAR

; 792  : {

	push	ebp
	mov	ebp, esp
	sub	esp, 12					; 0000000cH

; 793  : 	const char * basename;
; 794  : 	int namelen;
; 795  : 	struct m_inode * dir, * inode;
; 796  : 	struct buffer_head * bh;
; 797  : 	struct dir_entry * de;
; 798  : 
; 799  : // ������ǳ����û����򷵻ط�����ɳ����롣
; 800  : 	if (!suser())

	mov	eax, DWORD PTR _current
	push	ebx
	push	esi
	push	edi
	cmp	WORD PTR [eax+578], 0

; 801  : 		return -EPERM;

	jne	$L1303

; 802  : // ����Ҳ�����Ӧ·����Ŀ¼��i �ڵ㣬�򷵻س����롣
; 803  : 	if (!(dir = dir_namei(name,&namelen,&basename)))

	mov	eax, DWORD PTR _name$[ebp]
	lea	ecx, DWORD PTR _basename$[ebp]
	lea	edx, DWORD PTR _namelen$[ebp]
	push	ecx
	push	edx
	push	eax
	call	_dir_namei
	add	esp, 12					; 0000000cH
	mov	DWORD PTR _dir$[ebp], eax
	test	eax, eax
	jne	SHORT $L1114
	pop	edi
	pop	esi

; 804  : 		return -ENOENT;

	mov	eax, -2					; fffffffeH
	pop	ebx

; 895  : }

	mov	esp, ebp
	pop	ebp
	ret	0
$L1114:

; 805  : // �����˵��ļ�������Ϊ0����˵��������·�������û��ָ���ļ������ͷŸ�Ŀ¼i �ڵ㣬����
; 806  : // �����룬�˳���
; 807  : 	if (!namelen) {

	mov	ecx, DWORD PTR _namelen$[ebp]
	test	ecx, ecx
	jne	SHORT $L1115

; 808  : 		iput(dir);

	push	eax
	call	_iput
	add	esp, 4

; 809  : 		return -ENOENT;

	mov	eax, -2					; fffffffeH
	pop	edi
	pop	esi
	pop	ebx

; 895  : }

	mov	esp, ebp
	pop	ebp
	ret	0
$L1115:

; 810  : 	}
; 811  : // ����ڸ�Ŀ¼��û��д��Ȩ�ޣ����ͷŸ�Ŀ¼��i �ڵ㣬���ط�����ɳ����룬�˳���
; 812  : 	if (!permission(dir,MAY_WRITE)) {

	push	2
	push	eax
	call	_permission
	add	esp, 8
	test	eax, eax
	jne	SHORT $L1116

; 813  : 		iput(dir);

	mov	ecx, DWORD PTR _dir$[ebp]
	push	ecx
	call	_iput
	add	esp, 4

; 848  : 		return -EPERM;

	or	eax, -1
	pop	edi
	pop	esi
	pop	ebx

; 895  : }

	mov	esp, ebp
	pop	ebp
	ret	0
$L1116:

; 814  : 		return -EPERM;
; 815  : 	}
; 816  : // �����Ӧ·�����������ļ�����Ŀ¼����ڣ����ͷŰ�����Ŀ¼��ĸ��ٻ��������ͷ�Ŀ¼
; 817  : // ��i �ڵ㣬�����ļ��Ѿ����ڳ����룬�˳�������dir �ǰ���Ҫ��ɾ��Ŀ¼����Ŀ¼i �ڵ㣬de
; 818  : // ��Ҫ��ɾ��Ŀ¼��Ŀ¼��ṹ��
; 819  : 	bh = find_entry(&dir,basename,namelen,&de);

	mov	eax, DWORD PTR _namelen$[ebp]
	mov	ecx, DWORD PTR _basename$[ebp]
	lea	edx, DWORD PTR _de$[ebp]
	push	edx
	push	eax
	lea	edx, DWORD PTR _dir$[ebp]
	push	ecx
	push	edx
	call	_find_entry
	mov	edi, eax
	add	esp, 16					; 00000010H

; 820  : 	if (!bh) {

	test	edi, edi
	jne	SHORT $L1117

; 821  : 		iput(dir);

	mov	eax, DWORD PTR _dir$[ebp]
	push	eax
	call	_iput
	add	esp, 4

; 822  : 		return -ENOENT;

	mov	eax, -2					; fffffffeH
	pop	edi
	pop	esi
	pop	ebx

; 895  : }

	mov	esp, ebp
	pop	ebp
	ret	0
$L1117:

; 823  : 	}
; 824  : // ȡ��Ŀ¼��ָ����i �ڵ㡣���������ͷ�Ŀ¼��i �ڵ㣬���ͷź���Ŀ¼��ĸ��ٻ�����������
; 825  : // ����š�
; 826  : 	if (!(inode = iget(dir->i_dev, de->inode))) {

	mov	edx, DWORD PTR _de$[ebp]
	xor	ecx, ecx
	xor	eax, eax
	mov	cx, WORD PTR [edx]
	push	ecx
	mov	ecx, DWORD PTR _dir$[ebp]
	mov	ax, WORD PTR [ecx+44]
	push	eax
	call	_iget
	mov	esi, eax
	add	esp, 8
	test	esi, esi
	jne	SHORT $L1118

; 827  : 		iput(dir);

	mov	edx, DWORD PTR _dir$[ebp]
	push	edx
	call	_iput

; 828  : 		brelse(bh);

	push	edi
	call	_brelse
	add	esp, 8

; 848  : 		return -EPERM;

	or	eax, -1
	pop	edi
	pop	esi
	pop	ebx

; 895  : }

	mov	esp, ebp
	pop	ebp
	ret	0
$L1118:

; 829  : 		return -EPERM;
; 830  : 	}
; 831  : // ����Ŀ¼����������ɾ����־���ҽ��̵���Ч�û�id �����ڸ�i �ڵ���û�id�����ʾû��Ȩ��ɾ
; 832  : // ����Ŀ¼�������ͷŰ���Ҫɾ��Ŀ¼����Ŀ¼i �ڵ�͸�Ҫɾ��Ŀ¼��i �ڵ㣬�ͷŸ��ٻ�������
; 833  : // ���س����롣
; 834  : 	if ((dir->i_mode & S_ISVTX) && current->euid &&
; 835  : 	    inode->i_uid != current->euid) {

	mov	eax, DWORD PTR _dir$[ebp]
	test	BYTE PTR [eax+1], 2
	je	SHORT $L1119
	mov	ecx, DWORD PTR _current
	mov	cx, WORD PTR [ecx+578]
	test	cx, cx
	je	SHORT $L1119
	cmp	WORD PTR [esi+2], cx

; 836  : 		iput(dir);
; 837  : 		iput(inode);
; 838  : 		brelse(bh);
; 839  : 		return -EPERM;

	jne	$L1121
$L1119:

; 840  : 	}
; 841  : // ���Ҫ��ɾ����Ŀ¼���i �ڵ���豸�Ų����ڰ�����Ŀ¼���Ŀ¼���豸�ţ����߸ñ�ɾ��Ŀ¼��
; 842  : // �������Ӽ�������1(��ʾ�з������ӵ�)������ɾ����Ŀ¼�������ͷŰ���Ҫɾ��Ŀ¼����Ŀ¼
; 843  : // i �ڵ�͸�Ҫɾ��Ŀ¼��i �ڵ㣬�ͷŸ��ٻ����������س����롣
; 844  : 	if (inode->i_dev != dir->i_dev || inode->i_count>1) {

	mov	dx, WORD PTR [esi+44]
	cmp	dx, WORD PTR [eax+44]
	jne	$L1121
	mov	ebx, 1
	cmp	WORD PTR [esi+48], bx
	ja	$L1121

; 849  : 	}
; 850  : // ���Ҫ��ɾ��Ŀ¼��Ŀ¼��i �ڵ�Ľڵ�ŵ��ڰ�������ɾ��Ŀ¼��i �ڵ�ţ����ʾ��ͼɾ��"."
; 851  : // Ŀ¼�������ͷŰ���Ҫɾ��Ŀ¼����Ŀ¼i �ڵ�͸�Ҫɾ��Ŀ¼��i �ڵ㣬�ͷŸ��ٻ�����������
; 852  : // �����롣
; 853  : 	if (inode == dir) {	/* ���ǲ�����ɾ��"."��������ɾ��"../dir"*/

	cmp	esi, eax
	jne	SHORT $L1122

; 854  : 		iput(inode);

	push	esi
	call	_iput

; 855  : 		iput(dir);

	mov	eax, DWORD PTR _dir$[ebp]
	push	eax

; 856  : 		brelse(bh);
; 857  : 		return -EPERM;

	jmp	$L1304
$L1122:

; 858  : 	}
; 859  : // ��Ҫ��ɾ����Ŀ¼��i �ڵ�����Ա����ⲻ��һ��Ŀ¼�����ͷŰ���Ҫɾ��Ŀ¼����Ŀ¼i �ڵ��
; 860  : // ��Ҫɾ��Ŀ¼��i �ڵ㣬�ͷŸ��ٻ����������س����롣
; 861  : 	if (!S_ISDIR(inode->i_mode)) {

	mov	cx, WORD PTR [esi]

; 862  : 		iput(inode);

	push	esi
	and	ecx, 61440				; 0000f000H
	cmp	ecx, 16384				; 00004000H
	je	SHORT $L1123
	call	_iput

; 863  : 		iput(dir);

	mov	edx, DWORD PTR _dir$[ebp]
	push	edx
	call	_iput

; 864  : 		brelse(bh);

	push	edi
	call	_brelse
	add	esp, 12					; 0000000cH

; 865  : 		return -ENOTDIR;

	mov	eax, -20				; ffffffecH
	pop	edi
	pop	esi
	pop	ebx

; 895  : }

	mov	esp, ebp
	pop	ebp
	ret	0
$L1123:

; 866  : 	}
; 867  : // �����豻ɾ����Ŀ¼���գ����ͷŰ���Ҫɾ��Ŀ¼����Ŀ¼i �ڵ�͸�Ҫɾ��Ŀ¼��i �ڵ㣬�ͷ�
; 868  : // ���ٻ����������س����롣
; 869  : 	if (!empty_dir(inode)) {

	call	_empty_dir
	add	esp, 4
	test	eax, eax
	jne	SHORT $L1124

; 870  : 		iput(inode);

	push	esi
	call	_iput

; 871  : 		iput(dir);

	mov	eax, DWORD PTR _dir$[ebp]
	push	eax
	call	_iput

; 872  : 		brelse(bh);

	push	edi
	call	_brelse
	add	esp, 12					; 0000000cH

; 873  : 		return -ENOTEMPTY;

	mov	eax, -39				; ffffffd9H
	pop	edi
	pop	esi
	pop	ebx

; 895  : }

	mov	esp, ebp
	pop	ebp
	ret	0
$L1124:

; 874  : 	}
; 875  : // �����豻ɾ��Ŀ¼��i �ڵ��������������2������ʾ������Ϣ��
; 876  : 	if (inode->i_nlinks != 2)

	mov	al, BYTE PTR [esi+13]
	cmp	al, 2
	je	SHORT $L1125

; 877  : 		printk("empty directory has nlink!=2 (%d)",inode->i_nlinks);

	and	eax, 255				; 000000ffH
	push	eax
	push	OFFSET FLAT:$SG1126
	call	_printk
	add	esp, 8
$L1125:

; 878  : // �ø��豻ɾ��Ŀ¼��Ŀ¼���i �ڵ���ֶ�Ϊ0����ʾ��Ŀ¼���ʹ�ã����ú��и�Ŀ¼��ĸ���
; 879  : // ���������޸ı�־�����ͷŸû�������
; 880  : 	de->inode = 0;

	mov	ecx, DWORD PTR _de$[ebp]

; 881  : 	bh->b_dirt = 1;
; 882  : 	brelse(bh);

	push	edi
	mov	BYTE PTR [edi+11], bl
	mov	WORD PTR [ecx], 0
	call	_brelse

; 883  : // �ñ�ɾ��Ŀ¼��i �ڵ��������Ϊ0������i �ڵ����޸ı�־��
; 884  : 	inode->i_nlinks=0;

	mov	BYTE PTR [esi+13], 0

; 885  : 	inode->i_dirt=1;

	mov	BYTE PTR [esi+51], bl

; 886  : // ��������ɾ��Ŀ¼����Ŀ¼��i �ڵ����ü�����1���޸���ı�ʱ����޸�ʱ��Ϊ��ǰʱ�䣬����
; 887  : // �ýڵ����޸ı�־��
; 888  : 	dir->i_nlinks--;

	mov	eax, DWORD PTR _dir$[ebp]
	mov	cl, BYTE PTR [eax+13]
	dec	cl
	mov	BYTE PTR [eax+13], cl

; 889  : 	dir->i_ctime = dir->i_mtime = CURRENT_TIME;

	mov	ecx, DWORD PTR _jiffies
	mov	eax, 1374389535				; 51eb851fH
	imul	ecx
	sar	edx, 5
	mov	ecx, DWORD PTR _dir$[ebp]
	mov	eax, edx
	shr	eax, 31					; 0000001fH
	add	edx, eax
	mov	eax, DWORD PTR _startup_time
	add	edx, eax
	mov	DWORD PTR [ecx+8], edx
	mov	eax, DWORD PTR _dir$[ebp]
	mov	edx, DWORD PTR [eax+8]
	mov	DWORD PTR [eax+40], edx

; 890  : 	dir->i_dirt=1;

	mov	eax, DWORD PTR _dir$[ebp]
	mov	BYTE PTR [eax+51], bl

; 891  : // ����ͷŰ���Ҫɾ��Ŀ¼����Ŀ¼i �ڵ�͸�Ҫɾ��Ŀ¼��i �ڵ㣬����0(�ɹ�)��
; 892  : 	iput(dir);

	mov	ecx, DWORD PTR _dir$[ebp]
	push	ecx
	call	_iput

; 893  : 	iput(inode);

	push	esi
	call	_iput
	add	esp, 12					; 0000000cH

; 894  : 	return 0;

	xor	eax, eax
	pop	edi
	pop	esi
	pop	ebx

; 895  : }

	mov	esp, ebp
	pop	ebp
	ret	0
$L1121:

; 845  : 		iput(dir);

	push	eax
	call	_iput

; 846  : 		iput(inode);

	push	esi
$L1304:
	call	_iput

; 847  : 		brelse(bh);

	push	edi
	call	_brelse
	add	esp, 12					; 0000000cH
$L1303:
	pop	edi
	pop	esi

; 848  : 		return -EPERM;

	or	eax, -1
	pop	ebx

; 895  : }

	mov	esp, ebp
	pop	ebp
	ret	0
_sys_rmdir ENDP
_TEXT	ENDS
_DATA	SEGMENT
	ORG $+2
$SG1084	DB	'warning - bad directory on dev %04x', 0aH, 00H
	ORG $+3
$SG1088	DB	'.', 00H
	ORG $+2
$SG1089	DB	'..', 00H
	ORG $+1
$SG1090	DB	'warning - bad directory on dev %04x', 0aH, 00H
_DATA	ENDS
_TEXT	SEGMENT
_inode$ = 8
_len$ = -8
_de$ = -4
$T1312 = -4
$T1320 = -4
_empty_dir PROC NEAR

; 729  : {

	push	ebp
	mov	ebp, esp
	sub	esp, 8
	push	ebx
	push	esi

; 736  : 	len = inode->i_size / sizeof (struct dir_entry);

	mov	esi, DWORD PTR _inode$[ebp]
	push	edi
	mov	eax, DWORD PTR [esi+4]
	shr	eax, 4

; 740  : 	    !(bh=bread(inode->i_dev,inode->i_zone[0]))) {

	cmp	eax, 2
	mov	DWORD PTR _len$[ebp], eax
	jl	$L1083
	mov	ax, WORD PTR [esi+14]
	test	ax, ax
	je	$L1083
	and	eax, 65535				; 0000ffffH
	push	eax
	xor	eax, eax
	mov	ax, WORD PTR [esi+44]
	push	eax
	call	_bread
	mov	ebx, eax
	add	esp, 8
	test	ebx, ebx
	je	$L1083

; 745  : 	de = (struct dir_entry *) bh->b_data;

	mov	ecx, DWORD PTR [ebx]

; 748  : // ������0��
; 749  : 	if (de[0].inode != inode->i_num || !de[1].inode || 
; 750  : 	    strcmp(".",de[0].name) || strcmp("..",de[1].name)) {

	mov	dx, WORD PTR [ecx]
	cmp	dx, WORD PTR [esi+46]
	jne	$L1087
	cmp	WORD PTR [ecx+16], 0
	je	$L1087
	lea	eax, DWORD PTR [ecx+2]
	mov	DWORD PTR $T1312[ebp], eax

; 730  : 	int nr,block;
; 731  : 	int len;
; 732  : 	struct buffer_head * bh;

	pushf

; 733  : 	struct dir_entry * de;

	mov	edi, OFFSET FLAT:$SG1088

; 734  : 

	mov	esi, DWORD PTR $T1312[ebp]

; 735  : // ����ָ��Ŀ¼������Ŀ¼��ĸ���(Ӧ��������2 ������"."��".."�����ļ�Ŀ¼��)��

	cld
$l1$1309:

; 736  : 	len = inode->i_size / sizeof (struct dir_entry);

	lodsb

; 737  : // ���Ŀ¼���������2 �����߸�Ŀ¼i �ڵ�ĵ�1 ��ֱ�ӿ�û��ָ���κδ��̿�ţ�������Ӧ����

	scasb

; 738  : // �������������ʾ������Ϣ���豸dev ��Ŀ¼��������0(ʧ��)��

	jne	SHORT $l2$1310

; 739  : 	if (len<2 || !inode->i_zone[0] ||

	test	al, al

; 740  : 	    !(bh=bread(inode->i_dev,inode->i_zone[0]))) {

	jne	SHORT $l1$1309

; 741  : 	    	printk("warning - bad directory on dev %04x\n",inode->i_dev);

	xor	eax, eax

; 742  : 		return 0;

	jmp	SHORT $l3$1311
$l2$1310:

; 743  : 	}

	mov	eax, 1

; 744  : // ��de ָ���ж������̿����ݵĸ��ٻ������е�1 ��Ŀ¼�

	jl	SHORT $l3$1311

; 745  : 	de = (struct dir_entry *) bh->b_data;

	neg	eax
$l3$1311:

; 746  : // �����1 ��Ŀ¼���i �ڵ���ֶ�ֵ�����ڸ�Ŀ¼��i �ڵ�ţ����ߵ�2 ��Ŀ¼���i �ڵ���ֶ�
; 747  : // Ϊ�㣬��������Ŀ¼��������ֶβ��ֱ����"."��".."������ʾ��������Ϣ���豸dev ��Ŀ¼��

	popf

; 748  : // ������0��
; 749  : 	if (de[0].inode != inode->i_num || !de[1].inode || 
; 750  : 	    strcmp(".",de[0].name) || strcmp("..",de[1].name)) {

	test	eax, eax
	jne	$L1326
	lea	edx, DWORD PTR [ecx+18]
	mov	DWORD PTR $T1320[ebp], edx

; 730  : 	int nr,block;
; 731  : 	int len;
; 732  : 	struct buffer_head * bh;

	pushf

; 733  : 	struct dir_entry * de;

	mov	edi, OFFSET FLAT:$SG1089

; 734  : 

	mov	esi, DWORD PTR $T1320[ebp]

; 735  : // ����ָ��Ŀ¼������Ŀ¼��ĸ���(Ӧ��������2 ������"."��".."�����ļ�Ŀ¼��)��

	cld
$l1$1317:

; 736  : 	len = inode->i_size / sizeof (struct dir_entry);

	lodsb

; 737  : // ���Ŀ¼���������2 �����߸�Ŀ¼i �ڵ�ĵ�1 ��ֱ�ӿ�û��ָ���κδ��̿�ţ�������Ӧ����

	scasb

; 738  : // �������������ʾ������Ϣ���豸dev ��Ŀ¼��������0(ʧ��)��

	jne	SHORT $l2$1318

; 739  : 	if (len<2 || !inode->i_zone[0] ||

	test	al, al

; 740  : 	    !(bh=bread(inode->i_dev,inode->i_zone[0]))) {

	jne	SHORT $l1$1317

; 741  : 	    	printk("warning - bad directory on dev %04x\n",inode->i_dev);

	xor	eax, eax

; 742  : 		return 0;

	jmp	SHORT $l3$1319
$l2$1318:

; 743  : 	}

	mov	eax, 1

; 744  : // ��de ָ���ж������̿����ݵĸ��ٻ������е�1 ��Ŀ¼�

	jl	SHORT $l3$1319

; 745  : 	de = (struct dir_entry *) bh->b_data;

	neg	eax
$l3$1319:

; 746  : // �����1 ��Ŀ¼���i �ڵ���ֶ�ֵ�����ڸ�Ŀ¼��i �ڵ�ţ����ߵ�2 ��Ŀ¼���i �ڵ���ֶ�
; 747  : // Ϊ�㣬��������Ŀ¼��������ֶβ��ֱ����"."��".."������ʾ��������Ϣ���豸dev ��Ŀ¼��

	popf

; 748  : // ������0��
; 749  : 	if (de[0].inode != inode->i_num || !de[1].inode || 
; 750  : 	    strcmp(".",de[0].name) || strcmp("..",de[1].name)) {

	test	eax, eax
	jne	$L1326

; 752  : 		return 0;
; 753  : 	}
; 754  : // ��nr ����Ŀ¼����ţ�de ָ�������Ŀ¼�
; 755  : 	nr = 2;
; 756  : 	de += 2;
; 757  : // ѭ������Ŀ¼�����е�Ŀ¼��(len-2 ��)������û��Ŀ¼���i �ڵ���ֶβ�Ϊ0(��ʹ��)��
; 758  : 	while (nr<len) {

	mov	eax, DWORD PTR _len$[ebp]
	mov	edi, 2
	add	ecx, 32					; 00000020H
	cmp	eax, edi
	mov	DWORD PTR _de$[ebp], ecx
	jle	SHORT $L1093
$L1092:

; 759  : // ����ÿ���̿��е�Ŀ¼���Ѿ�����꣬���ͷŸô��̿�ĸ��ٻ���������ȡ��һ�麬��Ŀ¼���
; 760  : // ���̿顣����Ӧ��û��ʹ��(���Ѿ����ã����ļ��Ѿ�ɾ����)�����������һ�飬�������������
; 761  : // ������0��������de ָ���������׸�Ŀ¼�
; 762  : 		if ((void *) de >= (void *) (bh->b_data+BLOCK_SIZE)) {

	mov	eax, DWORD PTR [ebx]
	add	eax, 1024				; 00000400H
	cmp	ecx, eax
	jb	SHORT $L1096

; 763  : 			brelse(bh);

	push	ebx
	call	_brelse

; 764  : 			block=bmap(inode,nr/DIR_ENTRIES_PER_BLOCK);

	mov	esi, DWORD PTR _inode$[ebp]
	mov	ecx, edi
	shr	ecx, 6
	push	ecx
	push	esi
	call	_bmap
	add	esp, 12					; 0000000cH

; 765  : 			if (!block) {

	test	eax, eax
	jne	SHORT $L1098

; 766  : 				nr += DIR_ENTRIES_PER_BLOCK;
; 767  : 				continue;

	mov	ecx, DWORD PTR _de$[ebp]
	add	edi, 64					; 00000040H
	jmp	SHORT $L1325
$L1098:

; 768  : 			}
; 769  : 			if (!(bh=bread(inode->i_dev,block)))

	xor	edx, edx
	push	eax
	mov	dx, WORD PTR [esi+44]
	push	edx
	call	_bread
	mov	ebx, eax
	add	esp, 8
	test	ebx, ebx
	je	SHORT $L1323

; 770  : 				return 0;
; 771  : 			de = (struct dir_entry *) bh->b_data;

	mov	eax, DWORD PTR [ebx]
	mov	DWORD PTR _de$[ebp], eax
	mov	ecx, eax
$L1096:

; 772  : 		}
; 773  : // �����Ŀ¼���i �ڵ���ֶβ�����0�����ʾ��Ŀ¼��Ŀǰ����ʹ�ã����ͷŸø��ٻ�������
; 774  : // ����0���˳���
; 775  : 		if (de->inode) {

	cmp	WORD PTR [ecx], 0
	jne	SHORT $L1324

; 777  : 			return 0;
; 778  : 		}
; 779  : // ��������û�в�ѯ���Ŀ¼�е�����Ŀ¼��������⡣
; 780  : 		de++;

	add	ecx, 16					; 00000010H

; 781  : 		nr++;

	inc	edi
	mov	DWORD PTR _de$[ebp], ecx
$L1325:
	cmp	edi, DWORD PTR _len$[ebp]
	jl	SHORT $L1092
$L1093:

; 782  : 	}
; 783  : // ������˵����Ŀ¼��û���ҵ����õ�Ŀ¼��(��Ȼ����ͷ��������)���򷵻ػ�����������1��
; 784  : 	brelse(bh);

	push	ebx
	call	_brelse
	add	esp, 4

; 785  : 	return 1;

	mov	eax, 1

; 786  : }

	pop	edi
	pop	esi
	pop	ebx
	mov	esp, ebp
	pop	ebp
	ret	0
$L1324:

; 776  : 			brelse(bh);

	push	ebx
	call	_brelse
	add	esp, 4
	xor	eax, eax

; 786  : }

	pop	edi
	pop	esi
	pop	ebx
	mov	esp, ebp
	pop	ebp
	ret	0
$L1326:

; 752  : 		return 0;
; 753  : 	}
; 754  : // ��nr ����Ŀ¼����ţ�de ָ�������Ŀ¼�
; 755  : 	nr = 2;
; 756  : 	de += 2;
; 757  : // ѭ������Ŀ¼�����е�Ŀ¼��(len-2 ��)������û��Ŀ¼���i �ڵ���ֶβ�Ϊ0(��ʹ��)��
; 758  : 	while (nr<len) {

	mov	esi, DWORD PTR _inode$[ebp]
$L1087:

; 751  : 	    	printk("warning - bad directory on dev %04x\n",inode->i_dev);

	xor	ecx, ecx
	mov	cx, WORD PTR [esi+44]
	push	ecx
	push	OFFSET FLAT:$SG1090
	call	_printk
	add	esp, 8
	xor	eax, eax

; 786  : }

	pop	edi
	pop	esi
	pop	ebx
	mov	esp, ebp
	pop	ebp
	ret	0
$L1083:

; 741  : 	    	printk("warning - bad directory on dev %04x\n",inode->i_dev);

	xor	edx, edx
	mov	dx, WORD PTR [esi+44]
	push	edx
	push	OFFSET FLAT:$SG1084
	call	_printk
	add	esp, 8
$L1323:

; 786  : }

	pop	edi
	pop	esi
	xor	eax, eax
	pop	ebx
	mov	esp, ebp
	pop	ebp
	ret	0
_empty_dir ENDP
_TEXT	ENDS
PUBLIC	_sys_unlink
_DATA	SEGMENT
	ORG $+3
$SG1145	DB	'Deleting nonexistent file (%04x:%d), %d', 0aH, 00H
_DATA	ENDS
_TEXT	SEGMENT
_name$ = 8
_basename$ = -12
_namelen$ = -4
_dir$ = 8
_de$ = -8
_sys_unlink PROC NEAR

; 903  : {

	push	ebp
	mov	ebp, esp
	sub	esp, 12					; 0000000cH

; 904  : 	const char * basename;
; 905  : 	int namelen;
; 906  : 	struct m_inode * dir, * inode;
; 907  : 	struct buffer_head * bh;
; 908  : 	struct dir_entry * de;
; 909  : 
; 910  : // ����Ҳ�����Ӧ·����Ŀ¼��i �ڵ㣬�򷵻س����롣
; 911  : 	if (!(dir = dir_namei(name,&namelen,&basename)))

	mov	edx, DWORD PTR _name$[ebp]
	push	esi
	lea	eax, DWORD PTR _basename$[ebp]
	push	edi
	lea	ecx, DWORD PTR _namelen$[ebp]
	push	eax
	push	ecx
	push	edx
	call	_dir_namei
	add	esp, 12					; 0000000cH
	mov	DWORD PTR _dir$[ebp], eax
	test	eax, eax
	jne	SHORT $L1137
	pop	edi

; 912  : 		return -ENOENT;

	mov	eax, -2					; fffffffeH
	pop	esi

; 977  : }

	mov	esp, ebp
	pop	ebp
	ret	0
$L1137:

; 913  : // �����˵��ļ�������Ϊ0����˵��������·�������û��ָ���ļ������ͷŸ�Ŀ¼i �ڵ㣬
; 914  : // ���س����룬�˳���
; 915  : 	if (!namelen) {

	mov	ecx, DWORD PTR _namelen$[ebp]
	test	ecx, ecx
	jne	SHORT $L1138

; 916  : 		iput(dir);

	push	eax
	call	_iput
	add	esp, 4

; 917  : 		return -ENOENT;

	mov	eax, -2					; fffffffeH
	pop	edi
	pop	esi

; 977  : }

	mov	esp, ebp
	pop	ebp
	ret	0
$L1138:

; 918  : 	}
; 919  : // ����ڸ�Ŀ¼��û��д��Ȩ�ޣ����ͷŸ�Ŀ¼��i �ڵ㣬���ط�����ɳ����룬�˳���
; 920  : 	if (!permission(dir,MAY_WRITE)) {

	push	2
	push	eax
	call	_permission
	add	esp, 8
	test	eax, eax
	jne	SHORT $L1139

; 921  : 		iput(dir);

	mov	eax, DWORD PTR _dir$[ebp]
	push	eax
	call	_iput
	add	esp, 4

; 956  : 		return -EPERM;

	or	eax, -1
	pop	edi
	pop	esi

; 977  : }

	mov	esp, ebp
	pop	ebp
	ret	0
$L1139:

; 922  : 		return -EPERM;
; 923  : 	}
; 924  : // �����Ӧ·�����������ļ�����Ŀ¼����ڣ����ͷŰ�����Ŀ¼��ĸ��ٻ��������ͷ�Ŀ¼
; 925  : // ��i �ڵ㣬�����ļ��Ѿ����ڳ����룬�˳�������dir �ǰ���Ҫ��ɾ��Ŀ¼����Ŀ¼i �ڵ㣬de
; 926  : // ��Ҫ��ɾ��Ŀ¼��Ŀ¼��ṹ��
; 927  : 	bh = find_entry(&dir,basename,namelen,&de);

	mov	edx, DWORD PTR _namelen$[ebp]
	mov	eax, DWORD PTR _basename$[ebp]
	lea	ecx, DWORD PTR _de$[ebp]
	push	ecx
	push	edx
	lea	ecx, DWORD PTR _dir$[ebp]
	push	eax
	push	ecx
	call	_find_entry
	mov	edi, eax
	add	esp, 16					; 00000010H

; 928  : 	if (!bh) {

	test	edi, edi
	jne	SHORT $L1140

; 929  : 		iput(dir);

	mov	edx, DWORD PTR _dir$[ebp]
	push	edx
	call	_iput
	add	esp, 4

; 930  : 		return -ENOENT;

	mov	eax, -2					; fffffffeH
	pop	edi
	pop	esi

; 977  : }

	mov	esp, ebp
	pop	ebp
	ret	0
$L1140:

; 931  : 	}
; 932  : // ȡ��Ŀ¼��ָ����i �ڵ㡣���������ͷ�Ŀ¼��i �ڵ㣬���ͷź���Ŀ¼��ĸ��ٻ�������
; 933  : // ���س���š�
; 934  : 	if (!(inode = iget(dir->i_dev, de->inode))) {

	mov	ecx, DWORD PTR _de$[ebp]
	xor	eax, eax
	xor	edx, edx
	mov	ax, WORD PTR [ecx]
	push	eax
	mov	eax, DWORD PTR _dir$[ebp]
	mov	dx, WORD PTR [eax+44]
	push	edx
	call	_iget

; 935  : 		iput(dir);

	mov	ecx, DWORD PTR _dir$[ebp]
	mov	esi, eax
	add	esp, 8
	test	esi, esi
	jne	SHORT $L1141
	push	ecx
	call	_iput

; 936  : 		brelse(bh);

	push	edi
	call	_brelse
	add	esp, 8

; 937  : 		return -ENOENT;

	mov	eax, -2					; fffffffeH
	pop	edi
	pop	esi

; 977  : }

	mov	esp, ebp
	pop	ebp
	ret	0
$L1141:

; 938  : 	}
; 939  : // �����Ŀ¼����������ɾ����־�����û����ǳ����û������ҽ��̵���Ч�û�id �����ڱ�ɾ���ļ�
; 940  : // ��i �ڵ���û�id�����ҽ��̵���Ч�û�id Ҳ������Ŀ¼i �ڵ���û�id����û��Ȩ��ɾ�����ļ�
; 941  : // �������ͷŸ�Ŀ¼i �ڵ�͸��ļ���Ŀ¼���i �ڵ㣬�ͷŰ�����Ŀ¼��Ļ����������س���š�
; 942  : 	if ((dir->i_mode & S_ISVTX) && !suser() &&
; 943  : 	    current->euid != inode->i_uid &&
; 944  : 	    current->euid != dir->i_uid) {

	test	BYTE PTR [ecx+1], 2
	je	SHORT $L1142
	mov	edx, DWORD PTR _current
	mov	ax, WORD PTR [edx+578]
	test	ax, ax
	je	SHORT $L1142
	cmp	ax, WORD PTR [esi+2]
	je	SHORT $L1142
	cmp	ax, WORD PTR [ecx+2]
	je	SHORT $L1142

; 945  : 		iput(dir);

	push	ecx
	call	_iput

; 946  : 		iput(inode);

	push	esi

; 947  : 		brelse(bh);
; 948  : 		return -EPERM;

	jmp	SHORT $L1329
$L1142:

; 949  : 	}
; 950  : // �����ָ���ļ�����һ��Ŀ¼����Ҳ����ɾ�����ͷŸ�Ŀ¼i �ڵ�͸��ļ���Ŀ¼���i �ڵ㣬
; 951  : // �ͷŰ�����Ŀ¼��Ļ����������س���š�
; 952  : 	if (S_ISDIR(inode->i_mode)) {

	mov	ax, WORD PTR [esi]
	and	eax, 61440				; 0000f000H
	cmp	eax, 16384				; 00004000H
	jne	SHORT $L1143

; 953  : 		iput(inode);

	push	esi
	call	_iput

; 954  : 		iput(dir);

	mov	ecx, DWORD PTR _dir$[ebp]
	push	ecx
$L1329:
	call	_iput

; 955  : 		brelse(bh);

	push	edi
	call	_brelse
	add	esp, 12					; 0000000cH

; 956  : 		return -EPERM;

	or	eax, -1
	pop	edi
	pop	esi

; 977  : }

	mov	esp, ebp
	pop	ebp
	ret	0
$L1143:

; 957  : 	}
; 958  : // �����i �ڵ���������Ѿ�Ϊ0������ʾ������Ϣ��������Ϊ1��
; 959  : 	if (!inode->i_nlinks) {

	mov	al, BYTE PTR [esi+13]
	test	al, al
	jne	SHORT $L1144

; 960  : 		printk("Deleting nonexistent file (%04x:%d), %d\n",
; 961  : 			inode->i_dev,inode->i_num,inode->i_nlinks);

	xor	edx, edx
	xor	eax, eax
	mov	dx, WORD PTR [esi+46]
	mov	ax, WORD PTR [esi+44]
	push	0
	push	edx
	push	eax
	push	OFFSET FLAT:$SG1145
	call	_printk
	add	esp, 16					; 00000010H

; 962  : 		inode->i_nlinks=1;

	mov	BYTE PTR [esi+13], 1
$L1144:

; 963  : 	}
; 964  : // �����ļ�����Ŀ¼���е�i �ڵ���ֶ���Ϊ0����ʾ�ͷŸ�Ŀ¼������ð�����Ŀ¼��Ļ�����
; 965  : // ���޸ı�־���ͷŸø��ٻ�������
; 966  : 	de->inode = 0;

	mov	ecx, DWORD PTR _de$[ebp]

; 967  : 	bh->b_dirt = 1;
; 968  : 	brelse(bh);

	push	edi
	mov	BYTE PTR [edi+11], 1
	mov	WORD PTR [ecx], 0
	call	_brelse

; 969  : // ��i �ڵ����������1�������޸ı�־�����¸ı�ʱ��Ϊ��ǰʱ�䡣����ͷŸ�i �ڵ��Ŀ¼��i ��
; 970  : // �㣬����0(�ɹ�)��
; 971  : 	inode->i_nlinks--;

	mov	cl, BYTE PTR [esi+13]

; 972  : 	inode->i_dirt = 1;

	mov	BYTE PTR [esi+51], 1
	dec	cl
	mov	BYTE PTR [esi+13], cl

; 973  : 	inode->i_ctime = CURRENT_TIME;

	mov	ecx, DWORD PTR _jiffies
	mov	eax, 1374389535				; 51eb851fH

; 974  : 	iput(inode);

	push	esi
	imul	ecx
	sar	edx, 5
	mov	eax, edx
	shr	eax, 31					; 0000001fH
	add	edx, eax
	mov	eax, DWORD PTR _startup_time
	add	edx, eax
	mov	DWORD PTR [esi+40], edx
	call	_iput

; 975  : 	iput(dir);

	mov	ecx, DWORD PTR _dir$[ebp]
	push	ecx
	call	_iput
	add	esp, 12					; 0000000cH

; 976  : 	return 0;

	xor	eax, eax
	pop	edi
	pop	esi

; 977  : }

	mov	esp, ebp
	pop	ebp
	ret	0
_sys_unlink ENDP
_TEXT	ENDS
PUBLIC	_sys_link
_TEXT	SEGMENT
_oldname$ = 8
_newname$ = 12
_de$ = -12
_dir$ = 8
_basename$ = -8
_namelen$ = -4
_sys_link PROC NEAR

; 984  : {

	push	ebp
	mov	ebp, esp
	sub	esp, 12					; 0000000cH

; 985  : 	struct dir_entry * de;
; 986  : 	struct m_inode * oldinode, * dir;
; 987  : 	struct buffer_head * bh;
; 988  : 	const char * basename;
; 989  : 	int namelen;
; 990  : 
; 991  : // ȡԭ�ļ�·������Ӧ��i �ڵ�oldinode�����Ϊ0�����ʾ�������س���š�
; 992  : 	oldinode=namei(oldname);

	mov	eax, DWORD PTR _oldname$[ebp]
	push	esi
	push	eax
	call	_namei
	mov	esi, eax
	add	esp, 4

; 993  : 	if (!oldinode)

	test	esi, esi
	jne	SHORT $L1158

; 994  : 		return -ENOENT;

	mov	eax, -2					; fffffffeH
	pop	esi

; 1056 : }

	mov	esp, ebp
	pop	ebp
	ret	0
$L1158:

; 995  : // ���ԭ·������Ӧ����һ��Ŀ¼�������ͷŸ�i �ڵ㣬���س���š�
; 996  : 	if (S_ISDIR(oldinode->i_mode)) {

	mov	cx, WORD PTR [esi]
	and	ecx, 61440				; 0000f000H
	cmp	ecx, 16384				; 00004000H
	jne	SHORT $L1159

; 997  : 		iput(oldinode);

	push	esi
	call	_iput
	add	esp, 4

; 998  : 		return -EPERM;

	or	eax, -1
	pop	esi

; 1056 : }

	mov	esp, ebp
	pop	ebp
	ret	0
$L1159:

; 999  : 	}
; 1000 : // ������·���������Ŀ¼��i �ڵ㣬�����������ļ������䳤�ȡ����Ŀ¼��i �ڵ�û���ҵ���
; 1001 : // ���ͷ�ԭ·������i �ڵ㣬���س���š�
; 1002 : 	dir = dir_namei(newname,&namelen,&basename);

	mov	ecx, DWORD PTR _newname$[ebp]
	lea	edx, DWORD PTR _basename$[ebp]
	lea	eax, DWORD PTR _namelen$[ebp]
	push	edx
	push	eax
	push	ecx
	call	_dir_namei
	add	esp, 12					; 0000000cH
	mov	DWORD PTR _dir$[ebp], eax

; 1003 : 	if (!dir) {

	test	eax, eax
	jne	SHORT $L1160

; 1004 : 		iput(oldinode);

	push	esi
	call	_iput
	add	esp, 4

; 1005 : 		return -EACCES;

	mov	eax, -13				; fffffff3H
	pop	esi

; 1056 : }

	mov	esp, ebp
	pop	ebp
	ret	0
$L1160:

; 1006 : 	}
; 1007 : // �����·�����в������ļ��������ͷ�ԭ·����i �ڵ����·����Ŀ¼��i �ڵ㣬���س���š�
; 1008 : 	if (!namelen) {

	mov	ecx, DWORD PTR _namelen$[ebp]
	test	ecx, ecx
	jne	SHORT $L1161

; 1009 : 		iput(oldinode);

	push	esi
	call	_iput

; 1010 : 		iput(dir);

	mov	edx, DWORD PTR _dir$[ebp]
	push	edx
	call	_iput
	add	esp, 8

; 1011 : 		return -EPERM;

	or	eax, -1
	pop	esi

; 1056 : }

	mov	esp, ebp
	pop	ebp
	ret	0
$L1161:

; 1012 : 	}
; 1013 : // �����·����Ŀ¼���豸����ԭ·�������豸�Ų�һ������Ҳ���ܽ������ӣ������ͷ���·����
; 1014 : // Ŀ¼��i �ڵ��ԭ·������i �ڵ㣬���س���š�
; 1015 : 	if (dir->i_dev != oldinode->i_dev) {

	mov	cx, WORD PTR [eax+44]
	cmp	cx, WORD PTR [esi+44]
	je	SHORT $L1162

; 1016 : 		iput(dir);

	push	eax
	call	_iput

; 1017 : 		iput(oldinode);

	push	esi
	call	_iput
	add	esp, 8

; 1018 : 		return -EXDEV;

	mov	eax, -18				; ffffffeeH
	pop	esi

; 1056 : }

	mov	esp, ebp
	pop	ebp
	ret	0
$L1162:

; 1019 : 	}
; 1020 : // ����û�û������Ŀ¼��д��Ȩ�ޣ���Ҳ���ܽ������ӣ������ͷ���·����Ŀ¼��i �ڵ�
; 1021 : // ��ԭ·������i �ڵ㣬���س���š�
; 1022 : 	if (!permission(dir,MAY_WRITE)) {

	push	2
	push	eax
	call	_permission
	add	esp, 8
	test	eax, eax
	jne	SHORT $L1163

; 1023 : 		iput(dir);

	mov	edx, DWORD PTR _dir$[ebp]
	push	edx
	call	_iput

; 1024 : 		iput(oldinode);

	push	esi
	call	_iput
	add	esp, 8

; 1025 : 		return -EACCES;

	mov	eax, -13				; fffffff3H
	pop	esi

; 1056 : }

	mov	esp, ebp
	pop	ebp
	ret	0
$L1163:

; 1026 : 	}
; 1027 : // ��ѯ����·�����Ƿ��Ѿ����ڣ�������ڣ���Ҳ���ܽ������ӣ������ͷŰ������Ѵ���Ŀ¼���
; 1028 : // ���ٻ��������ͷ���·����Ŀ¼��i �ڵ��ԭ·������i �ڵ㣬���س���š�
; 1029 : 	bh = find_entry(&dir,basename,namelen,&de);

	mov	ecx, DWORD PTR _namelen$[ebp]
	mov	edx, DWORD PTR _basename$[ebp]
	lea	eax, DWORD PTR _de$[ebp]
	push	eax
	push	ecx
	lea	eax, DWORD PTR _dir$[ebp]
	push	edx
	push	eax
	call	_find_entry
	add	esp, 16					; 00000010H

; 1030 : 	if (bh) {

	test	eax, eax
	je	SHORT $L1164

; 1031 : 		brelse(bh);

	push	eax
	call	_brelse

; 1032 : 		iput(dir);

	mov	ecx, DWORD PTR _dir$[ebp]
	push	ecx
	call	_iput

; 1033 : 		iput(oldinode);

	push	esi
	call	_iput
	add	esp, 12					; 0000000cH

; 1034 : 		return -EEXIST;

	mov	eax, -17				; ffffffefH
	pop	esi

; 1056 : }

	mov	esp, ebp
	pop	ebp
	ret	0
$L1164:

; 1035 : 	}
; 1036 : // ����Ŀ¼�����һ��Ŀ¼���ʧ�����ͷŸ�Ŀ¼��i �ڵ��ԭ·������i �ڵ㣬���س���š�
; 1037 : 	bh = add_entry(dir,basename,namelen,&de);

	mov	eax, DWORD PTR _namelen$[ebp]
	mov	ecx, DWORD PTR _basename$[ebp]
	lea	edx, DWORD PTR _de$[ebp]
	push	edx
	mov	edx, DWORD PTR _dir$[ebp]
	push	eax
	push	ecx
	push	edx
	call	_add_entry
	add	esp, 16					; 00000010H

; 1038 : 	if (!bh) {

	test	eax, eax
	jne	SHORT $L1165

; 1039 : 		iput(dir);

	mov	eax, DWORD PTR _dir$[ebp]
	push	eax
	call	_iput

; 1040 : 		iput(oldinode);

	push	esi
	call	_iput
	add	esp, 8

; 1041 : 		return -ENOSPC;

	mov	eax, -28				; ffffffe4H
	pop	esi

; 1056 : }

	mov	esp, ebp
	pop	ebp
	ret	0
$L1165:

; 1042 : 	}
; 1043 : // �����ʼ���ø�Ŀ¼���i �ڵ�ŵ���ԭ·������i �ڵ�ţ����ð���������Ŀ¼��ĸ��ٻ�����
; 1044 : // ���޸ı�־���ͷŸû��������ͷ�Ŀ¼��i �ڵ㡣
; 1045 : 	de->inode = oldinode->i_num;

	mov	edx, DWORD PTR _de$[ebp]
	mov	cx, WORD PTR [esi+46]

; 1046 : 	bh->b_dirt = 1;
; 1047 : 	brelse(bh);

	push	eax
	mov	BYTE PTR [eax+11], 1
	mov	WORD PTR [edx], cx
	call	_brelse

; 1048 : 	iput(dir);

	mov	eax, DWORD PTR _dir$[ebp]
	push	eax
	call	_iput

; 1049 : // ��ԭ�ڵ��Ӧ�ü�����1���޸���ı�ʱ��Ϊ��ǰʱ�䣬������i �ڵ����޸ı�־������ͷ�ԭ
; 1050 : // ·������i �ڵ㣬������0(�ɹ�)��
; 1051 : 	oldinode->i_nlinks++;

	mov	dl, BYTE PTR [esi+13]
	inc	dl
	mov	BYTE PTR [esi+13], dl

; 1052 : 	oldinode->i_ctime = CURRENT_TIME;

	mov	ecx, DWORD PTR _jiffies
	mov	eax, 1374389535				; 51eb851fH

; 1053 : 	oldinode->i_dirt = 1;
; 1054 : 	iput(oldinode);

	push	esi
	imul	ecx
	mov	eax, DWORD PTR _startup_time
	mov	BYTE PTR [esi+51], 1
	sar	edx, 5
	mov	ecx, edx
	shr	ecx, 31					; 0000001fH
	add	edx, ecx
	add	edx, eax
	mov	DWORD PTR [esi+40], edx
	call	_iput
	add	esp, 12					; 0000000cH

; 1055 : 	return 0;

	xor	eax, eax
	pop	esi

; 1056 : }

	mov	esp, ebp
	pop	ebp
	ret	0
_sys_link ENDP
_TEXT	ENDS
END
