	TITLE	..\kernel\blk_drv\ramdisk.c
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
;	COMDAT ??_C@_0CF@NPNB@ramdisk?3?5free?5buffer?5being?5unloc@
_DATA	SEGMENT DWORD USE32 PUBLIC 'DATA'
_DATA	ENDS
;	COMDAT ??_C@_0BE@HGNO@ramdisk?5I?1O?5error?6?$AN?$AA@
_DATA	SEGMENT DWORD USE32 PUBLIC 'DATA'
_DATA	ENDS
;	COMDAT ??_C@_0BF@ONON@dev?5?$CF04x?0?5block?5?$CFd?6?$AN?$AA@
_DATA	SEGMENT DWORD USE32 PUBLIC 'DATA'
_DATA	ENDS
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
;	COMDAT _unlock_buffer
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT _end_request
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
FLAT	GROUP _DATA, CONST, _BSS
	ASSUME	CS: FLAT, DS: FLAT, SS: FLAT
endif
PUBLIC	_rd_start
PUBLIC	_rd_length
_BSS	SEGMENT
_rd_start DD	01H DUP (?)
_rd_length DD	01H DUP (?)
_BSS	ENDS
PUBLIC	_rd_init
EXTRN	_blk_dev:BYTE
_TEXT	SEGMENT
_mem_start$ = 8
_length$ = 12
_rd_init PROC NEAR

; 78   : {

	push	ebp
	mov	ebp, esp

; 79   : 	int i;
; 80   : 	char *cp;
; 81   : 
; 82   : 	blk_dev[MAJOR_NR].request_fn = DEVICE_REQUEST;	// do_rd_request()。
; 83   : 	rd_start = (char *) mem_start;
; 84   : 	rd_length = length;

	mov	edx, DWORD PTR _length$[ebp]
	push	edi
	mov	edi, DWORD PTR _mem_start$[ebp]
	mov	DWORD PTR _blk_dev+8, OFFSET FLAT:_do_rd_request

; 85   : 	cp = rd_start;
; 86   : 	for (i = 0; i < length; i++)

	test	edx, edx
	mov	DWORD PTR _rd_start, edi
	mov	DWORD PTR _rd_length, edx
	jle	SHORT $L923
	mov	ecx, edx
	push	esi
	mov	esi, ecx
	xor	eax, eax
	shr	ecx, 2
	rep stosd
	mov	ecx, esi
	pop	esi
	and	ecx, 3
	rep stosb

; 87   : 		*cp++ = '\0';
; 88   : 	return (length);

	mov	eax, edx
	pop	edi

; 89   : }

	pop	ebp
	ret	0
$L923:

; 87   : 		*cp++ = '\0';
; 88   : 	return (length);

	mov	eax, edx
	pop	edi

; 89   : }

	pop	ebp
	ret	0
_rd_init ENDP
_TEXT	ENDS
PUBLIC	??_C@_0CF@NPNB@ramdisk?3?5free?5buffer?5being?5unloc@ ; `string'
PUBLIC	??_C@_0BE@HGNO@ramdisk?5I?1O?5error?6?$AN?$AA@	; `string'
PUBLIC	??_C@_0BF@ONON@dev?5?$CF04x?0?5block?5?$CFd?6?$AN?$AA@ ; `string'
EXTRN	_panic:NEAR
EXTRN	_wake_up:NEAR
EXTRN	_printk:NEAR
EXTRN	_wait_for_request:DWORD
;	COMDAT ??_C@_0CF@NPNB@ramdisk?3?5free?5buffer?5being?5unloc@
; File ..\kernel\blk_drv\blk.h
_DATA	SEGMENT
??_C@_0CF@NPNB@ramdisk?3?5free?5buffer?5being?5unloc@ DB 'ramdisk: free b'
	DB	'uffer being unlocked', 0aH, 00H		; `string'
_DATA	ENDS
;	COMDAT ??_C@_0BE@HGNO@ramdisk?5I?1O?5error?6?$AN?$AA@
_DATA	SEGMENT
??_C@_0BE@HGNO@ramdisk?5I?1O?5error?6?$AN?$AA@ DB 'ramdisk I/O error', 0aH
	DB	0dH, 00H					; `string'
_DATA	ENDS
;	COMDAT ??_C@_0BF@ONON@dev?5?$CF04x?0?5block?5?$CFd?6?$AN?$AA@
_DATA	SEGMENT
??_C@_0BF@ONON@dev?5?$CF04x?0?5block?5?$CFd?6?$AN?$AA@ DB 'dev %04x, bloc'
	DB	'k %d', 0aH, 0dH, 00H			; `string'
_DATA	ENDS
_DATA	SEGMENT
$SG826	DB	'ramdisk: request list destroyed', 00H
$SG829	DB	'ramdisk: block not locked', 00H
	ORG $+2
$SG838	DB	'unknown ramdisk-command', 00H
_DATA	ENDS
_TEXT	SEGMENT
_len$ = -4
_addr$ = -8
$T942 = -12
$T946 = -12
_do_rd_request PROC NEAR

