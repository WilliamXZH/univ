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

; 276  : 		cmp ecx, current/* 任务n 是当前任务吗?(current ==task[n]?) */ 

	cmp	ecx, DWORD PTR _current

; 277  : 		je l1 /* 是，则什么都不做，退出。*/ 

	je	SHORT $l1$499

; 278  : 		xchg ecx,current/* current = task[n]； */

	xchg	ecx, DWORD PTR _current

; 279  : 		/*执行长跳转，造成任务切换 (头大了很长时间，多多包涵)*/
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

; 289  : // 在任务切换回来后才会继续执行下面的语句。
; 290  : 		cmp last_task_used_math,ecx /* 新任务上次使用过协处理器吗？*/

	cmp	DWORD PTR _last_task_used_math, ecx

; 291  : 		jne l1

	jne	SHORT $l1$499

; 292  : 		clts/* 新任务上次使用过协处理器，则清cr0 的TS 标志。*/

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

; 325  : 	_asm mov word ptr [ebx+2],dx // 基址base 低16 位(位15-0)->[addr+2]。

	mov	WORD PTR [ebx+2], dx

; 326  : 	_asm ror edx,16 // edx 中基址高16 位(位31-16) -> dx。 

	ror	edx, 16					; 00000010H

; 327  : 	_asm mov byte ptr [ebx+4],dl // 基址高16 位中的低8 位(位23-16)->[addr+4]。

	mov	BYTE PTR [ebx+4], dl

; 328  : 	_asm mov byte ptr [ebx+7],dh // 基址高16 位中的高8 位(位31-24)->[addr+7]。

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

; 345  : 	_asm mov word ptr [ebx],dx // 段长limit 低16 位(位15-0)->[addr]。

	mov	WORD PTR [ebx], dx

; 346  : 	_asm ror edx,16 // edx 中的段长高4 位(位19-16)->dl。

	ror	edx, 16					; 00000010H

; 347  : 	_asm mov dh,byte ptr [ebx+6] // 取原[addr+6]字节->dh，其中高4 位是些标志。

	mov	dh, BYTE PTR [ebx+6]

; 348  : 	_asm and dh,0f0h // 清dh 的低4 位(将存放段长的位19-16)。

	and	dh, -16					; fffffff0H

; 349  : 	_asm or dl,dh // 将原高4 位标志和段长的高4 位(位19-16)合成1 字节，

	or	dl, dh

; 350  : 	_asm mov byte ptr [ebx+6],dl // 并放回[addr+6]处。

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

; 378  : 		_asm mov ah,byte ptr [ebx+7] // 取[addr+7]处基址高16 位的高8 位(位31-24)->dh。

	mov	ah, BYTE PTR [ebx+7]

; 379  : 		_asm mov al,byte ptr [ebx+4] // 取[addr+4]处基址高16 位的低8 位(位23-16)->dl。

	mov	al, BYTE PTR [ebx+4]

; 380  : 		_asm shl eax,16 // 基地址高16 位移到edx 中高16 位处。

	shl	eax, 16					; 00000010H

; 381  : 		_asm mov ax,word ptr [ebx+2] // 取[addr+2]处基址低16 位(位15-0)->dx。

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

; 38   : 		cld		// 清方向位。

	cld
$l1$598:

; 39   : 	l1:	lodsb	// 加载DS:[esi]处1 字节->al，并更新esi。

	lodsb

; 40   : 		stosb		// 存储字节al->ES:[edi]，并更新edi。

	stosb

; 41   : 		test al,al	// 刚存储的字节是0？

	test	al, al

; 42   : 		jne l1	// 不是则跳转到标号l1 处，否则结束。

	jne	SHORT $l1$598

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
$l1$615:

; 115  : 	l1: lodsb	// 取源字符串字节ds:[esi]->al，并esi++。

	lodsb

; 116  : 		stosb		// 将该字节存到es:[edi]，并edi++。

	stosb

; 117  : 		test al,al	// 该字节是0？

	test	al, al

; 118  : 		jne l1	// 不是，则向后跳转到标号1 处继续拷贝，否则结束。

	jne	SHORT $l1$615

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
; 411  : // 首先查找指定路径的最顶层目录的目录名及其i 节点，若不存在，则返回NULL，退出。
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
; 414  : // 如果返回的最顶层名字的长度是0，则表示该路径名以一个目录名为最后一项。
; 415  : 	if (!namelen)			/* 对应于'/usr/'等情况 */

	mov	ecx, DWORD PTR _namelen$[ebp]
	test	ecx, ecx

; 416  : 		return dir;

	je	$L979

; 417  : // 在返回的顶层目录中寻找指定文件名的目录项的i 节点。因为如果最后也是一个目录名，但其后没
; 418  : // 有加'/'，则不会返回该最后目录的i 节点！比如：/var/log/httpd，将只返回log/目录的i 节点。
; 419  : // 因此dir_namei()将不以'/'结束的最后一个名字当作一个文件名来看待。因此这里需要单独对这种
; 420  : // 情况使用寻找目录项i 节点函数find_entry()进行处理。
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
; 426  : // 取该目录项的i 节点号和目录的设备号，并释放包含该目录项的高速缓冲区以及目录i 节点。
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

; 431  : // 取对应节号的i 节点，修改其被访问时间为当前时间，并置已修改标志。最后返回该i 节点指针。
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
; 134  : // 如果定义了NO_TRUNCATE，则若文件名长度超过最大长度NAME_LEN，则返回。
; 135  : #ifdef NO_TRUNCATE
; 136  : 	if (namelen > NAME_LEN)
; 137  : 		return NULL;
; 138  : //如果没有定义NO_TRUNCATE，则若文件名长度超过最大长度NAME_LEN，则截短之。
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
; 143  : // 计算本目录中目录项项数entries。置空返回目录项结构指针。
; 144  : 	entries = (*dir)->i_size / (sizeof (struct dir_entry));

	mov	edi, DWORD PTR _dir$[ebp]

; 145  : 	*res_dir = NULL;

	mov	edx, DWORD PTR _res_dir$[ebp]
	mov	eax, DWORD PTR [edi]
	mov	DWORD PTR [edx], 0
	mov	eax, DWORD PTR [eax+4]
	shr	eax, 4

; 146  : // 如果文件名长度等于0，则返回NULL，退出。
; 147  : 	if (!namelen)

	test	ecx, ecx
	mov	DWORD PTR _entries$[ebp], eax

; 148  : 		return NULL;

	je	$L1231

; 149  : /* 检查目录项'..'，因为可能需要对其特别处理 */
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

; 149  : /* 检查目录项'..'，因为可能需要对其特别处理 */
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

