	TITLE	..\kernel\chr_drv\console.c
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
;	COMDAT __outb
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT __outb_p
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT __inb_p
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT __set_gate
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT __set_tssldt_desc
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
FLAT	GROUP _DATA, CONST, _BSS
	ASSUME	CS: FLAT, DS: FLAT, SS: FLAT
endif
PUBLIC	_beepcount
_BSS	SEGMENT
_beepcount DD	01H DUP (?)
_state	DD	01H DUP (?)
_ques	DD	01H DUP (?)
_saved_x DD	01H DUP (?)
_saved_y DD	01H DUP (?)
_BSS	ENDS
_DATA	SEGMENT
_attr	DB	07H
_DATA	ENDS
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
PUBLIC	__set_tssldt_desc
;	COMDAT __set_tssldt_desc
_TEXT	SEGMENT
_n$ = 8
_addr$ = 12
_tp$ = 16
__set_tssldt_desc PROC NEAR				; COMDAT

; 105  : { 

	push	ebp
	mov	ebp, esp
	push	ebx

; 106  : /*	n[0] = 104;
; 107  : 	n[1] = addr;
; 108  : 	n[2] = addr >> 16;
; 109  : 	((char*)n)[7] = ((char*)n)[5];
; 110  : 	((char*)n)[5] = tp;
; 111  : 	((char*)n)[6] = 0;*/
; 112  : 	_asm mov ebx,n

	mov	ebx, DWORD PTR _n$[ebp]

; 113  : 	_asm mov ax,104 

	mov	ax, 104					; 00000068H

; 114  : 	_asm mov word ptr [ebx],ax // 将TSS 长度放入描述符长度域(第0-1 字节)。

	mov	WORD PTR [ebx], ax

; 115  : 	_asm mov eax,addr 

	mov	eax, DWORD PTR _addr$[ebp]

; 116  : 	_asm mov word ptr [ebx+2],ax // 将基地址的低字放入描述符第2-3 字节。

	mov	WORD PTR [ebx+2], ax

; 117  : 	_asm ror eax,16 // 将基地址高字移入ax 中。

	ror	eax, 16					; 00000010H

; 118  : 	_asm mov byte ptr [ebx+4],al // 将基地址高字中低字节移入描述符第4 字节。

	mov	BYTE PTR [ebx+4], al

; 119  : 	_asm mov al,tp

	mov	al, BYTE PTR _tp$[ebp]

; 120  : 	_asm mov byte ptr [ebx+5],al // 将标志类型字节移入描述符的第5 字节。

	mov	BYTE PTR [ebx+5], al

; 121  : 	_asm mov al,0 

	mov	al, 0

; 122  : 	_asm mov byte ptr [ebx+6],al // 描述符的第6 字节置0。

	mov	BYTE PTR [ebx+6], al

; 123  : 	_asm mov byte ptr [ebx+7],ah // 将基地址高字中高字节移入描述符第7 字节。

	mov	BYTE PTR [ebx+7], ah

; 124  : 	_asm ror eax,16 // eax 清零。

	ror	eax, 16					; 00000010H
	pop	ebx

; 125  : }

	pop	ebp
	ret	0
__set_tssldt_desc ENDP
_TEXT	ENDS
PUBLIC	_csi_m
_BSS	SEGMENT
_npar	DD	01H DUP (?)
_par	DD	010H DUP (?)
_BSS	ENDS
_TEXT	SEGMENT
_csi_m	PROC NEAR

; 494  : 	unsigned int i;
; 495  : 
; 496  : 	for (i = 0; i <= npar; i++)

	mov	eax, DWORD PTR _npar
	push	ebx
	push	esi
	mov	ecx, OFFSET FLAT:_par
	lea	esi, DWORD PTR [eax+1]
	mov	dl, 15					; 0000000fH
$L796:

; 497  : 		switch (par[i])
; 498  : 		{

	mov	eax, DWORD PTR [ecx]
	cmp	eax, 27					; 0000001bH
	ja	SHORT $L797
	xor	ebx, ebx
	mov	bl, BYTE PTR $L1088[eax]
	jmp	DWORD PTR $L1089[ebx*4]
$L805:

; 499  : 		case 0:
; 500  : 			attr = 0x07;
; 501  : 			break;
; 502  : 		case 1:
; 503  : 			attr = 0x0f;

	mov	BYTE PTR _attr, dl

; 504  : 			break;

	jmp	SHORT $L797
$L806:

; 505  : 		case 4:
; 506  : 			attr = 0x0f;
; 507  : 			break;
; 508  : 		case 7:
; 509  : 			attr = 0x70;

	mov	BYTE PTR _attr, 112			; 00000070H

; 510  : 			break;

	jmp	SHORT $L797
$L803:

; 511  : 		case 27:
; 512  : 			attr = 0x07;

	mov	BYTE PTR _attr, 7
$L797:

; 494  : 	unsigned int i;
; 495  : 
; 496  : 	for (i = 0; i <= npar; i++)

	add	ecx, 4
	dec	esi
	jne	SHORT $L796
	pop	esi
	pop	ebx

; 513  : 			break;
; 514  : 		}
; 515  : }

	ret	0
$L1089:
	DD	$L803
	DD	$L805
	DD	$L806
	DD	$L797
$L1088:
	DB	0
	DB	1
	DB	3
	DB	3
	DB	1
	DB	3
	DB	3
	DB	2
	DB	3
	DB	3
	DB	3
	DB	3
	DB	3
	DB	3
	DB	3
	DB	3
	DB	3
	DB	3
	DB	3
	DB	3
	DB	3
	DB	3
	DB	3
	DB	3
	DB	3
	DB	3
	DB	3
	DB	0
_csi_m	ENDP
_TEXT	ENDS
PUBLIC	_con_write
_BSS	SEGMENT
_video_num_columns DD 01H DUP (?)
_video_size_row DD 01H DUP (?)
_video_num_lines DD 01H DUP (?)
_video_mem_start DD 01H DUP (?)
_video_port_reg DW 01H DUP (?)
	ALIGN	4

_video_port_val DW 01H DUP (?)
	ALIGN	4

_origin	DD	01H DUP (?)
_pos	DD	01H DUP (?)
_x	DD	01H DUP (?)
_y	DD	01H DUP (?)
_top	DD	01H DUP (?)
_bottom	DD	01H DUP (?)
_BSS	ENDS
_TEXT	SEGMENT
$T1160 = 11
$T1166 = 11
$T1172 = 11
$T1178 = 11
_tty$ = 8
_nr$ = -4
_c$ = 11
_con_write PROC NEAR

; 705  : {

	push	ebp
	mov	ebp, esp
	push	ecx
	push	ebx
	push	esi

; 710  : 	nr = CHARS (tty->write_q);

	mov	esi, DWORD PTR _tty$[ebp]
	push	edi
	mov	eax, DWORD PTR [esi+1092]
	mov	ebx, DWORD PTR [esi+1096]
	sub	eax, ebx
	and	eax, 1023				; 000003ffH

; 711  : 	while (nr--)

	mov	ecx, eax
	dec	eax
	test	ecx, ecx
	mov	DWORD PTR _nr$[ebp], eax
	je	$L917
	mov	eax, DWORD PTR _par
$L916:

; 715  : // 1：原是状态0，并且字符是转义字符ESC(0x1b = 033 = 27)；
; 716  : // 2：原是状态1，并且字符是'['；
; 717  : // 3：原是状态2；或者原是状态3，并且字符是';'或数字。
; 718  : // 4：原是状态3，并且字符不是';'或数字；
; 719  : 		GETCH (tty->write_q, c);

	mov	ecx, DWORD PTR [esi+1096]
	mov	dl, BYTE PTR [ecx+esi+1104]
	inc	ecx
	and	ecx, 1023				; 000003ffH
	mov	BYTE PTR _c$[ebp], dl
	mov	DWORD PTR [esi+1096], ecx

; 720  : 		switch (state)
; 721  : 		{

	mov	ecx, DWORD PTR _state
	cmp	ecx, 4
	ja	$L970
	jmp	DWORD PTR $L1209[ecx*4]
$L923:

; 722  : 		case 0:
; 723  : // 如果字符不是控制字符(c>31)，并且也不是扩展字符(c<127)，则
; 724  : 			if (c > 31 && c < 127)

	cmp	dl, 31					; 0000001fH
	jle	SHORT $L924
	cmp	dl, 127					; 0000007fH
	jge	SHORT $L924

; 725  : 			{
; 726  : // 若当前光标处在行末端或末端以外，则将光标移到下行头列。并调整光标位置对应的内存指针pos。
; 727  : 				if (x >= video_num_columns)

	mov	eax, DWORD PTR _video_num_columns
	mov	ecx, DWORD PTR _x
	cmp	ecx, eax
	jb	SHORT $L925

; 728  : 				{
; 729  : 					x -= video_num_columns;
; 730  : 					pos -= video_size_row;

	mov	edx, DWORD PTR _video_size_row
	sub	ecx, eax
	mov	eax, DWORD PTR _pos
	mov	DWORD PTR _x, ecx
	sub	eax, edx
	mov	DWORD PTR _pos, eax

; 731  : 					lf ();

	call	_lf
$L925:

; 732  : 				}
; 733  : // 将字符c 写到显示内存中pos 处，并将光标右移1 列，同时也将pos 对应地移动2 个字节。
; 734  : //__asm__ ("movb _attr,%%ah\n\t" "movw %%ax,%1\n\t"::"a" (c), "m" (*(short *) pos):"ax");
; 735  : 				_asm {
; 736  : 					mov al,c;

	mov	al, BYTE PTR _c$[ebp]

; 737  : 					mov ah,attr;

	mov	ah, BYTE PTR _attr

; 738  : 					mov ebx,pos

	mov	ebx, DWORD PTR _pos

; 739  : 					mov [ebx],ax;

	mov	WORD PTR [ebx], ax

; 740  : 				}
; 741  : 				pos += 2;

	mov	ecx, DWORD PTR _pos

; 742  : 				x++;

	mov	eax, DWORD PTR _x
	add	ecx, 2
	inc	eax
	mov	DWORD PTR _pos, ecx
	mov	DWORD PTR _x, eax

; 743  : // 如果字符c 是转义字符ESC，则转换状态state 到1。
; 744  : 			}
; 745  : 			else if (c == 27)

	jmp	$L1201
$L924:
	cmp	dl, 27					; 0000001bH
	jne	SHORT $L927

; 746  : 				state = 1;

	mov	DWORD PTR _state, 1

; 747  : // 如果字符c 是换行符(10)，或是垂直制表符VT(11)，或者是换页符FF(12)，则移动光标到下一行。
; 748  : 			else if (c == 10 || c == 11 || c == 12)

	jmp	$L970
$L927:
	cmp	dl, 10					; 0000000aH
	je	$L930
	cmp	dl, 11					; 0000000bH
	je	$L930
	cmp	dl, 12					; 0000000cH
	je	$L930

; 749  : 				lf ();
; 750  : // 如果字符c 是回车符CR(13)，则将光标移动到头列(0 列)。
; 751  : 			else if (c == 13)

	cmp	dl, 13					; 0000000dH
	jne	SHORT $L932

; 752  : 				cr ();

	call	_cr

; 753  : // 如果字符c 是DEL(127)，则将光标右边一字符擦除(用空格字符替代)，并将光标移到被擦除位置。
; 754  : 			else if (c == ERASE_CHAR (tty))

	jmp	$L1201
$L932:
	xor	ecx, ecx
	mov	cl, BYTE PTR [esi+19]
	movsx	edi, dl
	cmp	edi, ecx
	jne	SHORT $L934

; 755  : 				del ();

	call	_del

; 756  : // 如果字符c 是BS(backspace,8)，则将光标右移1 格，并相应调整光标对应内存位置指针pos。
; 757  : 			else if (c == 8)

	jmp	$L1201
$L934:
	cmp	dl, 8
	jne	SHORT $L936

; 758  : 			{
; 759  : 				if (x)

	mov	ecx, DWORD PTR _x
	test	ecx, ecx
	je	$L970

; 760  : 				{
; 761  : 					x--;

	mov	edx, ecx

; 762  : 					pos -= 2;

	mov	ecx, DWORD PTR _pos
	dec	edx
	sub	ecx, 2
	mov	DWORD PTR _x, edx
	mov	DWORD PTR _pos, ecx

; 763  : 				}
; 764  : // 如果字符c 是水平制表符TAB(9)，则将光标移到8 的倍数列上。若此时光标列数超出屏幕最大列数，
; 765  : // 则将光标移到下一行上。
; 766  : 			}
; 767  : 			else if (c == 9)

	jmp	$L970
$L936:
	cmp	dl, 9
	jne	SHORT $L939

; 768  : 			{
; 769  : 				c = (char)(8 - (x & 7));

	mov	edx, DWORD PTR _x

; 770  : 				x += c;
; 771  : 				pos += c << 1;

	mov	edi, DWORD PTR _pos
	mov	bl, dl
	mov	cl, 8
	and	bl, 7
	sub	cl, bl
	movsx	ecx, cl
	add	edx, ecx
	lea	ecx, DWORD PTR [edi+ecx*2]

; 772  : 				if (x > video_num_columns)

	mov	edi, DWORD PTR _video_num_columns
	cmp	edx, edi
	mov	DWORD PTR _x, edx
	mov	DWORD PTR _pos, ecx
	jbe	$L970

; 773  : 				{
; 774  : 					x -= video_num_columns;
; 775  : 					pos -= video_size_row;

	mov	eax, DWORD PTR _video_size_row
	sub	edx, edi
	sub	ecx, eax
	mov	DWORD PTR _x, edx
	mov	DWORD PTR _pos, ecx

; 776  : 					lf ();

	call	_lf

; 777  : 				}
; 778  : 				c = 9;
; 779  : // 如果字符c 是响铃符BEL(7)，则调用蜂鸣函数，是扬声器发声。
; 780  : 			}
; 781  : 			else if (c == 7)

	jmp	$L1201
$L939:
	cmp	dl, 7
	jne	$L970

; 782  : 				sysbeep ();

	call	_sysbeep
	jmp	$L1201
$L944:

; 783  : 			break;
; 784  : // 如果原状态是0，并且字符是转义字符ESC(0x1b = 033 = 27)，则转到状态1 处理。
; 785  : 		case 1:
; 786  : 			state = 0;
; 787  : // 如果字符c 是'['，则将状态state 转到2。
; 788  : 			if (c == '[')

	cmp	dl, 91					; 0000005bH
	mov	DWORD PTR _state, 0
	jne	SHORT $L945

; 789  : 				state = 2;

	mov	DWORD PTR _state, 2

; 790  : // 如果字符c 是'E'，则光标移到下一行开始处(0 列)。
; 791  : 			else if (c == 'E')

	jmp	$L970
$L945:
	cmp	dl, 69					; 00000045H
	jne	SHORT $L947

; 792  : 				gotoxy (0, y + 1);

	mov	edx, DWORD PTR _y
	lea	ecx, DWORD PTR [edx+1]
	mov	edx, DWORD PTR _video_num_lines
	cmp	ecx, edx
	jae	SHORT $L970
	mov	DWORD PTR _x, 0
$L1205:
	mov	edx, DWORD PTR _video_size_row
	mov	DWORD PTR _y, ecx
	imul	edx, ecx
	add	edx, DWORD PTR _origin
	mov	DWORD PTR _pos, edx

; 793  : // 如果字符c 是'M'，则光标上移一行。
; 794  : 			else if (c == 'M')

	jmp	SHORT $L970
$L947:
	cmp	dl, 77					; 0000004dH
	jne	SHORT $L949

; 795  : 				ri ();

	call	_ri

; 796  : // 如果字符c 是'D'，则光标下移一行。
; 797  : 			else if (c == 'D')

	jmp	SHORT $L1201
$L949:
	cmp	dl, 68					; 00000044H
	jne	SHORT $L951
$L930:

; 798  : 				lf ();

	call	_lf

; 799  : // 如果字符c 是'Z'，则发送终端应答字符序列。
; 800  : 			else if (c == 'Z')

	jmp	SHORT $L1201
$L951:
	cmp	dl, 90					; 0000005aH
	jne	SHORT $L953

; 801  : 				respond (tty);

	push	esi
	call	_respond
	add	esp, 4

; 802  : // 如果字符c 是'7'，则保存当前光标位置。注意这里代码写错！应该是(c=='7')。
; 803  : 			else if (x == '7')

	jmp	SHORT $L1201
$L953:
	mov	ecx, DWORD PTR _x
	cmp	ecx, 55					; 00000037H
	jne	SHORT $L955
$L1003:

; 804  : 				save_cur ();

	call	_save_cur

; 805  : // 如果字符c 是'8'，则恢复到原保存的光标位置。注意这里代码写错！应该是(c=='8')。
; 806  : 			else if (x == '8')

	jmp	SHORT $L1201
$L955:
	cmp	ecx, 56					; 00000038H
	jne	SHORT $L970
$L1004:

; 948  : // 如果字符c 是'u'，则表示恢复光标到原保存的位置处。
; 949  : 			case 'u':
; 950  : 				restore_cur ();

	call	_restore_cur
$L1201:

; 944  : // 如果字符c 是's'，则表示保存当前光标所在位置。
; 945  : 			case 's':
; 946  : 				save_cur ();
; 947  : 				break;

	mov	eax, DWORD PTR _par
$L970:

; 711  : 	while (nr--)

	mov	ecx, DWORD PTR _nr$[ebp]
	mov	edx, ecx
	dec	ecx
	test	edx, edx
	mov	DWORD PTR _nr$[ebp], ecx
	jne	$L916
$L917:

; 706  : 	int nr;

	cli

; 951  : 				break;
; 952  : 			}
; 953  : 		}
; 954  : 	}
; 955  : // 最后根据上面设置的光标位置，向显示控制器发送光标显示位置。
; 956  : 	set_cursor ();

	mov	BYTE PTR $T1160[ebp], 14		; 0000000eH

