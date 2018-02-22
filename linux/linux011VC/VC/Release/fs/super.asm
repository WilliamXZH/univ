	TITLE	..\fs\super.c
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
;	COMDAT _set_bit
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
FLAT	GROUP _DATA, CONST, _BSS
	ASSUME	CS: FLAT, DS: FLAT, SS: FLAT
endif
PUBLIC	_super_block
_BSS	SEGMENT
_super_block DB	0360H DUP (?)
_BSS	ENDS
_DATA	SEGMENT
COMM	_ROOT_DEV:DWORD
_DATA	ENDS
PUBLIC	_set_bit
;	COMDAT _set_bit
_TEXT	SEGMENT
_bitnr$ = 8
_addr$ = 12
_set_bit PROC NEAR					; COMDAT

; 32   : {

	push	ebp
	mov	ebp, esp
	push	ebx

; 33   : //	register int __res;
; 34   : 	_asm{
; 35   : 		xor eax,eax

	xor	eax, eax

; 36   : 		mov ebx,bitnr

	mov	ebx, DWORD PTR _bitnr$[ebp]

; 37   : 		mov edx,addr

	mov	edx, DWORD PTR _addr$[ebp]

; 38   : 		bt [edx],ebx

	bt	DWORD PTR [edx], ebx

; 39   : 		setb al

	setb	al
	pop	ebx

; 40   : //		mov __res,eax
; 41   : 	}
; 42   : //	return __res;
; 43   : }

	pop	ebp
	ret	0
_set_bit ENDP
_TEXT	ENDS
PUBLIC	_get_super
_TEXT	SEGMENT
_dev$ = 8
_get_super PROC NEAR

; 84   : {

	push	ebp
	mov	ebp, esp
	push	esi
	push	edi

; 85   : 	struct super_block *s;
; 86   : 
; 87   : // 如果没有指定设备，则返回空指针。
; 88   : 	if (!dev)

	mov	edi, DWORD PTR _dev$[ebp]
	test	edi, edi

; 89   : 		return NULL;

	je	SHORT $L647
$L795:

; 90   : // s 指向超级块数组开始处。搜索整个超级块数组，寻找指定设备的超级块。
; 91   : 	s = 0 + super_block;

	mov	esi, OFFSET FLAT:_super_block
$L646:

; 92   : 	while (s < NR_SUPER + super_block)
; 93   : // 如果当前搜索项是指定设备的超级块，则首先等待该超级块解锁（若已经被其它进程上锁的话）。
; 94   : // 在等待期间，该超级块有可能被其它设备使用，因此此时需再判断一次是否是指定设备的超级块，
; 95   : // 如果是则返回该超级块的指针。否则就重新对超级块数组再搜索一遍，因此s 重又指向超级块数组
; 96   : // 开始处。
; 97   : 	if (s->s_dev == dev)

	xor	eax, eax
	mov	ax, WORD PTR [esi+84]
	cmp	eax, edi
	jne	SHORT $L648

; 98   : 	{
; 99   : 		wait_on_super (s);

	push	esi
	call	_wait_on_super

; 100  : 		if (s->s_dev == dev)

	xor	ecx, ecx
	add	esp, 4
	mov	cx, WORD PTR [esi+84]
	cmp	ecx, edi
	je	SHORT $L794

; 102  : 		s = 0 + super_block;
; 103  : // 如果当前搜索项不是，则检查下一项。如果没有找到指定的超级块，则返回空指针。
; 104  : 	}
; 105  : 	else

	jmp	SHORT $L795
$L648:

; 106  : 		s++;

	add	esi, 108				; 0000006cH
	cmp	esi, OFFSET FLAT:_super_block+864
	jb	SHORT $L646
$L647:
	pop	edi

; 107  : 	return NULL;

	xor	eax, eax
	pop	esi

; 108  : }

	pop	ebp
	ret	0
$L794:

; 101  : 			return s;

	mov	eax, esi
	pop	edi
	pop	esi

; 108  : }

	pop	ebp
	ret	0
_get_super ENDP
_TEXT	ENDS
EXTRN	_sleep_on:NEAR
_TEXT	SEGMENT
_sb$ = 8
_wait_on_super PROC NEAR

; 74   : {

	push	ebp
	mov	ebp, esp
	push	esi

; 75   : 	cli ();			// 关中断。

	cli

; 76   : 	while (sb->s_lock)		// 如果超级块已经上锁，则睡眠等待。

	mov	esi, DWORD PTR _sb$[ebp]
	mov	al, BYTE PTR [esi+104]
	test	al, al
	je	SHORT $L639
	push	edi

; 77   : 		sleep_on (&(sb->s_wait));

	lea	edi, DWORD PTR [esi+100]
$L638:
	push	edi
	call	_sleep_on
	mov	al, BYTE PTR [esi+104]
	add	esp, 4
	test	al, al
	jne	SHORT $L638
	pop	edi
$L639:

; 78   : 	sti ();			// 开中断。

	sti
	pop	esi

; 79   : }

	pop	ebp
	ret	0
_wait_on_super ENDP
_TEXT	ENDS
PUBLIC	_put_super
EXTRN	_brelse:NEAR
EXTRN	_printk:NEAR
_DATA	SEGMENT
$SG658	DB	'root diskette changed: prepare for armageddon', 0aH, 0dH
	DB	00H
$SG661	DB	'Mounted disk changed - tssk, tssk', 0aH, 0dH, 00H
_DATA	ENDS
_TEXT	SEGMENT
_dev$ = 8
_put_super PROC NEAR