; 40   : {

	push	ebp
	mov	ebp, esp
	sub	esp, 12					; 0000000cH

; 44   : 	INIT_REQUEST;			// 检测请求的合法性(参见kernel/blk_drv/blk.h,127)。

	mov	eax, DWORD PTR _blk_dev+12
	push	ebx
	xor	ebx, ebx
	push	esi
	cmp	eax, ebx
	push	edi
	je	$L963
$repeat$822:
	mov	ecx, DWORD PTR [eax]
	and	cl, 0
	cmp	ecx, 256				; 00000100H
	je	SHORT $L825
	push	OFFSET FLAT:$SG826
	call	_panic
	mov	eax, DWORD PTR _blk_dev+12
	add	esp, 4
$L825:
	mov	ecx, DWORD PTR [eax+28]
	cmp	ecx, ebx
	je	SHORT $L828
	cmp	BYTE PTR [ecx+13], bl
	jne	SHORT $L828
	push	OFFSET FLAT:$SG829
	call	_panic
	mov	eax, DWORD PTR _blk_dev+12
	add	esp, 4
$L828:

; 47   : 	addr = rd_start + (CURRENT->sector << 9);

	mov	ecx, DWORD PTR [eax+12]
	mov	esi, DWORD PTR _rd_start

; 48   : 	len = CURRENT->nr_sectors << 9;

	mov	edx, DWORD PTR [eax+16]
	shl	ecx, 9
	add	ecx, esi
	shl	edx, 9

; 49   : // 如果子设备号不为1 或者对应内存起始位置>虚拟盘末尾，则结束该请求，并跳转到repeat 处
; 50   : // （定义在28 行的INIT_REQUEST 内开始处）。
; 51   : 	if ((MINOR (CURRENT->dev) != 1) || (addr + len > rd_start + rd_length))

	cmp	BYTE PTR [eax], 1
	mov	DWORD PTR _addr$[ebp], ecx
	mov	DWORD PTR _len$[ebp], edx
	jne	$L831
	mov	edi, DWORD PTR _rd_length
	add	edx, ecx
	add	edi, esi
	cmp	edx, edi
	ja	$L831

; 54   : 		goto repeat;
; 55   : 	}
; 56   : // 如果是写命令(WRITE)，则将请求项中缓冲区的内容复制到addr 处，长度为len 字节。
; 57   : 	if (CURRENT->cmd == WRITE)

	mov	ecx, DWORD PTR [eax+4]
	cmp	ecx, 1
	jne	SHORT $L832

; 58   : 	{
; 59   : 		(void) memcpy (addr, CURRENT->buffer, len);

	mov	edx, DWORD PTR [eax+20]
	mov	DWORD PTR $T942[ebp], edx

; 41   : 	int len;
; 42   : 	char *addr;

	pushf

; 43   : 

	mov	esi, DWORD PTR $T942[ebp]

; 44   : 	INIT_REQUEST;			// 检测请求的合法性(参见kernel/blk_drv/blk.h,127)。

	mov	edi, DWORD PTR _addr$[ebp]

; 45   : // 下面语句取得ramdisk 的起始扇区对应的内存起始位置和内存长度。

	mov	ecx, DWORD PTR _len$[ebp]

; 46   : // 其中sector << 9 表示sector * 512，CURRENT 定义为(blk_dev[MAJOR_NR].current_request)。

	cld

; 47   : 	addr = rd_start + (CURRENT->sector << 9);

	rep	 movsb

; 48   : 	len = CURRENT->nr_sectors << 9;

	popf

; 60   : // 如果是读命令(READ)，则将addr 开始的内容复制到请求项中缓冲区中，长度为len 字节。
; 61   : 	}
; 62   : 	else if (CURRENT->cmd == READ)

	jmp	SHORT $L837
$L832:
	cmp	ecx, ebx
	jne	SHORT $L835

; 63   : 	{
; 64   : 		(void) memcpy (CURRENT->buffer, addr, len);

	mov	eax, DWORD PTR [eax+20]
	mov	DWORD PTR $T946[ebp], eax

; 41   : 	int len;
; 42   : 	char *addr;

	pushf

; 43   : 

	mov	esi, DWORD PTR _addr$[ebp]

; 44   : 	INIT_REQUEST;			// 检测请求的合法性(参见kernel/blk_drv/blk.h,127)。

	mov	edi, DWORD PTR $T946[ebp]

; 45   : // 下面语句取得ramdisk 的起始扇区对应的内存起始位置和内存长度。

	mov	ecx, DWORD PTR _len$[ebp]

; 46   : // 其中sector << 9 表示sector * 512，CURRENT 定义为(blk_dev[MAJOR_NR].current_request)。

	cld

; 47   : 	addr = rd_start + (CURRENT->sector << 9);

	rep	 movsb

; 48   : 	len = CURRENT->nr_sectors << 9;

	popf

; 65   : // 否则显示命令不存在，死机。
; 66   : 	}
; 67   : 	else

	jmp	SHORT $L837
$L835:

; 68   : 		panic ("unknown ramdisk-command");

	push	OFFSET FLAT:$SG838
	call	_panic
	add	esp, 4
$L837:

; 69   : // 请求项成功后处理，置更新标志。并继续处理本设备的下一请求项。
; 70   : 	end_request (1);

	mov	ecx, DWORD PTR _blk_dev+12
	mov	esi, DWORD PTR [ecx+28]
	cmp	esi, ebx
	je	SHORT $L955
	mov	al, BYTE PTR [esi+13]
	mov	BYTE PTR [esi+10], 1
	cmp	al, bl
	jne	SHORT $L958
	push	OFFSET FLAT:??_C@_0CF@NPNB@ramdisk?3?5free?5buffer?5being?5unloc@ ; `string'
	call	_printk
	add	esp, 4
$L958:
	mov	BYTE PTR [esi+13], bl
	add	esi, 16					; 00000010H
	push	esi
	call	_wake_up
	add	esp, 4
$L955:
	mov	edx, DWORD PTR _blk_dev+12
	add	edx, 24					; 00000018H
	push	edx
	call	_wake_up
	push	OFFSET FLAT:_wait_for_request
	call	_wake_up
	add	esp, 8

; 71   : 	goto repeat;

	jmp	SHORT $L966
$L831:

; 52   : 	{
; 53   : 		end_request (0);

	mov	esi, DWORD PTR [eax+28]
	cmp	esi, ebx
	je	SHORT $L965
	mov	al, BYTE PTR [esi+13]
	mov	BYTE PTR [esi+10], bl
	cmp	al, bl
	jne	SHORT $L936
	push	OFFSET FLAT:??_C@_0CF@NPNB@ramdisk?3?5free?5buffer?5being?5unloc@ ; `string'
	call	_printk
	add	esp, 4
$L936:
	mov	BYTE PTR [esi+13], bl
	add	esi, 16					; 00000010H
	push	esi
	call	_wake_up
	add	esp, 4
$L965:
	push	OFFSET FLAT:??_C@_0BE@HGNO@ramdisk?5I?1O?5error?6?$AN?$AA@ ; `string'
	call	_printk
	mov	eax, DWORD PTR _blk_dev+12
	mov	ecx, DWORD PTR [eax+28]
	mov	eax, DWORD PTR [eax]
	mov	edx, DWORD PTR [ecx+4]
	push	edx
	push	eax
	push	OFFSET FLAT:??_C@_0BF@ONON@dev?5?$CF04x?0?5block?5?$CFd?6?$AN?$AA@ ; `string'
	call	_printk
	mov	ecx, DWORD PTR _blk_dev+12
	add	ecx, 24					; 00000018H
	push	ecx
	call	_wake_up
	push	OFFSET FLAT:_wait_for_request
	call	_wake_up
	add	esp, 24					; 00000018H
$L966:
	mov	eax, DWORD PTR _blk_dev+12
	mov	DWORD PTR [eax], -1
	mov	eax, DWORD PTR [eax+32]
	cmp	eax, ebx
	mov	DWORD PTR _blk_dev+12, eax
	jne	$repeat$822
$L963:

; 72   : }

	pop	edi
	pop	esi
	pop	ebx
	mov	esp, ebp
	pop	ebp
	ret	0
_do_rd_request ENDP
_TEXT	ENDS
PUBLIC	_rd_load
EXTRN	_brelse:NEAR
EXTRN	_bread:NEAR
EXTRN	_breada:NEAR
EXTRN	_ROOT_DEV:DWORD
_DATA	SEGMENT
$SG862	DB	'Ram disk: %d bytes, starting at 0x%x', 0aH, 00H
	ORG $+2
$SG866	DB	'Disk error while looking for ramdisk!', 0aH, 00H
	ORG $+1
$SG871	DB	'Ram disk image too big! (%d blocks, %d avail)', 0aH, 00H
	ORG $+1
$SG872	DB	'Loading %d bytes into ram disk... 0000k', 00H
$SG879	DB	'I/O error on block %d, aborting load', 0aH, 00H
	ORG $+2
$SG881	DB	08H, 08H, 08H, 08H, 08H, '%4dk', 00H
	ORG $+2
$SG882	DB	08H, 08H, 08H, 08H, 08H, 'done ', 0aH, 00H
_DATA	ENDS
_TEXT	SEGMENT
_s$ = -124
_block$ = -4
_nblocks$ = -12
_cp$ = -8
$T971 = -16
_rd_load PROC NEAR

