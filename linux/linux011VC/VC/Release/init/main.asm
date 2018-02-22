	TITLE	..\init\main.c
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
;	COMDAT __set_tssldt_desc
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT __outb_p
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT __inb_p
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT _CMOS_READ
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
FLAT	GROUP _DATA, CONST, _BSS
	ASSUME	CS: FLAT, DS: FLAT, SS: FLAT
endif
_BSS	SEGMENT
_memory_end DD	01H DUP (?)
_buffer_memory_end DD 01H DUP (?)
_main_memory_start DD 01H DUP (?)
_BSS	ENDS
_DATA	SEGMENT
COMM	_drive_info:BYTE:020H
_argv_rc DD	FLAT:$SG1158
	DD	00H
_envp_rc DD	FLAT:$SG1160
	DD	00H
_argv	DD	FLAT:$SG1162
	DD	00H
_envp	DD	FLAT:$SG1164
	DD	00H
$SG1158	DB	'/bin/sh', 00H
$SG1160	DB	'HOME=/', 00H
	ORG $+1
$SG1162	DB	'-/bin/sh', 00H
	ORG $+3
$SG1164	DB	'HOME=/usr/root', 00H
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

; 276  : 		cmp ecx, current/* ����n �ǵ�ǰ������?(current ==task[n]?) */ 

	cmp	ecx, DWORD PTR _current

; 277  : 		je l1 /* �ǣ���ʲô���������˳���*/ 

	je	SHORT $l1$996

; 278  : 		xchg ecx,current/* current = task[n]�� */

	xchg	ecx, DWORD PTR _current

; 279  : 		/*ִ�г���ת����������л� (ͷ���˺ܳ�ʱ�䣬������)*/
; 280  : 		mov ax, __tmp

	mov	ax, WORD PTR ___tmp$[ebp]

; 281  : 		mov word ptr ds:[lcs],ax

	mov	WORD PTR ds:$lcs$997, ax

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
$lcs$997:

; 287  : lcs:	_emit 0		// cs

	DB	0

; 288  : 		_emit 0

	DB	0

; 289  : // �������л�������Ż����ִ���������䡣
; 290  : 		cmp last_task_used_math,ecx /* �������ϴ�ʹ�ù�Э��������*/

	cmp	DWORD PTR _last_task_used_math, ecx

; 291  : 		jne l1

	jne	SHORT $l1$996

; 292  : 		clts/* �������ϴ�ʹ�ù�Э������������cr0 ��TS ��־��*/

	clts
$l1$996:

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

; 114  : 	_asm mov word ptr [ebx],ax // ��TSS ���ȷ���������������(��0-1 �ֽ�)��

	mov	WORD PTR [ebx], ax

; 115  : 	_asm mov eax,addr 

	mov	eax, DWORD PTR _addr$[ebp]

; 116  : 	_asm mov word ptr [ebx+2],ax // ������ַ�ĵ��ַ�����������2-3 �ֽڡ�

	mov	WORD PTR [ebx+2], ax

; 117  : 	_asm ror eax,16 // ������ַ��������ax �С�

	ror	eax, 16					; 00000010H

; 118  : 	_asm mov byte ptr [ebx+4],al // ������ַ�����е��ֽ�������������4 �ֽڡ�

	mov	BYTE PTR [ebx+4], al

; 119  : 	_asm mov al,tp

	mov	al, BYTE PTR _tp$[ebp]

; 120  : 	_asm mov byte ptr [ebx+5],al // ����־�����ֽ������������ĵ�5 �ֽڡ�

	mov	BYTE PTR [ebx+5], al

; 121  : 	_asm mov al,0 

	mov	al, 0

; 122  : 	_asm mov byte ptr [ebx+6],al // �������ĵ�6 �ֽ���0��

	mov	BYTE PTR [ebx+6], al

; 123  : 	_asm mov byte ptr [ebx+7],ah // ������ַ�����и��ֽ�������������7 �ֽڡ�

	mov	BYTE PTR [ebx+7], ah

; 124  : 	_asm ror eax,16 // eax ���㡣

	ror	eax, 16					; 00000010H
	pop	ebx

; 125  : }

	pop	ebp
	ret	0
__set_tssldt_desc ENDP
_TEXT	ENDS
PUBLIC	_init
PUBLIC	_main_rename
EXTRN	_blk_dev_init:NEAR
EXTRN	_chr_dev_init:NEAR
EXTRN	_hd_init:NEAR
EXTRN	_floppy_init:NEAR
EXTRN	_mem_init:NEAR
EXTRN	_errno:DWORD
EXTRN	_tty_init:NEAR
EXTRN	_buffer_init:NEAR
EXTRN	_ROOT_DEV:DWORD
EXTRN	_sched_init:NEAR
EXTRN	_trap_init:NEAR
_TEXT	SEGMENT
___res$1223 = -4
___res$1229 = -4
_main_rename PROC NEAR