; 149  : /* 检查目录项'..'，因为可能需要对其特别处理 */
; 150  : 	if (namelen==2 && get_fs_byte(name)=='.' && get_fs_byte(name+1)=='.') {

	cmp	al, 46					; 0000002eH
	jne	SHORT $L877

; 151  : /* 伪根中的'..'如同一个假'.'(只需改变名字长度) */
; 152  : // 如果当前进程的根节点指针即是指定的目录，则将文件名修改为'.'，
; 153  : 		if ((*dir) == current->root)

	mov	ecx, DWORD PTR _current
	mov	eax, DWORD PTR [edi]
	cmp	eax, DWORD PTR [ecx+628]
	jne	SHORT $L874

; 154  : 			namelen=1;

	mov	DWORD PTR _namelen$[ebp], 1

; 155  : // 否则如果该目录的i 节点号等于ROOT_INO(1)的话，说明是文件系统根节点。则取文件系统的超级块。
; 156  : 		else if ((*dir)->i_num == ROOT_INO) {

	jmp	SHORT $L877
$L874:
	cmp	WORD PTR [eax+46], 1
	jne	SHORT $L877

; 157  : /* 在一个安装点上的'..'将导致目录交换到安装到文件系统的目录i 节点。
; 158  :    注意！由于设置了mounted 标志，因而我们能够取出该新目录 */
; 159  : 			sb=get_super((*dir)->i_dev);

	xor	edx, edx
	mov	dx, WORD PTR [eax+44]
	push	edx
	call	_get_super

; 160  : // 如果被安装到的i 节点存在，则先释放原i 节点，然后对被安装到的i 节点进行处理。
; 161  : // 让*dir 指向该被安装到的i 节点；该i 节点的引用数加1。
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
; 169  : // 如果该i 节点所指向的第一个直接磁盘块号为0，则返回NULL，退出。
; 170  : 	if (!(block = (*dir)->i_zone[0]))

	mov	ecx, DWORD PTR [edi]
	xor	eax, eax
	mov	DWORD PTR 8+[ebp], ecx
	mov	ax, WORD PTR [ecx+14]
	test	eax, eax

; 171  : 		return NULL;

	je	$L1231

; 172  : // 从节点所在设备读取指定的目录项数据块，如果不成功，则返回NULL，退出。
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

; 175  : // 在目录项数据块中搜索匹配指定文件名的目录项，首先让de 指向数据块，并在不超过目录中目录项数
; 176  : // 的条件下，循环执行搜索。
; 177  : 	i = 0;
; 178  : 	de = (struct dir_entry *) bh->b_data;
; 179  : 	while (i < entries) {

	mov	eax, DWORD PTR _entries$[ebp]
	mov	ebx, DWORD PTR [esi]
	xor	edi, edi
	test	eax, eax
	jle	$L883
$L882:

; 180  : // 如果当前目录项数据块已经搜索完，还没有找到匹配的目录项，则释放当前目录项数据块。
; 181  : 		if ((char *)de >= BLOCK_SIZE+bh->b_data) {

	mov	eax, DWORD PTR [esi]
	add	eax, 1024				; 00000400H
	cmp	ebx, eax
	jb	SHORT $L885

; 182  : 			brelse(bh);

	push	esi
	call	_brelse

; 183  : 			bh = NULL;
; 184  : // 在读入下一目录项数据块。若这块为空，则只要还没有搜索完目录中的所有目录项，就跳过该块，
; 185  : // 继续读下一目录项数据块。若该块不空，就让de 指向该目录项数据块，继续搜索。
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
; 193  : // 如果找到匹配的目录项的话，则返回该目录项结构指针和该目录项数据块指针，退出。
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
; 198  : // 否则继续在目录项数据块中比较下一个目录项。
; 199  : 		de++;

	add	ebx, 16					; 00000010H

; 200  : 		i++;

	inc	edi
$L1229:
	cmp	edi, DWORD PTR _entries$[ebp]
	jl	SHORT $L882

; 201  : 	}
; 202  : // 若指定目录中的所有目录项都搜索完还没有找到相应的目录项，则释放目录项数据块，返回NULL。
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
; 202  : // 若指定目录中的所有目录项都搜索完还没有找到相应的目录项，则释放目录项数据块，返回NULL。
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
; 79   : // 如果目录项指针空，或者目录项i 节点等于0，或者要比较的字符串长度超过文件名长度，则返回0。
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
; 82   : // 如果要比较的长度len 小于NAME_LEN，但是目录项中文件名长度超过len，则返回0。
; 83   : 	if (len < NAME_LEN && de->name[len])

	jge	SHORT $L853
	mov	dl, BYTE PTR [eax+ecx+2]
	test	dl, dl

; 84   : 		return 0;

	jne	SHORT $L852
$L853:

; 85   : // 下面嵌入汇编语句，在用户数据空间(fs)执行字符串的比较操作。
; 86   : // %0 - eax(比较结果same)；%1 - eax(eax 初值0)；%2 - esi(名字指针)；%3 - edi(目录项名指针)；
; 87   : // %4 - ecx(比较的字节长度值len)。
; 88   : /*	__asm__("cld\n\t"				// 清方向位。
; 89   : 		"fs ; repe ; cmpsb\n\t"		// 用户空间执行循环比较[esi++]和[edi++]操作，
; 90   : 		"setz %%al"					// 若比较结果一样(z=0)则设置al=1(same=eax)。
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

; 101  : 		cld		// 清方向位。

	cld

; 102  : 		// 用户空间执行循环比较[esi++]和[edi++]操作，
; 103  : 		repe cmps byte ptr fs:[edi],[esi]

	rep	 cmps	 BYTE PTR fs:[edi], BYTE PTR [esi]

; 104  : 		//上语句应该是错误的，但我不知道怎么改。还好系统可以运行:)
; 105  : 		setz al			// 若比较结果一样(z=0)则设置al=1(same=eax)。

	sete	al

; 106  : 		mov same,eax

	mov	DWORD PTR _same$[ebp], eax

; 107  : 		popf

	popf

; 108  : 	}
; 109  : 	return same;			// 返回比较结果。

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
; 383  : // 对路径名pathname 进行搜索检测，查处最后一个'/'后面的名字字符串，计算其长度，并返回最顶
; 384  : // 层目录的i 节点指针。
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

; 380  : // 取指定路径名最顶层目录的i 节点，若出错则返回NULL，退出。

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
; 315  : // 如果进程没有设定根i 节点，或者该进程根i 节点的引用为0，则系统出错，死机。
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

; 318  : // 如果进程的当前工作目录指针为空，或者该当前目录i 节点的引用计数为0，也是系统有问题，死机。
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

; 321  : // 如果用户指定的路径名的第1 个字符是'/'，则说明路径名是绝对路径名。则从根i 节点开始操作。
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

; 325  : // 否则若第一个字符是其它字符，则表示给定的是相对路径名。应从进程的当前工作目录开始操作。
; 326  : // 则取进程当前工作目录的i 节点。
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

; 329  : // 否则表示路径名为空，出错。返回NULL，退出。
; 330  : 	else
; 331  : 		return NULL;	/* 空的路径名是错误的 */
; 332  : // 将取得的i 节点引用计数增1。
; 333  : 	inode->i_count++;

	inc	WORD PTR [eax+48]
	mov	eax, DWORD PTR _inode$[ebp]
$L951:

; 335  : // 若该i 节点不是目录节点，或者没有可进入的访问许可，则释放该i 节点，返回NULL，退出。
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
; 341  : // 从路径名开始起搜索检测字符，直到字符已是结尾符(NULL)或者是'/'，此时namelen 正好是当前处理
; 342  : // 目录名的长度。如果最后也是一个目录名，但其后没有加'/'，则不会返回该最后目录的i 节点！
; 343  : // 比如：/var/log/httpd，将只返回log/目录的i 节点。
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
; 341  : // 从路径名开始起搜索检测字符，直到字符已是结尾符(NULL)或者是'/'，此时namelen 正好是当前处理
; 342  : // 目录名的长度。如果最后也是一个目录名，但其后没有加'/'，则不会返回该最后目录的i 节点！
; 343  : // 比如：/var/log/httpd，将只返回log/目录的i 节点。
; 344  : 		for(namelen=0;(c=get_fs_byte(pathname++))&&(c!='/');namelen++)

	test	al, al
	je	SHORT $L1254
	cmp	al, 47					; 0000002fH
	je	SHORT $L957
	inc	ecx
	jmp	SHORT $L955
$L957:

; 349  : // 调用查找指定目录和文件名的目录项函数，在当前处理目录中寻找子目录项。如果没有找到，
; 350  : // 则释放该i 节点，并返回NULL，退出。
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
; 355  : // 取该子目录项的i 节点号inr 和设备号idev，释放包含该目录项的高速缓冲块和该i 节点。
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

; 360  : // 取节点号inr 的i 节点信息，若失败，则返回NULL，退出。否则继续以该子目录的i 节点进行操作。
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
; 346  : // 若字符是结尾符NULL，则表明已经到达指定目录，则返回该i 节点指针，退出。
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

; 47   : 	int mode = inode->i_mode;// 文件访问属性

	mov	ecx, DWORD PTR _inode$[ebp]
	xor	eax, eax
	push	esi

; 48   : 
; 49   : /* 特殊情况：即使是超级用户(root)也不能读/写一个已被删除的文件 */
; 50   : // 如果i 节点有对应的设备，但该i 节点的连接数等于0，则返回。
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

; 53   : // 否则，如果进程的有效用户id(euid)与i 节点的用户id 相同，则取文件宿主的用户访问权限。
; 54   : 	else if (current->euid==inode->i_uid)

	mov	edx, DWORD PTR _current
	mov	si, WORD PTR [edx+578]
	cmp	si, WORD PTR [ecx+2]
	jne	SHORT $L836

; 55   : 		mode >>= 6;

	sar	eax, 6

; 56   : // 否则，如果进程的有效组id(egid)与i 节点的组id 相同，则取组用户的访问权限。
; 57   : 	else if (current->egid==inode->i_gid)

	jmp	SHORT $L838
$L836:
	movzx	cx, BYTE PTR [ecx+12]
	cmp	WORD PTR [edx+584], cx
	jne	SHORT $L838

; 58   : 		mode >>= 3;

	sar	eax, 3
$L838:

; 59   : // 如果上面所取的的访问权限与屏蔽码相同，或者是超级用户，则返回1，否则返回0。
; 60   : 	if (((mode & mask & 0007) == mask) || suser()) // suser()在linux/kernel.h。

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
$l1$632:

; 201  :   l1: lodsb	// 取字符串2 的字节ds:[esi]??al，并且esi++。

	lodsb

; 202  : 	  scasb		// al 与字符串1 的字节es:[edi]作比较，并且edi++。

	scasb

; 203  : 	  jne l2		// 如果不相等，则向前跳转到标号2。

	jne	SHORT $l2$633

; 204  : 	  test al,al	// 该字节是0 值字节吗（字符串结尾）？

	test	al, al

; 205  : 	  jne l1		// 不是，则向后跳转到标号1，继续比较。

	jne	SHORT $l1$632

; 206  : 	  xor eax,eax	// 是，则返回值eax 清零，

	xor	eax, eax

; 207  : 	  jmp l3		// 向前跳转到标号3，结束。

	jmp	SHORT $l3$634
$l2$633:

; 208  :   l2: mov eax,1	// eax 中置1。

	mov	eax, 1

; 209  : 	  jl l3		// 若前面比较中串2 字符<串1 字符，则返回正值，结束。

	jl	SHORT $l3$634

; 210  : 	  neg eax	// 否则eax = -eax，返回负值，结束。

	neg	eax
$l3$634:

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
; 457  : // 如果文件访问许可模式标志是只读(0)，但文件截0 标志O_TRUNC 却置位了，则改为只写标志。
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

; 460  : // 使用进程的文件访问许可屏蔽码，屏蔽掉给定模式中的相应位，并添上普通文件标志。
; 461  : 	mode &= 0777 & ~current->umask;
; 462  : 	mode |= I_REGULAR;

	mov	eax, DWORD PTR _current
	mov	ecx, DWORD PTR _mode$[ebp]

; 463  : // 根据路径名寻找到对应的i 节点，以及最顶端文件名及其长度。
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

; 466  : // 如果最顶端文件名长度为0(例如'/usr/'这种路径名的情况)，那么若打开操作不是创建、截0，
; 467  : // 则表示打开一个目录名，直接返回该目录的i 节点，并退出。
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
; 473  : // 否则释放该i 节点，返回出错码。
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
; 477  : // 在dir 节点对应的目录中取文件名对应的目录项结构de 和该目录项所在的高速缓冲区。
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

; 479  : // 如果该高速缓冲指针为NULL，则表示没有找到对应文件名的目录项，因此只可能是创建文件操作。
; 480  : 	if (!bh) {

	test	eax, eax
	jne	$L1012

; 481  : // 如果不是创建文件，则释放该目录的i 节点，返回出错号退出。
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
; 486  : // 如果用户在该目录没有写的权力，则释放该目录的i 节点，返回出错号退出。
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
; 491  : // 在目录节点对应的设备上申请一个新i 节点，若失败，则释放目录的i 节点，并返回没有空间出错码。
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
; 497  : // 否则使用该新i 节点，对其进行初始设置：置节点的用户id；对应节点访问模式；置已修改标志。
; 498  : 		inode->i_uid = current->euid;

	mov	edx, DWORD PTR _current

; 499  : 		inode->i_mode = mode;

	mov	WORD PTR [esi], di

; 500  : 		inode->i_dirt = 1;

	mov	BYTE PTR [esi+51], 1

; 501  : // 然后在指定目录dir 中添加一新目录项。
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

; 503  : // 如果返回的应该含有新目录项的高速缓冲区指针为NULL，则表示添加目录项操作失败。于是将该
; 504  : // 新i 节点的引用连接计数减1；并释放该i 节点与目录的i 节点，返回出错码，退出。
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
; 511  : // 初始设置该新目录项：置i 节点号为新申请到的i 节点的号码；并置高速缓冲区已修改标志。然后
; 512  : // 释放该高速缓冲区，释放目录的i 节点。返回新目录项的i 节点指针，退出。
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

; 544  : // 最后返回该目录项i 节点的指针，并返回0（成功）。
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
; 520  : // 若上面在目录中取文件名对应的目录项结构操作成功(也即bh 不为NULL)，取出该目录项的i 节点号
; 521  : // 和其所在的设备号，并释放该高速缓冲区以及目录的i 节点。
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

; 526  : // 如果独占使用标志O_EXCL 置位，则返回文件已存在出错码，退出。
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

; 529  : // 如果取该目录项对应i 节点的操作失败，则返回访问出错码，退出。
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

; 532  : // 若该i 节点是一个目录的节点并且访问模式是只读或只写，或者没有访问的许可权限，则释放该i
; 533  : // 节点，返回访问权限出错码，退出。
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
; 539  : // 更新该i 节点的访问时间字段为当前时间。
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

; 541  : // 如果设立了截0 标志，则将该i 节点的文件长度截为0。
; 542  : 	if (flag & O_TRUNC)

	test	bh, 2
	mov	DWORD PTR [esi+36], edx
	je	SHORT $L1023

; 543  : 		truncate(inode);

	push	esi
	call	_truncate
	add	esp, 4
$L1023:

; 544  : // 最后返回该目录项i 节点的指针，并返回0（成功）。
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

; 228  : // 如果定义了NO_TRUNCATE，则若文件名长度超过最大长度NAME_LEN，则返回。
; 229  : #ifdef NO_TRUNCATE
; 230  : 	if (namelen > NAME_LEN)
; 231  : 		return NULL;
; 232  : //如果没有定义NO_TRUNCATE，则若文件名长度超过最大长度NAME_LEN，则截短之。
; 233  : #else
; 234  : 	if (namelen > NAME_LEN)

	mov	eax, DWORD PTR _namelen$[ebp]
	cmp	eax, 14					; 0000000eH
	push	edi
	jle	SHORT $L906

; 235  : 		namelen = NAME_LEN;

	mov	DWORD PTR _namelen$[ebp], 14		; 0000000eH
$L907:

; 240  : // 如果该目录i 节点所指向的第一个直接磁盘块号为0，则返回NULL 退出。
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
; 292  : // 执行不到这里。也许Linus 在写这段代码时是先复制了上面find_entry()的代码，而后修改的:)
; 293  : 	brelse(bh);
; 294  : 	return NULL;
; 295  : }

	mov	esp, ebp
	pop	ebp
	ret	0
$L906:

; 236  : #endif
; 237  : // 如果文件名长度等于0，则返回NULL，退出。
; 238  : 	if (!namelen)

	cmp	eax, ebx
	jne	SHORT $L907
	pop	edi
	pop	esi

; 239  : 		return NULL;

	xor	eax, eax
	pop	ebx

; 291  : 	}
; 292  : // 执行不到这里。也许Linus 在写这段代码时是先复制了上面find_entry()的代码，而后修改的:)
; 293  : 	brelse(bh);
; 294  : 	return NULL;
; 295  : }

	mov	esp, ebp
	pop	ebp
	ret	0
$L908:

; 243  : // 如果读取该磁盘块失败，则返回NULL 并退出。
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
; 292  : // 执行不到这里。也许Linus 在写这段代码时是先复制了上面find_entry()的代码，而后修改的:)
; 293  : 	brelse(bh);
; 294  : 	return NULL;
; 295  : }

	mov	esp, ebp
	pop	ebp
	ret	0