; 116  : {

	push	ebp
	mov	ebp, esp

; 117  : 	struct super_block *sb;
; 118  : //  struct m_inode *inode;
; 119  : 	int i;
; 120  : 
; 121  : // 如果指定设备是根文件系统设备，则显示警告信息“根系统盘改变了，准备生死决战吧”，并返回。
; 122  : 	if (dev == ROOT_DEV)

	mov	eax, DWORD PTR _dev$[ebp]
	mov	ecx, DWORD PTR _ROOT_DEV
	cmp	eax, ecx
	push	esi
	jne	SHORT $L657

; 123  : 	{
; 124  : 		printk ("root diskette changed: prepare for armageddon\n\r");

	push	OFFSET FLAT:$SG658
	call	_printk
	add	esp, 4
	pop	esi

; 147  : 	return;
; 148  : }

	pop	ebp
	ret	0
$L657:

; 125  : 		return;
; 126  : 	}
; 127  : // 如果找不到指定设备的超级块，则返回。
; 128  : 	if (!(sb = get_super (dev)))

	push	eax
	call	_get_super
	mov	esi, eax
	add	esp, 4
	test	esi, esi
	je	SHORT $L654

; 129  : 		return;
; 130  : // 如果该超级块指明本文件系统i 节点上安装有其它的文件系统，则显示警告信息，返回。
; 131  : 	if (sb->s_imount)

	mov	eax, DWORD PTR [esi+92]
	test	eax, eax
	je	SHORT $L660

; 132  : 	{
; 133  : 		printk ("Mounted disk changed - tssk, tssk\n\r");

	push	OFFSET FLAT:$SG661
	call	_printk
	add	esp, 4
	pop	esi

; 147  : 	return;
; 148  : }

	pop	ebp
	ret	0
$L660:
	push	ebx
	push	edi

; 134  : 		return;
; 135  : 	}
; 136  : // 找到指定设备的超级块后，首先锁定该超级块，然后置该超级块对应的设备号字段为0，也即即将
; 137  : // 放弃该超级块。
; 138  : 	lock_super (sb);

	push	esi
	call	_lock_super
	add	esp, 4

; 139  : 	sb->s_dev = 0;

	mov	WORD PTR [esi+84], 0
	lea	edi, DWORD PTR [esi+20]
	mov	ebx, 8
$L662:

; 140  : // 然后释放该设备i 节点位图和逻辑块位图在缓冲区中所占用的缓冲块。
; 141  : 	for (i = 0; i < I_MAP_SLOTS; i++)
; 142  : 		brelse (sb->s_imap[i]);

	mov	eax, DWORD PTR [edi]
	push	eax
	call	_brelse
	add	esp, 4
	add	edi, 4
	dec	ebx
	jne	SHORT $L662

; 143  : 	for (i = 0; i < Z_MAP_SLOTS; i++)

	lea	edi, DWORD PTR [esi+52]
	mov	ebx, 8
$L665:

; 144  : 		brelse (sb->s_zmap[i]);

	mov	ecx, DWORD PTR [edi]
	push	ecx
	call	_brelse
	add	esp, 4
	add	edi, 4
	dec	ebx
	jne	SHORT $L665

; 145  : // 最后对该超级块解锁，并返回。
; 146  : 	free_super (sb);

	push	esi
	call	_free_super
	add	esp, 4
	pop	edi
	pop	ebx
$L654:
	pop	esi

; 147  : 	return;
; 148  : }

	pop	ebp
	ret	0
_put_super ENDP
_sb$ = 8
_lock_super PROC NEAR

; 53   : {

	push	ebp
	mov	ebp, esp
	push	esi

; 54   : 	cli ();			// 关中断。

	cli

; 55   : 	while (sb->s_lock)		// 如果该超级块已经上锁，则睡眠等待。

	mov	esi, DWORD PTR _sb$[ebp]
	mov	al, BYTE PTR [esi+104]
	test	al, al
	je	SHORT $L628
	push	edi

; 56   : 		sleep_on (&(sb->s_wait));

	lea	edi, DWORD PTR [esi+100]
$L627:
	push	edi
	call	_sleep_on
	mov	al, BYTE PTR [esi+104]
	add	esp, 4
	test	al, al
	jne	SHORT $L627
	pop	edi
$L628:

; 57   : 	sb->s_lock = 1;		// 给该超级块加锁（置锁定标志）。

	mov	BYTE PTR [esi+104], 1

; 58   : 	sti ();			// 开中断。

	sti

; 57   : 	sb->s_lock = 1;		// 给该超级块加锁（置锁定标志）。

	pop	esi

; 59   : }

	pop	ebp
	ret	0
_lock_super ENDP
_TEXT	ENDS
EXTRN	_wake_up:NEAR
_TEXT	SEGMENT
_sb$ = 8
_free_super PROC NEAR

; 64   : {

	push	ebp
	mov	ebp, esp

; 65   : 	cli ();			// 关中断。

	cli

; 66   : 	sb->s_lock = 0;		// 复位锁定标志。

	mov	eax, DWORD PTR _sb$[ebp]
	mov	BYTE PTR [eax+104], 0

; 67   : 	wake_up (&(sb->s_wait));	// 唤醒等待该超级块的进程。

	add	eax, 100				; 00000064H
	push	eax
	call	_wake_up
	add	esp, 4

; 68   : 	sti ();			// 开中断。

	sti

; 69   : }

	pop	ebp
	ret	0
_free_super ENDP
_TEXT	ENDS
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

	je	SHORT $l1$500

; 278  : 		xchg ecx,current/* current = task[n]； */

	xchg	ecx, DWORD PTR _current

; 279  : 		/*执行长跳转，造成任务切换 (头大了很长时间，多多包涵)*/
; 280  : 		mov ax, __tmp

	mov	ax, WORD PTR ___tmp$[ebp]

; 281  : 		mov word ptr ds:[lcs],ax

	mov	WORD PTR ds:$lcs$501, ax

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
$lcs$501:

; 287  : lcs:	_emit 0		// cs

	DB	0

; 288  : 		_emit 0

	DB	0