; 706  : 	int nr;

	mov	al, BYTE PTR $T1160[ebp]

; 707  : 	char c;

	mov	dx, WORD PTR _video_port_reg

; 708  : 

	out	dx, al

; 709  : // 首先取得写缓冲队列中现有字符数nr，然后针对每个字符进行处理。

	jmp	SHORT $l1$1182
$l1$1182:

; 710  : 	nr = CHARS (tty->write_q);

	jmp	SHORT $l2$1183
$l2$1183:

; 951  : 				break;
; 952  : 			}
; 953  : 		}
; 954  : 	}
; 955  : // 最后根据上面设置的光标位置，向显示控制器发送光标显示位置。
; 956  : 	set_cursor ();

	mov	eax, DWORD PTR _pos
	mov	edi, DWORD PTR _video_mem_start
	sub	eax, edi
	shr	eax, 9
	mov	BYTE PTR $T1166[ebp], al

; 706  : 	int nr;

	mov	al, BYTE PTR $T1166[ebp]

; 707  : 	char c;

	mov	dx, WORD PTR _video_port_val

; 708  : 

	out	dx, al

; 709  : // 首先取得写缓冲队列中现有字符数nr，然后针对每个字符进行处理。

	jmp	SHORT $l1$1186
$l1$1186:

; 710  : 	nr = CHARS (tty->write_q);

	jmp	SHORT $l2$1187
$l2$1187:

; 951  : 				break;
; 952  : 			}
; 953  : 		}
; 954  : 	}
; 955  : // 最后根据上面设置的光标位置，向显示控制器发送光标显示位置。
; 956  : 	set_cursor ();

	mov	BYTE PTR $T1172[ebp], 15		; 0000000fH

; 706  : 	int nr;

	mov	al, BYTE PTR $T1172[ebp]

; 707  : 	char c;

	mov	dx, WORD PTR _video_port_reg

; 708  : 

	out	dx, al

; 709  : // 首先取得写缓冲队列中现有字符数nr，然后针对每个字符进行处理。

	jmp	SHORT $l1$1190
$l1$1190:

; 710  : 	nr = CHARS (tty->write_q);

	jmp	SHORT $l2$1191
$l2$1191:

; 951  : 				break;
; 952  : 			}
; 953  : 		}
; 954  : 	}
; 955  : // 最后根据上面设置的光标位置，向显示控制器发送光标显示位置。
; 956  : 	set_cursor ();

	mov	ecx, DWORD PTR _pos
	mov	edx, DWORD PTR _video_mem_start
	sub	ecx, edx
	shr	ecx, 1
	mov	BYTE PTR $T1178[ebp], cl

; 706  : 	int nr;

	mov	al, BYTE PTR $T1178[ebp]

; 707  : 	char c;

	mov	dx, WORD PTR _video_port_val

; 708  : 

	out	dx, al

; 709  : // 首先取得写缓冲队列中现有字符数nr，然后针对每个字符进行处理。

	jmp	SHORT $l1$1194
$l1$1194:

; 710  : 	nr = CHARS (tty->write_q);

	jmp	SHORT $l2$1195
$l2$1195:

; 712  : 	{
; 713  : // 从写队列中取一字符c，根据前面所处理字符的状态state 分别处理。状态之间的转换关系为：
; 714  : // state = 0：初始状态；或者原是状态4；或者原是状态1，但字符不是'['；

	sti

; 951  : 				break;
; 952  : 			}
; 953  : 		}
; 954  : 	}
; 955  : // 最后根据上面设置的光标位置，向显示控制器发送光标显示位置。
; 956  : 	set_cursor ();

	pop	edi
	pop	esi
	pop	ebx

; 957  : }

	mov	esp, ebp
	pop	ebp
	ret	0
$L958:

; 807  : 				restore_cur ();
; 808  : 			break;
; 809  : // 如果原状态是1，并且上一字符是'['，则转到状态2 来处理。
; 810  : 		case 2:
; 811  : // 首先对ESC 转义字符序列参数使用的处理数组par[]清零，索引变量npar 指向首项，并且设置状态
; 812  : // 为3。若此时字符不是'?'，则直接转到状态3 去处理，否则去读一字符，再到状态3 处理代码处。
; 813  : 			for (npar = 0; npar < NPAR; npar++)
; 814  : 				par[npar] = 0;

	mov	ecx, 16					; 00000010H
	xor	eax, eax
	mov	edi, OFFSET FLAT:_par

; 815  : 			npar = 0;
; 816  : 			state = 3;

	mov	DWORD PTR _state, 3
	rep stosd
	xor	ecx, ecx

; 817  : 			if (ques = (c == '?'))

	cmp	dl, 63					; 0000003fH
	sete	al
	test	eax, eax
	mov	DWORD PTR _npar, ecx
	mov	DWORD PTR _ques, eax
	jne	$L1201
	mov	eax, DWORD PTR _par
	jmp	SHORT $L962
$L1203:
	mov	ecx, DWORD PTR _npar
$L962:

; 818  : 				break;
; 819  : // 如果原来是状态2；或者原来就是状态3，但原字符是';'或数字，则在下面处理。
; 820  : 		case 3:
; 821  : // 如果字符c 是分号';'，并且数组par 未满，则索引值加1。
; 822  : 			if (c == ';' && npar < NPAR - 1)

	cmp	dl, 59					; 0000003bH
	jne	SHORT $L964
	cmp	ecx, 15					; 0000000fH
	jae	SHORT $L966

; 823  : 			{
; 824  : 				npar++;

	inc	ecx
	mov	DWORD PTR _npar, ecx

; 825  : 				break;

	jmp	$L970
$L964:

; 826  : // 如果字符c 是数字字符'0'-'9'，则将该字符转换成数值并与npar 所索引的项组成10 进制数。
; 827  : 			}
; 828  : 			else if (c >= '0' && c <= '9')

	cmp	dl, 48					; 00000030H
	jl	SHORT $L966
	cmp	dl, 57					; 00000039H
	jg	SHORT $L966