$L909:

; 246  : // 在目录项数据块中循环查找最后未使用的目录项。首先让目录项结构指针de 指向高速缓冲的数据块
; 247  : // 开始处，也即第一个目录项。
; 248  : 	i = 0;
; 249  : 	de = (struct dir_entry *) bh->b_data;

	mov	edi, DWORD PTR [eax]
	mov	DWORD PTR _i$[ebp], ebx
	mov	DWORD PTR -4+[ebp], ebx
	mov	ebx, 16					; 00000010H
$L912:

; 250  : 	while (1) {
; 251  : // 如果当前判别的目录项已经超出当前数据块，则释放该数据块，重新申请一块磁盘块block。如果
; 252  : // 申请失败，则返回NULL，退出。
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
; 259  : // 如果读取磁盘块返回的指针为空，则跳过该块继续。
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
; 264  : // 否则，让目录项结构指针de 志向该块的高速缓冲数据块开始处。
; 265  : 			de = (struct dir_entry *) bh->b_data;

	mov	edi, DWORD PTR [eax]
$L915:

; 266  : 		}
; 267  : // 如果当前所操作的目录项序号i*目录结构大小已经超过了该目录所指出的大小i_size，则说明该第i
; 268  : // 个目录项还未使用，我们可以使用它。于是对该目录项进行设置(置该目录项的i 节点指针为空)。并
; 269  : // 更新该目录的长度值(加上一个目录项的长度，设置目录的i 节点已修改标志，再更新该目录的改变时
; 270  : // 间为当前时间。
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
; 277  : // 若该目录项的i 节点为空，则表示找到一个还未使用的目录项。于是更新目录的修改时间为当前时间。
; 278  : // 并从用户数据区复制文件名到该目录项的文件名字段，置相应的高速缓冲块已修改标志。返回该目录
; 279  : // 项的指针以及该高速缓冲区的指针，退出。
; 280  : 		if (!de->inode) {

	cmp	WORD PTR [edi], 0
	je	SHORT $L1274

; 286  : 			return bh;
; 287  : 		}
; 288  : // 如果该目录项已经被使用，则继续检测下一个目录项。
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
; 292  : // 执行不到这里。也许Linus 在写这段代码时是先复制了上面find_entry()的代码，而后修改的:)
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
$l1$670:

; 396  :   l1: lodsb	// 取串1 字符ds:[esi]->al，并且esi++。

	lodsb

; 397  : 	  test al,al	// 该字符等于0 值吗（串1 结尾）？

	test	al, al

; 398  : 	  je l2		// 如果是，则向前跳转到标号2 处。

	je	SHORT $l2$671

; 399  : 	  mov edi,ebx	// 取串2 头指针放入edi 中。

	mov	edi, ebx

; 400  : 	  mov ecx,edx	// 再将串2 的长度值放入ecx 中。

	mov	ecx, edx

; 401  : 	  repne scasb	// 比较al 与串2 中字符es:[edi]，并且edi++。如果不相等就继续比较。

	repnz	 scasb

; 402  : 	  je l1		// 如果相等，则向后跳转到标号1 处。

	je	SHORT $l1$670
$l2$671:

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
$l1$679:

; 454  : 	l1: lodsb	// 取串1 字符ds:[esi]->al，并且esi++。

	lodsb

; 455  : 		test al,al	// 该字符等于0 值吗（串1 结尾）？

	test	al, al

; 456  : 		je l2		// 如果是，则向前跳转到标号2 处。

	je	SHORT $l2$680

; 457  : 		mov edi,ebx	// 取串2 头指针放入edi 中。

	mov	edi, ebx