; 289  : // 在任务切换回来后才会继续执行下面的语句。
; 290  : 		cmp last_task_used_math,ecx /* 新任务上次使用过协处理器吗？*/

	cmp	DWORD PTR _last_task_used_math, ecx

; 291  : 		jne l1

	jne	SHORT $l1$500

; 292  : 		clts/* 新任务上次使用过协处理器，则清cr0 的TS 标志。*/

	clts
$l1$500:

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
PUBLIC	_sys_umount
EXTRN	_inode_table:BYTE
EXTRN	_namei:NEAR
EXTRN	_iput:NEAR
EXTRN	_sync_dev:NEAR
_DATA	SEGMENT
$SG723	DB	'Mounted inode has i_mount=0', 0aH, 00H
_DATA	ENDS
_TEXT	SEGMENT
_dev_name$ = 8
_sys_umount PROC NEAR

; 249  : {

	push	ebp
	mov	ebp, esp

; 250  : 	struct m_inode *inode;
; 251  : 	struct super_block *sb;
; 252  : 	int dev;
; 253  : 
; 254  : // 首先根据设备文件名找到对应的i 节点，并取其中的设备号。
; 255  : 	if (!(inode = namei (dev_name)))

	mov	eax, DWORD PTR _dev_name$[ebp]
	push	ebx
	push	esi
	push	edi
	push	eax
	call	_namei
	add	esp, 4
	test	eax, eax

; 256  : 		return -ENOENT;

	je	$L721

; 257  : 	dev = inode->i_zone[0];
; 258  : // 如果不是块设备文件，则释放刚申请的i 节点dev_i，返回出错码。
; 259  : 	if (!S_ISBLK (inode->i_mode))

	mov	cx, WORD PTR [eax]
	xor	esi, esi
	mov	si, WORD PTR [eax+14]
	and	ecx, 61440				; 0000f000H
	cmp	ecx, 24576				; 00006000H

; 260  : 	{
; 261  : 		iput (inode);

	push	eax
	je	SHORT $L718
	call	_iput
	add	esp, 4

; 262  : 		return -ENOTBLK;

	mov	eax, -15				; fffffff1H
	pop	edi
	pop	esi
	pop	ebx

; 291  : }

	pop	ebp
	ret	0
$L718:

; 263  : 	}
; 264  : // 释放设备文件名的i 节点。
; 265  : 	iput (inode);

	call	_iput

; 266  : // 如果设备是根文件系统，则不能被卸载，返回出错号。
; 267  : 	if (dev == ROOT_DEV)

	mov	eax, DWORD PTR _ROOT_DEV
	add	esp, 4
	cmp	esi, eax
	jne	SHORT $L719
$L817:
	pop	edi
	pop	esi

; 268  : 		return -EBUSY;

	mov	eax, -16				; fffffff0H
	pop	ebx

; 291  : }

	pop	ebp
	ret	0
$L719:

; 269  : // 如果取设备的超级块失败，或者该设备文件系统没有安装过，则返回出错码。
; 270  : 	if (!(sb = get_super (dev)) || !(sb->s_imount))

	push	esi
	call	_get_super
	mov	edi, eax
	add	esp, 4
	test	edi, edi
	je	SHORT $L721
	mov	ebx, DWORD PTR [edi+92]
	test	ebx, ebx
	je	SHORT $L721

; 272  : // 如果超级块所指明的被安装到的i 节点没有置位其安装标志，则显示警告信息。
; 273  : 	if (!sb->s_imount->i_mount)

	mov	al, BYTE PTR [ebx+53]
	test	al, al
	jne	SHORT $L722

; 274  : 		printk ("Mounted inode has i_mount=0\n");

	push	OFFSET FLAT:$SG723
	call	_printk
	add	esp, 4
$L722:

; 275  : // 查找i 节点表，看是否有进程在使用该设备上的文件，如果有则返回忙出错码。
; 276  : 	for (inode = inode_table + 0; inode < inode_table + NR_INODE; inode++)

	mov	eax, OFFSET FLAT:_inode_table+48
$L724:

; 277  : 		if (inode->i_dev == dev && inode->i_count)

	xor	edx, edx
	mov	dx, WORD PTR [eax-4]
	cmp	edx, esi
	jne	SHORT $L725
	cmp	WORD PTR [eax], 0
	jne	SHORT $L817
$L725:

; 275  : // 查找i 节点表，看是否有进程在使用该设备上的文件，如果有则返回忙出错码。
; 276  : 	for (inode = inode_table + 0; inode < inode_table + NR_INODE; inode++)

	add	eax, 56					; 00000038H
	lea	ecx, DWORD PTR [eax-48]
	cmp	ecx, OFFSET FLAT:_inode_table+1792
	jb	SHORT $L724

; 278  : 			return -EBUSY;
; 279  : // 复位被安装到的i 节点的安装标志，释放该i 节点。
; 280  : 	sb->s_imount->i_mount = 0;
; 281  : 	iput (sb->s_imount);

	push	ebx
	mov	BYTE PTR [ebx+53], 0
	call	_iput

; 282  : // 置超级块中被安装i 节点字段为空，并释放设备文件系统的根i 节点，置超级块中被安装系统
; 283  : // 根i 节点指针为空。
; 284  : 	sb->s_imount = NULL;
; 285  : 	iput (sb->s_isup);

	mov	edx, DWORD PTR [edi+88]
	xor	ebx, ebx
	push	edx
	mov	DWORD PTR [edi+92], ebx
	call	_iput

; 286  : 	sb->s_isup = NULL;
; 287  : // 释放该设备的超级块以及位图占用的缓冲块，并对该设备执行高速缓冲与设备上数据的同步操作。
; 288  : 	put_super (dev);

	push	esi
	mov	DWORD PTR [edi+88], ebx
	call	_put_super