; 98   : {

	push	ebp
	mov	ebp, esp
	sub	esp, 124				; 0000007cH

; 106  : 	if (!rd_length)		// 如果ramdisk 的长度为零，则退出。

	mov	eax, DWORD PTR _rd_length
	push	ebx
	push	esi
	push	edi
	test	eax, eax
	mov	DWORD PTR _block$[ebp], 256		; 00000100H
	je	$L853

; 107  : 		return;
; 108  : 	printk ("Ram disk: %d bytes, starting at 0x%x\n", rd_length, (int) rd_start);	// 显示ramdisk 的大小以及内存起始位置。

	mov	ecx, DWORD PTR _rd_start
	push	ecx
	push	eax
	push	OFFSET FLAT:$SG862
	call	_printk

; 109  : 	if (MAJOR (ROOT_DEV) != 2)	// 如果此时根文件设备不是软盘，则退出。

	mov	eax, DWORD PTR _ROOT_DEV
	add	esp, 12					; 0000000cH
	mov	edx, eax
	and	dl, 0
	cmp	edx, 512				; 00000200H
	jne	$L853

; 110  : 		return;
; 111  : // 读软盘块256+1,256,256+2。breada()用于读取指定的数据块，并标出还需要读的块，然后返回
; 112  : // 含有数据块的缓冲区指针。如果返回NULL，则表示数据块不可读(fs/buffer.c,322)。
; 113  : // 这里block+1 是指磁盘上的超级块。
; 114  : 	bh = breada (ROOT_DEV, block + 1, block, block + 2, -1);

	push	-1
	push	258					; 00000102H
	push	256					; 00000100H
	push	257					; 00000101H
	push	eax
	call	_breada
	add	esp, 20					; 00000014H

; 115  : 	if (!bh)

	test	eax, eax
	jne	SHORT $L865

; 116  : 	{
; 117  : 		printk ("Disk error while looking for ramdisk!\n");

	push	OFFSET FLAT:$SG866
	call	_printk
	add	esp, 4

; 160  : }

	pop	edi
	pop	esi
	pop	ebx
	mov	esp, ebp
	pop	ebp
	ret	0
$L865:

; 118  : 		return;
; 119  : 	}
; 120  : // 将s 指向缓冲区中的磁盘超级块。(d_super_block 磁盘中超级块结构)。
; 121  : 	*((struct d_super_block *) &s) = *((struct d_super_block *) bh->b_data);

	mov	esi, DWORD PTR [eax]
	mov	ecx, 5
	lea	edi, DWORD PTR _s$[ebp]

; 122  : 	brelse (bh);			// [?? 为什么数据没有复制就立刻释放呢？]

	push	eax
	rep movsd
	call	_brelse
	add	esp, 4

; 123  : 	if (s.s_magic != SUPER_MAGIC)	// 如果超级块中魔数不对，则说明不是minix 文件系统。

	cmp	WORD PTR _s$[ebp+16], 4991		; 0000137fH
	jne	$L853

; 124  : 		return;/* 磁盘中没有ramdisk 映像文件，退出执行通常的软盘引导 */
; 125  : // 块数 = 逻辑块数(区段数) * 2^(每区段块数的次方)。
; 126  : // 如果数据块数大于内存中虚拟盘所能容纳的块数，则不能加载，显示出错信息并返回。否则显示
; 127  : // 加载数据块信息。
; 128  : 	nblocks = s.s_nzones << s.s_log_zone_size;

	mov	esi, DWORD PTR _s$[ebp+2]
	mov	cl, BYTE PTR _s$[ebp+10]

; 129  : 	if (nblocks > (rd_length >> BLOCK_SIZE_BITS))

	mov	eax, DWORD PTR _rd_length
	and	esi, 65535				; 0000ffffH
	shl	esi, cl
	sar	eax, 10					; 0000000aH
	cmp	esi, eax
	mov	DWORD PTR _nblocks$[ebp], esi
	jle	SHORT $L870

; 130  : 	{
; 131  : 		printk ("Ram disk image too big! (%d blocks, %d avail)\n",
; 132  : 				nblocks, rd_length >> BLOCK_SIZE_BITS);

	push	eax
	push	esi
	push	OFFSET FLAT:$SG871
	call	_printk
	add	esp, 12					; 0000000cH

; 160  : }

	pop	edi
	pop	esi
	pop	ebx
	mov	esp, ebp
	pop	ebp
	ret	0
$L870:

; 133  : 		return;
; 134  : 	}
; 135  : 	printk ("Loading %d bytes into ram disk... 0000k",
; 136  : 	nblocks << BLOCK_SIZE_BITS);

	mov	eax, esi
	shl	eax, 10					; 0000000aH
	push	eax
	push	OFFSET FLAT:$SG872
	call	_printk

; 137  : // cp 指向虚拟盘起始处，然后将磁盘上的根文件系统映象文件复制到虚拟盘上。
; 138  : 	cp = rd_start;

	mov	ecx, DWORD PTR _rd_start
	add	esp, 8

; 139  : 	while (nblocks)

	test	esi, esi
	mov	DWORD PTR _cp$[ebp], ecx
	je	$L875

; 133  : 		return;
; 134  : 	}
; 135  : 	printk ("Loading %d bytes into ram disk... 0000k",
; 136  : 	nblocks << BLOCK_SIZE_BITS);

	mov	ebx, 257				; 00000101H
	jmp	SHORT $L874
$L975:
	mov	esi, DWORD PTR _nblocks$[ebp]
$L874:

; 140  : 	{
; 141  : 		if (nblocks > 2)		// 如果需读取的块数多于3 快则采用超前预读方式读数据块。

	cmp	esi, 2
	jle	SHORT $L876

; 142  : 			bh = breada (ROOT_DEV, block, block + 1, block + 2, -1);

	mov	eax, DWORD PTR _block$[ebp]
	mov	ecx, DWORD PTR _ROOT_DEV
	lea	edx, DWORD PTR [ebx+1]
	push	-1
	push	edx
	push	ebx
	push	eax
	push	ecx
	call	_breada
	add	esp, 20					; 00000014H

; 143  : 		else			// 否则就单块读取。

	jmp	SHORT $L877
$L876:

; 144  : 			bh = bread (ROOT_DEV, block);

	mov	edx, DWORD PTR _block$[ebp]
	mov	eax, DWORD PTR _ROOT_DEV
	push	edx
	push	eax
	call	_bread
	add	esp, 8
$L877:

; 145  : 		if (!bh)

	test	eax, eax
	je	SHORT $L973

; 148  : 			return;
; 149  : 		}
; 150  : 		(void) memcpy (cp, bh->b_data, BLOCK_SIZE);	// 将缓冲区中的数据复制到cp 处。

	mov	ecx, DWORD PTR [eax]
	mov	DWORD PTR $T971[ebp], ecx

; 99   : 	struct buffer_head *bh;
; 100  : 	struct super_block s;

	pushf

; 101  : 	int block = 256;		/* Start at block 256 */

	mov	esi, DWORD PTR $T971[ebp]

; 102  : 	int i = 1;

	mov	edi, DWORD PTR _cp$[ebp]

; 103  : 	int nblocks;

	mov	ecx, 1024				; 00000400H

; 104  : 	char *cp;			/* Move pointer */

	cld

; 105  : 

	rep	 movsb

; 106  : 	if (!rd_length)		// 如果ramdisk 的长度为零，则退出。

	popf

; 151  : 		brelse (bh);		// 释放缓冲区。

	push	eax
	call	_brelse
	lea	edx, DWORD PTR [ebx-256]

; 152  : 		printk ("\010\010\010\010\010%4dk", i);	// 打印加载块计数值。

	push	edx
	push	OFFSET FLAT:$SG881
	call	_printk

; 153  : 		cp += BLOCK_SIZE;		// 虚拟盘指针前移。

	mov	esi, DWORD PTR _cp$[ebp]

; 154  : 		block++;

	mov	edx, DWORD PTR _block$[ebp]

; 155  : 		nblocks--;

	mov	eax, DWORD PTR _nblocks$[ebp]
	add	esp, 12					; 0000000cH
	add	esi, 1024				; 00000400H
	inc	edx
	inc	ebx
	dec	eax
	mov	DWORD PTR _cp$[ebp], esi
	mov	DWORD PTR _block$[ebp], edx
	mov	DWORD PTR _nblocks$[ebp], eax
	jne	$L975
$L875:

; 156  : 		i++;
; 157  : 	}
; 158  : 	printk ("\010\010\010\010\010done \n");

	push	OFFSET FLAT:$SG882
	call	_printk
	add	esp, 4

; 159  : 	ROOT_DEV = 0x0101;		// 修改ROOT_DEV 使其指向虚拟盘ramdisk。

	mov	DWORD PTR _ROOT_DEV, 257		; 00000101H
$L853:

; 160  : }

	pop	edi
	pop	esi
	pop	ebx
	mov	esp, ebp
	pop	ebp
	ret	0
$L973:

; 146  : 		{
; 147  : 			printk ("I/O error on block %d, aborting load\n", block);

	mov	eax, DWORD PTR _block$[ebp]
	push	eax
	push	OFFSET FLAT:$SG879
	call	_printk
	add	esp, 8

; 160  : }

	pop	edi
	pop	esi
	pop	ebx
	mov	esp, ebp
	pop	ebp
	ret	0
_rd_load ENDP
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
$l1$42:

; 39   : 	l1:	lodsb	// 加载DS:[esi]处1 字节->al，并更新esi。

	lodsb

; 40   : 		stosb		// 存储字节al->ES:[edi]，并更新edi。

	stosb

; 41   : 		test al,al	// 刚存储的字节是0？

	test	al, al

; 42   : 		jne l1	// 不是则跳转到标号l1 处，否则结束。

	jne	SHORT $l1$42

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
$l1$59:

; 115  : 	l1: lodsb	// 取源字符串字节ds:[esi]->al，并esi++。

	lodsb

; 116  : 		stosb		// 将该字节存到es:[edi]，并edi++。

	stosb

; 117  : 		test al,al	// 该字节是0？

	test	al, al

; 118  : 		jne l1	// 不是，则向后跳转到标号1 处继续拷贝，否则结束。

	jne	SHORT $l1$59

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
$l1$76:

; 201  :   l1: lodsb	// 取字符串2 的字节ds:[esi]??al，并且esi++。

	lodsb

; 202  : 	  scasb		// al 与字符串1 的字节es:[edi]作比较，并且edi++。

	scasb

; 203  : 	  jne l2		// 如果不相等，则向前跳转到标号2。

	jne	SHORT $l2$77

; 204  : 	  test al,al	// 该字节是0 值字节吗（字符串结尾）？

	test	al, al

; 205  : 	  jne l1		// 不是，则向后跳转到标号1，继续比较。

	jne	SHORT $l1$76

; 206  : 	  xor eax,eax	// 是，则返回值eax 清零，

	xor	eax, eax

; 207  : 	  jmp l3		// 向前跳转到标号3，结束。

	jmp	SHORT $l3$78
$l2$77:

; 208  :   l2: mov eax,1	// eax 中置1。

	mov	eax, 1