; 458  : 		mov ecx,edx 	// 再将串2 的长度值放入ecx 中。

	mov	ecx, edx

; 459  : 		repne scasb	// 比较al 与串2 中字符es:[edi]，并且edi++。如果不相等就继续比较。

	repnz	 scasb

; 460  : 		jne l1		// 如果不相等，则向后跳转到标号1 处。

	jne	SHORT $l1$679
$l2$680:

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
; 561  : // 如果不是超级用户，则返回访问许可出错码。
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

; 564  : // 如果找不到对应路径名目录的i 节点，则返回出错码。
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

; 567  : // 如果最顶端的文件名长度为0，则说明给出的路径名最后没有指定文件名，释放该目录i 节点，返回
; 568  : // 出错码，退出。
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
; 573  : // 如果在该目录中没有写的权限，则释放该目录的i 节点，返回访问许可出错码，退出。
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
; 578  : // 如果对应路径名上最后的文件名的目录项已经存在，则释放包含该目录项的高速缓冲区，释放目录
; 579  : // 的i 节点，返回文件已经存在出错码，退出。
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
; 586  : // 申请一个新的i 节点，如果不成功，则释放目录的i 节点，返回无空间出错码，退出。
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
; 592  : // 设置该i 节点的属性模式。如果要创建的是块设备文件或者是字符设备文件，则令i 节点的直接块
; 593  : // 指针0 等于设备号。
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

; 597  : // 设置该i 节点的修改时间、访问时间为当前时间。
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

; 600  : // 在目录中新添加一个目录项，如果失败(包含该目录项的高速缓冲区指针为NULL)，则释放目录的
; 601  : // i 节点；所申请的i 节点引用连接计数复位，并释放该i 节点。返回出错码，退出。
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
; 609  : // 令该目录项的i 节点字段等于新i 节点号，置高速缓冲区已修改标志，释放目录和新的i 节点，
; 610  : // 释放高速缓冲区，最后返回0(成功)。
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
$l1$687:

; 512  : 	l1: lodsb	// 取串1 字符ds:[esi]??al，并且esi++。

	lodsb

; 513  : 		test al,al	// 该字符等于0 值吗（串1 结尾）？

	test	al, al

; 514  : 		je l2		// 如果是，则向前跳转到标号2 处。

	je	SHORT $l2$688

; 515  : 		mov edi,ebx	// 取串2 头指针放入edi 中。

	mov	edi, ebx

; 516  : 		mov ecx,edx	// 再将串2 的长度值放入ecx 中。

	mov	ecx, edx

; 517  : 		repne scasb		// 比较al 与串2 中字符es:[edi]，并且edi++。如果不相等就继续比较。

	repnz	 scasb

; 518  : 		jne l1	// 如果不相等，则向后跳转到标号1 处。

	jne	SHORT $l1$687

; 519  : 		dec esi	// esi--，指向一个包含在串2 中的字符。

	dec	esi

; 520  : 		jmp l3		// 向前跳转到标号3 处。

	jmp	SHORT $l3$689
$l2$688:

; 521  : 	l2: xor esi,esi	// 没有找到符合条件的，将返回值为NULL。

	xor	esi, esi
$l3$689:

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
$l1$696:

; 576  : 	l1: mov edi,ebx	// 取串2 头指针放入edi 中。

	mov	edi, ebx

; 577  : 		mov ecx,edx	// 再将串2 的长度值放入ecx 中。

	mov	ecx, edx

; 578  : 		mov eax,esi	// 将串1 的指针复制到eax 中。

	mov	eax, esi

; 579  : 		repe cmpsb// 比较串1 和串2 字符(ds:[esi],es:[edi])，esi++,edi++。若对应字符相等就一直比较下去。

	rep	 cmpsb

; 580  : 		je l2

	je	SHORT $l2$697

; 581  : // 对空串同样有效，见上面 // 若全相等，则转到标号2。
; 582  : 		xchg esi,eax	// 串1 头指针->esi，比较结果的串1 指针->eax。

	xchg	esi, eax

; 583  : 		inc esi	// 串1 头指针指向下一个字符。

	inc	esi

; 584  : 		cmp [eax-1],0	// 串1 指针(eax-1)所指字节是0 吗？

	cmp	BYTE PTR [eax-1], 0

; 585  : 		jne l1	// 不是则跳转到标号1，继续从串1 的第2 个字符开始比较。

	jne	SHORT $l1$696

; 586  : 		xor eax,eax	// 清eax，表示没有找到匹配。

	xor	eax, eax
$l2$697:

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

; 636  : // 如果最顶端的文件名长度为0，则说明给出的路径名最后没有指定文件名，释放该目录i 节点，返回
; 637  : // 出错码，退出。
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
; 642  : // 如果在该目录中没有写的权限，则释放该目录的i 节点，返回访问许可出错码，退出。
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
; 647  : // 如果对应路径名上最后的文件名的目录项已经存在，则释放包含该目录项的高速缓冲区，释放目录
; 648  : // 的i 节点，返回文件已经存在出错码，退出。
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
; 655  : // 申请一个新的i 节点，如果不成功，则释放目录的i 节点，返回无空间出错码，退出。
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
; 661  : // 置该新i 节点对应的文件长度为32(一个目录项的大小)，置节点已修改标志，以及节点的修改时间
; 662  : // 和访问时间。
; 663  : 	inode->i_size = 32;

	mov	DWORD PTR [ebx+4], 32			; 00000020H

; 664  : 	inode->i_dirt = 1;

	mov	BYTE PTR [ebx+51], 1

; 665  : 	inode->i_mtime = inode->i_atime = CURRENT_TIME;

	mov	ecx, DWORD PTR _jiffies
	mov	eax, 1374389535				; 51eb851fH
	imul	ecx
	mov	eax, DWORD PTR _startup_time

; 666  : // 为该i 节点申请一磁盘块，并令节点第一个直接块指针等于该块号。如果申请失败，则释放对应目录
; 667  : // 的i 节点；复位新申请的i 节点连接计数；释放该新的i 节点，返回没有空间出错码，退出。
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
; 674  : // 置该新的i 节点已修改标志。
; 675  : 	inode->i_dirt = 1;
; 676  : // 读新申请的磁盘块。若出错，则释放对应目录的i 节点；释放申请的磁盘块；复位新申请的i 节点
; 677  : // 连接计数；释放该新的i 节点，返回没有空间出错码，退出。
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
; 685  : // 令de 指向目录项数据块，置该目录项的i 节点号字段等于新申请的i 节点号，名字字段等于"."。
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