; 829  : 			{
; 830  : 				par[npar] = 10 * par[npar] + c - '0';

	mov	eax, DWORD PTR _par[ecx*4]
	movsx	edx, dl
	lea	eax, DWORD PTR [eax+eax*4]
	lea	eax, DWORD PTR [edx+eax*2-48]
	mov	DWORD PTR _par[ecx*4], eax

; 831  : 				break;

	jmp	$L1201
$L966:

; 832  : // 否则转到状态4。
; 833  : 			}
; 834  : 			else
; 835  : 				state = 4;
; 836  : // 如果原状态是状态3，并且字符不是';'或数字，则转到状态4 处理。首先复位状态state=0。
; 837  : 		case 4:
; 838  : 			state = 0;
; 839  : 			switch (c)
; 840  : 			{

	movsx	ecx, dl
	add	ecx, -64				; ffffffc0H
	xor	edi, edi
	cmp	ecx, 53					; 00000035H
	mov	DWORD PTR _state, edi
	ja	$L970
	xor	edx, edx
	mov	dl, BYTE PTR $L1210[ecx]
	jmp	DWORD PTR $L1211[edx*4]
$L973:

; 841  : // 如果字符c 是'G'或'`'，则par[]中第一个参数代表列号。若列号不为零，则将光标右移一格。
; 842  : 			case 'G':
; 843  : 			case '`':
; 844  : 				if (par[0])

	cmp	eax, edi
	je	SHORT $L974

; 845  : 					par[0]--;

	dec	eax
	mov	DWORD PTR _par, eax
$L974:

; 846  : 				gotoxy (par[0], y);

	cmp	eax, DWORD PTR _video_num_columns
	ja	$L970
	mov	ecx, DWORD PTR _y
	mov	edx, DWORD PTR _video_num_lines
	cmp	ecx, edx
	jae	$L970
	imul	ecx, DWORD PTR _video_size_row
	mov	edx, DWORD PTR _origin
	mov	DWORD PTR _x, eax
	add	edx, ecx
	lea	ecx, DWORD PTR [edx+eax*2]

; 899  : 				gotoxy (par[1], par[0]);

	mov	DWORD PTR _pos, ecx

; 900  : 				break;

	jmp	$L970
$L975:

; 847  : 				break;
; 848  : // 如果字符c 是'A'，则第一个参数代表光标上移的行数。若参数为0 则上移一行。
; 849  : 			case 'A':
; 850  : 				if (!par[0])

	cmp	eax, edi
	jne	SHORT $L976

; 851  : 					par[0]++;

	mov	eax, 1
	mov	DWORD PTR _par, eax
$L976:

; 852  : 				gotoxy (x, y - par[0]);

	mov	ecx, DWORD PTR _y
	mov	edx, DWORD PTR _x
	mov	edi, DWORD PTR _video_num_columns
	sub	ecx, eax
	cmp	edx, edi
	ja	$L970
	cmp	ecx, DWORD PTR _video_num_lines
	jae	$L970
	mov	edi, DWORD PTR _video_size_row
	mov	DWORD PTR _y, ecx
	imul	edi, ecx
	mov	ecx, DWORD PTR _origin
	add	ecx, edi
	lea	edx, DWORD PTR [ecx+edx*2]
	mov	DWORD PTR _pos, edx
	jmp	$L970
$L977:

; 853  : 				break;
; 854  : // 如果字符c 是'B'或'e'，则第一个参数代表光标下移的行数。若参数为0 则下移一行。
; 855  : 			case 'B':
; 856  : 			case 'e':
; 857  : 				if (!par[0])

	cmp	eax, edi
	jne	SHORT $L978

; 858  : 					par[0]++;

	mov	eax, 1
	mov	DWORD PTR _par, eax
$L978:

; 859  : 				gotoxy (x, y + par[0]);

	mov	ecx, DWORD PTR _y
	mov	edx, DWORD PTR _x
	mov	edi, DWORD PTR _video_num_columns
	add	ecx, eax
	cmp	edx, edi
	ja	$L970
	cmp	ecx, DWORD PTR _video_num_lines
	jae	$L970
	mov	edi, DWORD PTR _video_size_row
	mov	DWORD PTR _y, ecx
	imul	edi, ecx
	mov	ecx, DWORD PTR _origin
	add	ecx, edi
	lea	edx, DWORD PTR [ecx+edx*2]
	mov	DWORD PTR _pos, edx
	jmp	$L970
$L979:

; 860  : 				break;
; 861  : // 如果字符c 是'C'或'a'，则第一个参数代表光标右移的格数。若参数为0 则右移一格。
; 862  : 			case 'C':
; 863  : 			case 'a':
; 864  : 				if (!par[0])

	cmp	eax, edi
	jne	SHORT $L980

; 865  : 					par[0]++;

	mov	eax, 1
	mov	DWORD PTR _par, eax
$L980:

; 866  : 				gotoxy (x + par[0], y);

	mov	ecx, DWORD PTR _x
	mov	edx, DWORD PTR _video_num_columns
	add	ecx, eax
	cmp	ecx, edx
	ja	$L970
	mov	edx, DWORD PTR _y
	mov	edi, DWORD PTR _video_num_lines
	cmp	edx, edi
	jae	$L970
	imul	edx, DWORD PTR _video_size_row
	mov	edi, DWORD PTR _origin
	mov	DWORD PTR _x, ecx
	add	edi, edx
	lea	edx, DWORD PTR [edi+ecx*2]
	mov	DWORD PTR _pos, edx
	jmp	$L970
$L981:

; 867  : 				break;
; 868  : // 如果字符c 是'D'，则第一个参数代表光标左移的格数。若参数为0 则左移一格。
; 869  : 			case 'D':
; 870  : 				if (!par[0])

	cmp	eax, edi
	jne	SHORT $L982

; 871  : 					par[0]++;

	mov	eax, 1
	mov	DWORD PTR _par, eax
$L982:

; 872  : 				gotoxy (x - par[0], y);

	mov	ecx, DWORD PTR _x
	mov	edx, DWORD PTR _video_num_columns
	sub	ecx, eax
	cmp	ecx, edx
	ja	$L970
	mov	edx, DWORD PTR _y
	mov	edi, DWORD PTR _video_num_lines
	cmp	edx, edi
	jae	$L970
	mov	DWORD PTR _x, ecx

; 873  : 				break;

	jmp	$L1207
$L983:

; 874  : // 如果字符c 是'E'，则第一个参数代表光标向下移动的行数，并回到0 列。若参数为0 则下移一行。
; 875  : 			case 'E':
; 876  : 				if (!par[0])

	cmp	eax, edi
	jne	SHORT $L984

; 877  : 					par[0]++;

	mov	eax, 1
	mov	DWORD PTR _par, eax
$L984:

; 878  : 				gotoxy (0, y + par[0]);

	mov	edx, DWORD PTR _y
	lea	ecx, DWORD PTR [eax+edx]
	mov	edx, DWORD PTR _video_num_lines
	cmp	ecx, edx
	jae	$L970
	mov	DWORD PTR _x, edi

; 879  : 				break;

	jmp	$L1205
$L985:

; 880  : // 如果字符c 是'F'，则第一个参数代表光标向上移动的行数，并回到0 列。若参数为0 则上移一行。
; 881  : 			case 'F':
; 882  : 				if (!par[0])

	cmp	eax, edi
	jne	SHORT $L986

; 883  : 					par[0]++;

	mov	eax, 1
	mov	DWORD PTR _par, eax
$L986:

; 884  : 				gotoxy (0, y - par[0]);

	mov	ecx, DWORD PTR _y
	mov	edx, DWORD PTR _video_num_lines
	sub	ecx, eax
	cmp	ecx, edx
	jae	$L970
	mov	DWORD PTR _x, edi

; 885  : 				break;

	jmp	$L1205
$L987:

; 886  : // 如果字符c 是'd'，则第一个参数代表光标所需在的行号(从0 计数)。
; 887  : 			case 'd':
; 888  : 				if (par[0])

	cmp	eax, edi
	je	SHORT $L988

; 889  : 					par[0]--;

	dec	eax
	mov	DWORD PTR _par, eax
$L988:

; 890  : 				gotoxy (x, par[0]);

	mov	ecx, DWORD PTR _x
	mov	edx, DWORD PTR _video_num_columns
	cmp	ecx, edx
	ja	$L970
	cmp	eax, DWORD PTR _video_num_lines
	jae	$L970
	mov	edx, eax
	mov	edi, DWORD PTR _origin
	imul	edx, DWORD PTR _video_size_row
	add	edi, edx
	mov	DWORD PTR _y, eax
	lea	ecx, DWORD PTR [edi+ecx*2]
	mov	DWORD PTR _pos, ecx

; 891  : 				break;

	jmp	$L970
$L989:

; 892  : // 如果字符c 是'H'或'f'，则第一个参数代表光标移到的行号，第二个参数代表光标移到的列号。
; 893  : 			case 'H':
; 894  : 			case 'f':
; 895  : 				if (par[0])

	cmp	eax, edi
	je	SHORT $L990

; 896  : 					par[0]--;

	dec	eax
	mov	DWORD PTR _par, eax
$L990:

; 897  : 				if (par[1])

	mov	ecx, DWORD PTR _par+4
	cmp	ecx, edi
	je	SHORT $L991

; 898  : 					par[1]--;

	dec	ecx
	mov	DWORD PTR _par+4, ecx
$L991:

; 899  : 				gotoxy (par[1], par[0]);

	cmp	ecx, DWORD PTR _video_num_columns
	ja	$L970
	cmp	eax, DWORD PTR _video_num_lines
	jae	$L970
	mov	DWORD PTR _x, ecx
	mov	DWORD PTR _y, eax
	mov	edx, eax
$L1207:
	imul	edx, DWORD PTR _video_size_row
	mov	edi, DWORD PTR _origin
	add	edi, edx
	lea	ecx, DWORD PTR [edi+ecx*2]
	mov	DWORD PTR _pos, ecx

; 900  : 				break;

	jmp	$L970
$L992:

; 901  : // 如果字符c 是'J'，则第一个参数代表以光标所处位置清屏的方式：
; 902  : // ANSI 转义序列：'ESC [sJ'(s = 0 删除光标到屏幕底端；1 删除屏幕开始到光标处；2 整屏删除)。
; 903  : 			case 'J':
; 904  : 				csi_J (par[0]);

	push	eax
	call	_csi_J
	add	esp, 4

; 905  : 				break;

	jmp	$L1201
$L993:

; 906  : // 如果字符c 是'K'，则第一个参数代表以光标所在位置对行中字符进行删除处理的方式。
; 907  : // ANSI 转义字符序列：'ESC [sK'(s = 0 删除到行尾；1 从开始删除；2 整行都删除)。
; 908  : 			case 'K':
; 909  : 				csi_K (par[0]);

	push	eax
	call	_csi_K
	add	esp, 4

; 910  : 				break;

	jmp	$L1201
$L994:

; 911  : // 如果字符c 是'L'，表示在光标位置处插入n 行(ANSI 转义字符序列'ESC [nL')。
; 912  : 			case 'L':
; 913  : 				csi_L (par[0]);

	push	eax
	call	_csi_L
	add	esp, 4

; 914  : 				break;

	jmp	$L1201
$L995:

; 915  : // 如果字符c 是'M'，表示在光标位置处删除n 行(ANSI 转义字符序列'ESC [nM')。
; 916  : 			case 'M':
; 917  : 				csi_M (par[0]);

	push	eax
	call	_csi_M
	add	esp, 4

; 918  : 				break;

	jmp	$L1201
$L996:

; 919  : // 如果字符c 是'P'，表示在光标位置处删除n 个字符(ANSI 转义字符序列'ESC [nP')。
; 920  : 			case 'P':
; 921  : 				csi_P (par[0]);

	push	eax
	call	_csi_P
	add	esp, 4

; 922  : 				break;

	jmp	$L1201
$L997:

; 923  : // 如果字符c 是'@'，表示在光标位置处插入n 个字符(ANSI 转义字符序列'ESC [n@')。
; 924  : 			case '@':
; 925  : 				csi_at (par[0]);

	push	eax
	call	_csi_at
	add	esp, 4

; 926  : 				break;

	jmp	$L1201
$L998:

; 927  : // 如果字符c 是'm'，表示改变光标处字符的显示属性，比如加粗、加下划线、闪烁、反显等。
; 928  : // ANSI 转义字符序列：'ESC [nm'。n = 0 正常显示；1 加粗；4 加下划线；7 反显；27 正常显示。
; 929  : 			case 'm':
; 930  : 				csi_m ();

	call	_csi_m

; 931  : 				break;

	jmp	$L1201
$L999:

; 932  : // 如果字符c 是'r'，则表示用两个参数设置滚屏的起始行号和终止行号。
; 933  : 			case 'r':
; 934  : 				if (par[0])

	cmp	eax, edi
	je	SHORT $L1000

; 935  : 					par[0]--;

	dec	eax
	mov	DWORD PTR _par, eax
$L1000:

; 936  : 				if (!par[1])

	mov	ecx, DWORD PTR _par+4
	cmp	ecx, edi
	jne	SHORT $L1001

; 937  : 					par[1] = video_num_lines;

	mov	ecx, DWORD PTR _video_num_lines
	mov	DWORD PTR _par+4, ecx
$L1001:

; 938  : 				if (par[0] < par[1] && par[1] <= video_num_lines)

	cmp	eax, ecx
	jae	$L970
	cmp	ecx, DWORD PTR _video_num_lines
	ja	$L970

; 939  : 				{
; 940  : 					top = par[0];

	mov	DWORD PTR _top, eax

; 941  : 					bottom = par[1];

	mov	DWORD PTR _bottom, ecx

; 942  : 				}
; 943  : 				break;

	jmp	$L970

; 957  : }

	npad	1
$L1209:
	DD	$L923
	DD	$L944
	DD	$L958
	DD	$L1203
	DD	$L966
$L1211:
	DD	$L997
	DD	$L975
	DD	$L977
	DD	$L979
	DD	$L981
	DD	$L983
	DD	$L985
	DD	$L973
	DD	$L989
	DD	$L992
	DD	$L993
	DD	$L994
	DD	$L995
	DD	$L996
	DD	$L987
	DD	$L998
	DD	$L999
	DD	$L1003
	DD	$L1004
	DD	$L970
$L1210:
	DB	0
	DB	1
	DB	2
	DB	3
	DB	4
	DB	5
	DB	6
	DB	7
	DB	8
	DB	19					; 00000013H
	DB	9
	DB	10					; 0000000aH
	DB	11					; 0000000bH
	DB	12					; 0000000cH
	DB	19					; 00000013H
	DB	19					; 00000013H
	DB	13					; 0000000dH
	DB	19					; 00000013H
	DB	19					; 00000013H
	DB	19					; 00000013H
	DB	19					; 00000013H
	DB	19					; 00000013H
	DB	19					; 00000013H
	DB	19					; 00000013H
	DB	19					; 00000013H
	DB	19					; 00000013H
	DB	19					; 00000013H
	DB	19					; 00000013H
	DB	19					; 00000013H
	DB	19					; 00000013H
	DB	19					; 00000013H
	DB	19					; 00000013H
	DB	7
	DB	3
	DB	19					; 00000013H
	DB	19					; 00000013H
	DB	14					; 0000000eH
	DB	2
	DB	8
	DB	19					; 00000013H
	DB	19					; 00000013H
	DB	19					; 00000013H
	DB	19					; 00000013H
	DB	19					; 00000013H
	DB	19					; 00000013H
	DB	15					; 0000000fH
	DB	19					; 00000013H
	DB	19					; 00000013H
	DB	19					; 00000013H
	DB	19					; 00000013H
	DB	16					; 00000010H
	DB	17					; 00000011H
	DB	19					; 00000013H
	DB	18					; 00000012H
_con_write ENDP
_lf	PROC NEAR

; 352  : // 如果光标没有处在倒数第2 行之后，则直接修改光标当前行变量y++，并调整光标对应显示内存位置
; 353  : // pos(加上屏幕一行字符所对应的内存长度)。
; 354  : 	if (y + 1 < bottom)

	mov	eax, DWORD PTR _y
	mov	ecx, DWORD PTR _bottom
	inc	eax
	cmp	eax, ecx
	jae	SHORT $L750

; 355  : 	{
; 356  : 		y++;
; 357  : 		pos += video_size_row;

	mov	ecx, DWORD PTR _video_size_row
	mov	DWORD PTR _y, eax
	add	DWORD PTR _pos, ecx

; 362  : }

	ret	0
$L750:

; 358  : 		return;
; 359  : 	}
; 360  : // 否则需要将屏幕内容上移一行。
; 361  : 	scrup ();

	jmp	_scrup
_lf	ENDP
_TEXT	ENDS
_BSS	SEGMENT
_video_type DB	01H DUP (?)
	ALIGN	4

_video_mem_end DD 01H DUP (?)
_video_erase_char DW 01H DUP (?)
	ALIGN	4

_scr_end DD	01H DUP (?)
_BSS	ENDS
_TEXT	SEGMENT
$T1220 = -1
$T1226 = -1
$T1232 = -1
$T1238 = -1
_t1$ = -8
_t2$ = -16
_t3$ = -12
_scrup	PROC NEAR