; 209  : 	  jl l3		// 若前面比较中串2 字符<串1 字符，则返回正值，结束。

	jl	SHORT $l3$78

; 210  : 	  neg eax	// 否则eax = -eax，返回负值，结束。

	neg	eax
$l3$78:

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
$l1$114:

; 396  :   l1: lodsb	// 取串1 字符ds:[esi]->al，并且esi++。

	lodsb

; 397  : 	  test al,al	// 该字符等于0 值吗（串1 结尾）？

	test	al, al

; 398  : 	  je l2		// 如果是，则向前跳转到标号2 处。

	je	SHORT $l2$115

; 399  : 	  mov edi,ebx	// 取串2 头指针放入edi 中。

	mov	edi, ebx

; 400  : 	  mov ecx,edx	// 再将串2 的长度值放入ecx 中。

	mov	ecx, edx

; 401  : 	  repne scasb	// 比较al 与串2 中字符es:[edi]，并且edi++。如果不相等就继续比较。

	repnz	 scasb

; 402  : 	  je l1		// 如果相等，则向后跳转到标号1 处。

	je	SHORT $l1$114
$l2$115:

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
$l1$123:

; 454  : 	l1: lodsb	// 取串1 字符ds:[esi]->al，并且esi++。

	lodsb

; 455  : 		test al,al	// 该字符等于0 值吗（串1 结尾）？

	test	al, al

; 456  : 		je l2		// 如果是，则向前跳转到标号2 处。

	je	SHORT $l2$124

; 457  : 		mov edi,ebx	// 取串2 头指针放入edi 中。

	mov	edi, ebx

; 458  : 		mov ecx,edx 	// 再将串2 的长度值放入ecx 中。

	mov	ecx, edx

; 459  : 		repne scasb	// 比较al 与串2 中字符es:[edi]，并且edi++。如果不相等就继续比较。

	repnz	 scasb

; 460  : 		jne l1		// 如果不相等，则向后跳转到标号1 处。

	jne	SHORT $l1$123
$l2$124:

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
$l1$131:

; 512  : 	l1: lodsb	// 取串1 字符ds:[esi]??al，并且esi++。

	lodsb

; 513  : 		test al,al	// 该字符等于0 值吗（串1 结尾）？

	test	al, al

; 514  : 		je l2		// 如果是，则向前跳转到标号2 处。

	je	SHORT $l2$132

; 515  : 		mov edi,ebx	// 取串2 头指针放入edi 中。

	mov	edi, ebx

; 516  : 		mov ecx,edx	// 再将串2 的长度值放入ecx 中。

	mov	ecx, edx

; 517  : 		repne scasb		// 比较al 与串2 中字符es:[edi]，并且edi++。如果不相等就继续比较。

	repnz	 scasb

; 518  : 		jne l1	// 如果不相等，则向后跳转到标号1 处。

	jne	SHORT $l1$131

; 519  : 		dec esi	// esi--，指向一个包含在串2 中的字符。

	dec	esi

; 520  : 		jmp l3		// 向前跳转到标号3 处。

	jmp	SHORT $l3$133
$l2$132:

; 521  : 	l2: xor esi,esi	// 没有找到符合条件的，将返回值为NULL。

	xor	esi, esi
$l3$133:

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
$l1$140:

; 576  : 	l1: mov edi,ebx	// 取串2 头指针放入edi 中。

	mov	edi, ebx

; 577  : 		mov ecx,edx	// 再将串2 的长度值放入ecx 中。

	mov	ecx, edx

; 578  : 		mov eax,esi	// 将串1 的指针复制到eax 中。

	mov	eax, esi

; 579  : 		repe cmpsb// 比较串1 和串2 字符(ds:[esi],es:[edi])，esi++,edi++。若对应字符相等就一直比较下去。

	rep	 cmpsb

; 580  : 		je l2

	je	SHORT $l2$141

; 581  : // 对空串同样有效，见上面 // 若全相等，则转到标号2。
; 582  : 		xchg esi,eax	// 串1 头指针->esi，比较结果的串1 指针->eax。

	xchg	esi, eax

; 583  : 		inc esi	// 串1 头指针指向下一个字符。

	inc	esi

; 584  : 		cmp [eax-1],0	// 串1 指针(eax-1)所指字节是0 吗？

	cmp	BYTE PTR [eax-1], 0

; 585  : 		jne l1	// 不是则跳转到标号1，继续从串1 的第2 个字符开始比较。

	jne	SHORT $l1$140

; 586  : 		xor eax,eax	// 清eax，表示没有找到匹配。

	xor	eax, eax
$l2$141:

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

	jne	SHORT $l1$153

; 678  : 		mov ebx,strtok

	mov	ebx, DWORD PTR _strtok

; 679  : 		test ebx,ebx	// 如果是NULL，则表示此次是后续调用，测ebx(__strtok)。

	test	ebx, ebx

; 680  : 		je l8		// 如果ebx 指针是NULL，则不能处理，跳转结束。

	je	SHORT $l8$154

; 681  : 		mov esi,ebx	// 将ebx 指针复制到esi。

	mov	esi, ebx
$l1$153:

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

	je	SHORT $l7$155

; 691  : 		mov edx,ecx	// 将串2 长度暂存入edx。

	mov	edx, ecx