; 630  : // 如果不是超级用户，则返回访问许可出错码。

	stosb

; 631  : 	if (!suser())

	test	al, al

; 632  : 		return -EPERM;

	jne	SHORT $l1$1289

; 633  : // 如果找不到对应路径名目录的i 节点，则返回出错码。

	popf

; 689  : // 然后de 指向下一个目录项结构，该结构用于存放上级目录的节点号和名字".."。
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

; 630  : // 如果不是超级用户，则返回访问许可出错码。

	stosb

; 631  : 	if (!suser())

	test	al, al

; 632  : 		return -EPERM;

	jne	SHORT $l1$1294

; 633  : // 如果找不到对应路径名目录的i 节点，则返回出错码。

	popf

; 693  : 	inode->i_nlinks = 2;
; 694  : // 然后设置该高速缓冲区已修改标志，并释放该缓冲区。
; 695  : 	dir_block->b_dirt = 1;
; 696  : 	brelse(dir_block);

	push	ecx
	mov	BYTE PTR [ebx+13], 2
	mov	BYTE PTR [ecx+11], 1
	call	_brelse

; 697  : // 初始化设置新i 节点的模式字段，并置该i 节点已修改标志。
; 698  : 	inode->i_mode = I_DIRECTORY | (mode & 0777 & ~current->umask);

	mov	ecx, DWORD PTR _current
	mov	eax, DWORD PTR _mode$[ebp]

; 699  : 	inode->i_dirt = 1;

	mov	BYTE PTR [ebx+51], 1
	mov	dx, WORD PTR [ecx+620]
	not	dx
	and	edx, eax

; 700  : // 在目录中新添加一个目录项，如果失败(包含该目录项的高速缓冲区指针为NULL)，则释放目录的
; 701  : // i 节点；所申请的i 节点引用连接计数复位，并释放该i 节点。返回出错码，退出。
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
; 710  : // 令该目录项的i 节点字段等于新i 节点号，置高速缓冲区已修改标志，释放目录和新的i 节点，释放
; 711  : // 高速缓冲区，最后返回0(成功)。
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

; 676  : 		test esi,esi	// 首先测试esi(字符串1 指针s)是否是NULL。

	test	esi, esi

; 677  : 		jne l1		// 如果不是，则表明是首次调用本函数，跳转标号1。

	jne	SHORT $l1$709

; 678  : 		mov ebx,strtok

	mov	ebx, DWORD PTR _strtok

; 679  : 		test ebx,ebx	// 如果是NULL，则表示此次是后续调用，测ebx(__strtok)。

	test	ebx, ebx

; 680  : 		je l8		// 如果ebx 指针是NULL，则不能处理，跳转结束。

	je	SHORT $l8$710

; 681  : 		mov esi,ebx	// 将ebx 指针复制到esi。

	mov	esi, ebx
$l1$709:

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

	je	SHORT $l7$711

; 691  : 		mov edx,ecx	// 将串2 长度暂存入edx。

	mov	edx, ecx
$l2$712:

; 692  : 	l2: lodsb	// 取串1 的字符ds:[esi]->al，并且esi++。

	lodsb

; 693  : 		test al,al	// 该字符为0 值吗(串1 结束)？

	test	al, al

; 694  : 		je l7		// 如果是，则跳转标号7。

	je	SHORT $l7$711

; 695  : 		mov edi,ct	// edi 再次指向串2 首。

	mov	edi, DWORD PTR _ct$[ebp]

; 696  : 		mov ecx,edx	// 取串2 的长度值置入计数器ecx。

	mov	ecx, edx

; 697  : 		repne scasb// 将al 中串1 的字符与串2 中所有字符比较，判断该字符是否为分割符。

	repnz	 scasb

; 698  : 		je l2		// 若能在串2 中找到相同字符（分割符），则跳转标号2。

	je	SHORT $l2$712

; 699  : 		dec esi	// 若不是分割符，则串1 指针esi 指向此时的该字符。

	dec	esi

; 700  : 		cmp [esi],0	// 该字符是NULL 字符吗？

	cmp	BYTE PTR [esi], 0

; 701  : 		je l7		// 若是，则跳转标号7 处。

	je	SHORT $l7$711

; 702  : 		mov ebx,esi	// 将该字符的指针esi 存放在ebx。

	mov	ebx, esi
$l3$713:

; 703  : 	l3: lodsb	// 取串1 下一个字符ds:[esi]->al，并且esi++。

	lodsb

; 704  : 		test al,al	// 该字符是NULL 字符吗？

	test	al, al

; 705  : 		je l5		// 若是，表示串1 结束，跳转到标号5。

	je	SHORT $l5$714

; 706  : 		mov edi,ct	// edi 再次指向串2 首。

	mov	edi, DWORD PTR _ct$[ebp]

; 707  : 		mov ecx,edx	// 串2 长度值置入计数器ecx。

	mov	ecx, edx

; 708  : 		repne scasb // 将al 中串1 的字符与串2 中每个字符比较，测试al 字符是否是分割符。

	repnz	 scasb

; 709  : 		jne l3		// 若不是分割符则跳转标号3，检测串1 中下一个字符。

	jne	SHORT $l3$713

; 710  : 		dec esi	// 若是分割符，则esi--，指向该分割符字符。

	dec	esi

; 711  : 		cmp [esi],0	// 该分割符是NULL 字符吗？

	cmp	BYTE PTR [esi], 0

; 712  : 		je l5		// 若是，则跳转到标号5。

	je	SHORT $l5$714

; 713  : 		mov [esi],0	// 若不是，则将该分割符用NULL 字符替换掉。

	mov	BYTE PTR [esi], 0

; 714  : 		inc esi	// esi 指向串1 中下一个字符，也即剩余串首。

	inc	esi

; 715  : 		jmp l6		// 跳转标号6 处。

	jmp	SHORT $l6$715
$l5$714:

; 716  : 	l5: xor esi,esi	// esi 清零。

	xor	esi, esi
$l6$715:

; 717  : 	l6: cmp [ebx],0	// ebx 指针指向NULL 字符吗？

	cmp	BYTE PTR [ebx], 0

; 718  : 		jne l7	// 若不是，则跳转标号7。

	jne	SHORT $l7$711

; 719  : 		xor ebx,ebx	// 若是，则让ebx=NULL。

	xor	ebx, ebx
$l7$711:

; 720  : 	l7: test ebx,ebx	// ebx 指针为NULL 吗？

	test	ebx, ebx

; 721  : 		jne l8	// 若不是则跳转8，结束汇编代码。

	jne	SHORT $l8$710