; 289  : 	sync_dev (dev);

	push	esi
	call	_sync_dev
	add	esp, 16					; 00000010H

; 290  : 	return 0;

	xor	eax, eax
	pop	edi
	pop	esi
	pop	ebx

; 291  : }

	pop	ebp
	ret	0
$L721:
	pop	edi
	pop	esi

; 271  : 		return -ENOENT;

	mov	eax, -2					; fffffffeH
	pop	ebx

; 291  : }

	pop	ebp
	ret	0
_sys_umount ENDP
_TEXT	ENDS
PUBLIC	_sys_mount
_TEXT	SEGMENT
_dev_name$ = 8
_dir_name$ = 12
_sys_mount PROC NEAR

; 298  : {

	push	ebp
	mov	ebp, esp

; 299  : 	struct m_inode *dev_i, *dir_i;
; 300  : 	struct super_block *sb;
; 301  : 	int dev;
; 302  : 
; 303  : // 首先根据设备文件名找到对应的i 节点，并取其中的设备号。
; 304  : // 对于块特殊设备文件，设备号在i 节点的i_zone[0]中。
; 305  : 	if (!(dev_i = namei (dev_name)))

	mov	eax, DWORD PTR _dev_name$[ebp]
	push	ebx
	push	esi
	push	edi
	push	eax
	call	_namei
	add	esp, 4
	test	eax, eax
	jne	SHORT $L740
	pop	edi
	pop	esi

; 306  : 		return -ENOENT;

	mov	eax, -2					; fffffffeH
	pop	ebx

; 356  : }

	pop	ebp
	ret	0
$L740:

; 307  : 	dev = dev_i->i_zone[0];
; 308  : // 如果不是块设备文件，则释放刚取得的i 节点dev_i，返回出错码。
; 309  : 	if (!S_ISBLK (dev_i->i_mode))

	mov	cx, WORD PTR [eax]
	xor	edi, edi
	mov	di, WORD PTR [eax+14]
	and	ecx, 61440				; 0000f000H
	cmp	ecx, 24576				; 00006000H

; 310  : 	{
; 311  : 		iput (dev_i);

	push	eax
	je	SHORT $L741
	call	_iput
	add	esp, 4

; 312  : 		return -EPERM;

	or	eax, -1
	pop	edi
	pop	esi
	pop	ebx

; 356  : }

	pop	ebp
	ret	0
$L741:

; 313  : 	}
; 314  : // 释放该设备文件的i 节点dev_i。
; 315  : 	iput (dev_i);

	call	_iput

; 316  : // 根据给定的目录文件名找到对应的i 节点dir_i。
; 317  : 	if (!(dir_i = namei (dir_name)))

	mov	edx, DWORD PTR _dir_name$[ebp]
	push	edx
	call	_namei
	mov	esi, eax
	add	esp, 8
	test	esi, esi
	jne	SHORT $L742
	pop	edi
	pop	esi

; 318  : 		return -ENOENT;

	mov	eax, -2					; fffffffeH
	pop	ebx

; 356  : }

	pop	ebp
	ret	0
$L742:

; 319  : // 如果该i 节点的引用计数不为1（仅在这里引用），或者该i 节点的节点号是根文件系统的节点
; 320  : // 号1，则释放该i 节点，返回出错码。
; 321  : 	if (dir_i->i_count != 1 || dir_i->i_num == ROOT_INO)

	mov	ebx, 1
	cmp	WORD PTR [esi+48], bx
	jne	SHORT $L744
	cmp	WORD PTR [esi+46], bx
	je	SHORT $L744

; 325  : 	}
; 326  : // 如果该节点不是一个目录文件节点，则也释放该i 节点，返回出错码。
; 327  : 	if (!S_ISDIR (dir_i->i_mode))

	mov	ax, WORD PTR [esi]
	and	eax, 61440				; 0000f000H
	cmp	eax, 16384				; 00004000H
	je	SHORT $L745

; 328  : 	{
; 329  : 		iput (dir_i);

	push	esi
	call	_iput
	add	esp, 4

; 330  : 		return -EPERM;

	or	eax, -1
	pop	edi
	pop	esi
	pop	ebx

; 356  : }

	pop	ebp
	ret	0
$L745:

; 331  : 	}
; 332  : // 读取将安装文件系统的超级块，如果失败则也释放该i 节点，返回出错码。
; 333  : 	if (!(sb = read_super (dev)))

	push	edi
	call	_read_super
	add	esp, 4
	test	eax, eax

; 334  : 	{
; 335  : 		iput (dir_i);
; 336  : 		return -EBUSY;

	je	SHORT $L744

; 337  : 	}
; 338  : // 如果将要被安装的文件系统已经安装在其它地方，则释放该i 节点，返回出错码。
; 339  : 	if (sb->s_imount)

	mov	ecx, DWORD PTR [eax+92]
	test	ecx, ecx

; 340  : 	{
; 341  : 		iput (dir_i);
; 342  : 		return -EBUSY;

	jne	SHORT $L744

; 343  : 	}
; 344  : // 如果将要安装到的i 节点已经安装了文件系统(安装标志已经置位)，则释放该i 节点，返回出错码。
; 345  : 	if (dir_i->i_mount)

	mov	cl, BYTE PTR [esi+53]
	test	cl, cl
	je	SHORT $L748

; 346  : 	{
; 347  : 		iput (dir_i);

	push	esi
	call	_iput
	add	esp, 4

; 348  : 		return -EPERM;

	or	eax, -1
	pop	edi
	pop	esi
	pop	ebx

; 356  : }

	pop	ebp
	ret	0
$L748:

; 349  : 	}
; 350  : // 被安装文件系统超级块的“被安装到i 节点”字段指向安装到的目录名的i 节点。
; 351  : 	sb->s_imount = dir_i;

	mov	DWORD PTR [eax+92], esi