$l2$156:

; 692  : 	l2: lodsb	// 取串1 的字符ds:[esi]->al，并且esi++。

	lodsb

; 693  : 		test al,al	// 该字符为0 值吗(串1 结束)？

	test	al, al

; 694  : 		je l7		// 如果是，则跳转标号7。

	je	SHORT $l7$155

; 695  : 		mov edi,ct	// edi 再次指向串2 首。

	mov	edi, DWORD PTR _ct$[ebp]

; 696  : 		mov ecx,edx	// 取串2 的长度值置入计数器ecx。

	mov	ecx, edx

; 697  : 		repne scasb// 将al 中串1 的字符与串2 中所有字符比较，判断该字符是否为分割符。

	repnz	 scasb

; 698  : 		je l2		// 若能在串2 中找到相同字符（分割符），则跳转标号2。

	je	SHORT $l2$156

; 699  : 		dec esi	// 若不是分割符，则串1 指针esi 指向此时的该字符。

	dec	esi

; 700  : 		cmp [esi],0	// 该字符是NULL 字符吗？

	cmp	BYTE PTR [esi], 0

; 701  : 		je l7		// 若是，则跳转标号7 处。

	je	SHORT $l7$155

; 702  : 		mov ebx,esi	// 将该字符的指针esi 存放在ebx。

	mov	ebx, esi
$l3$157:

; 703  : 	l3: lodsb	// 取串1 下一个字符ds:[esi]->al，并且esi++。

	lodsb

; 704  : 		test al,al	// 该字符是NULL 字符吗？

	test	al, al

; 705  : 		je l5		// 若是，表示串1 结束，跳转到标号5。

	je	SHORT $l5$158

; 706  : 		mov edi,ct	// edi 再次指向串2 首。

	mov	edi, DWORD PTR _ct$[ebp]

; 707  : 		mov ecx,edx	// 串2 长度值置入计数器ecx。

	mov	ecx, edx

; 708  : 		repne scasb // 将al 中串1 的字符与串2 中每个字符比较，测试al 字符是否是分割符。

	repnz	 scasb

; 709  : 		jne l3		// 若不是分割符则跳转标号3，检测串1 中下一个字符。

	jne	SHORT $l3$157

; 710  : 		dec esi	// 若是分割符，则esi--，指向该分割符字符。

	dec	esi

; 711  : 		cmp [esi],0	// 该分割符是NULL 字符吗？

	cmp	BYTE PTR [esi], 0

; 712  : 		je l5		// 若是，则跳转到标号5。

	je	SHORT $l5$158

; 713  : 		mov [esi],0	// 若不是，则将该分割符用NULL 字符替换掉。

	mov	BYTE PTR [esi], 0

; 714  : 		inc esi	// esi 指向串1 中下一个字符，也即剩余串首。

	inc	esi

; 715  : 		jmp l6		// 跳转标号6 处。

	jmp	SHORT $l6$159
$l5$158:

; 716  : 	l5: xor esi,esi	// esi 清零。

	xor	esi, esi
$l6$159:

; 717  : 	l6: cmp [ebx],0	// ebx 指针指向NULL 字符吗？

	cmp	BYTE PTR [ebx], 0

; 718  : 		jne l7	// 若不是，则跳转标号7。

	jne	SHORT $l7$155

; 719  : 		xor ebx,ebx	// 若是，则让ebx=NULL。

	xor	ebx, ebx
$l7$155:

; 720  : 	l7: test ebx,ebx	// ebx 指针为NULL 吗？

	test	ebx, ebx

; 721  : 		jne l8	// 若不是则跳转8，结束汇编代码。

	jne	SHORT $l8$154

; 722  : 		mov esi,ebx	// 将esi 置为NULL。

	mov	esi, ebx
$l8$154:

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
	jae	SHORT $L176

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
$L176:

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

	je	SHORT $l1$186

; 881  : 		mov eax,1	// 否则eax 置1，

	mov	eax, 1

; 882  : 		jl l1		// 若内存块2 内容的值<内存块1，则跳转标号1。

	jl	SHORT $l1$186

; 883  : 		neg eax	// 否则eax = -eax。

	neg	eax
$l1$186:

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
	jne	SHORT $L195

; 914  :     return NULL;

	xor	eax, eax

; 928  : 	}
; 929  : //  return __res;			// 返回字符指针。
; 930  : }

	pop	edi
	pop	ebp
	ret	0
$L195:

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

	je	SHORT $l1$196

; 923  : 		mov edi,1	// 否则edi 中置1。

	mov	edi, 1
$l1$196:

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

	je	SHORT $l1$673

; 278  : 		xchg ecx,current/* current = task[n]； */

	xchg	ecx, DWORD PTR _current

; 279  : 		/*执行长跳转，造成任务切换 (头大了很长时间，多多包涵)*/
; 280  : 		mov ax, __tmp

	mov	ax, WORD PTR ___tmp$[ebp]

; 281  : 		mov word ptr ds:[lcs],ax

	mov	WORD PTR ds:$lcs$674, ax

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
$lcs$674:

; 287  : lcs:	_emit 0		// cs

	DB	0

; 288  : 		_emit 0

	DB	0