; 722  : 		mov esi,ebx	// 将esi 置为NULL。

	mov	esi, ebx
$l8$710:

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

	je	SHORT $l1$742

; 881  : 		mov eax,1	// 否则eax 置1，

	mov	eax, 1

; 882  : 		jl l1		// 若内存块2 内容的值<内存块1，则跳转标号1。

	jl	SHORT $l1$742

; 883  : 		neg eax	// 否则eax = -eax。

	neg	eax
$l1$742:

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
	jne	SHORT $L751

; 914  :     return NULL;

	xor	eax, eax

; 928  : 	}
; 929  : //  return __res;			// 返回字符指针。
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

; 920  : 		cld		// 清方向位。

	cld

; 921  : 		repne scasb// al 中字符与es:[edi]字符作比较，并且edi++，如果不相等则重复执行下面语句，

	repnz	 scasb

; 922  : 		je l1		// 如果相等则向前跳转到标号1 处。

	je	SHORT $l1$752

; 923  : 		mov edi,1	// 否则edi 中置1。

	mov	edi, 1
$l1$752:

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
; 799  : // 如果不是超级用户，则返回访问许可出错码。
; 800  : 	if (!suser())

	mov	eax, DWORD PTR _current
	push	ebx
	push	esi
	push	edi
	cmp	WORD PTR [eax+578], 0

; 801  : 		return -EPERM;

	jne	$L1303

; 802  : // 如果找不到对应路径名目录的i 节点，则返回出错码。
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