; 128  : {

	push	ebp
	mov	ebp, esp
	sub	esp, 16					; 00000010H

; 132  : 	if (video_type == VIDEO_TYPE_EGAC || video_type == VIDEO_TYPE_EGAM)

	mov	al, BYTE PTR _video_type
	push	esi
	cmp	al, 33					; 00000021H
	push	edi
	je	SHORT $L732
	cmp	al, 32					; 00000020H
	je	SHORT $L732

; 226  : 			}
; 227  : /*	  __asm__ ("cld\n\t"
; 228  : 		   "rep\n\t"
; 229  : 		   "movsl\n\t"	//
; 230  : 		   "movl _video_num_columns,%%ecx\n\t"
; 231  : 		   "rep\n\t"
; 232  : 	"stosw"::"a" (video_erase_char), "c" ((bottom - top - 1) * video_num_columns >> 1), 
; 233  : 	"D" (origin + video_size_row * top), "S" (origin + video_size_row * (top + 1))
; 234  : 			:"cx", "di","si");*/
; 235  : 		}
; 236  : 	}
; 237  : // 如果显示类型不是EGA(是MDA)，则执行下面移动操作。因为MDA 显示控制卡会自动调整超出显示范围
; 238  : // 的情况，也即会自动翻卷指针，所以这里不对屏幕内容对应内存超出显示内存的情况单独处理。处理
; 239  : // 方法与EGA 非整屏移动情况完全一样。
; 240  : 	else				/* Not EGA/VGA */
; 241  : 	{
; 242  : 		t1 = (bottom - top - 1) * video_num_columns >> 1;

	mov	ecx, DWORD PTR _bottom
	mov	eax, DWORD PTR _top
	sub	ecx, eax

; 243  : 		t2 = origin + video_size_row * top;

	mov	edx, DWORD PTR _origin
	dec	ecx
	imul	ecx, DWORD PTR _video_num_columns
	shr	ecx, 1
	mov	DWORD PTR _t1$[ebp], ecx
	mov	ecx, DWORD PTR _video_size_row
	mov	esi, ecx
	imul	esi, eax
	add	esi, edx

; 244  : 		t3 = origin + video_size_row * (top + 1);

	inc	eax
	imul	eax, ecx
	add	eax, edx
	mov	DWORD PTR _t2$[ebp], esi
	mov	DWORD PTR _t3$[ebp], eax

; 245  : 		_asm {
; 246  : 			pushf

	pushf

; 247  : 			mov ecx,t1;

	mov	ecx, DWORD PTR _t1$[ebp]

; 248  : //		  mov ecx,((bottom - top - 1) * video_num_columns >> 1);
; 249  : 			mov edi,t2;

	mov	edi, DWORD PTR _t2$[ebp]

; 250  : //		  mov edi,(origin + video_size_row * top);
; 251  : 			mov esi,t3;

	mov	esi, DWORD PTR _t3$[ebp]

; 252  : //		  mov esi,(origin + video_size_row * (top + 1));
; 253  : 			mov ax,video_erase_char;

	mov	ax, WORD PTR _video_erase_char

; 254  : 			cld;

	cld

; 255  : 			rep movsd;

	rep	 movsd

; 256  : 			mov ecx,video_num_columns;

	mov	ecx, DWORD PTR _video_num_columns

; 257  : 			rep stosw;

	rep	 stosw

; 258  : 			popf

	popf

; 259  : 		}
; 260  : /*    __asm__ ("cld\n\t" "rep\n\t" "movsl\n\t" \
; 261  : 		"movl _video_num_columns,%%ecx\n\t" "rep\n\t" "stosw"\
; 262  : 		::"a" (video_erase_char), \
; 263  : 		"c" ((bottom - top - 1) * video_num_columns >> 1), \
; 264  : 		"D" (origin + video_size_row * top), \
; 265  : 		"S" (origin + video_size_row * (top + 1)):"cx", "di","si");*/
; 266  : 	}
; 267  : }

	pop	edi
	pop	esi
	mov	esp, ebp
	pop	ebp
	ret	0
$L732:

; 134  : // 如果移动起始行top=0，移动最底行bottom=video_num_lines=25，则表示整屏窗口向下移动。
; 135  : 		if (!top && bottom == video_num_lines)

	mov	ecx, DWORD PTR _top
	mov	eax, DWORD PTR _bottom
	test	ecx, ecx
	jne	$L733
	mov	edx, DWORD PTR _video_num_lines
	cmp	eax, edx
	jne	$L733

; 138  : // 当前光标对应的内存位置以及屏幕末行末端字符指针scr_end 的位置。
; 139  : 			origin += video_size_row;

	mov	eax, DWORD PTR _video_size_row

; 140  : 			pos += video_size_row;

	mov	ecx, DWORD PTR _pos
	mov	esi, DWORD PTR _origin
	add	ecx, eax
	add	esi, eax
	mov	DWORD PTR _pos, ecx

; 141  : 			scr_end += video_size_row;

	mov	ecx, DWORD PTR _scr_end
	mov	DWORD PTR _origin, esi

; 142  : // 如果屏幕末端最后一个显示字符所对应的显示内存指针scr_end 超出了实际显示内存的末端，则将
; 143  : // 屏幕内容内存数据移动到显示内存的起始位置video_mem_start 处，并在出现的新行上填入空格字符。
; 144  : 			if (scr_end > video_mem_end)

	mov	esi, DWORD PTR _video_mem_end
	add	ecx, eax
	cmp	ecx, esi
	mov	DWORD PTR _scr_end, ecx
	jbe	SHORT $L734

; 145  : 			{
; 146  : // %0 - eax(擦除字符+属性)；%1 - ecx((显示器字符行数-1)所对应的字符数/2，是以长字移动)；
; 147  : // %2 - edi(显示内存起始位置video_mem_start)；%3 - esi(屏幕内容对应的内存起始位置origin)。
; 148  : // 移动方向：[edi]->[esi]，移动ecx 个长字。
; 149  : 				t1 = (video_num_lines - 1) * video_num_columns >> 1;

	dec	edx
	imul	edx, DWORD PTR _video_num_columns
	shr	edx, 1
	mov	DWORD PTR _t1$[ebp], edx

; 150  : 				_asm {
; 151  : 					pushf

	pushf

; 152  : 					mov ecx,t1;

	mov	ecx, DWORD PTR _t1$[ebp]

; 153  : //			  mov ecx,((video_num_lines - 1) * video_num_columns >> 1);
; 154  : 					mov ax,video_erase_char;

	mov	ax, WORD PTR _video_erase_char

; 155  : 					mov edi,video_mem_start;

	mov	edi, DWORD PTR _video_mem_start

; 156  : 					mov esi,origin;

	mov	esi, DWORD PTR _origin

; 157  : 					cld;	// 清方向位。

	cld

; 158  : 					rep movsd;	// 重复操作，将当前屏幕内存数据移动到显示内存起始处。

	rep	 movsd

; 159  : 					mov ecx,video_num_columns;	// ecx=1 行字符数。

	mov	ecx, DWORD PTR _video_num_columns

; 160  : 					rep stosw;	// 在新行上填入空格字符。

	rep	 stosw

; 161  : 					popf

	popf

; 162  : 				}
; 163  : /*	      __asm__ ("cld\n\t"
; 164  : 		       "rep\n\t"
; 165  : 		       "movsl\n\t" 
; 166  : 		       "movl _video_num_columns,%1\n\t"
; 167  : 		       "rep\n\t"
; 168  : 			   "stosw"
; 169  : 		::"a" (video_erase_char), "c" ((video_num_lines - 1) * video_num_columns >> 1), 
; 170  : 		       "D" (video_mem_start), "S" (origin):"cx", "di","si"); */
; 171  : // 根据屏幕内存数据移动后的情况，重新调整当前屏幕对应内存的起始指针、光标位置指针和屏幕末端
; 172  : // 对应内存指针scr_end。
; 173  : 				scr_end -= origin - video_mem_start;

	mov	ecx, DWORD PTR _video_mem_start
	mov	edi, DWORD PTR _origin
	mov	esi, DWORD PTR _scr_end

; 174  : 				pos -= origin - video_mem_start;

	mov	edx, DWORD PTR _pos
	mov	eax, ecx

; 175  : 				origin = video_mem_start;

	mov	DWORD PTR _origin, ecx
	sub	eax, edi
	add	esi, eax
	add	edx, eax
	mov	DWORD PTR _scr_end, esi
	mov	DWORD PTR _pos, edx

; 176  : 			}
; 177  : 			else

	jmp	SHORT $L735
$L734:

; 178  : 			{
; 179  : // 如果调整后的屏幕末端对应的内存指针scr_end 没有超出显示内存的末端video_mem_end，则只需在
; 180  : // 新行上填入擦除字符(空格字符)。
; 181  : // %0 - eax(擦除字符+属性)；%1 - ecx(显示器字符行数)；%2 - edi(屏幕对应内存最后一行开始处)；
; 182  : 				t1 = scr_end - video_size_row;

	sub	ecx, eax
	mov	DWORD PTR _t1$[ebp], ecx

; 183  : 				_asm {
; 184  : 					pushf

	pushf

; 185  : 					mov ax,video_erase_char;

	mov	ax, WORD PTR _video_erase_char

; 186  : 					mov ecx,video_num_columns;

	mov	ecx, DWORD PTR _video_num_columns

; 187  : 					mov edi,t1;

	mov	edi, DWORD PTR _t1$[ebp]

; 188  : //			  mov edi,(scr_end - video_size_row);
; 189  : 					cld;	// 清方向位。

	cld

; 190  : 					rep stosw;	// 重复操作，在新出现行上填入擦除字符(空格字符)。

	rep	 stosw

; 191  : 					popf

	popf

; 178  : 			{
; 179  : // 如果调整后的屏幕末端对应的内存指针scr_end 没有超出显示内存的末端video_mem_end，则只需在
; 180  : // 新行上填入擦除字符(空格字符)。
; 181  : // %0 - eax(擦除字符+属性)；%1 - ecx(显示器字符行数)；%2 - edi(屏幕对应内存最后一行开始处)；
; 182  : 				t1 = scr_end - video_size_row;

$L735:

; 129  : 	unsigned long t1,t2,t3;

	cli

; 192  : 				}
; 193  : /*		  __asm__ ("cld\n\t"
; 194  : 		       "rep\n\t"
; 195  : 		       "stosw" 
; 196  : 			::"a" (video_erase_char), "c" (video_num_columns), 
; 197  : 		      "D" (scr_end - video_size_row):"cx","di");*/
; 198  : 			} 
; 199  : // 向显示控制器中写入新的屏幕内容对应的内存起始位置值。
; 200  : 			set_origin ();

	mov	BYTE PTR $T1220[ebp], 12		; 0000000cH

; 129  : 	unsigned long t1,t2,t3;

	mov	al, BYTE PTR $T1220[ebp]

; 130  : 

	mov	dx, WORD PTR _video_port_reg

; 131  : // 如果显示类型是EGA，则执行以下操作。

	out	dx, al

; 132  : 	if (video_type == VIDEO_TYPE_EGAC || video_type == VIDEO_TYPE_EGAM)

	jmp	SHORT $l1$1242
$l1$1242:

; 133  : 	{

	jmp	SHORT $l2$1243
$l2$1243:

; 192  : 				}
; 193  : /*		  __asm__ ("cld\n\t"
; 194  : 		       "rep\n\t"
; 195  : 		       "stosw" 
; 196  : 			::"a" (video_erase_char), "c" (video_num_columns), 
; 197  : 		      "D" (scr_end - video_size_row):"cx","di");*/
; 198  : 			} 
; 199  : // 向显示控制器中写入新的屏幕内容对应的内存起始位置值。
; 200  : 			set_origin ();

	mov	edx, DWORD PTR _origin
	mov	edi, DWORD PTR _video_mem_start
	sub	edx, edi
	shr	edx, 9
	mov	BYTE PTR $T1226[ebp], dl

; 129  : 	unsigned long t1,t2,t3;

	mov	al, BYTE PTR $T1226[ebp]

; 130  : 

	mov	dx, WORD PTR _video_port_val

; 131  : // 如果显示类型是EGA，则执行以下操作。

	out	dx, al

; 132  : 	if (video_type == VIDEO_TYPE_EGAC || video_type == VIDEO_TYPE_EGAM)

	jmp	SHORT $l1$1246
$l1$1246:

; 133  : 	{

	jmp	SHORT $l2$1247
$l2$1247:

; 192  : 				}
; 193  : /*		  __asm__ ("cld\n\t"
; 194  : 		       "rep\n\t"
; 195  : 		       "stosw" 
; 196  : 			::"a" (video_erase_char), "c" (video_num_columns), 
; 197  : 		      "D" (scr_end - video_size_row):"cx","di");*/
; 198  : 			} 
; 199  : // 向显示控制器中写入新的屏幕内容对应的内存起始位置值。
; 200  : 			set_origin ();

	mov	BYTE PTR $T1232[ebp], 13		; 0000000dH

; 129  : 	unsigned long t1,t2,t3;

	mov	al, BYTE PTR $T1232[ebp]

; 130  : 

	mov	dx, WORD PTR _video_port_reg

; 131  : // 如果显示类型是EGA，则执行以下操作。

	out	dx, al

; 132  : 	if (video_type == VIDEO_TYPE_EGAC || video_type == VIDEO_TYPE_EGAM)

	jmp	SHORT $l1$1250
$l1$1250:

; 133  : 	{

	jmp	SHORT $l2$1251
$l2$1251:

; 192  : 				}
; 193  : /*		  __asm__ ("cld\n\t"
; 194  : 		       "rep\n\t"
; 195  : 		       "stosw" 
; 196  : 			::"a" (video_erase_char), "c" (video_num_columns), 
; 197  : 		      "D" (scr_end - video_size_row):"cx","di");*/
; 198  : 			} 
; 199  : // 向显示控制器中写入新的屏幕内容对应的内存起始位置值。
; 200  : 			set_origin ();

	mov	eax, DWORD PTR _origin
	mov	edx, DWORD PTR _video_mem_start
	sub	eax, edx
	shr	eax, 1
	mov	BYTE PTR $T1238[ebp], al

; 129  : 	unsigned long t1,t2,t3;

	mov	al, BYTE PTR $T1238[ebp]

; 130  : 

	mov	dx, WORD PTR _video_port_val

; 131  : // 如果显示类型是EGA，则执行以下操作。

	out	dx, al