; 128  : {			/* ��startup ����(head.s)�о�����������ġ� */

	push	ebp
	mov	ebp, esp
	push	ecx

; 129  : /*
; 130  :  * ��ʱ�ж��Ա���ֹ�ţ������Ҫ�����ú�ͽ��俪����
; 131  :  */
; 132  : 	// ������δ������ڱ��棺
; 133  : 	// ���豸�� -> ROOT_DEV�� ���ٻ���ĩ�˵�ַ -> buffer_memory_end��
; 134  : 	// �����ڴ��� -> memory_end�����ڴ濪ʼ��ַ -> main_memory_start��
; 135  :  	ROOT_DEV = ORIG_ROOT_DEV;

	xor	eax, eax
	push	esi
	mov	ax, WORD PTR ds:590332
	push	edi

; 136  :  	drive_info = DRIVE_INFO;

	mov	ecx, 8
	mov	esi, 589952				; 00090080H
	mov	edi, OFFSET FLAT:_drive_info
	mov	DWORD PTR _ROOT_DEV, eax
	rep movsd

; 137  : 	memory_end = (1<<20) + (EXT_MEM_K<<10);// �ڴ��С=1Mb �ֽ�+��չ�ڴ�(k)*1024 �ֽڡ�
; 138  : 	memory_end &= 0xfffff000;			// ���Բ���4Kb��1 ҳ�����ڴ�����

	xor	ecx, ecx
	mov	cx, WORD PTR ds:589826
	mov	eax, ecx
	add	eax, 1024				; 00000400H
	shl	eax, 10					; 0000000aH
	and	eax, -4096				; fffff000H

; 139  : 	if (memory_end > 16*1024*1024)		// ����ڴ泬��16Mb����16Mb �ơ�

	cmp	eax, 16777216				; 01000000H
	mov	DWORD PTR _memory_end, eax
	jle	SHORT $L1137

; 140  : 		memory_end = 16*1024*1024;

	mov	eax, 16777216				; 01000000H

; 142  : 		buffer_memory_end = 4*1024*1024;

	mov	ecx, 4194304				; 00400000H
	mov	DWORD PTR _memory_end, eax

; 143  : 	else if (memory_end > 6*1024*1024)	// ��������ڴ�>6Mb�������û�����ĩ��=2Mb

	jmp	SHORT $L1235
$L1137:

; 141  : 	if (memory_end > 12*1024*1024)		// ����ڴ�>12Mb�������û�����ĩ��=4Mb

	cmp	eax, 12582912				; 00c00000H
	jle	SHORT $L1138

; 142  : 		buffer_memory_end = 4*1024*1024;

	mov	ecx, 4194304				; 00400000H

; 143  : 	else if (memory_end > 6*1024*1024)	// ��������ڴ�>6Mb�������û�����ĩ��=2Mb

	jmp	SHORT $L1235
$L1138:
	xor	ecx, ecx
	cmp	eax, 6291456				; 00600000H
	setle	cl
	dec	ecx
	and	ecx, 1048576				; 00100000H
	add	ecx, 1048576				; 00100000H
$L1235:

; 144  : 		buffer_memory_end = 2*1024*1024;
; 145  : 	else
; 146  : 		buffer_memory_end = 1*1024*1024;// ���������û�����ĩ��=1Mb
; 147  : 	main_memory_start = buffer_memory_end;// ���ڴ���ʼλ��=������ĩ�ˣ�
; 148  : #ifdef RAMDISK	// ��������������̣������ڴ潫���١�
; 149  : 	main_memory_start += rd_init(main_memory_start, RAMDISK*1024);
; 150  : #endif
; 151  : // �������ں˽������з���ĳ�ʼ���������Ķ�ʱ��ø��ŵ��õĳ��������ȥ����ʵ�ڿ�
; 152  : // ����ȥ�ˣ����ȷ�һ�ţ�����һ����ʼ������-- ���Ǿ���̸֮:)
; 153  : 	mem_init(main_memory_start,memory_end);

	push	eax
	push	ecx
	mov	DWORD PTR _buffer_memory_end, ecx
	mov	DWORD PTR _main_memory_start, ecx
	call	_mem_init

; 154  : 	trap_init();	// �����ţ�Ӳ���ж���������ʼ������kernel/traps.c��

	call	_trap_init

; 155  : 	blk_dev_init();	// ���豸��ʼ������kernel/blk_dev/ll_rw_blk.c��

	call	_blk_dev_init

; 156  : 	chr_dev_init();	// �ַ��豸��ʼ������kernel/chr_dev/tty_io.c���գ�Ϊ�Ժ���չ��׼����

	call	_chr_dev_init

; 157  : 	tty_init();		// tty ��ʼ������kernel/chr_dev/tty_io.c��

	call	_tty_init

; 158  : 	time_init();	// ���ÿ�������ʱ�� -> startup_time��

	call	_time_init

; 159  : 	sched_init();	// ���ȳ����ʼ��(����������0 ��tr, ldtr) ��kernel/sched.c��

	call	_sched_init

; 160  : 	buffer_init(buffer_memory_end);// ��������ʼ�������ڴ�����ȡ���fs/buffer.c��

	mov	edx, DWORD PTR _buffer_memory_end
	push	edx
	call	_buffer_init
	add	esp, 12					; 0000000cH

; 161  : 	hd_init();		// Ӳ�̳�ʼ������kernel/blk_dev/hd.c��

	call	_hd_init

; 162  : 	floppy_init();	// ������ʼ������kernel/blk_dev/floppy.c��

	call	_floppy_init

; 163  : 	sti();			// ���г�ʼ�������������ˣ������жϡ�

	sti

; 164  : 
; 165  : // �������ͨ���ڶ�ջ�����õĲ����������жϷ���ָ���л�������0��
; 166  : 	move_to_user_mode();	// �Ƶ��û�ģʽ����include/asm/system.h��

	mov	eax, esp
	push	23					; 00000017H
	push	eax
	pushfd
	push	15					; 0000000fH
	push	OFFSET FLAT:$l1$1142
	iretd
$l1$1142:
	mov	eax, 23					; 00000017H
	mov	ds, ax
	mov	es, ax
	mov	fs, ax
	mov	gs, ax

; 128  : {			/* ��startup ����(head.s)�о�����������ġ� */

	mov	eax, 2
	int	-128					; ffffff80H
	mov	DWORD PTR ___res$1223[ebp], eax

; 167  : 	if (!fork()) {		/* we count on this going ok */

	mov	eax, DWORD PTR ___res$1223[ebp]
	test	eax, eax
	mov	eax, DWORD PTR ___res$1223[ebp]
	jge	SHORT $L1222
	neg	eax
	mov	DWORD PTR _errno, eax
	jmp	SHORT $L1145
$L1222:
	test	eax, eax
	jne	SHORT $L1145

; 168  : 		init();

	call	_init
$L1145:

; 128  : {			/* ��startup ����(head.s)�о�����������ġ� */

	mov	eax, 29					; 0000001dH
	int	-128					; ffffff80H
	mov	DWORD PTR ___res$1229[ebp], eax

; 169  : 	}
; 170  : /*
; 171  :  * ע��!! �����κ�����������'pause()'����ζ�����Ǳ���ȴ��յ�һ���źŲŻ᷵
; 172  :  * �ؾ�������̬��������0��task0����Ψһ������������μ�'schedule()'������Ϊ��
; 173  :  * ��0 ���κο���ʱ���ﶼ�ᱻ�����û����������������ʱ����
; 174  :  * ��˶�������0'pause()'����ζ�����Ƿ������鿴�Ƿ�����������������У����û
; 175  :  * �еĻ����Ǿͻص����һֱѭ��ִ��'pause()'��
; 176  :  */
; 177  : 	for(;;) pause();

	mov	eax, DWORD PTR ___res$1229[ebp]
	test	eax, eax
	jge	SHORT $L1145
	mov	ecx, DWORD PTR ___res$1229[ebp]
	neg	ecx
	mov	DWORD PTR _errno, ecx
	jmp	SHORT $L1145
_main_rename ENDP
_TEXT	ENDS
EXTRN	_kernel_mktime:NEAR
EXTRN	_startup_time:DWORD
_TEXT	SEGMENT
_time$ = -128
$T1243 = -12
$T1249 = -16
$T1250 = -20
$T1261 = -1
$T1269 = -24
$T1275 = -28
$T1276 = -32
$T1287 = -2
$T1295 = -36
$T1301 = -40
$T1302 = -44
$T1313 = -3
$T1321 = -48
$T1327 = -52
$T1328 = -56
$T1339 = -4
$T1347 = -60
$T1353 = -64
$T1354 = -68
$T1365 = -5
$T1373 = -72
$T1379 = -76
$T1380 = -80
$T1391 = -6
$T1399 = -84
$T1405 = -88
$T1406 = -92
$T1417 = -7
_time_init PROC NEAR

; 100  : {

	push	ebp
	mov	ebp, esp
	sub	esp, 128				; 00000080H

; 104  : 		time.tm_sec = CMOS_READ(0);

	xor	dl, dl
	mov	ecx, 112				; 00000070H
	mov	eax, 113				; 00000071H
	mov	BYTE PTR $T1261[ebp], dl
	mov	DWORD PTR $T1243[ebp], ecx
	mov	DWORD PTR $T1249[ebp], eax

; 105  : 		time.tm_min = CMOS_READ(2);

	mov	BYTE PTR $T1287[ebp], 2
	mov	DWORD PTR $T1269[ebp], ecx
	mov	DWORD PTR $T1275[ebp], eax

; 106  : 		time.tm_hour = CMOS_READ(4);

	mov	BYTE PTR $T1313[ebp], 4
	mov	DWORD PTR $T1295[ebp], ecx
	mov	DWORD PTR $T1301[ebp], eax

; 107  : 		time.tm_mday = CMOS_READ(7);

	mov	BYTE PTR $T1339[ebp], 7
	mov	DWORD PTR $T1321[ebp], ecx
	mov	DWORD PTR $T1327[ebp], eax

; 108  : 		time.tm_mon = CMOS_READ(8);

	mov	BYTE PTR $T1365[ebp], 8
	mov	DWORD PTR $T1347[ebp], ecx
	mov	DWORD PTR $T1353[ebp], eax

; 109  : 		time.tm_year = CMOS_READ(9);

	mov	BYTE PTR $T1391[ebp], 9
	mov	DWORD PTR $T1373[ebp], ecx
	mov	DWORD PTR $T1379[ebp], eax

; 110  : 	} while (time.tm_sec != CMOS_READ(0));

	mov	BYTE PTR $T1417[ebp], dl
	mov	DWORD PTR $T1399[ebp], ecx
	mov	DWORD PTR $T1405[ebp], eax
$L1122:

; 101  : 	struct tm time;

	mov	al, BYTE PTR $T1261[ebp]

; 102  : 

	mov	dx, WORD PTR $T1243[ebp]

; 103  : 	do {// �μ�����CMOS �ڴ��б�

	out	dx, al

; 104  : 		time.tm_sec = CMOS_READ(0);

	jmp	SHORT $l1$1254
$l1$1254:

; 105  : 		time.tm_min = CMOS_READ(2);

	jmp	SHORT $l2$1255
$l2$1255:

; 103  : 	do {// �μ�����CMOS �ڴ��б�

	mov	dx, WORD PTR $T1249[ebp]

; 104  : 		time.tm_sec = CMOS_READ(0);

	in	al, dx

; 106  : 		time.tm_hour = CMOS_READ(4);

	jmp	SHORT $l1$1258
$l1$1258:

; 107  : 		time.tm_mday = CMOS_READ(7);

	jmp	SHORT $l2$1259
$l2$1259:

; 110  : 	} while (time.tm_sec != CMOS_READ(0));

	mov	BYTE PTR $T1250[ebp], al
	mov	eax, DWORD PTR $T1250[ebp]
	and	eax, 255				; 000000ffH
	mov	DWORD PTR _time$[ebp], eax

; 101  : 	struct tm time;

	mov	al, BYTE PTR $T1287[ebp]

; 102  : 

	mov	dx, WORD PTR $T1269[ebp]

; 103  : 	do {// �μ�����CMOS �ڴ��б�

	out	dx, al

; 104  : 		time.tm_sec = CMOS_READ(0);

	jmp	SHORT $l1$1280
$l1$1280:

; 105  : 		time.tm_min = CMOS_READ(2);

	jmp	SHORT $l2$1281
$l2$1281:

; 103  : 	do {// �μ�����CMOS �ڴ��б�

	mov	dx, WORD PTR $T1275[ebp]

; 104  : 		time.tm_sec = CMOS_READ(0);

	in	al, dx

; 106  : 		time.tm_hour = CMOS_READ(4);

	jmp	SHORT $l1$1284
$l1$1284:

; 107  : 		time.tm_mday = CMOS_READ(7);

	jmp	SHORT $l2$1285
$l2$1285:

; 110  : 	} while (time.tm_sec != CMOS_READ(0));

	mov	BYTE PTR $T1276[ebp], al
	mov	ecx, DWORD PTR $T1276[ebp]
	and	ecx, 255				; 000000ffH
	mov	DWORD PTR _time$[ebp+4], ecx

; 101  : 	struct tm time;

	mov	al, BYTE PTR $T1313[ebp]

; 102  : 

	mov	dx, WORD PTR $T1295[ebp]

; 103  : 	do {// �μ�����CMOS �ڴ��б�

	out	dx, al

; 104  : 		time.tm_sec = CMOS_READ(0);

	jmp	SHORT $l1$1306
$l1$1306:

; 105  : 		time.tm_min = CMOS_READ(2);

	jmp	SHORT $l2$1307
$l2$1307:

; 103  : 	do {// �μ�����CMOS �ڴ��б�

	mov	dx, WORD PTR $T1301[ebp]

; 104  : 		time.tm_sec = CMOS_READ(0);

	in	al, dx

; 106  : 		time.tm_hour = CMOS_READ(4);

	jmp	SHORT $l1$1310
$l1$1310:

; 107  : 		time.tm_mday = CMOS_READ(7);

	jmp	SHORT $l2$1311
$l2$1311:

; 110  : 	} while (time.tm_sec != CMOS_READ(0));

	mov	BYTE PTR $T1302[ebp], al
	mov	edx, DWORD PTR $T1302[ebp]
	and	edx, 255				; 000000ffH
	mov	DWORD PTR _time$[ebp+8], edx

; 101  : 	struct tm time;

	mov	al, BYTE PTR $T1339[ebp]

; 102  : 

	mov	dx, WORD PTR $T1321[ebp]

; 103  : 	do {// �μ�����CMOS �ڴ��б�

	out	dx, al

; 104  : 		time.tm_sec = CMOS_READ(0);

	jmp	SHORT $l1$1332
$l1$1332:

; 105  : 		time.tm_min = CMOS_READ(2);

	jmp	SHORT $l2$1333
$l2$1333:

; 103  : 	do {// �μ�����CMOS �ڴ��б�

	mov	dx, WORD PTR $T1327[ebp]

; 104  : 		time.tm_sec = CMOS_READ(0);

	in	al, dx

; 106  : 		time.tm_hour = CMOS_READ(4);

	jmp	SHORT $l1$1336
$l1$1336:

; 107  : 		time.tm_mday = CMOS_READ(7);

	jmp	SHORT $l2$1337
$l2$1337:

; 110  : 	} while (time.tm_sec != CMOS_READ(0));

	mov	BYTE PTR $T1328[ebp], al
	mov	eax, DWORD PTR $T1328[ebp]
	and	eax, 255				; 000000ffH
	mov	DWORD PTR _time$[ebp+12], eax

; 101  : 	struct tm time;

	mov	al, BYTE PTR $T1365[ebp]

; 102  : 

	mov	dx, WORD PTR $T1347[ebp]

; 103  : 	do {// �μ�����CMOS �ڴ��б�

	out	dx, al

; 104  : 		time.tm_sec = CMOS_READ(0);

	jmp	SHORT $l1$1358
$l1$1358:

; 105  : 		time.tm_min = CMOS_READ(2);

	jmp	SHORT $l2$1359
$l2$1359:

; 103  : 	do {// �μ�����CMOS �ڴ��б�

	mov	dx, WORD PTR $T1353[ebp]

; 104  : 		time.tm_sec = CMOS_READ(0);

	in	al, dx

; 106  : 		time.tm_hour = CMOS_READ(4);

	jmp	SHORT $l1$1362
$l1$1362:

; 107  : 		time.tm_mday = CMOS_READ(7);

	jmp	SHORT $l2$1363
$l2$1363:

; 110  : 	} while (time.tm_sec != CMOS_READ(0));

	mov	BYTE PTR $T1354[ebp], al
	mov	ecx, DWORD PTR $T1354[ebp]
	and	ecx, 255				; 000000ffH
	mov	DWORD PTR _time$[ebp+16], ecx

; 101  : 	struct tm time;

	mov	al, BYTE PTR $T1391[ebp]

; 102  : 

	mov	dx, WORD PTR $T1373[ebp]

; 103  : 	do {// �μ�����CMOS �ڴ��б�

	out	dx, al

; 104  : 		time.tm_sec = CMOS_READ(0);

	jmp	SHORT $l1$1384
$l1$1384:

; 105  : 		time.tm_min = CMOS_READ(2);

	jmp	SHORT $l2$1385
$l2$1385:

; 103  : 	do {// �μ�����CMOS �ڴ��б�

	mov	dx, WORD PTR $T1379[ebp]

; 104  : 		time.tm_sec = CMOS_READ(0);

	in	al, dx

; 106  : 		time.tm_hour = CMOS_READ(4);

	jmp	SHORT $l1$1388
$l1$1388:

; 107  : 		time.tm_mday = CMOS_READ(7);

	jmp	SHORT $l2$1389
$l2$1389:

; 110  : 	} while (time.tm_sec != CMOS_READ(0));

	mov	BYTE PTR $T1380[ebp], al
	mov	edx, DWORD PTR $T1380[ebp]
	and	edx, 255				; 000000ffH
	mov	DWORD PTR _time$[ebp+20], edx

; 101  : 	struct tm time;

	mov	al, BYTE PTR $T1417[ebp]

; 102  : 

	mov	dx, WORD PTR $T1399[ebp]

; 103  : 	do {// �μ�����CMOS �ڴ��б�

	out	dx, al

; 104  : 		time.tm_sec = CMOS_READ(0);

	jmp	SHORT $l1$1410
$l1$1410:

; 105  : 		time.tm_min = CMOS_READ(2);

	jmp	SHORT $l2$1411
$l2$1411:

; 103  : 	do {// �μ�����CMOS �ڴ��б�

	mov	dx, WORD PTR $T1405[ebp]

; 104  : 		time.tm_sec = CMOS_READ(0);

	in	al, dx

; 106  : 		time.tm_hour = CMOS_READ(4);

	jmp	SHORT $l1$1414
$l1$1414:

; 107  : 		time.tm_mday = CMOS_READ(7);

	jmp	SHORT $l2$1415
$l2$1415:

; 110  : 	} while (time.tm_sec != CMOS_READ(0));

	mov	ecx, DWORD PTR _time$[ebp]
	mov	BYTE PTR $T1406[ebp], al
	mov	eax, DWORD PTR $T1406[ebp]
	and	eax, 255				; 000000ffH
	cmp	ecx, eax
	jne	$L1122

; 111  : 	BCD_TO_BIN(time.tm_sec);

	mov	eax, ecx
	and	ecx, 15					; 0000000fH
	sar	eax, 4
	lea	edx, DWORD PTR [eax+eax*4]
	lea	eax, DWORD PTR [ecx+edx*2]

; 112  : 	BCD_TO_BIN(time.tm_min);

	mov	ecx, DWORD PTR _time$[ebp+4]
	mov	DWORD PTR _time$[ebp], eax
	mov	eax, ecx
	sar	eax, 4
	and	ecx, 15					; 0000000fH
	lea	edx, DWORD PTR [eax+eax*4]
	lea	eax, DWORD PTR [ecx+edx*2]

; 113  : 	BCD_TO_BIN(time.tm_hour);

	mov	ecx, DWORD PTR _time$[ebp+8]
	mov	DWORD PTR _time$[ebp+4], eax
	mov	eax, ecx
	sar	eax, 4
	and	ecx, 15					; 0000000fH
	lea	edx, DWORD PTR [eax+eax*4]
	lea	eax, DWORD PTR [ecx+edx*2]

; 114  : 	BCD_TO_BIN(time.tm_mday);

	mov	ecx, DWORD PTR _time$[ebp+12]
	mov	DWORD PTR _time$[ebp+8], eax
	mov	eax, ecx
	sar	eax, 4
	and	ecx, 15					; 0000000fH
	lea	edx, DWORD PTR [eax+eax*4]
	lea	eax, DWORD PTR [ecx+edx*2]

; 115  : 	BCD_TO_BIN(time.tm_mon);

	mov	ecx, DWORD PTR _time$[ebp+16]
	mov	DWORD PTR _time$[ebp+12], eax
	mov	eax, ecx
	sar	eax, 4
	and	ecx, 15					; 0000000fH
	lea	edx, DWORD PTR [eax+eax*4]
	lea	edx, DWORD PTR [ecx+edx*2]

; 116  : 	BCD_TO_BIN(time.tm_year);

	mov	ecx, DWORD PTR _time$[ebp+20]
	mov	eax, ecx
	and	ecx, 15					; 0000000fH
	sar	eax, 4

; 117  : 	time.tm_mon--;

	dec	edx
	lea	eax, DWORD PTR [eax+eax*4]
	mov	DWORD PTR _time$[ebp+16], edx

; 118  : 	startup_time = kernel_mktime(&time);

	lea	edx, DWORD PTR _time$[ebp]
	lea	ecx, DWORD PTR [ecx+eax*2]
	push	edx
	mov	DWORD PTR _time$[ebp+20], ecx
	call	_kernel_mktime
	add	esp, 4
	mov	DWORD PTR _startup_time, eax

; 119  : }

	mov	esp, ebp
	pop	ebp
	ret	0
_time_init ENDP
_TEXT	ENDS
EXTRN	_close:NEAR
EXTRN	_dup:NEAR
EXTRN	_execve:NEAR
EXTRN	__exit:NEAR
EXTRN	_open:NEAR
EXTRN	_wait:NEAR
EXTRN	_setsid:NEAR
EXTRN	_nr_buffers:DWORD
_DATA	SEGMENT
	ORG $+1
$SG1171	DB	'/dev/tty0', 00H
	ORG $+2
$SG1174	DB	'%d buffers = %d bytes buffer space', 0aH, 0dH, 00H
	ORG $+3
$SG1175	DB	'Free mem: %d bytes', 0aH, 0dH, 00H
	ORG $+3
$SG1178	DB	'/etc/rc', 00H
$SG1179	DB	'/bin/sh', 00H
$SG1188	DB	'Fork failed in init', 0dH, 0aH, 00H
	ORG $+2
$SG1191	DB	'/dev/tty0', 00H
	ORG $+2
$SG1194	DB	'/bin/sh', 00H
$SG1199	DB	0aH, 0dH, 'child %d died with code %04x', 0aH, 0dH, 00H
_DATA	ENDS
_TEXT	SEGMENT
_i$ = -4
___res$1424 = -8
___res$1429 = -8
___res$1434 = -8
___res$1439 = -12
_init	PROC NEAR

; 204  : {

	push	ebp
	mov	ebp, esp
	sub	esp, 12					; 0000000cH
	push	ebx
	push	esi
	mov	eax, 0
	mov	ebx, OFFSET FLAT:_drive_info
	int	-128					; ffffff80H
	mov	DWORD PTR ___res$1424[ebp], eax

; 205  : 	int pid,i;
; 206  : 
; 207  : // ��ȡӲ�̲���������������Ϣ�����������̺Ͱ�װ���ļ�ϵͳ�豸��
; 208  : // �ú�������25 ���ϵĺ궨��ģ���Ӧ������sys_setup()����kernel/blk_drv/hd.c��
; 209  : 	setup((void *) &drive_info);

	mov	eax, DWORD PTR ___res$1424[ebp]
	test	eax, eax
	jge	SHORT $L1423
	mov	eax, DWORD PTR ___res$1424[ebp]
	neg	eax
	mov	DWORD PTR _errno, eax
$L1423:

; 210  : 
; 211  : 	(void) open("/dev/tty0",O_RDWR,0);	// �ö�д���ʷ�ʽ���豸��/dev/tty0����

	push	0
	push	2
	push	OFFSET FLAT:$SG1171
	call	_open

; 212  : 										// �����Ӧ�ն˿���̨��
; 213  : 										// ���صľ����0 -- stdin ��׼�����豸��
; 214  : 	(void) dup(0);		// ���ƾ�����������1 ��-- stdout ��׼����豸��

	push	0
	call	_dup

; 215  : 	(void) dup(0);		// ���ƾ�����������2 ��-- stderr ��׼��������豸��

	push	0
	call	_dup

; 216  : 	printf("%d buffers = %d bytes buffer space\n\r",NR_BUFFERS, \
; 217  : 		NR_BUFFERS*BLOCK_SIZE);	// ��ӡ���������������ֽ�����ÿ��1024 �ֽڡ�

	mov	eax, DWORD PTR _nr_buffers
	mov	ecx, eax
	shl	ecx, 10					; 0000000aH
	push	ecx
	push	eax
	push	OFFSET FLAT:$SG1174
	call	_printf

; 218  : 	printf("Free mem: %d bytes\n\r",memory_end-main_memory_start);//�����ڴ��ֽ�����

	mov	edx, DWORD PTR _memory_end
	mov	ebx, DWORD PTR _main_memory_start
	sub	edx, ebx
	push	edx
	push	OFFSET FLAT:$SG1175
	call	_printf
	add	esp, 40					; 00000028H

; 204  : {

	mov	eax, 2
	int	-128					; ffffff80H
	mov	DWORD PTR ___res$1429[ebp], eax

; 219  : 
; 220  : // ����fork()���ڴ���һ���ӽ���(������)�����ڱ��������ӽ��̣�fork()������0 ֵ��
; 221  : // ����ԭ(������)�������ӽ��̵Ľ��̺š�����if (!(pid=fork())) {...} �����ӽ���ִ�е����ݡ�
; 222  : // ���ӽ��̹ر��˾��0(stdin)����ֻ����ʽ��/etc/rc �ļ�����ִ��/bin/sh ��������������
; 223  : // ���������ֱ���argv_rc ��envp_rc ����������μ������������
; 224  : 	if (!(pid=fork())) {

	mov	eax, DWORD PTR ___res$1429[ebp]
	test	eax, eax
	jl	SHORT $L1430
	mov	esi, DWORD PTR ___res$1429[ebp]
	test	esi, esi
	jne	SHORT $L1453

; 225  : 		close(0);

	push	esi
	call	_close

; 226  : 		if (open("/etc/rc",O_RDONLY,0))

	push	esi
	push	esi
	push	OFFSET FLAT:$SG1178
	call	_open
	add	esp, 16					; 00000010H
	test	eax, eax
	je	SHORT $L1177

; 227  : 			_exit(1);	// ������ļ�ʧ�ܣ����˳�(/lib/_exit.c)��

	push	1
	call	__exit
	add	esp, 4
$L1177:

; 228  : 		execve("/bin/sh",argv_rc,envp_rc);	// װ��/bin/sh ����ִ�С�(/lib/execve.c)

	push	OFFSET FLAT:_envp_rc
	push	OFFSET FLAT:_argv_rc
	push	OFFSET FLAT:$SG1179
	call	_execve

; 229  : 		_exit(2);	// ��execve()ִ��ʧ�����˳�(������2,���ļ���Ŀ¼�����ڡ�)��

	push	2
	call	__exit
	add	esp, 16					; 00000010H

; 230  : 	}
; 231  : 
; 232  : // �����Ǹ�����ִ�е���䡣wait()�ǵȴ��ӽ���ֹͣ����ֹ���䷵��ֵӦ���ӽ��̵�
; 233  : // ���̺�(pid)��������������Ǹ����̵ȴ��ӽ��̵Ľ�����&i �Ǵ�ŷ���״̬��Ϣ��
; 234  : // λ�á����wait()����ֵ�������ӽ��̺ţ�������ȴ���
; 235  : 	if (pid>0)

	jmp	SHORT $L1185

; 219  : 
; 220  : // ����fork()���ڴ���һ���ӽ���(������)�����ڱ��������ӽ��̣�fork()������0 ֵ��
; 221  : // ����ԭ(������)�������ӽ��̵Ľ��̺š�����if (!(pid=fork())) {...} �����ӽ���ִ�е����ݡ�
; 222  : // ���ӽ��̹ر��˾��0(stdin)����ֻ����ʽ��/etc/rc �ļ�����ִ��/bin/sh ��������������
; 223  : // ���������ֱ���argv_rc ��envp_rc ����������μ������������
; 224  : 	if (!(pid=fork())) {

$L1430:
	mov	eax, DWORD PTR ___res$1429[ebp]
	neg	eax
	mov	DWORD PTR _errno, eax
	jmp	SHORT $L1185
$L1453:

; 230  : 	}
; 231  : 
; 232  : // �����Ǹ�����ִ�е���䡣wait()�ǵȴ��ӽ���ֹͣ����ֹ���䷵��ֵӦ���ӽ��̵�
; 233  : // ���̺�(pid)��������������Ǹ����̵ȴ��ӽ��̵Ľ�����&i �Ǵ�ŷ���״̬��Ϣ��
; 234  : // λ�á����wait()����ֵ�������ӽ��̺ţ�������ȴ���
; 235  : 	if (pid>0)

	jle	SHORT $L1185

; 236  : 		while (pid != wait(&i))

	lea	ecx, DWORD PTR _i$[ebp]
	push	ecx
	call	_wait
	add	esp, 4
	cmp	esi, eax
	je	SHORT $L1185
$L1182:
	lea	edx, DWORD PTR _i$[ebp]
	push	edx
	call	_wait
	add	esp, 4
	cmp	esi, eax
	jne	SHORT $L1182
$L1185:

; 204  : {

	mov	eax, 2
	int	-128					; ffffff80H
	mov	DWORD PTR ___res$1434[ebp], eax

; 237  : 		{	/* nothing */;}
; 238  : 
; 239  : // --
; 240  : // ���ִ�е����˵���մ������ӽ��̵�ִ����ֹͣ����ֹ�ˡ�����ѭ���������ٴ���
; 241  : // һ���ӽ��̣������������ʾ����ʼ�����򴴽��ӽ���ʧ�ܡ�����Ϣ������ִ�С���
; 242  : // �����������ӽ��̹ر�������ǰ�������ľ��(stdin, stdout, stderr)���´���һ��
; 243  : // �Ự�����ý�����ţ�Ȼ�����´�/dev/tty0 ��Ϊstdin�������Ƴ�stdout ��stderr��
; 244  : // �ٴ�ִ��ϵͳ���ͳ���/bin/sh�������ִ����ѡ�õĲ����ͻ���������ѡ��һ�ף������棩��
; 245  : // Ȼ�󸸽����ٴ�����wait()�ȴ�������ӽ�����ֹͣ��ִ�У����ڱ�׼�������ʾ������Ϣ
; 246  : //		���ӽ���pid ֹͣ�����У���������i����
; 247  : // Ȼ�����������ȥ�����γɡ�����ѭ����
; 248  : 	while (1) {
; 249  : 		if ((pid=fork())<0) {

	mov	eax, DWORD PTR ___res$1434[ebp]
	test	eax, eax
	jl	SHORT $L1435
	mov	esi, DWORD PTR ___res$1434[ebp]
	test	esi, esi
	jge	SHORT $L1454

; 250  : 			printf("Fork failed in init\r\n");

	push	OFFSET FLAT:$SG1188
	call	_printf
	add	esp, 4

; 251  : 			continue;

	jmp	SHORT $L1185

; 237  : 		{	/* nothing */;}
; 238  : 
; 239  : // --
; 240  : // ���ִ�е����˵���մ������ӽ��̵�ִ����ֹͣ����ֹ�ˡ�����ѭ���������ٴ���
; 241  : // һ���ӽ��̣������������ʾ����ʼ�����򴴽��ӽ���ʧ�ܡ�����Ϣ������ִ�С���
; 242  : // �����������ӽ��̹ر�������ǰ�������ľ��(stdin, stdout, stderr)���´���һ��
; 243  : // �Ự�����ý�����ţ�Ȼ�����´�/dev/tty0 ��Ϊstdin�������Ƴ�stdout ��stderr��
; 244  : // �ٴ�ִ��ϵͳ���ͳ���/bin/sh�������ִ����ѡ�õĲ����ͻ���������ѡ��һ�ף������棩��
; 245  : // Ȼ�󸸽����ٴ�����wait()�ȴ�������ӽ�����ֹͣ��ִ�У����ڱ�׼�������ʾ������Ϣ
; 246  : //		���ӽ���pid ֹͣ�����У���������i����
; 247  : // Ȼ�����������ȥ�����γɡ�����ѭ����
; 248  : 	while (1) {
; 249  : 		if ((pid=fork())<0) {

$L1435:
	mov	eax, DWORD PTR ___res$1434[ebp]

; 250  : 			printf("Fork failed in init\r\n");

	push	OFFSET FLAT:$SG1188
	neg	eax
	mov	DWORD PTR _errno, eax
	call	_printf
	add	esp, 4

; 251  : 			continue;

	jmp	SHORT $L1185
$L1454:

; 252  : 		}
; 253  : 		if (!pid) {

	jne	SHORT $L1196

; 254  : 			close(0);close(1);close(2);

	push	0
	call	_close
	push	1
	call	_close
	push	2
	call	_close

; 255  : 			setsid();

	call	_setsid

; 256  : 			(void) open("/dev/tty0",O_RDWR,0);

	push	0
	push	2
	push	OFFSET FLAT:$SG1191
	call	_open

; 257  : 			(void) dup(0);

	push	0
	call	_dup

; 258  : 			(void) dup(0);

	push	0
	call	_dup

; 259  : 			_exit(execve("/bin/sh",argv,envp));

	push	OFFSET FLAT:_envp
	push	OFFSET FLAT:_argv
	push	OFFSET FLAT:$SG1194
	call	_execve
	push	eax
	call	__exit
	add	esp, 48					; 00000030H
$L1196:

; 260  : 		}
; 261  : 		while (1)
; 262  : 			if (pid == wait(&i))

	lea	ecx, DWORD PTR _i$[ebp]
	push	ecx
	call	_wait
	add	esp, 4
	cmp	esi, eax
	jne	SHORT $L1196

; 263  : 				break;
; 264  : 		printf("\n\rchild %d died with code %04x\n\r",pid,i);

	mov	edx, DWORD PTR _i$[ebp]
	push	edx
	push	esi
	push	OFFSET FLAT:$SG1199
	call	_printf
	add	esp, 12					; 0000000cH

; 204  : {

	mov	eax, 36					; 00000024H
	int	-128					; ffffff80H
	mov	DWORD PTR ___res$1439[ebp], eax

; 265  : 		sync();

	mov	eax, DWORD PTR ___res$1439[ebp]
	test	eax, eax
	jge	$L1185
	mov	eax, DWORD PTR ___res$1439[ebp]
	neg	eax
	mov	DWORD PTR _errno, eax
	jmp	$L1185
_init	ENDP
_TEXT	ENDS
EXTRN	_vsprintf:NEAR
EXTRN	_write:NEAR
_BSS	SEGMENT
_printbuf DB	0400H DUP (?)
_BSS	ENDS
_TEXT	SEGMENT
_fmt$ = 8
_printf	PROC NEAR

; 187  : {

	push	ebp
	mov	ebp, esp

; 188  : 	va_list args;
; 189  : 	int i;
; 190  : 
; 191  : 	va_start(args, fmt);
; 192  : 	write(1,printbuf,i=vsprintf(printbuf, fmt, args));

	mov	ecx, DWORD PTR _fmt$[ebp]
	lea	eax, DWORD PTR _fmt$[ebp+4]
	push	esi
	push	eax
	push	ecx
	push	OFFSET FLAT:_printbuf
	call	_vsprintf
	mov	esi, eax
	push	esi
	push	OFFSET FLAT:_printbuf
	push	1
	call	_write
	add	esp, 24					; 00000018H

; 193  : 	va_end(args);
; 194  : 	return i;

	mov	eax, esi
	pop	esi

; 195  : }

	pop	ebp
	ret	0
_printf	ENDP
_TEXT	ENDS
END