; 352  : // 设置安装位置i 节点的安装标志和节点已修改标志。/* 注意！这里没有iput(dir_i) */
; 353  : 	dir_i->i_mount = 1;		/* 这将在umount 内操作 */

	mov	BYTE PTR [esi+53], bl

; 354  : 	dir_i->i_dirt = 1;		/* NOTE! we don't iput(dir_i) */

	mov	BYTE PTR [esi+51], bl
	pop	edi
	pop	esi

; 355  : 	return 0;			/* we do that in umount */

	xor	eax, eax
	pop	ebx

; 356  : }

	pop	ebp
	ret	0
$L744:

; 322  : 	{
; 323  : 		iput (dir_i);

	push	esi
	call	_iput
	add	esp, 4

; 324  : 		return -EBUSY;

	mov	eax, -16				; fffffff0H
	pop	edi
	pop	esi
	pop	ebx

; 356  : }

	pop	ebp
	ret	0
_sys_mount ENDP
_TEXT	ENDS
EXTRN	_check_disk_change:NEAR
EXTRN	_bread:NEAR
_TEXT	SEGMENT
_dev$ = 8
_i$ = -4
_read_super PROC NEAR

; 154  : {

	push	ebp
	mov	ebp, esp
	push	ecx
	push	ebx
	push	esi

; 155  : 	struct super_block *s;
; 156  : 	struct buffer_head *bh;
; 157  : 	int i, block;
; 158  : 
; 159  : // 如果没有指明设备，则返回空指针。
; 160  : 	if (!dev)

	mov	esi, DWORD PTR _dev$[ebp]
	push	edi
	xor	edi, edi
	cmp	esi, edi

; 161  : 		return NULL;

	je	$L843

; 162  : // 首先检查该设备是否可更换过盘片（也即是否是软盘设备），如果更换过盘，则高速缓冲区有关该
; 163  : // 设备的所有缓冲块均失效，需要进行失效处理（释放原来加载的文件系统）。
; 164  : 	check_disk_change (dev);

	push	esi
	call	_check_disk_change

; 165  : // 如果该设备的超级块已经在高速缓冲中，则直接返回该超级块的指针。
; 166  : 	if (s = get_super (dev))

	push	esi
	call	_get_super
	add	esp, 8
	cmp	eax, edi

; 167  : 		return s;

	jne	$L671

; 168  : // 否则，首先在超级块数组中找出一个空项(也即其s_dev=0 的项)。如果数组已经占满则返回空指针。
; 169  : 	for (s = 0 + super_block;; s++)

	mov	ebx, OFFSET FLAT:_super_block
$L678:

; 170  : 	{
; 171  : 		if (s >= NR_SUPER + super_block)
; 172  : 			return NULL;
; 173  : 		if (!s->s_dev)

	cmp	WORD PTR [ebx+84], di
	je	SHORT $L830
	add	ebx, 108				; 0000006cH
	cmp	ebx, OFFSET FLAT:_super_block+864
	jb	SHORT $L678
	pop	edi
	pop	esi

; 233  : 		return NULL;

	xor	eax, eax
	pop	ebx

; 243  : }

	mov	esp, ebp
	pop	ebp
	ret	0
$L830:

; 174  : 			break;
; 175  : 	}
; 176  : // 找到超级块空项后，就将该超级块用于指定设备，对该超级块的内存项进行部分初始化。
; 177  : 	s->s_dev = dev;

	mov	WORD PTR [ebx+84], si

; 178  : 	s->s_isup = NULL;

	mov	DWORD PTR [ebx+88], edi

; 179  : 	s->s_imount = NULL;

	mov	DWORD PTR [ebx+92], edi

; 180  : 	s->s_time = 0;

	mov	DWORD PTR [ebx+96], edi

; 181  : 	s->s_rd_only = 0;

	mov	BYTE PTR [ebx+105], 0

; 182  : 	s->s_dirt = 0;
; 183  : // 然后锁定该超级块，并从设备上读取超级块信息到bh 指向的缓冲区中。如果读超级块操作失败，
; 184  : // 则释放上面选定的超级块数组中的项，并解锁该项，返回空指针退出。
; 185  : 	lock_super (s);

	push	ebx
	mov	BYTE PTR [ebx+106], 0
	call	_lock_super

; 186  : 	if (!(bh = bread (dev, 1)))

	push	1
	push	esi
	call	_bread
	add	esp, 12					; 0000000cH
	cmp	eax, edi
	jne	SHORT $L683

; 230  : //释放上面选定的超级块数组中的项，并解锁该超级块项，返回空指针退出。
; 231  : 		s->s_dev = 0;
; 232  : 		free_super (s);

	push	ebx
	mov	WORD PTR [ebx+84], di
	call	_free_super
	add	esp, 4

; 233  : 		return NULL;

	xor	eax, eax
	pop	edi
	pop	esi
	pop	ebx

; 243  : }

	mov	esp, ebp
	pop	ebp
	ret	0
$L683:

; 187  : 	{
; 188  : 		s->s_dev = 0;
; 189  : 		free_super (s);
; 190  : 		return NULL;
; 191  : 	}
; 192  : // 将设备上读取的超级块信息复制到超级块数组相应项结构中。并释放存放读取信息的高速缓冲块。
; 193  : 	*((struct d_super_block *) s) = *((struct d_super_block *) bh->b_data);

	mov	esi, DWORD PTR [eax]
	mov	ecx, 5
	mov	edi, ebx

; 194  : 	brelse (bh);

	push	eax
	rep movsd
	call	_brelse
	add	esp, 4