; 132  : 	if (video_type == VIDEO_TYPE_EGAC || video_type == VIDEO_TYPE_EGAM)

	jmp	SHORT $l1$1254
$l1$1254:

; 133  : 	{

	jmp	SHORT $l2$1255
$l2$1255:

; 136  : 		{
; 137  : // 调整屏幕显示对应内存的起始位置指针origin 为向下移一行屏幕字符对应的内存位置，同时也调整

	sti

; 259  : 		}
; 260  : /*    __asm__ ("cld\n\t" "rep\n\t" "movsl\n\t" \
; 261  : 		"movl _video_num_columns,%%ecx\n\t" "rep\n\t" "stosw"\
; 262  : 		::"a" (video_erase_char), \
; 263  : 		"c" ((bottom - top - 1) * video_num_columns >> 1), \
; 264  : 		"D" (origin + video_size_row * top), \
; 265  : 		"S" (origin + video_size_row * (top + 1)):"cx", "di","si");*/
; 266  : 	}
; 267  : }

	pop	edi
	pop	esi
	mov	esp, ebp
	pop	ebp
	ret	0
$L733:

; 201  : // 否则表示不是整屏移动。也即表示从指定行top 开始的所有行向上移动1 行(删除1 行)。此时直接
; 202  : // 将屏幕从指定行top 到屏幕末端所有行对应的显示内存数据向上移动1 行，并在新出现的行上填入擦
; 203  : // 除字符。
; 204  : // %0-eax(擦除字符+属性)；%1-ecx(top 行下1 行开始到屏幕末行的行数所对应的内存长字数)；
; 205  : // %2-edi(top 行所处的内存位置)；%3-esi(top+1 行所处的内存位置)。
; 206  : 		}
; 207  : 		else
; 208  : 		{
; 209  : 			t1 = (bottom - top - 1) * video_num_columns >> 1;

	sub	eax, ecx

; 210  : 			t2 = origin + video_size_row * top;

	mov	edx, DWORD PTR _origin
	dec	eax
	imul	eax, DWORD PTR _video_num_columns
	shr	eax, 1
	mov	DWORD PTR _t1$[ebp], eax
	mov	eax, DWORD PTR _video_size_row
	mov	esi, eax
	imul	esi, ecx
	add	esi, edx

; 211  : 			t3 = origin + video_size_row * (top + 1);

	inc	ecx
	imul	ecx, eax
	add	ecx, edx
	mov	DWORD PTR _t2$[ebp], esi
	mov	DWORD PTR _t3$[ebp], ecx

; 212  : 			_asm {
; 213  : 				pushf

	pushf

; 214  : //		  mov ecx,((bottom - top - 1) * video_num_columns >> 1);
; 215  : 				mov ecx,t1;

	mov	ecx, DWORD PTR _t1$[ebp]

; 216  : //		  mov edi,(origin + video_size_row * top);
; 217  : 				mov edi,t2;

	mov	edi, DWORD PTR _t2$[ebp]

; 218  : //		  mov esi,(origin + video_size_row * (top + 1));
; 219  : 				mov esi,t3;

	mov	esi, DWORD PTR _t3$[ebp]

; 220  : 				mov ax,video_erase_char;

	mov	ax, WORD PTR _video_erase_char

; 221  : 				cld;	// 清方向位。

	cld

; 222  : 				rep movsd;// 循环操作，将top+1 到bottom 行 所对应的内存块移到top 行开始处。

	rep	 movsd

; 223  : 				mov ecx,video_num_columns;	// ecx = 1 行字符数。

	mov	ecx, DWORD PTR _video_num_columns

; 224  : 				rep stosw;// 在新行上填入擦除字符。

	rep	 stosw

; 225  : 				popf

	popf

; 259  : 		}
; 260  : /*    __asm__ ("cld\n\t" "rep\n\t" "movsl\n\t" \
; 261  : 		"movl _video_num_columns,%%ecx\n\t" "rep\n\t" "stosw"\
; 262  : 		::"a" (video_erase_char), \
; 263  : 		"c" ((bottom - top - 1) * video_num_columns >> 1), \
; 264  : 		"D" (origin + video_size_row * top), \
; 265  : 		"S" (origin + video_size_row * (top + 1)):"cx", "di","si");*/
; 266  : 	}
; 267  : }

	pop	edi
	pop	esi
	mov	esp, ebp
	pop	ebp
	ret	0
_scrup	ENDP
_ri	PROC NEAR

; 368  : // 如果光标不在第1 行上，则直接修改光标当前行标量y--，并调整光标对应显示内存位置pos，减去
; 369  : // 屏幕上一行字符所对应的内存长度字节数。
; 370  : 	if (y > top)

	mov	eax, DWORD PTR _y
	mov	ecx, DWORD PTR _top
	cmp	eax, ecx
	jbe	SHORT $L754

; 371  : 	{
; 372  : 		y--;

	mov	ecx, eax

; 373  : 		pos -= video_size_row;

	mov	eax, DWORD PTR _pos
	dec	ecx
	mov	DWORD PTR _y, ecx
	mov	ecx, DWORD PTR _video_size_row
	sub	eax, ecx
	mov	DWORD PTR _pos, eax

; 378  : }

	ret	0
$L754:

; 374  : 		return;
; 375  : 	}
; 376  : // 否则需要将屏幕内容下移一行。
; 377  : 	scrdown ();

	jmp	_scrdown
_ri	ENDP
_t1$ = -12
_t2$ = -8
_t3$ = -4
_scrdown PROC NEAR

; 275  : {

	push	ebp
	mov	ebp, esp
	sub	esp, 12					; 0000000cH

; 276  : 	unsigned long t1,t2,t3;
; 277  : // 如果显示类型是EGA，则执行下列操作。
; 278  : // [??好象if 和else 的操作完全一样啊!为什么还要分别处理呢？难道与任务切换有关？]
; 279  : 	if (video_type == VIDEO_TYPE_EGAC || video_type == VIDEO_TYPE_EGAM)

	mov	al, BYTE PTR _video_type
	push	esi
	cmp	al, 33					; 00000021H
	push	edi
	je	SHORT $L745
	cmp	al, 32					; 00000020H
	je	SHORT $L745

; 302  : 		}
; 303  : /*      __asm__ ("std\n\t"
; 304  : 	       "rep\n\t"
; 305  : 	       "movsl\n\t"	// 
; 306  : 	       "addl $2,%%edi\n\t"
; 307  : 	       "movl _video_num_columns,%%ecx\n\t"
; 308  : 	       "rep\n\t"
; 309  : 		   "stosw":
; 310  : 	:"a" (video_erase_char), \
; 311  : 	"c" ((bottom - top - 1) * video_num_columns >> 1), \
; 312  : 	"D" (origin + video_size_row * bottom - 4), \
; 313  : 	"S" (origin + video_size_row * (bottom - 1) - 4)
; 314  : 	:"ax", "cx", "di", "si");*/
; 315  : 	}
; 316  : // 如果不是EGA 显示类型，则执行以下操作（目前与上面完全一样）。
; 317  : 	else				/* Not EGA/VGA */
; 318  : 	{
; 319  : 		t1 = (bottom - top - 1) * video_num_columns >> 1;

	mov	eax, DWORD PTR _bottom
	mov	edi, DWORD PTR _top
	mov	ecx, eax

; 320  : 		t2 = origin + video_size_row * bottom - 4;

	mov	edx, DWORD PTR _origin
	sub	ecx, edi
	dec	ecx
	imul	ecx, DWORD PTR _video_num_columns
	shr	ecx, 1
	mov	DWORD PTR _t1$[ebp], ecx
	mov	ecx, DWORD PTR _video_size_row
	mov	esi, ecx
	imul	esi, eax

; 321  : 		t3 = origin + video_size_row * (bottom - 1) - 4;

	dec	eax
	imul	eax, ecx
	lea	esi, DWORD PTR [esi+edx-4]
	lea	edx, DWORD PTR [eax+edx-4]
	mov	DWORD PTR _t2$[ebp], esi
	mov	DWORD PTR _t3$[ebp], edx

; 322  : 		_asm {
; 323  : 			pushf

	pushf

; 324  : 			mov ecx,t1;

	mov	ecx, DWORD PTR _t1$[ebp]

; 325  : //		  mov ecx,((bottom - top - 1) * video_num_columns >> 1);
; 326  : 			mov edi,t2;

	mov	edi, DWORD PTR _t2$[ebp]

; 327  : //		  mov edi,(origin + video_size_row * bottom - 4);
; 328  : 			mov esi,t3;

	mov	esi, DWORD PTR _t3$[ebp]

; 329  : //		  mov esi,(origin + video_size_row * (bottom - 1) - 4);
; 330  : 			mov ax,video_erase_char;

	mov	ax, WORD PTR _video_erase_char

; 331  : 			std;

	std

; 332  : 			rep movsd;

	rep	 movsd

; 333  : 			add edi,2;/* %edi has been decremented by 4 */

	add	edi, 2

; 334  : 			mov ecx,video_num_columns;

	mov	ecx, DWORD PTR _video_num_columns

; 335  : 			rep stosw;

	rep	 stosw

; 336  : 			popf

	popf

; 337  : 		}
; 338  :  /*     __asm__ ("std\n\t" "rep\n\t" "movsl\n\t" "addl $2,%%edi\n\t"
; 339  : 				"movl _video_num_columns,%%ecx\n\t" "rep\n\t" "stosw":
; 340  : 			:"a" (video_erase_char), 
; 341  : 			"c" ((bottom - top - 1) * video_num_columns >> 1), 
; 342  : 			"D" (origin + video_size_row * bottom - 4), 
; 343  : 			"S" (origin + video_size_row * (bottom - 1) - 4)
; 344  : 	       :"ax", "cx", "di","si");*/
; 345  : 	}
; 346  : }

	pop	edi
	pop	esi
	mov	esp, ebp
	pop	ebp
	ret	0
$L745:

; 280  : 	{
; 281  : // %0-eax(擦除字符+属性)；%1-ecx(top 行开始到屏幕末行-1 行的行数所对应的内存长字数)；
; 282  : // %2-edi(屏幕右下角最后一个长字位置)；%3-esi(屏幕倒数第2 行最后一个长字位置)。
; 283  : // 移动方向：[esi]??[edi]，移动ecx 个长字。
; 284  : 		t1 = (bottom - top - 1) * video_num_columns >> 1;

	mov	eax, DWORD PTR _bottom
	mov	edi, DWORD PTR _top
	mov	ecx, eax

; 285  : 		t2 = origin + video_size_row * bottom - 4;

	mov	edx, DWORD PTR _origin
	sub	ecx, edi
	dec	ecx
	imul	ecx, DWORD PTR _video_num_columns
	shr	ecx, 1
	mov	DWORD PTR _t1$[ebp], ecx
	mov	ecx, DWORD PTR _video_size_row
	mov	esi, ecx
	imul	esi, eax

; 286  : 		t3 = origin + video_size_row * (bottom - 1) - 4;

	dec	eax
	imul	eax, ecx
	lea	esi, DWORD PTR [esi+edx-4]
	lea	edx, DWORD PTR [eax+edx-4]
	mov	DWORD PTR _t2$[ebp], esi
	mov	DWORD PTR _t3$[ebp], edx

; 287  : 		_asm {
; 288  : 			pushf

	pushf

; 289  : 			mov ecx,t1;

	mov	ecx, DWORD PTR _t1$[ebp]

; 290  : //		  mov ecx,((bottom - top - 1) * video_num_columns >> 1);
; 291  : 			mov edi,t2;

	mov	edi, DWORD PTR _t2$[ebp]

; 292  : //		  mov edi,(origin + video_size_row * bottom - 4);
; 293  : 			mov esi,t3;

	mov	esi, DWORD PTR _t3$[ebp]

; 294  : //		  mov esi,(origin + video_size_row * (bottom - 1) - 4);
; 295  : 			mov ax,video_erase_char;

	mov	ax, WORD PTR _video_erase_char

; 296  : 			std;	// 置方向位。

	std

; 297  : 			rep movsd;	// 重复操作，向下移动从top 行到bottom-1 行对应的内存数据。

	rep	 movsd

; 298  : 			add edi,2;	/* %edi 已经减4，因为也是方向填擦除字符 */

	add	edi, 2

; 299  : 			mov ecx,video_num_columns;	// 置ecx=1 行字符数。

	mov	ecx, DWORD PTR _video_num_columns

; 300  : 			rep stosw;	// 将擦除字符填入上方新行中。

	rep	 stosw

; 301  : 			popf

	popf

; 337  : 		}
; 338  :  /*     __asm__ ("std\n\t" "rep\n\t" "movsl\n\t" "addl $2,%%edi\n\t"
; 339  : 				"movl _video_num_columns,%%ecx\n\t" "rep\n\t" "stosw":
; 340  : 			:"a" (video_erase_char), 
; 341  : 			"c" ((bottom - top - 1) * video_num_columns >> 1), 
; 342  : 			"D" (origin + video_size_row * bottom - 4), 
; 343  : 			"S" (origin + video_size_row * (bottom - 1) - 4)
; 344  : 	       :"ax", "cx", "di","si");*/
; 345  : 	}
; 346  : }

	pop	edi
	pop	esi
	mov	esp, ebp
	pop	ebp
	ret	0
_scrdown ENDP
_cr	PROC NEAR

; 384  : // 光标所在的列号*2 即0 列到光标所在列对应的内存字节长度。
; 385  : 	pos -= x << 1;

	mov	eax, DWORD PTR _x

; 386  : 	x = 0;

	mov	DWORD PTR _x, 0
	lea	ecx, DWORD PTR [eax+eax]
	mov	eax, DWORD PTR _pos
	sub	eax, ecx
	mov	DWORD PTR _pos, eax

; 387  : }

	ret	0
_cr	ENDP
_del	PROC NEAR