; 289  : // 在任务切换回来后才会继续执行下面的语句。
; 290  : 		cmp last_task_used_math,ecx /* 新任务上次使用过协处理器吗？*/

	cmp	DWORD PTR _last_task_used_math, ecx

; 291  : 		jne l1

	jne	SHORT $l1$673

; 292  : 		clts/* 新任务上次使用过协处理器，则清cr0 的TS 标志。*/

	clts
$l1$673:

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
PUBLIC	_unlock_buffer
;	COMDAT _unlock_buffer
_TEXT	SEGMENT
_bh$ = 8
_unlock_buffer PROC NEAR				; COMDAT

; 102  : {

	push	ebp
	mov	ebp, esp
	push	esi

; 103  :   if (!bh->b_lock)		// 如果指定的缓冲区bh 并没有被上锁，则显示警告信息。

	mov	esi, DWORD PTR _bh$[ebp]
	mov	al, BYTE PTR [esi+13]
	test	al, al
	jne	SHORT $L806

; 104  :     printk (DEVICE_NAME ": free buffer being unlocked\n");

	push	OFFSET FLAT:??_C@_0CF@NPNB@ramdisk?3?5free?5buffer?5being?5unloc@ ; `string'
	call	_printk
	add	esp, 4
$L806:

; 105  :   bh->b_lock = 0;		// 否则将该缓冲区解锁。

	mov	BYTE PTR [esi+13], 0

; 106  :   wake_up (&bh->b_wait);	// 唤醒等待该缓冲区的进程。

	add	esi, 16					; 00000010H
	push	esi
	call	_wake_up
	add	esp, 4
	pop	esi

; 107  : }

	pop	ebp
	ret	0
_unlock_buffer ENDP
_TEXT	ENDS
PUBLIC	_end_request
;	COMDAT _end_request
_TEXT	SEGMENT
_uptodate$ = 8
_end_request PROC NEAR					; COMDAT

; 112  : {

	push	ebp
	mov	ebp, esp

; 113  :   DEVICE_OFF (CURRENT->dev);	// 关闭设备。
; 114  :   if (CURRENT->bh)

	mov	eax, DWORD PTR _blk_dev+12
	push	ebx
	mov	ebx, DWORD PTR _uptodate$[ebp]
	push	esi
	mov	esi, DWORD PTR [eax+28]
	test	esi, esi
	je	SHORT $L1011

; 115  :     {				// CURRENT 为指定主设备号的当前请求结构。
; 116  :       CURRENT->bh->b_uptodate = uptodate;	// 置更新标志。
; 117  :       unlock_buffer (CURRENT->bh);	// 解锁缓冲区。

	mov	al, BYTE PTR [esi+13]
	mov	BYTE PTR [esi+10], bl
	test	al, al
	jne	SHORT $L1012
	push	OFFSET FLAT:??_C@_0CF@NPNB@ramdisk?3?5free?5buffer?5being?5unloc@ ; `string'
	call	_printk
	add	esp, 4
$L1012:
	mov	BYTE PTR [esi+13], 0
	add	esi, 16					; 00000010H
	push	esi
	call	_wake_up
	add	esp, 4
$L1011:
	pop	esi

; 118  :     }
; 119  :   if (!uptodate)

	test	ebx, ebx
	pop	ebx
	jne	SHORT $L813

; 120  :     {				// 如果更新标志为0 则显示设备错误信息。
; 121  :       printk (DEVICE_NAME " I/O error\n\r");

	push	OFFSET FLAT:??_C@_0BE@HGNO@ramdisk?5I?1O?5error?6?$AN?$AA@ ; `string'
	call	_printk

; 122  :       printk ("dev %04x, block %d\n\r", CURRENT->dev, CURRENT->bh->b_blocknr);

	mov	eax, DWORD PTR _blk_dev+12
	mov	ecx, DWORD PTR [eax+28]
	mov	eax, DWORD PTR [eax]
	mov	edx, DWORD PTR [ecx+4]
	push	edx
	push	eax
	push	OFFSET FLAT:??_C@_0BF@ONON@dev?5?$CF04x?0?5block?5?$CFd?6?$AN?$AA@ ; `string'
	call	_printk
	add	esp, 16					; 00000010H
$L813:

; 123  :     }
; 124  :   wake_up (&CURRENT->waiting);	// 唤醒等待该请求项的进程。

	mov	ecx, DWORD PTR _blk_dev+12
	add	ecx, 24					; 00000018H
	push	ecx
	call	_wake_up

; 125  :   wake_up (&wait_for_request);	// 唤醒等待请求的进程。

	push	OFFSET FLAT:_wait_for_request
	call	_wake_up

; 126  :   CURRENT->dev = -1;		// 释放该请求项。

	mov	eax, DWORD PTR _blk_dev+12
	add	esp, 8
	mov	DWORD PTR [eax], -1

; 127  :   CURRENT = CURRENT->next;	// 从请求链表中删除该请求项。

	mov	edx, DWORD PTR [eax+32]
	mov	DWORD PTR _blk_dev+12, edx

; 128  : }

	pop	ebp
	ret	0
_end_request ENDP
_TEXT	ENDS
END