; 195  : // 如果读取的超级块的文件系统魔数字段内容不对，说明设备上不是正确的文件系统，因此同上面
; 196  : // 一样，释放上面选定的超级块数组中的项，并解锁该项，返回空指针退出。
; 197  : // 对于该版linux 内核，只支持minix 文件系统版本1.0，其魔数是0x137f。
; 198  : 	if (s->s_magic != SUPER_MAGIC)

	cmp	WORD PTR [ebx+16], 4991			; 0000137fH

; 199  : 	{
; 200  : 		s->s_dev = 0;
; 201  : 		free_super (s);
; 202  : 		return NULL;

	jne	$L841

; 203  : 	}
; 204  : // 下面开始读取设备上i 节点位图和逻辑块位图数据。首先初始化内存超级块结构中位图空间。
; 205  : 	for (i = 0; i < I_MAP_SLOTS; i++)

	lea	esi, DWORD PTR [ebx+20]

; 206  : 		s->s_imap[i] = NULL;

	mov	ecx, 8
	xor	eax, eax
	mov	edi, esi
	rep stosd

; 207  : 	for (i = 0; i < Z_MAP_SLOTS; i++)

	lea	edi, DWORD PTR [ebx+52]

; 208  : 		s->s_zmap[i] = NULL;

	mov	ecx, 8
	rep stosd

; 209  : // 然后从设备上读取i 节点位图和逻辑块位图信息，并存放在超级块对应字段中。
; 210  : 	block = 2;
; 211  : 	for (i = 0; i < s->s_imap_blocks; i++)

	cmp	WORD PTR [ebx+4], ax
	mov	edi, 2
	jbe	SHORT $L696
$L693:

; 212  : 		if (s->s_imap[i] = bread (dev, block))

	mov	eax, DWORD PTR _dev$[ebp]
	push	edi
	push	eax
	call	_bread
	add	esp, 8
	mov	DWORD PTR [esi], eax
	test	eax, eax
	je	SHORT $L696

; 213  : 			block++;

	inc	edi
	xor	edx, edx
	mov	dx, WORD PTR [ebx+4]
	add	esi, 4
	lea	ecx, DWORD PTR [edi-2]
	cmp	ecx, edx
	jl	SHORT $L693
$L696:

; 214  : 		else
; 215  : 			break;
; 216  : 	for (i = 0; i < s->s_zmap_blocks; i++)

	cmp	WORD PTR [ebx+6], 0
	mov	DWORD PTR _i$[ebp], 0
	jbe	SHORT $L701
	lea	esi, DWORD PTR [ebx+52]
$L698:

; 217  : 		if (s->s_zmap[i] = bread (dev, block))

	mov	eax, DWORD PTR _dev$[ebp]
	push	edi
	push	eax
	call	_bread
	add	esp, 8
	mov	DWORD PTR [esi], eax
	test	eax, eax
	je	SHORT $L701
	mov	eax, DWORD PTR _i$[ebp]
	xor	ecx, ecx
	mov	cx, WORD PTR [ebx+6]

; 218  : 			block++;

	inc	edi
	inc	eax
	add	esi, 4
	cmp	eax, ecx
	mov	DWORD PTR _i$[ebp], eax
	jl	SHORT $L698
$L701:

; 219  : 		else
; 220  : 			break;
; 221  : // 如果读出的位图逻辑块数不等于位图应该占有的逻辑块数，说明文件系统位图信息有问题，超级块
; 222  : // 初始化失败。因此只能释放前面申请的所有资源，返回空指针并退出。
; 223  : 	if (block != 2 + s->s_imap_blocks + s->s_zmap_blocks)

	xor	edx, edx
	xor	eax, eax
	mov	dx, WORD PTR [ebx+6]
	mov	ax, WORD PTR [ebx+4]
	lea	ecx, DWORD PTR [edx+eax+2]
	cmp	edi, ecx
	je	SHORT $L703

; 224  : 	{
; 225  : // 释放i 节点位图和逻辑块位图占用的高速缓冲区。
; 226  : 		for (i = 0; i < I_MAP_SLOTS; i++)

	lea	esi, DWORD PTR [ebx+20]
	mov	edi, 8
$L704:

; 227  : 			brelse (s->s_imap[i]);

	mov	edx, DWORD PTR [esi]
	push	edx
	call	_brelse
	add	esp, 4
	add	esi, 4
	dec	edi
	jne	SHORT $L704

; 228  : 		for (i = 0; i < Z_MAP_SLOTS; i++)

	lea	esi, DWORD PTR [ebx+52]
	mov	edi, 8
$L707:

; 229  : 			brelse (s->s_zmap[i]);

	mov	eax, DWORD PTR [esi]
	push	eax
	call	_brelse
	add	esp, 4
	add	esi, 4
	dec	edi
	jne	SHORT $L707
$L841:

; 230  : //释放上面选定的超级块数组中的项，并解锁该超级块项，返回空指针退出。
; 231  : 		s->s_dev = 0;
; 232  : 		free_super (s);

	push	ebx
	mov	WORD PTR [ebx+84], 0
	call	_free_super
	add	esp, 4
$L843:
	pop	edi
	pop	esi

; 233  : 		return NULL;

	xor	eax, eax
	pop	ebx

; 243  : }

	mov	esp, ebp
	pop	ebp
	ret	0
$L703:

; 234  : 	}
; 235  : // 否则一切成功。对于申请空闲i 节点的函数来讲，如果设备上所有的i 节点已经全被使用，则查找
; 236  : // 函数会返回0 值。因此0 号i 节点是不能用的，所以这里将位图中的最低位设置为1，以防止文件
; 237  : // 系统分配0 号i 节点。同样的道理，也将逻辑块位图的最低位设置为1。
; 238  : 	s->s_imap[0]->b_data[0] |= 1;

	mov	ecx, DWORD PTR [ebx+20]

; 239  : 	s->s_zmap[0]->b_data[0] |= 1;

	mov	edx, DWORD PTR [ebx+52]