; 393  : // 如果光标没有处在0 列，则将光标对应内存位置指针pos 后退2 字节(对应屏幕上一个字符)，然后
; 394  : // 将当前光标变量列值减1，并将光标所在位置字符擦除。
; 395  : 	if (x)

	mov	eax, DWORD PTR _x
	test	eax, eax
	je	SHORT $L761

; 396  : 	{
; 397  : 		pos -= 2;

	mov	eax, DWORD PTR _pos

; 398  : 		x--;

	mov	ecx, DWORD PTR _x
	sub	eax, 2
	dec	ecx
	mov	DWORD PTR _x, ecx

; 399  : 		*(unsigned short *) pos = video_erase_char;

	mov	cx, WORD PTR _video_erase_char
	mov	DWORD PTR _pos, eax
	mov	WORD PTR [eax], cx
$L761:

; 400  : 	}
; 401  : }

	ret	0
_del	ENDP
_par$ = 8
_count$ = -4
_start$ = 8
_csi_J	PROC NEAR

; 409  : {

	push	ebp
	mov	ebp, esp
	push	ecx

; 410  : 	long count; //__asm__ ("cx")	// 设为寄存器变量。
; 411  : 	long start; //__asm__ ("di")
; 412  : 
; 413  : // 首先根据三种情况分别设置需要删除的字符数和删除开始的显示内存位置。
; 414  : 	switch (par)
; 415  : 	{

	mov	eax, DWORD PTR _par$[ebp]
	push	edi
	sub	eax, 0
	je	SHORT $L773
	dec	eax
	je	SHORT $L774
	dec	eax
	jne	SHORT $L766

; 424  : 	case 2:			/* erase whole display *//* 删除整个屏幕上的字符 */
; 425  : 		count = video_num_columns * video_num_lines;

	mov	eax, DWORD PTR _video_num_lines

; 426  : 		start = origin;

	mov	ecx, DWORD PTR _origin
	imul	eax, DWORD PTR _video_num_columns
	mov	DWORD PTR _count$[ebp], eax
	mov	DWORD PTR _start$[ebp], ecx

; 427  : 		break;

	jmp	SHORT $L770
$L774:

; 419  : 		break;
; 420  : 	case 1:			/* erase from start to cursor *//* 删除从屏幕开始到光标处的字符 */
; 421  : 		count = (pos - origin) >> 1;

	mov	edx, DWORD PTR _pos
	mov	eax, DWORD PTR _origin
	sub	edx, eax
	shr	edx, 1
	mov	DWORD PTR _count$[ebp], edx

; 422  : 		start = origin;
; 423  : 		break;

	jmp	SHORT $L1262
$L773:

; 416  : 	case 0:			/* erase from cursor to end of display *//* 擦除光标到屏幕底端 */
; 417  : 		count = (scr_end - pos) >> 1;

	mov	ecx, DWORD PTR _scr_end
	mov	eax, DWORD PTR _pos
	sub	ecx, eax
	shr	ecx, 1
	mov	DWORD PTR _count$[ebp], ecx
$L1262:

; 418  : 		start = pos;

	mov	DWORD PTR _start$[ebp], eax
$L770:

; 428  : 	default:
; 429  : 		return;
; 430  : 	}
; 431  : // 然后使用擦除字符填写删除字符的地方。
; 432  : // %0 - ecx(要删除的字符数count)；%1 - edi(删除操作开始地址)；%2 - eax（填入的擦除字符）。
; 433  : 	_asm {
; 434  : 		pushf

	pushf

; 435  : 		mov ecx,count;

	mov	ecx, DWORD PTR _count$[ebp]

; 436  : 		mov edi,start;

	mov	edi, DWORD PTR _start$[ebp]

; 437  : 		mov ax,video_erase_char;

	mov	ax, WORD PTR _video_erase_char

; 438  : 		cld;

	cld

; 439  : 		rep stosw;

	rep	 stosw

; 440  : 		popf

	popf
$L766:

; 441  : 	}
; 442  : /*  __asm__ ("cld\n\t" "rep\n\t" "stosw\n\t"
; 443  : 	::"c" (count), "D" (start), "a" (video_erase_char):"cx", "di");*/
; 444  : }

	pop	edi
	mov	esp, ebp
	pop	ebp
	ret	0
_csi_J	ENDP
_par$ = 8
_count$ = 8
_start$ = -4
_csi_K	PROC NEAR

; 450  : {

	push	ebp
	mov	ebp, esp
	push	ecx

; 451  : 	long count; //__asm__ ("cx")	// 设置寄存器变量。
; 452  : 	long start; //__asm__ ("di")
; 453  : 
; 454  : // 首先根据三种情况分别设置需要删除的字符数和删除开始的显示内存位置。
; 455  : 	switch (par)
; 456  : 	{

	mov	eax, DWORD PTR _par$[ebp]
	push	edi
	sub	eax, 0
	je	SHORT $L787
	dec	eax
	je	SHORT $L789
	dec	eax
	jne	SHORT $L780

; 467  : 	case 2:			/* erase whole line *//* 将整行字符全删除 */
; 468  : 		start = pos - (x << 1);

	mov	eax, DWORD PTR _x
	mov	edx, DWORD PTR _pos
	lea	ecx, DWORD PTR [eax+eax]

; 469  : 		count = video_num_columns;

	mov	eax, DWORD PTR _video_num_columns
	sub	edx, ecx
	mov	DWORD PTR _count$[ebp], eax
	mov	DWORD PTR _start$[ebp], edx

; 470  : 		break;

	jmp	SHORT $L784
$L789:

; 462  : 		break;
; 463  : 	case 1:			/* erase from start of line to cursor *//* 删除从行开始到光标处 */
; 464  : 		start = pos - (x << 1);

	mov	eax, DWORD PTR _x
	mov	edx, DWORD PTR _pos
	lea	ecx, DWORD PTR [eax+eax]
	sub	edx, ecx

; 465  : 		count = (x < video_num_columns) ? x : video_num_columns;

	mov	ecx, DWORD PTR _video_num_columns
	cmp	eax, ecx
	mov	DWORD PTR _start$[ebp], edx
	jae	SHORT $L1264
	mov	DWORD PTR _count$[ebp], eax
	jmp	SHORT $L784
$L1264:
	mov	DWORD PTR _count$[ebp], ecx

; 466  : 		break;

	jmp	SHORT $L784
$L787:

; 457  : 	case 0:			/* erase from cursor to end of line *//* 删除光标到行尾字符 */
; 458  : 		if (x >= video_num_columns)

	mov	ecx, DWORD PTR _x
	mov	eax, DWORD PTR _video_num_columns
	cmp	ecx, eax
	jae	SHORT $L780

; 459  : 			return;
; 460  : 		count = video_num_columns - x;

	sub	eax, ecx
	mov	DWORD PTR _count$[ebp], eax

; 461  : 		start = pos;

	mov	eax, DWORD PTR _pos
	mov	DWORD PTR _start$[ebp], eax
$L784:

; 471  : 	default:
; 472  : 		return;
; 473  : 	}
; 474  : // 然后使用擦除字符填写删除字符的地方。
; 475  : // %0 - ecx(要删除的字符数count)；%1 - edi(删除操作开始地址)；%2 - eax（填入的擦除字符）。
; 476  : 	_asm {
; 477  : 		pushf

	pushf

; 478  : 		mov ecx,count;

	mov	ecx, DWORD PTR _count$[ebp]

; 479  : 		mov edi,start;

	mov	edi, DWORD PTR _start$[ebp]

; 480  : 		mov ax,video_erase_char;

	mov	ax, WORD PTR _video_erase_char

; 481  : 		cld;

	cld

; 482  : 		rep stosw;

	rep	 stosw

; 483  : 		popf

	popf
$L780:

; 484  : 	}
; 485  : /*  __asm__ ("cld\n\t" "rep\n\t" "stosw\n\t"
; 486  : 	::"c" (count), "D" (start), "a" (video_erase_char):"cx", "di");*/
; 487  : }

	pop	edi
	mov	esp, ebp
	pop	ebp
	ret	0
_csi_K	ENDP
_TEXT	ENDS
EXTRN	_copy_to_cooked:NEAR
_DATA	SEGMENT
	ORG $+3
$SG826	DB	01bH, '[?1;2c', 00H
_DATA	ENDS
_TEXT	SEGMENT
_tty$ = 8
_respond PROC NEAR

; 537  : {

	push	ebp
	mov	ebp, esp

; 538  : 	char *p = RESPONSE;

	mov	edx, OFFSET FLAT:$SG826

; 539  : 
; 540  : 	cli ();			// 关中断。

	cli

; 541  : 	while (*p)

	mov	cl, BYTE PTR $SG826
	mov	eax, DWORD PTR _tty$[ebp]
	test	cl, cl
	je	SHORT $L829
	push	esi
$L828:

; 542  : 	{				// 将字符序列放入写队列。
; 543  : 		PUTCH (*p, tty->read_q);

	mov	esi, DWORD PTR [eax+52]
	mov	BYTE PTR [esi+eax+64], cl
	mov	ecx, DWORD PTR [eax+52]
	inc	ecx
	and	ecx, 1023				; 000003ffH

; 544  : 		p++;

	inc	edx
	mov	DWORD PTR [eax+52], ecx
	mov	cl, BYTE PTR [edx]
	test	cl, cl
	jne	SHORT $L828
	pop	esi
$L829:

; 545  : 	}
; 546  : 	sti ();			// 开中断。

	sti

; 547  : 	copy_to_cooked (tty);		// 转换成规范模式(放入辅助队列中)。

	push	eax
	call	_copy_to_cooked
	add	esp, 4

; 548  : }

	pop	ebp
	ret	0
_respond ENDP
_nr$ = 8
_csi_at	PROC NEAR

; 627  : {

	push	ebp
	mov	ebp, esp

; 628  : // 如果插入的字符数大于一行字符数，则截为一行字符数；若插入字符数nr 为0，则插入1 个字符。
; 629  : 	if (nr > video_num_columns)

	mov	eax, DWORD PTR _nr$[ebp]
	mov	ecx, DWORD PTR _video_num_columns
	cmp	eax, ecx
	jbe	SHORT $L866

; 630  : 		nr = video_num_columns;

	mov	eax, ecx

; 631  : 	else if (!nr)

	jmp	SHORT $L1270
$L866:
	test	eax, eax
	jne	SHORT $L1270

; 632  : 		nr = 1;

	mov	eax, 1
$L1270:

; 633  : // 循环插入指定的字符数。
; 634  : 	while (nr--)

	mov	ecx, eax
	dec	eax
	test	ecx, ecx
	je	SHORT $L871
	push	esi
	lea	esi, DWORD PTR [eax+1]
$L870:

; 635  : 		insert_char ();

	call	_insert_char
	dec	esi
	jne	SHORT $L870
	pop	esi
$L871:

; 636  : }

	pop	ebp
	ret	0
_csi_at	ENDP
_insert_char PROC NEAR

; 554  : 	unsigned long i = x;
; 555  : 	unsigned short tmp, old = video_erase_char;
; 556  : 	unsigned short *p = (unsigned short *) pos;
; 557  : 
; 558  : // 光标开始的所有字符右移一格，并将擦除字符插入在光标所在处。
; 559  : // 若一行上都有字符的话，则行最后一个字符将不会更动??
; 560  : 	while (i++ < video_num_columns)

	mov	edx, DWORD PTR _video_num_columns
	mov	ecx, DWORD PTR _video_erase_char
	mov	eax, DWORD PTR _pos
	push	esi
	mov	esi, DWORD PTR _x
	push	edi
	cmp	esi, edx
	lea	edi, DWORD PTR [esi+1]
	jae	SHORT $L841
	sub	edx, edi
	inc	edx
	mov	esi, edx
$L840:

; 561  : 	{
; 562  : 		tmp = *p;

	mov	dx, WORD PTR [eax]

; 563  : 		*p = old;

	mov	WORD PTR [eax], cx

; 564  : 		old = tmp;
; 565  : 		p++;

	add	eax, 2
	dec	esi
	mov	ecx, edx
	jne	SHORT $L840
$L841:
	pop	edi
	pop	esi

; 566  : 	}
; 567  : }

	ret	0
_insert_char ENDP
_nr$ = 8
_csi_L	PROC NEAR

; 642  : {

	push	ebp
	mov	ebp, esp

; 643  : // 如果插入的行数大于屏幕最多行数，则截为屏幕显示行数；若插入行数nr 为0，则插入1 行。
; 644  : 	if (nr > video_num_lines)

	mov	eax, DWORD PTR _nr$[ebp]
	mov	ecx, DWORD PTR _video_num_lines
	cmp	eax, ecx
	jbe	SHORT $L876

; 645  : 		nr = video_num_lines;

	mov	eax, ecx

; 646  : 	else if (!nr)

	jmp	SHORT $L1276
$L876:
	test	eax, eax
	jne	SHORT $L1276

; 647  : 		nr = 1;

	mov	eax, 1
$L1276:

; 648  : // 循环插入指定行数nr。
; 649  : 	while (nr--)

	mov	ecx, eax
	dec	eax
	test	ecx, ecx
	je	SHORT $L881
	push	esi
	lea	esi, DWORD PTR [eax+1]
$L880:

; 650  : 		insert_line ();

	call	_insert_line
	dec	esi
	jne	SHORT $L880
	pop	esi
$L881:

; 651  : }

	pop	ebp
	ret	0
_csi_L	ENDP
_insert_line PROC NEAR

; 574  : 	int oldtop, oldbottom;
; 575  : 
; 576  : 	oldtop = top;			// 保存原top，bottom 值。
; 577  : 	oldbottom = bottom;
; 578  : 	top = y;			// 设置屏幕卷动开始行。

	mov	eax, DWORD PTR _y

; 579  : 	bottom = video_num_lines;	// 设置屏幕卷动最后行。

	mov	ecx, DWORD PTR _video_num_lines
	push	esi
	mov	esi, DWORD PTR _top
	push	edi
	mov	edi, DWORD PTR _bottom
	mov	DWORD PTR _top, eax
	mov	DWORD PTR _bottom, ecx