; 805  : // 如果最顶端的文件名长度为0，则说明给出的路径名最后没有指定文件名，释放该目录i 节点，返回
; 806  : // 出错码，退出。
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
; 811  : // 如果在该目录中没有写的权限，则释放该目录的i 节点，返回访问许可出错码，退出。
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
; 816  : // 如果对应路径名上最后的文件名的目录项不存在，则释放包含该目录项的高速缓冲区，释放目录
; 817  : // 的i 节点，返回文件已经存在出错码，退出。否则dir 是包含要被删除目录名的目录i 节点，de
; 818  : // 是要被删除目录的目录项结构。
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
; 824  : // 取该目录项指明的i 节点。若出错则释放目录的i 节点，并释放含有目录项的高速缓冲区，返回
; 825  : // 出错号。
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
; 831  : // 若该目录设置了受限删除标志并且进程的有效用户id 不等于该i 节点的用户id，则表示没有权限删
; 832  : // 除该目录，于是释放包含要删除目录名的目录i 节点和该要删除目录的i 节点，释放高速缓冲区，
; 833  : // 返回出错码。
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
; 841  : // 如果要被删除的目录项的i 节点的设备号不等于包含该目录项的目录的设备号，或者该被删除目录的
; 842  : // 引用连接计数大于1(表示有符号连接等)，则不能删除该目录，于是释放包含要删除目录名的目录
; 843  : // i 节点和该要删除目录的i 节点，释放高速缓冲区，返回出错码。
; 844  : 	if (inode->i_dev != dir->i_dev || inode->i_count>1) {

	mov	dx, WORD PTR [esi+44]
	cmp	dx, WORD PTR [eax+44]
	jne	$L1121
	mov	ebx, 1
	cmp	WORD PTR [esi+48], bx
	ja	$L1121

; 849  : 	}
; 850  : // 如果要被删除目录的目录项i 节点的节点号等于包含该需删除目录的i 节点号，则表示试图删除"."
; 851  : // 目录。于是释放包含要删除目录名的目录i 节点和该要删除目录的i 节点，释放高速缓冲区，返回
; 852  : // 出错码。
; 853  : 	if (inode == dir) {	/* 我们不可以删除"."，但可以删除"../dir"*/

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
; 859  : // 若要被删除的目录的i 节点的属性表明这不是一个目录，则释放包含要删除目录名的目录i 节点和
; 860  : // 该要删除目录的i 节点，释放高速缓冲区，返回出错码。
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
; 867  : // 若该需被删除的目录不空，则释放包含要删除目录名的目录i 节点和该要删除目录的i 节点，释放
; 868  : // 高速缓冲区，返回出错码。
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
; 875  : // 若该需被删除目录的i 节点的连接数不等于2，则显示警告信息。
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

; 878  : // 置该需被删除目录的目录项的i 节点号字段为0，表示该目录项不再使用，并置含有该目录项的高速
; 879  : // 缓冲区已修改标志，并释放该缓冲区。
; 880  : 	de->inode = 0;

	mov	ecx, DWORD PTR _de$[ebp]

; 881  : 	bh->b_dirt = 1;
; 882  : 	brelse(bh);

	push	edi
	mov	BYTE PTR [edi+11], bl
	mov	WORD PTR [ecx], 0
	call	_brelse

; 883  : // 置被删除目录的i 节点的连接数为0，并置i 节点已修改标志。
; 884  : 	inode->i_nlinks=0;

	mov	BYTE PTR [esi+13], 0

; 885  : 	inode->i_dirt=1;

	mov	BYTE PTR [esi+51], bl

; 886  : // 将包含被删除目录名的目录的i 节点引用计数减1，修改其改变时间和修改时间为当前时间，并置
; 887  : // 该节点已修改标志。
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

; 891  : // 最后释放包含要删除目录名的目录i 节点和该要删除目录的i 节点，返回0(成功)。
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

; 748  : // 并返回0。
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

; 735  : // 计算指定目录中现有目录项的个数(应该起码有2 个，即"."和".."两个文件目录项)。

	cld
$l1$1309:

; 736  : 	len = inode->i_size / sizeof (struct dir_entry);

	lodsb

; 737  : // 如果目录项个数少于2 个或者该目录i 节点的第1 个直接块没有指向任何磁盘块号，或者相应磁盘

	scasb

; 738  : // 块读不出，则显示警告信息“设备dev 上目录错”，返回0(失败)。

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

; 744  : // 让de 指向含有读出磁盘块数据的高速缓冲区中第1 项目录项。

	jl	SHORT $l3$1311

; 745  : 	de = (struct dir_entry *) bh->b_data;

	neg	eax
$l3$1311:

; 746  : // 如果第1 个目录项的i 节点号字段值不等于该目录的i 节点号，或者第2 个目录项的i 节点号字段
; 747  : // 为零，或者两个目录项的名字字段不分别等于"."和".."，则显示出错警告信息“设备dev 上目录错”

	popf

; 748  : // 并返回0。
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

; 735  : // 计算指定目录中现有目录项的个数(应该起码有2 个，即"."和".."两个文件目录项)。

	cld
$l1$1317:

; 736  : 	len = inode->i_size / sizeof (struct dir_entry);

	lodsb

; 737  : // 如果目录项个数少于2 个或者该目录i 节点的第1 个直接块没有指向任何磁盘块号，或者相应磁盘

	scasb

; 738  : // 块读不出，则显示警告信息“设备dev 上目录错”，返回0(失败)。

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

; 744  : // 让de 指向含有读出磁盘块数据的高速缓冲区中第1 项目录项。

	jl	SHORT $l3$1319

; 745  : 	de = (struct dir_entry *) bh->b_data;

	neg	eax
$l3$1319:

; 746  : // 如果第1 个目录项的i 节点号字段值不等于该目录的i 节点号，或者第2 个目录项的i 节点号字段
; 747  : // 为零，或者两个目录项的名字字段不分别等于"."和".."，则显示出错警告信息“设备dev 上目录错”

	popf

; 748  : // 并返回0。
; 749  : 	if (de[0].inode != inode->i_num || !de[1].inode || 
; 750  : 	    strcmp(".",de[0].name) || strcmp("..",de[1].name)) {

	test	eax, eax
	jne	$L1326

; 752  : 		return 0;
; 753  : 	}
; 754  : // 令nr 等于目录项序号；de 指向第三个目录项。
; 755  : 	nr = 2;
; 756  : 	de += 2;
; 757  : // 循环检测该目录中所有的目录项(len-2 个)，看有没有目录项的i 节点号字段不为0(被使用)。
; 758  : 	while (nr<len) {

	mov	eax, DWORD PTR _len$[ebp]
	mov	edi, 2
	add	ecx, 32					; 00000020H
	cmp	eax, edi
	mov	DWORD PTR _de$[ebp], ecx
	jle	SHORT $L1093
$L1092:

; 759  : // 如果该块磁盘块中的目录项已经检测完，则释放该磁盘块的高速缓冲区，读取下一块含有目录项的
; 760  : // 磁盘块。若相应块没有使用(或已经不用，如文件已经删除等)，则继续读下一块，若读不出，则出
; 761  : // 错，返回0。否则让de 指向读出块的首个目录项。
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
; 773  : // 如果该目录项的i 节点号字段不等于0，则表示该目录项目前正被使用，则释放该高速缓冲区，
; 774  : // 返回0，退出。
; 775  : 		if (de->inode) {

	cmp	WORD PTR [ecx], 0
	jne	SHORT $L1324

; 777  : 			return 0;
; 778  : 		}
; 779  : // 否则，若还没有查询完该目录中的所有目录项，则继续检测。
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
; 783  : // 到这里说明该目录中没有找到已用的目录项(当然除了头两个以外)，则返回缓冲区，返回1。
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
; 754  : // 令nr 等于目录项序号；de 指向第三个目录项。
; 755  : 	nr = 2;
; 756  : 	de += 2;
; 757  : // 循环检测该目录中所有的目录项(len-2 个)，看有没有目录项的i 节点号字段不为0(被使用)。
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
; 910  : // 如果找不到对应路径名目录的i 节点，则返回出错码。
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

; 913  : // 如果最顶端的文件名长度为0，则说明给出的路径名最后没有指定文件名，释放该目录i 节点，
; 914  : // 返回出错码，退出。
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
; 919  : // 如果在该目录中没有写的权限，则释放该目录的i 节点，返回访问许可出错码，退出。
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
; 924  : // 如果对应路径名上最后的文件名的目录项不存在，则释放包含该目录项的高速缓冲区，释放目录
; 925  : // 的i 节点，返回文件已经存在出错码，退出。否则dir 是包含要被删除目录名的目录i 节点，de
; 926  : // 是要被删除目录的目录项结构。
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
; 932  : // 取该目录项指明的i 节点。若出错则释放目录的i 节点，并释放含有目录项的高速缓冲区，
; 933  : // 返回出错号。
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
; 939  : // 如果该目录设置了受限删除标志并且用户不是超级用户，并且进程的有效用户id 不等于被删除文件
; 940  : // 名i 节点的用户id，并且进程的有效用户id 也不等于目录i 节点的用户id，则没有权限删除该文件
; 941  : // 名。则释放该目录i 节点和该文件名目录项的i 节点，释放包含该目录项的缓冲区，返回出错号。
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
; 950  : // 如果该指定文件名是一个目录，则也不能删除，释放该目录i 节点和该文件名目录项的i 节点，
; 951  : // 释放包含该目录项的缓冲区，返回出错号。
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
; 958  : // 如果该i 节点的连接数已经为0，则显示警告信息，修正其为1。
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
; 964  : // 将该文件名的目录项中的i 节点号字段置为0，表示释放该目录项，并设置包含该目录项的缓冲区
; 965  : // 已修改标志，释放该高速缓冲区。
; 966  : 	de->inode = 0;

	mov	ecx, DWORD PTR _de$[ebp]

; 967  : 	bh->b_dirt = 1;
; 968  : 	brelse(bh);

	push	edi
	mov	BYTE PTR [edi+11], 1
	mov	WORD PTR [ecx], 0
	call	_brelse

; 969  : // 该i 节点的连接数减1，置已修改标志，更新改变时间为当前时间。最后释放该i 节点和目录的i 节
; 970  : // 点，返回0(成功)。
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
; 991  : // 取原文件路径名对应的i 节点oldinode。如果为0，则表示出错，返回出错号。
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

; 995  : // 如果原路径名对应的是一个目录名，则释放该i 节点，返回出错号。
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
; 1000 : // 查找新路径名的最顶层目录的i 节点，并返回最后的文件名及其长度。如果目录的i 节点没有找到，
; 1001 : // 则释放原路径名的i 节点，返回出错号。
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
; 1007 : // 如果新路径名中不包括文件名，则释放原路径名i 节点和新路径名目录的i 节点，返回出错号。
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
; 1013 : // 如果新路径名目录的设备号与原路径名的设备号不一样，则也不能建立连接，于是释放新路径名
; 1014 : // 目录的i 节点和原路径名的i 节点，返回出错号。
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
; 1020 : // 如果用户没有在新目录中写的权限，则也不能建立连接，于是释放新路径名目录的i 节点
; 1021 : // 和原路径名的i 节点，返回出错号。
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
; 1027 : // 查询该新路径名是否已经存在，如果存在，则也不能建立连接，于是释放包含该已存在目录项的
; 1028 : // 高速缓冲区，释放新路径名目录的i 节点和原路径名的i 节点，返回出错号。
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
; 1036 : // 在新目录中添加一个目录项。若失败则释放该目录的i 节点和原路径名的i 节点，返回出错号。
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
; 1043 : // 否则初始设置该目录项的i 节点号等于原路径名的i 节点号，并置包含该新添目录项的高速缓冲区
; 1044 : // 已修改标志，释放该缓冲区，释放目录的i 节点。
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

; 1049 : // 将原节点的应用计数加1，修改其改变时间为当前时间，并设置i 节点已修改标志，最后释放原
; 1050 : // 路径名的i 节点，并返回0(成功)。
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