; 240  : // 解锁该超级块，并返回超级块指针。
; 241  : 	free_super (s);

	push	ebx
	mov	eax, DWORD PTR [ecx]
	mov	cl, BYTE PTR [eax]
	or	cl, 1
	mov	BYTE PTR [eax], cl
	mov	eax, DWORD PTR [edx]
	or	BYTE PTR [eax], 1
	call	_free_super
	add	esp, 4

; 242  : 	return s;

	mov	eax, ebx
$L671:
	pop	edi
	pop	esi
	pop	ebx

; 243  : }

	mov	esp, ebp
	pop	ebp
	ret	0
_read_super ENDP
_TEXT	ENDS
PUBLIC	_mount_root
EXTRN	_file_table:BYTE
EXTRN	_iget:NEAR
EXTRN	_panic:NEAR
EXTRN	_wait_for_keypress:NEAR
_DATA	SEGMENT
	ORG $+3
$SG757	DB	'bad i-node size', 00H
$SG763	DB	'Insert root floppy and press ENTER', 00H
	ORG $+1
$SG768	DB	'Unable to mount root', 00H
	ORG $+3
$SG770	DB	'Unable to read root i-node', 00H
	ORG $+1
$SG775	DB	'%d/%d free blocks', 0aH, 0dH, 00H
$SG780	DB	'%d/%d free inodes', 0aH, 0dH, 00H
_DATA	ENDS
_TEXT	SEGMENT
$T848 = -8
$T849 = -4
$T854 = -4
$T855 = -8
_mount_root PROC NEAR