; 580  : 	scrdown ();			// 从光标开始处，屏幕内容向下滚动一行。

	call	_scrdown

; 581  : 	top = oldtop;			// 恢复原top，bottom 值。
; 582  : 	bottom = oldbottom;

	mov	DWORD PTR _bottom, edi
	mov	DWORD PTR _top, esi
	pop	edi
	pop	esi

; 583  : }

	ret	0
_insert_line ENDP
_nr$ = 8
_csi_P	PROC NEAR

; 657  : {

	push	ebp
	mov	ebp, esp

; 658  : // 如果删除的字符数大于一行字符数，则截为一行字符数；若删除字符数nr 为0，则删除1 个字符。
; 659  : 	if (nr > video_num_columns)

	mov	eax, DWORD PTR _nr$[ebp]
	mov	ecx, DWORD PTR _video_num_columns
	cmp	eax, ecx
	jbe	SHORT $L886

; 660  : 		nr = video_num_columns;

	mov	eax, ecx

; 661  : 	else if (!nr)

	jmp	SHORT $L1280
$L886:
	test	eax, eax
	jne	SHORT $L1280

; 662  : 		nr = 1;

	mov	eax, 1
$L1280:

; 663  : // 循环删除指定字符数nr。
; 664  : 	while (nr--)

	mov	ecx, eax
	dec	eax
	test	ecx, ecx
	je	SHORT $L891
	push	esi
	lea	esi, DWORD PTR [eax+1]
$L890:

; 665  : 		delete_char ();

	call	_delete_char
	dec	esi
	jne	SHORT $L890
	pop	esi
$L891:

; 666  : }

	pop	ebp
	ret	0
_csi_P	ENDP
_delete_char PROC NEAR

; 589  : 	unsigned long i;
; 590  : 	unsigned short *p = (unsigned short *) pos;
; 591  : 
; 592  : // 如果光标超出屏幕最右列，则返回。
; 593  : 	if (x >= video_num_columns)

	mov	ecx, DWORD PTR _x
	mov	eax, DWORD PTR _video_num_columns
	mov	edx, DWORD PTR _pos
	cmp	ecx, eax
	jae	SHORT $L849

; 594  : 		return;
; 595  : // 从光标右一个字符开始到行末所有字符左移一格。
; 596  : 	i = x;
; 597  : 	while (++i < video_num_columns)

	inc	ecx
	cmp	ecx, eax
	jae	SHORT $L855
	sub	eax, ecx
	push	esi
	mov	ecx, eax
	push	edi
	lea	esi, DWORD PTR [edx+2]
	mov	edi, edx
	shr	ecx, 1
	rep movsd
	adc	ecx, ecx
	lea	edx, DWORD PTR [edx+eax*2]
	rep movsw
	pop	edi
	pop	esi
$L855:

; 598  : 	{
; 599  : 		*p = *(p + 1);
; 600  : 		p++;
; 601  : 	}
; 602  : // 最后一个字符处填入擦除字符(空格字符)。
; 603  : 	*p = video_erase_char;

	mov	ax, WORD PTR _video_erase_char
	mov	WORD PTR [edx], ax
$L849:

; 604  : }

	ret	0
_delete_char ENDP
_nr$ = 8
_csi_M	PROC NEAR

; 672  : {

	push	ebp
	mov	ebp, esp

; 673  : // 如果删除的行数大于屏幕最多行数，则截为屏幕显示行数；若删除的行数nr 为0，则删除1 行。
; 674  : 	if (nr > video_num_lines)

	mov	eax, DWORD PTR _nr$[ebp]
	mov	ecx, DWORD PTR _video_num_lines
	cmp	eax, ecx
	jbe	SHORT $L896

; 675  : 		nr = video_num_lines;

	mov	eax, ecx

; 676  : 	else if (!nr)

	jmp	SHORT $L1286
$L896:
	test	eax, eax
	jne	SHORT $L1286

; 677  : 		nr = 1;

	mov	eax, 1
$L1286:

; 678  : // 循环删除指定行数nr。
; 679  : 	while (nr--)

	mov	ecx, eax
	dec	eax
	test	ecx, ecx
	je	SHORT $L901
	push	esi
	lea	esi, DWORD PTR [eax+1]
$L900:

; 680  : 		delete_line ();

	call	_delete_line
	dec	esi
	jne	SHORT $L900
	pop	esi
$L901:

; 681  : }

	pop	ebp
	ret	0
_csi_M	ENDP
_delete_line PROC NEAR

; 611  : 	int oldtop, oldbottom;
; 612  : 
; 613  : 	oldtop = top;			// 保存原top，bottom 值。
; 614  : 	oldbottom = bottom;
; 615  : 	top = y;			// 设置屏幕卷动开始行。

	mov	eax, DWORD PTR _y

; 616  : 	bottom = video_num_lines;	// 设置屏幕卷动最后行。

	mov	ecx, DWORD PTR _video_num_lines
	push	esi
	mov	esi, DWORD PTR _top
	push	edi
	mov	edi, DWORD PTR _bottom
	mov	DWORD PTR _top, eax
	mov	DWORD PTR _bottom, ecx

; 617  : 	scrup ();			// 从光标开始处，屏幕内容向上滚动一行。

	call	_scrup

; 618  : 	top = oldtop;			// 恢复原top，bottom 值。
; 619  : 	bottom = oldbottom;

	mov	DWORD PTR _bottom, edi
	mov	DWORD PTR _top, esi
	pop	edi
	pop	esi

; 620  : }

	ret	0
_delete_line ENDP
_save_cur PROC NEAR

; 690  : 	saved_x = x;

	mov	eax, DWORD PTR _x

; 691  : 	saved_y = y;

	mov	ecx, DWORD PTR _y
	mov	DWORD PTR _saved_x, eax
	mov	DWORD PTR _saved_y, ecx

; 692  : }

	ret	0
_save_cur ENDP
_restore_cur PROC NEAR

; 698  : 	gotoxy (saved_x, saved_y);

	mov	ecx, DWORD PTR _saved_x
	mov	eax, DWORD PTR _video_num_columns
	cmp	ecx, eax
	ja	SHORT $L1295
	mov	eax, DWORD PTR _saved_y
	mov	edx, DWORD PTR _video_num_lines
	cmp	eax, edx
	jae	SHORT $L1295
	mov	edx, DWORD PTR _video_size_row
	mov	DWORD PTR _y, eax
	imul	edx, eax
	mov	eax, DWORD PTR _origin
	mov	DWORD PTR _x, ecx
	add	eax, edx
	lea	ecx, DWORD PTR [eax+ecx*2]
	mov	DWORD PTR _pos, ecx
$L1295:

; 699  : }

	ret	0
_restore_cur ENDP
_TEXT	ENDS
PUBLIC	_con_init
EXTRN	_idt:BYTE
EXTRN	_keyboard_interrupt:NEAR
_BSS	SEGMENT
_video_page DB	01H DUP (?)
_BSS	ENDS
_DATA	SEGMENT
$SG1009	DB	'????', 00H
	ORG $+3
$SG1018	DB	'EGAm', 00H
	ORG $+3
$SG1020	DB	'*MDA', 00H
	ORG $+3
$SG1024	DB	'EGAc', 00H
	ORG $+3
$SG1026	DB	'*CGA', 00H
_DATA	ENDS
_TEXT	SEGMENT
$T1313 = -8
$T1320 = -1
$T1321 = -8
$T1327 = -8
$T1333 = -1
$T1334 = -8
$T1338 = -8
_a$ = -2
_con_init PROC NEAR

; 968  : {

	push	ebp
	mov	ebp, esp
	sub	esp, 8
	push	ebx

; 973  : 	video_num_columns = ORIG_VIDEO_COLS;	// 显示器显示字符列数。

	xor	ebx, ebx
	mov	bx, WORD PTR ds:589830
	push	esi
	shr	ebx, 8
	mov	DWORD PTR _video_num_columns, ebx

; 975  : 	video_num_lines = ORIG_VIDEO_LINES;	// 显示器显示字符行数。

	mov	DWORD PTR _video_num_lines, 25		; 00000019H
	lea	esi, DWORD PTR [ebx+ebx]
	push	edi
	mov	DWORD PTR _video_size_row, esi

; 976  : 	video_page = (unsigned char)ORIG_VIDEO_PAGE;	// 当前显示页面。

	mov	al, BYTE PTR ds:589828
	mov	BYTE PTR _video_page, al

; 977  : 	video_erase_char = 0x0720;	// 擦除字符(0x20 显示字符， 0x07 是属性)。

	mov	WORD PTR _video_erase_char, 1824	; 00000720H

; 978  : 
; 979  : // 如果原始显示模式等于7，则表示是单色显示器。
; 980  : 	if (ORIG_VIDEO_MODE == 7)	/* Is this a monochrome display? */

	cmp	BYTE PTR ds:589830, 7
	jne	SHORT $L1015

; 981  : 	{
; 982  : 		video_mem_start = 0xb0000;	// 设置单显映象内存起始地址。

	mov	edx, 720896				; 000b0000H

; 983  : 		video_port_reg = 0x3b4;	// 设置单显索引寄存器端口。

	mov	WORD PTR _video_port_reg, 948		; 000003b4H
	mov	DWORD PTR _video_mem_start, edx

; 984  : 		video_port_val = 0x3b5;	// 设置单显数据寄存器端口。

	mov	WORD PTR _video_port_val, 949		; 000003b5H

; 985  : // 根据BIOS 中断int 0x10 功能0x12 获得的显示模式信息，判断显示卡单色显示卡还是彩色显示卡。
; 986  : // 如果使用上述中断功能所得到的BX 寄存器返回值不等于0x10，则说明是EGA 卡。因此初始
; 987  : // 显示类型为EGA 单色；所使用映象内存末端地址为0xb8000；并置显示器描述字符串为'EGAm'。
; 988  : // 在系统初始化期间显示器描述字符串将显示在屏幕的右上角。
; 989  : 		if ((ORIG_VIDEO_EGA_BX & 0xff) != 0x10)

	mov	cl, BYTE PTR ds:589834
	mov	al, 16					; 00000010H
	cmp	cl, al
	je	SHORT $L1017

; 990  : 		{
; 991  : 			video_type = VIDEO_TYPE_EGAM;	// 设置显示类型(EGA 单色)。

	mov	BYTE PTR _video_type, 32		; 00000020H

; 992  : 			video_mem_end = 0xb8000;	// 设置显示内存末端地址。

	mov	DWORD PTR _video_mem_end, 753664	; 000b8000H

; 993  : 			display_desc = "EGAm";	// 设置显示描述字符串。

	mov	ecx, OFFSET FLAT:$SG1018

; 994  : 		}
; 995  : // 如果BX 寄存器的值等于0x10，则说明是单色显示卡MDA。则设置相应参数。
; 996  : 		else

	jmp	SHORT $L1025
$L1017:

; 997  : 		{
; 998  : 			video_type = VIDEO_TYPE_MDA;	// 设置显示类型(MDA 单色)。

	mov	BYTE PTR _video_type, al

; 999  : 			video_mem_end = 0xb2000;	// 设置显示内存末端地址。

	mov	DWORD PTR _video_mem_end, 729088	; 000b2000H

; 1000 : 			display_desc = "*MDA";	// 设置显示描述字符串。

	mov	ecx, OFFSET FLAT:$SG1020

; 1001 : 		}
; 1002 : 	}
; 1003 : // 如果显示模式不为7，则为彩色模式。此时所用的显示内存起始地址为0xb800；显示控制索引寄存
; 1004 : // 器端口地址为0x3d4；数据寄存器端口地址为0x3d5。
; 1005 : 	else				/* If not, it is color. */

	jmp	SHORT $L1025
$L1015:

; 1006 : 	{
; 1007 : 		video_mem_start = 0xb8000;	// 显示内存起始地址。

	mov	edx, 753664				; 000b8000H

; 1008 : 		video_port_reg = 0x3d4;	// 设置彩色显示索引寄存器端口。

	mov	WORD PTR _video_port_reg, 980		; 000003d4H
	mov	DWORD PTR _video_mem_start, edx

; 1009 : 		video_port_val = 0x3d5;	// 设置彩色显示数据寄存器端口。

	mov	WORD PTR _video_port_val, 981		; 000003d5H

; 1010 : // 再判断显示卡类别。如果BX 不等于0x10，则说明是EGA 显示卡。
; 1011 : 		if ((ORIG_VIDEO_EGA_BX & 0xff) != 0x10)

	cmp	BYTE PTR ds:589834, 16			; 00000010H
	je	SHORT $L1023

; 1012 : 		{
; 1013 : 			video_type = VIDEO_TYPE_EGAC;	// 设置显示类型(EGA 彩色)。

	mov	BYTE PTR _video_type, 33		; 00000021H

; 1014 : 			video_mem_end = 0xbc000;	// 设置显示内存末端地址。

	mov	DWORD PTR _video_mem_end, 770048	; 000bc000H

; 1015 : 			display_desc = "EGAc";	// 设置显示描述字符串。

	mov	ecx, OFFSET FLAT:$SG1024

; 1016 : 		}
; 1017 : // 如果BX 寄存器的值等于0x10，则说明是CGA 显示卡。则设置相应参数。
; 1018 : 		else

	jmp	SHORT $L1025
$L1023:

; 1019 : 		{
; 1020 : 			video_type = VIDEO_TYPE_CGA;	// 设置显示类型(CGA)。

	mov	BYTE PTR _video_type, 17		; 00000011H

; 1021 : 			video_mem_end = 0xba000;	// 设置显示内存末端地址。

	mov	DWORD PTR _video_mem_end, 761856	; 000ba000H

; 1022 : 			display_desc = "*CGA";	// 设置显示描述字符串。

	mov	ecx, OFFSET FLAT:$SG1026
$L1025:

; 1023 : 		}
; 1024 : 	}
; 1025 : 
; 1026 : /* Let the user known what kind of display driver we are using */
; 1027 : /* 让用户知道我们正在使用哪一类显示驱动程序 */
; 1028 : 
; 1029 : // 在屏幕的右上角显示显示描述字符串。采用的方法是直接将字符串写到显示内存的相应位置处。
; 1030 : // 首先将显示指针display_ptr 指到屏幕第一行右端差4 个字符处(每个字符需2 个字节，因此减8)。
; 1031 : 	display_ptr = ((char *) video_mem_start) + video_size_row - 8;
; 1032 : // 然后循环复制字符串中的字符，并且每复制一个字符都空开一个属性字节。
; 1033 : 	while (*display_desc)

	mov	al, BYTE PTR [ecx]
	lea	edi, DWORD PTR [edx+esi-8]
	test	al, al
	je	SHORT $L1030
$L1029:

; 1034 : 	{
; 1035 : 		*display_ptr++ = *display_desc++;	// 复制字符。

	inc	ecx
	mov	BYTE PTR [edi], al

; 1036 : 		display_ptr++;		// 空开属性字节位置。

	add	edi, 2
	mov	al, BYTE PTR [ecx]
	test	al, al
	jne	SHORT $L1029
$L1030:

; 1037 : 	}
; 1038 : 
; 1039 : /* 初始化用于滚屏的变量(主要用于EGA/VGA) */
; 1040 : 
; 1041 : 	origin = video_mem_start;	// 滚屏起始显示内存地址。
; 1042 : 	scr_end = video_mem_start + video_num_lines * video_size_row;	// 滚屏结束内存地址。

	lea	eax, DWORD PTR [esi+esi*4]
	mov	DWORD PTR _origin, edx

; 1043 : 	top = 0;			// 最顶行号。

	mov	DWORD PTR _top, 0

; 1044 : 	bottom = video_num_lines;	// 最底行号。

	mov	DWORD PTR _bottom, 25			; 00000019H
	lea	ecx, DWORD PTR [edx+eax*4]
	add	eax, ecx

; 1045 : 
; 1046 : 	gotoxy (ORIG_X, ORIG_Y);	// 初始化光标位置x,y 和对应的内存位置pos。

	xor	ecx, ecx
	mov	DWORD PTR _scr_end, eax
	mov	cl, BYTE PTR ds:589825
	xor	eax, eax
	mov	al, BYTE PTR ds:589824
	cmp	eax, ebx
	ja	SHORT $L1301
	cmp	ecx, 25					; 00000019H
	jae	SHORT $L1301
	imul	esi, ecx
	add	edx, esi
	mov	DWORD PTR _x, eax
	mov	DWORD PTR _y, ecx
	lea	edx, DWORD PTR [edx+eax*2]
	mov	DWORD PTR _pos, edx
$L1301:

; 1047 : 	set_trap_gate (0x21, &keyboard_interrupt);	// 设置键盘中断陷阱门。

	mov	ecx, OFFSET FLAT:_keyboard_interrupt
	mov	eax, OFFSET FLAT:_keyboard_interrupt
	and	ecx, -65536				; ffff0000H
	and	eax, 65535				; 0000ffffH
	add	ecx, 36608				; 00008f00H
	add	eax, 524288				; 00080000H
	mov	DWORD PTR _idt+268, ecx

; 1048 : 	outb_p ((unsigned char)(inb_p (0x21) & 0xfd), 0x21);	// 取消8259A 中对键盘中断的屏蔽，允许IRQ1。

	mov	ecx, 33					; 00000021H
	mov	DWORD PTR _idt+264, eax
	mov	DWORD PTR $T1313[ebp], ecx

; 971  : 	char *display_ptr;

	mov	dx, WORD PTR $T1313[ebp]

; 972  : 

	in	al, dx

; 974  : 	video_size_row = video_num_columns * 2;	// 每行需使用字节数。

	jmp	SHORT $l1$1311
$l1$1311:

; 975  : 	video_num_lines = ORIG_VIDEO_LINES;	// 显示器显示字符行数。

	jmp	SHORT $l2$1312
$l2$1312:

; 1048 : 	outb_p ((unsigned char)(inb_p (0x21) & 0xfd), 0x21);	// 取消8259A 中对键盘中断的屏蔽，允许IRQ1。

	and	al, 253					; 000000fdH
	mov	DWORD PTR $T1321[ebp], ecx
	mov	BYTE PTR $T1320[ebp], al

; 969  : 	register unsigned char a;

	mov	al, BYTE PTR $T1320[ebp]

; 970  : 	char *display_desc = "????";

	mov	dx, WORD PTR $T1321[ebp]

; 971  : 	char *display_ptr;

	out	dx, al

; 972  : 

	jmp	SHORT $l1$1318
$l1$1318:

; 973  : 	video_num_columns = ORIG_VIDEO_COLS;	// 显示器显示字符列数。

	jmp	SHORT $l2$1319
$l2$1319:

; 1049 : 	a = inb_p (0x61);		// 延迟读取键盘端口0x61(8255A 端口PB)。

	mov	ecx, 97					; 00000061H
	mov	DWORD PTR $T1327[ebp], ecx

; 971  : 	char *display_ptr;

	mov	dx, WORD PTR $T1327[ebp]

; 972  : 

	in	al, dx

; 974  : 	video_size_row = video_num_columns * 2;	// 每行需使用字节数。

	jmp	SHORT $l1$1325
$l1$1325:

; 975  : 	video_num_lines = ORIG_VIDEO_LINES;	// 显示器显示字符行数。

	jmp	SHORT $l2$1326
$l2$1326:

; 1049 : 	a = inb_p (0x61);		// 延迟读取键盘端口0x61(8255A 端口PB)。

	mov	BYTE PTR _a$[ebp], al

; 1050 : 	outb_p ((unsigned char)(a | 0x80), 0x61);	// 设置禁止键盘工作(位7 置位)，

	or	al, 128					; 00000080H
	mov	DWORD PTR $T1334[ebp], ecx
	mov	BYTE PTR $T1333[ebp], al

; 969  : 	register unsigned char a;

	mov	al, BYTE PTR $T1333[ebp]

; 970  : 	char *display_desc = "????";

	mov	dx, WORD PTR $T1334[ebp]

; 971  : 	char *display_ptr;

	out	dx, al

; 972  : 

	jmp	SHORT $l1$1331
$l1$1331:

; 973  : 	video_num_columns = ORIG_VIDEO_COLS;	// 显示器显示字符列数。

	jmp	SHORT $l2$1332
$l2$1332:

; 1051 : 	outb (a, 0x61);		// 再允许键盘工作，用以复位键盘操作。

	mov	DWORD PTR $T1338[ebp], ecx

; 969  : 	register unsigned char a;

	mov	dx, WORD PTR $T1338[ebp]

; 970  : 	char *display_desc = "????";

	mov	al, BYTE PTR _a$[ebp]

; 971  : 	char *display_ptr;

	out	dx, al

; 1051 : 	outb (a, 0x61);		// 再允许键盘工作，用以复位键盘操作。

	pop	edi
	pop	esi
	pop	ebx

; 1052 : }

	mov	esp, ebp
	pop	ebp
	ret	0
_con_init ENDP
_TEXT	ENDS
PUBLIC	_sysbeepstop
_TEXT	SEGMENT
$T1347 = -8
$T1352 = -1
$T1353 = -8
_sysbeepstop PROC NEAR

; 1060 : {

	push	ebp
	mov	ebp, esp
	sub	esp, 8

; 1062 : 	outb ((unsigned char)(inb_p (0x61) & 0xFC), 0x61);

	mov	ecx, 97					; 00000061H
	mov	DWORD PTR $T1347[ebp], ecx

; 1063 : }

	mov	dx, WORD PTR $T1347[ebp]
; File ..\include\asm/io.h

; 82   : {

	in	al, dx

; 83   : //	volatile unsigned char _v; 
; 84   : 	_asm { 

	jmp	SHORT $l1$1345
$l1$1345:

; 85   : 		mov dx,port 

	jmp	SHORT $l2$1346
$l2$1346:
; File ..\kernel\chr_drv\console.c

; 1062 : // 然后循环复制字符串中的字符，并且每复制一个字符都空开一个属性字节。

	and	al, 252					; 000000fcH
	mov	DWORD PTR $T1353[ebp], ecx
	mov	BYTE PTR $T1352[ebp], al

; 1061 : 	display_ptr = ((char *) video_mem_start) + video_size_row - 8;

	mov	dx, WORD PTR $T1353[ebp]

; 1062 : // 然后循环复制字符串中的字符，并且每复制一个字符都空开一个属性字节。

	mov	al, BYTE PTR $T1352[ebp]

; 1063 : 	while (*display_desc)

	out	dx, al
	mov	esp, ebp
	pop	ebp
	ret	0
_sysbeepstop ENDP
$T1360 = -8
$T1367 = -1
$T1368 = -8
$T1374 = -1
$T1375 = -8
$T1381 = -1
$T1382 = -8
$T1386 = -1
$T1387 = -8
_sysbeep PROC NEAR

; 1073 : 	top = 0;			// 最顶行号。

	push	ebp
	mov	ebp, esp
	sub	esp, 8

; 1075 : 

	mov	ecx, 97					; 00000061H
	mov	DWORD PTR $T1360[ebp], ecx

; 1076 : 	gotoxy (ORIG_X, ORIG_Y);	// 初始化光标位置x,y 和对应的内存位置pos。

	mov	dx, WORD PTR $T1360[ebp]

; 1077 : 	set_trap_gate (0x21, &keyboard_interrupt);	// 设置键盘中断陷阱门。

	in	al, dx

; 1079 : 	a = inb_p (0x61);		// 延迟读取键盘端口0x61(8255A 端口PB)。

	jmp	SHORT $l1$1358
$l1$1358:

; 1080 : 	outb_p ((unsigned char)(a | 0x80), 0x61);	// 设置禁止键盘工作(位7 置位)，

	jmp	SHORT $l2$1359
$l2$1359:

; 1075 : 

	or	al, 3
	mov	DWORD PTR $T1368[ebp], ecx
	mov	BYTE PTR $T1367[ebp], al

; 1074 : 	bottom = video_num_lines;	// 最底行号。

	mov	al, BYTE PTR $T1367[ebp]

; 1075 : 

	mov	dx, WORD PTR $T1368[ebp]

; 1076 : 	gotoxy (ORIG_X, ORIG_Y);	// 初始化光标位置x,y 和对应的内存位置pos。

	out	dx, al

; 1077 : 	set_trap_gate (0x21, &keyboard_interrupt);	// 设置键盘中断陷阱门。

	jmp	SHORT $l1$1365
$l1$1365:

; 1078 : 	outb_p ((unsigned char)(inb_p (0x21) & 0xfd), 0x21);	// 取消8259A 中对键盘中断的屏蔽，允许IRQ1。

	jmp	SHORT $l2$1366
$l2$1366:

; 1077 : 	set_trap_gate (0x21, &keyboard_interrupt);	// 设置键盘中断陷阱门。

	mov	DWORD PTR $T1375[ebp], 67		; 00000043H
	mov	BYTE PTR $T1374[ebp], 182		; 000000b6H

; 1074 : 	bottom = video_num_lines;	// 最底行号。

	mov	al, BYTE PTR $T1374[ebp]

; 1075 : 

	mov	dx, WORD PTR $T1375[ebp]

; 1076 : 	gotoxy (ORIG_X, ORIG_Y);	// 初始化光标位置x,y 和对应的内存位置pos。

	out	dx, al

; 1077 : 	set_trap_gate (0x21, &keyboard_interrupt);	// 设置键盘中断陷阱门。

	jmp	SHORT $l1$1372
$l1$1372:

; 1078 : 	outb_p ((unsigned char)(inb_p (0x21) & 0xfd), 0x21);	// 取消8259A 中对键盘中断的屏蔽，允许IRQ1。

	jmp	SHORT $l2$1373
$l2$1373:

; 1079 : 	a = inb_p (0x61);		// 延迟读取键盘端口0x61(8255A 端口PB)。

	mov	ecx, 66					; 00000042H
	mov	BYTE PTR $T1381[ebp], 55		; 00000037H
	mov	DWORD PTR $T1382[ebp], ecx

; 1074 : 	bottom = video_num_lines;	// 最底行号。

	mov	al, BYTE PTR $T1381[ebp]

; 1075 : 

	mov	dx, WORD PTR $T1382[ebp]

; 1076 : 	gotoxy (ORIG_X, ORIG_Y);	// 初始化光标位置x,y 和对应的内存位置pos。

	out	dx, al

; 1077 : 	set_trap_gate (0x21, &keyboard_interrupt);	// 设置键盘中断陷阱门。

	jmp	SHORT $l1$1379
$l1$1379:

; 1078 : 	outb_p ((unsigned char)(inb_p (0x21) & 0xfd), 0x21);	// 取消8259A 中对键盘中断的屏蔽，允许IRQ1。

	jmp	SHORT $l2$1380
$l2$1380:

; 1080 : 	outb_p ((unsigned char)(a | 0x80), 0x61);	// 设置禁止键盘工作(位7 置位)，

	mov	DWORD PTR $T1387[ebp], ecx
	mov	BYTE PTR $T1386[ebp], 6

; 1074 : 	bottom = video_num_lines;	// 最底行号。

	mov	dx, WORD PTR $T1387[ebp]

; 1075 : 

	mov	al, BYTE PTR $T1386[ebp]

; 1076 : 	gotoxy (ORIG_X, ORIG_Y);	// 初始化光标位置x,y 和对应的内存位置pos。

	out	dx, al

; 1081 : 	outb (a, 0x61);		// 再允许键盘工作，用以复位键盘操作。
; 1082 : }

	mov	DWORD PTR _beepcount, 12		; 0000000cH

; 1083 : 

	mov	esp, ebp
	pop	ebp
	ret	0
_sysbeep ENDP
_TEXT	ENDS
END