; 362  : {

	push	ebp
	mov	ebp, esp
	sub	esp, 8

; 370  : // 初始化文件表数组（共64 项，也即系统同时只能打开64 个文件），将所有文件结构中的引用计数
; 371  : // 设置为0。[??为什么放在这里初始化？]
; 372  : 	for (i = 0; i < NR_FILE; i++)

	mov	eax, OFFSET FLAT:_file_table+4
$L758:

; 373  : 		file_table[i].f_count = 0;

	mov	WORD PTR [eax], 0
	add	eax, 16					; 00000010H
	cmp	eax, OFFSET FLAT:_file_table+1028
	jl	SHORT $L758

; 374  : // 如果根文件系统所在设备是软盘的话，就提示“插入根文件系统盘，并按回车键”，并等待按键。
; 375  : 	if (MAJOR (ROOT_DEV) == 2)

	mov	eax, DWORD PTR _ROOT_DEV
	and	al, 0
	cmp	eax, 512				; 00000200H
	jne	SHORT $L762

; 376  : 	{
; 377  : 		printk ("Insert root floppy and press ENTER");

	push	OFFSET FLAT:$SG763
	call	_printk
	add	esp, 4

; 378  : 		wait_for_keypress ();

	call	_wait_for_keypress
$L762:

; 379  : 	}
; 380  : // 初始化超级块数组（共8 项）。
; 381  : 	for (p = &super_block[0]; p < &super_block[NR_SUPER]; p++)

	mov	eax, OFFSET FLAT:_super_block+104
$L764:

; 382  : 	{
; 383  : 		p->s_dev = 0;

	xor	ecx, ecx
	mov	WORD PTR [eax-20], cx

; 384  : 		p->s_lock = 0;

	mov	BYTE PTR [eax], cl

; 385  : 		p->s_wait = NULL;

	mov	DWORD PTR [eax-4], ecx
	add	eax, 108				; 0000006cH
	lea	ecx, DWORD PTR [eax-104]
	cmp	ecx, OFFSET FLAT:_super_block+864
	jb	SHORT $L764

; 386  : 	}
; 387  : // 如果读根设备上超级块失败，则显示信息，并死机。
; 388  : 	if (!(p = read_super (ROOT_DEV)))

	mov	edx, DWORD PTR _ROOT_DEV
	push	ebx
	push	esi
	push	edi
	push	edx
	call	_read_super
	mov	esi, eax
	add	esp, 4
	test	esi, esi
	jne	SHORT $L767

; 389  : 		panic ("Unable to mount root");

	push	OFFSET FLAT:$SG768
	call	_panic
	add	esp, 4
$L767:

; 390  : //从设备上读取文件系统的根i 节点(1)，如果失败则显示出错信息，死机。
; 391  : 	if (!(mi = iget (ROOT_DEV, ROOT_INO)))

	mov	eax, DWORD PTR _ROOT_DEV
	push	1
	push	eax
	call	_iget
	mov	edi, eax
	add	esp, 8
	test	edi, edi
	jne	SHORT $L769

; 392  : 		panic ("Unable to read root i-node");

	push	OFFSET FLAT:$SG770
	call	_panic
	add	esp, 4
$L769:

; 393  : // 该i 节点引用次数递增3 次。因为下面266-268 行上也引用了该i 节点。
; 394  : 	mi->i_count += 3;		/* NOTE! it is logically used 4 times, not 1 */
; 395  : /* 注意！从逻辑上讲，它已被引用了4 次，而不是1 次 */
; 396  : // 置该超级块的被安装文件系统i 节点和被安装到的i 节点为该i 节点。
; 397  : 	p->s_isup = p->s_imount = mi;
; 398  : // 设置当前进程的当前工作目录和根目录i 节点。此时当前进程是1 号进程。
; 399  : 	current->pwd = mi;

	mov	eax, DWORD PTR _current
	add	WORD PTR [edi+48], 3

; 400  : 	current->root = mi;
; 401  : // 统计该设备上空闲块数。首先令i 等于超级块中表明的设备逻辑块总数。
; 402  : 	free = 0;
; 403  : 	i = p->s_nzones;
; 404  : // 然后根据逻辑块位图中相应比特位的占用情况统计出空闲块数。这里宏函数set_bit()只是在测试
; 405  : // 比特位，而非设置比特位。"i&8191"用于取得i 节点号在当前块中的偏移值。"i>>13"是将i 除以
; 406  : // 8192，也即除一个磁盘块包含的比特位数。
; 407  : 	while (--i >= 0)

	xor	ecx, ecx
	mov	DWORD PTR [esi+92], edi
	mov	cx, WORD PTR [esi+2]
	mov	DWORD PTR [eax+624], edi
	mov	DWORD PTR [esi+88], edi
	mov	DWORD PTR [eax+628], edi
	xor	edi, edi
	dec	ecx
	js	SHORT $L773
$L772:

; 408  : 		if (!set_bit (i & 8191, p->s_zmap[i >> 13]->b_data))

	mov	edx, ecx
	sar	edx, 13					; 0000000dH
	mov	eax, DWORD PTR [esi+edx*4+52]
	mov	edx, DWORD PTR [eax]
	mov	eax, ecx
	and	eax, 8191				; 00001fffH
	mov	DWORD PTR $T849[ebp], edx
	mov	DWORD PTR $T848[ebp], eax

; 363  : 	int i, free;
; 364  : 	struct super_block *p;
; 365  : 	struct m_inode *mi;

	xor	eax, eax

; 366  : 

	mov	ebx, DWORD PTR $T848[ebp]

; 367  : // 如果磁盘i 节点结构不是32 个字节，则出错，死机。该判断是用于防止修改源代码时的不一致性。

	mov	edx, DWORD PTR $T849[ebp]

; 368  : 	if (32 != sizeof (struct d_inode))

	bt	DWORD PTR [edx], ebx

; 369  : 		panic ("bad i-node size");

	setb	al

; 408  : 		if (!set_bit (i & 8191, p->s_zmap[i >> 13]->b_data))

	test	eax, eax
	jne	SHORT $L774

; 409  : 			free++;

	inc	edi
$L774:

; 400  : 	current->root = mi;
; 401  : // 统计该设备上空闲块数。首先令i 等于超级块中表明的设备逻辑块总数。
; 402  : 	free = 0;
; 403  : 	i = p->s_nzones;
; 404  : // 然后根据逻辑块位图中相应比特位的占用情况统计出空闲块数。这里宏函数set_bit()只是在测试
; 405  : // 比特位，而非设置比特位。"i&8191"用于取得i 节点号在当前块中的偏移值。"i>>13"是将i 除以
; 406  : // 8192，也即除一个磁盘块包含的比特位数。
; 407  : 	while (--i >= 0)

	dec	ecx
	jns	SHORT $L772
$L773:

; 410  : // 显示设备上空闲逻辑块数/逻辑块总数。
; 411  : 	printk ("%d/%d free blocks\n\r", free, p->s_nzones);

	xor	ecx, ecx
	mov	cx, WORD PTR [esi+2]
	push	ecx
	push	edi
	push	OFFSET FLAT:$SG775
	call	_printk

; 412  : // 统计设备上空闲i 节点数。首先令i 等于超级块中表明的设备上i 节点总数+1。加1 是将0 节点
; 413  : // 也统计进去。
; 414  : 	free = 0;
; 415  : 	i = p->s_ninodes + 1;
; 416  : // 然后根据i 节点位图中相应比特位的占用情况计算出空闲i 节点数。
; 417  : 	while (--i >= 0)

	xor	ecx, ecx
	add	esp, 12					; 0000000cH
	mov	cx, WORD PTR [esi]
	xor	edi, edi
	test	ecx, ecx
	jl	SHORT $L778
$L777:

; 418  : 		if (!set_bit (i & 8191, p->s_imap[i >> 13]->b_data))

	mov	edx, ecx
	sar	edx, 13					; 0000000dH
	mov	eax, DWORD PTR [esi+edx*4+20]
	mov	edx, DWORD PTR [eax]
	mov	eax, ecx
	and	eax, 8191				; 00001fffH
	mov	DWORD PTR $T855[ebp], edx
	mov	DWORD PTR $T854[ebp], eax

; 363  : 	int i, free;
; 364  : 	struct super_block *p;
; 365  : 	struct m_inode *mi;

	xor	eax, eax

; 366  : 

	mov	ebx, DWORD PTR $T854[ebp]

; 367  : // 如果磁盘i 节点结构不是32 个字节，则出错，死机。该判断是用于防止修改源代码时的不一致性。

	mov	edx, DWORD PTR $T855[ebp]

; 368  : 	if (32 != sizeof (struct d_inode))

	bt	DWORD PTR [edx], ebx

; 369  : 		panic ("bad i-node size");

	setb	al

; 418  : 		if (!set_bit (i & 8191, p->s_imap[i >> 13]->b_data))

	test	eax, eax
	jne	SHORT $L779

; 419  : 			free++;

	inc	edi
$L779:

; 412  : // 统计设备上空闲i 节点数。首先令i 等于超级块中表明的设备上i 节点总数+1。加1 是将0 节点
; 413  : // 也统计进去。
; 414  : 	free = 0;
; 415  : 	i = p->s_ninodes + 1;
; 416  : // 然后根据i 节点位图中相应比特位的占用情况计算出空闲i 节点数。
; 417  : 	while (--i >= 0)

	dec	ecx
	jns	SHORT $L777
$L778:

; 420  : // 显示设备上可用的空闲i 节点数/i 节点总数。
; 421  : 	printk ("%d/%d free inodes\n\r", free, p->s_ninodes);

	xor	ecx, ecx
	mov	cx, WORD PTR [esi]
	push	ecx
	push	edi
	push	OFFSET FLAT:$SG780
	call	_printk
	add	esp, 12					; 0000000cH
	pop	edi
	pop	esi
	pop	ebx

; 422  : }

	mov	esp, ebp
	pop	ebp
	ret	0
_mount_root ENDP
_TEXT	ENDS
END
