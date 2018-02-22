	TITLE	..\fs\bitmap.c
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
;	COMDAT _clear_block
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT _set_bit
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT _clear_bit
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT _find_first_zero
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
FLAT	GROUP _DATA, CONST, _BSS
	ASSUME	CS: FLAT, DS: FLAT, SS: FLAT
endif
PUBLIC	_clear_block
;	COMDAT _clear_block
_TEXT	SEGMENT
_addr$ = 8
_clear_block PROC NEAR					; COMDAT

; 22   : {_asm{

	push	ebp
	mov	ebp, esp
	push	edi

; 23   : 	pushf

	pushf

; 24   : 	mov edi,addr

	mov	edi, DWORD PTR _addr$[ebp]

; 25   : 	mov ecx,BLOCK_SIZE/4

	mov	ecx, 256				; 00000100H

; 26   : 	xor eax,eax

	xor	eax, eax

; 27   : 	cld

	cld

; 28   : 	rep stosd

	rep	 stosd

; 29   : 	popf

	popf

; 30   : }}

	pop	edi
	pop	ebp
	ret	0
_clear_block ENDP
_TEXT	ENDS
PUBLIC	_set_bit
;	COMDAT _set_bit
_TEXT	SEGMENT
_nr$ = 8
_addr$ = 12
_set_bit PROC NEAR					; COMDAT

; 40   : {

	push	ebp
	mov	ebp, esp
	push	ebx

; 41   : //	volatile register int __res;
; 42   : 	_asm{
; 43   : 		xor eax,eax

	xor	eax, eax

; 44   : 		mov ebx,nr

	mov	ebx, DWORD PTR _nr$[ebp]

; 45   : 		mov edx,addr

	mov	edx, DWORD PTR _addr$[ebp]

; 46   : 		bts [edx],ebx

	bts	DWORD PTR [edx], ebx

; 47   : 		setb al

	setb	al
	pop	ebx

; 48   : //		mov __res,eax
; 49   : 	}
; 50   : //	return __res;
; 51   : }

	pop	ebp
	ret	0
_set_bit ENDP
_TEXT	ENDS
PUBLIC	_clear_bit
;	COMDAT _clear_bit
_TEXT	SEGMENT
_nr$ = 8
_addr$ = 12
_clear_bit PROC NEAR					; COMDAT

; 61   : {

	push	ebp
	mov	ebp, esp
	push	ebx

; 62   : //	volatile register int __res;
; 63   : 	_asm{
; 64   : 		xor eax,eax

	xor	eax, eax

; 65   : 		mov ebx,nr

	mov	ebx, DWORD PTR _nr$[ebp]

; 66   : 		mov edx,addr

	mov	edx, DWORD PTR _addr$[ebp]

; 67   : 		btr [edx],ebx

	btr	DWORD PTR [edx], ebx

; 68   : 		setnb al

	setae	al
	pop	ebx

; 69   : //		mov __res,eax
; 70   : 	}
; 71   : //	return __res;
; 72   : }

	pop	ebp
	ret	0
_clear_bit ENDP
_TEXT	ENDS
PUBLIC	_find_first_zero
;	COMDAT _find_first_zero
_TEXT	SEGMENT
_addr$ = 8
_find_first_zero PROC NEAR				; COMDAT

; 83   : {

	push	ebp
	mov	ebp, esp
	push	esi

; 84   : //	int __res;
; 85   : 	_asm{
; 86   : 		pushf

	pushf

; 87   : 		xor ecx,ecx

	xor	ecx, ecx

; 88   : 		mov esi,addr

	mov	esi, DWORD PTR _addr$[ebp]

; 89   : 		cld   /*清方向位。*/

	cld
$l1$742:

; 90   : 	l1: lodsd   /*取[esi] -> eax。*/

	lodsd

; 91   : 		not eax   /*eax 中每位取反。*/

	not	eax

; 92   : 		bsf edx,eax   /*从位0 扫描eax 中是1 的第1 个位，其偏移值 -> edx。*/

	bsf	edx, eax

; 93   : 		je l2   /*如果eax 中全是0，则向前跳转到标号2 处(40 行)。*/

	je	SHORT $l2$743

; 94   : 		add ecx,edx   /*偏移值加入ecx(ecx 中是位图中首个是0 的比特位的偏移值)*/

	add	ecx, edx

; 95   : 		jmp l3   /*向前跳转到标号3 处（结束）。*/

	jmp	SHORT $l3$744
$l2$743:

; 96   : 	l2: add ecx,32   /*没有找到0 比特位，则将ecx 加上1 个长字的位偏移量32。*/

	add	ecx, 32					; 00000020H

; 97   : 		cmp ecx,8192   /*已经扫描了8192 位（1024 字节）了吗？*/

	cmp	ecx, 8192				; 00002000H

; 98   : 		jl l1  /*若还没有扫描完1 块数据，则向前跳转到标号1 处，继续。*/

	jl	SHORT $l1$742
$l3$744:

; 99   : //	l3: mov __res,ecx  /*结束。此时ecx 中是位偏移量。*/
; 100  : 	l3: mov eax,ecx

	mov	eax, ecx

; 101  : 		popf

	popf

; 102  : 	}
; 103  : //	return __res;
; 104  : }

	pop	esi
	pop	ebp
	ret	0
_find_first_zero ENDP
_TEXT	ENDS
PUBLIC	_free_block
EXTRN	_get_hash_table:NEAR
EXTRN	_brelse:NEAR
EXTRN	_get_super:NEAR
EXTRN	_panic:NEAR
EXTRN	_printk:NEAR
_DATA	SEGMENT
$SG753	DB	'trying to free block on nonexistent device', 00H
	ORG $+1
$SG756	DB	'trying to free block not in datazone', 00H
	ORG $+3
$SG759	DB	'trying to free block (%04x:%d), count=%d', 0aH, 00H
	ORG $+2
$SG761	DB	'block (%04x:%d) ', 00H
	ORG $+3
$SG762	DB	'free_block: bit already cleared', 00H
_DATA	ENDS
_TEXT	SEGMENT
_dev$ = 8
_block$ = 12
$T861 = -4
$T862 = 12
_free_block PROC NEAR

; 125  : {

	push	ebp
	mov	ebp, esp
	sub	esp, 8

; 130  : 	if (!(sb = get_super(dev)))

	mov	eax, DWORD PTR _dev$[ebp]
	push	ebx
	push	esi
	push	edi
	push	eax
	call	_get_super
	mov	edi, eax
	add	esp, 4
	test	edi, edi
	jne	SHORT $L752

; 131  : 		panic("trying to free block on nonexistent device");

	push	OFFSET FLAT:$SG753
	call	_panic
	add	esp, 4
$L752:

; 133  : 	if (block < sb->s_firstdatazone || block >= sb->s_nzones)

	mov	esi, DWORD PTR _block$[ebp]
	xor	ebx, ebx
	mov	bx, WORD PTR [edi+8]
	cmp	esi, ebx
	jl	SHORT $L755
	xor	ecx, ecx
	mov	cx, WORD PTR [edi+2]
	cmp	esi, ecx
	jl	SHORT $L754
$L755:

; 134  : 		panic("trying to free block not in datazone");

	push	OFFSET FLAT:$SG756
	call	_panic
	add	esp, 4
$L754:

; 135  : // 从hash 表中寻找该块数据。若找到了则判断其有效性，并清已修改和更新标志，释放该数据块。
; 136  : // 该段代码的主要用途是如果该逻辑块当前存在于高速缓冲中，就释放对应的缓冲块。
; 137  : 	bh = get_hash_table(dev,block);

	mov	edx, DWORD PTR _dev$[ebp]
	push	esi
	push	edx
	call	_get_hash_table
	add	esp, 8

; 138  : 	if (bh) {

	test	eax, eax
	je	SHORT $L757

; 139  : 		if (bh->b_count != 1) {

	mov	cl, BYTE PTR [eax+12]
	cmp	cl, 1
	je	SHORT $L758

; 140  : 			printk("trying to free block (%04x:%d), count=%d\n",
; 141  : 				dev,block,bh->b_count);

	mov	eax, DWORD PTR _dev$[ebp]
	and	ecx, 255				; 000000ffH
	push	ecx
	push	esi
	push	eax
	push	OFFSET FLAT:$SG759
	call	_printk
	add	esp, 16					; 00000010H
	pop	edi
	pop	esi
	pop	ebx

; 157  : }

	mov	esp, ebp
	pop	ebp
	ret	0
$L758:

; 142  : 			return;
; 143  : 		}
; 144  : 		bh->b_dirt=0;		// 复位脏（已修改）标志位。
; 145  : 		bh->b_uptodate=0;	// 复位更新标志。
; 146  : 		brelse(bh);

	push	eax
	mov	BYTE PTR [eax+11], 0
	mov	BYTE PTR [eax+10], 0
	call	_brelse
	add	esp, 4
$L757:

; 147  : 	}
; 148  : // 计算block 在数据区开始算起的数据逻辑块号（从1 开始计数）。然后对逻辑块(区块)位图进行操作，
; 149  : // 复位对应的比特位。若对应比特位原来即是0，则出错，死机。
; 150  : 	block -= sb->s_firstdatazone - 1 ;

	mov	ecx, 1
	sub	ecx, ebx
	add	esi, ecx

; 151  : 	if (clear_bit(block&8191,sb->s_zmap[block/8192]->b_data)) {

	mov	eax, esi
	cdq
	and	edx, 8191				; 00001fffH
	add	eax, edx
	sar	eax, 13					; 0000000dH
	mov	edx, DWORD PTR [edi+eax*4+52]
	lea	ecx, DWORD PTR [edi+eax*4+52]
	mov	DWORD PTR -8+[ebp], ecx
	mov	eax, DWORD PTR [edx]
	mov	edx, esi
	and	edx, 8191				; 00001fffH
	mov	DWORD PTR $T862[ebp], eax
	mov	DWORD PTR $T861[ebp], edx

; 126  : 	struct super_block * sb;
; 127  : 	struct buffer_head * bh;
; 128  : 

	xor	eax, eax

; 129  : // 取指定设备dev 的超级块，如果指定设备不存在，则出错死机。

	mov	ebx, DWORD PTR $T861[ebp]

; 130  : 	if (!(sb = get_super(dev)))

	mov	edx, DWORD PTR $T862[ebp]

; 131  : 		panic("trying to free block on nonexistent device");

	btr	DWORD PTR [edx], ebx

; 132  : // 若逻辑块号小于首个逻辑块号或者大于设备上总逻辑块数，则出错，死机。

	setae	al

; 151  : 	if (clear_bit(block&8191,sb->s_zmap[block/8192]->b_data)) {

	test	eax, eax
	je	SHORT $L760

; 152  : 		printk("block (%04x:%d) ",dev,block+sb->s_firstdatazone-1);

	mov	edx, DWORD PTR _dev$[ebp]
	xor	eax, eax
	mov	ax, WORD PTR [edi+8]
	lea	ecx, DWORD PTR [eax+esi-1]
	push	ecx
	push	edx
	push	OFFSET FLAT:$SG761
	call	_printk

; 153  : 		panic("free_block: bit already cleared");

	push	OFFSET FLAT:$SG762
	call	_panic
	mov	ecx, DWORD PTR -8+[ebp]
	add	esp, 16					; 00000010H
$L760:

; 154  : 	}
; 155  : 	// 置相应逻辑块位图所在缓冲区已修改标志。
; 156  : 	sb->s_zmap[block/8192]->b_dirt = 1;

	mov	eax, DWORD PTR [ecx]
	pop	edi
	pop	esi
	pop	ebx
	mov	BYTE PTR [eax+11], 1

; 157  : }

	mov	esp, ebp
	pop	ebp
	ret	0
_free_block ENDP
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
PUBLIC	_new_block
EXTRN	_getblk:NEAR
_DATA	SEGMENT
$SG771	DB	'trying to get new block from nonexistant device', 00H
$SG780	DB	'new_block: bit already set', 00H
	ORG $+1
$SG783	DB	'new_block: cannot get block', 00H
$SG785	DB	'new block: count is != 1', 00H
_DATA	ENDS
_TEXT	SEGMENT
_dev$ = 8
_bh$ = -16
_sb$ = -20
_j$ = -12
$T873 = -8
$T877 = -8
$T882 = 8
_new_block PROC NEAR

; 162  : {

	push	ebp
	mov	ebp, esp
	sub	esp, 20					; 00000014H

; 168  : 	if (!(sb = get_super(dev)))

	mov	eax, DWORD PTR _dev$[ebp]
	push	ebx
	push	esi
	push	edi
	push	eax
	call	_get_super
	mov	esi, eax
	add	esp, 4
	test	esi, esi
	mov	DWORD PTR _sb$[ebp], esi
	jne	SHORT $L770

; 169  : 		panic("trying to get new block from nonexistant device");

	push	OFFSET FLAT:$SG771
	call	_panic
	add	esp, 4
$L770:

; 172  : 	for (i=0 ; i<8 ; i++)

	xor	edi, edi
	add	esi, 52					; 00000034H
	mov	DWORD PTR -4+[ebp], esi
$L772:

; 173  : 		if (bh=sb->s_zmap[i])

	mov	ebx, DWORD PTR [esi]
	test	ebx, ebx
	mov	DWORD PTR _bh$[ebp], ebx
	je	SHORT $L773

; 174  : 			if ((j=find_first_zero(bh->b_data))<8192)

	mov	ecx, DWORD PTR [ebx]
	mov	DWORD PTR $T873[ebp], ecx

; 165  : 	int i,j;

	pushf

; 166  : 

	xor	ecx, ecx

; 167  : // 从设备dev 取超级块，如果指定设备不存在，则出错死机。

	mov	esi, DWORD PTR $T873[ebp]

; 168  : 	if (!(sb = get_super(dev)))

	cld
$l1$869:

; 169  : 		panic("trying to get new block from nonexistant device");

	lodsd

; 170  : // 扫描逻辑块位图，寻找首个0 比特位，寻找空闲逻辑块，获取放置该逻辑块的块号。

	not	eax

; 171  : 	j = 8192;

	bsf	edx, eax

; 172  : 	for (i=0 ; i<8 ; i++)

	je	SHORT $l2$870

; 173  : 		if (bh=sb->s_zmap[i])

	add	ecx, edx

; 174  : 			if ((j=find_first_zero(bh->b_data))<8192)

	jmp	SHORT $l3$871
$l2$870:

; 175  : 				break;

	add	ecx, 32					; 00000020H

; 176  : // 如果全部扫描完还没找到(i>=8 或j>=8192)或者位图所在的缓冲块无效(bh=NULL)则返回0，

	cmp	ecx, 8192				; 00002000H

; 177  : // 退出（没有空闲逻辑块）。

	jl	SHORT $l1$869
$l3$871:

; 179  : 		return 0;

	mov	eax, ecx

; 180  : // 设置新逻辑块对应逻辑块位图中的比特位，若对应比特位已经置位，则出错，死机。

	popf

; 174  : 			if ((j=find_first_zero(bh->b_data))<8192)

	mov	esi, eax
	cmp	esi, 8192				; 00002000H
	mov	DWORD PTR _j$[ebp], esi
	jl	SHORT $L884
$L773:

; 172  : 	for (i=0 ; i<8 ; i++)

	mov	esi, DWORD PTR -4+[ebp]
	inc	edi
	add	esi, 4
	cmp	edi, 8
	mov	DWORD PTR -4+[ebp], esi
	jl	SHORT $L772
$L778:

; 179  : 		return 0;

	xor	eax, eax

; 201  : }

	pop	edi
	pop	esi
	pop	ebx
	mov	esp, ebp
	pop	ebp
	ret	0
$L884:

; 178  : 	if (i>=8 || !bh || j>=8192)

	cmp	edi, 8
	jge	SHORT $L778
	test	ebx, ebx
	je	SHORT $L778

; 181  : 	if (set_bit(j,bh->b_data))

	mov	edx, DWORD PTR [ebx]
	mov	DWORD PTR $T877[ebp], edx

; 165  : 	int i,j;

	xor	eax, eax

; 166  : 

	mov	ebx, DWORD PTR _j$[ebp]

; 167  : // 从设备dev 取超级块，如果指定设备不存在，则出错死机。

	mov	edx, DWORD PTR $T877[ebp]

; 168  : 	if (!(sb = get_super(dev)))

	bts	DWORD PTR [edx], ebx

; 169  : 		panic("trying to get new block from nonexistant device");

	setb	al

; 181  : 	if (set_bit(j,bh->b_data))

	test	eax, eax
	je	SHORT $L779

; 182  : 		panic("new_block: bit already set");

	push	OFFSET FLAT:$SG780
	call	_panic
	add	esp, 4
$L779:

; 183  : // 置对应缓冲区块的已修改标志。如果新逻辑块大于该设备上的总逻辑块数，则说明指定逻辑块在
; 184  : // 对应设备上不存在。申请失败，返回0，退出。
; 185  : 	bh->b_dirt = 1;

	mov	eax, DWORD PTR _bh$[ebp]

; 186  : 	j += i*8192 + sb->s_firstdatazone-1;

	xor	ecx, ecx
	shl	edi, 13					; 0000000dH
	mov	BYTE PTR [eax+11], 1
	mov	eax, DWORD PTR _sb$[ebp]
	add	edi, esi

; 187  : 	if (j >= sb->s_nzones)

	xor	edx, edx
	mov	cx, WORD PTR [eax+8]
	mov	dx, WORD PTR [eax+2]
	lea	ebx, DWORD PTR [edi+ecx-1]
	cmp	ebx, edx

; 188  : 		return 0;

	jge	SHORT $L778

; 189  : // 读取设备上的该新逻辑块数据（验证）。如果失败则死机。
; 190  : 	if (!(bh=getblk(dev,j)))

	mov	eax, DWORD PTR _dev$[ebp]
	push	ebx
	push	eax
	call	_getblk
	mov	esi, eax
	add	esp, 8
	test	esi, esi
	jne	SHORT $L782

; 191  : 		panic("new_block: cannot get block");

	push	OFFSET FLAT:$SG783
	call	_panic
	add	esp, 4
$L782:

; 192  : // 新块的引用计数应为1。否则死机。
; 193  : 	if (bh->b_count != 1)

	cmp	BYTE PTR [esi+12], 1
	je	SHORT $L784

; 194  : 		panic("new block: count is != 1");

	push	OFFSET FLAT:$SG785
	call	_panic
	add	esp, 4
$L784:

; 195  : // 将该新逻辑块清零，并置位更新标志和已修改标志。然后释放对应缓冲区，返回逻辑块号。
; 196  : 	clear_block(bh->b_data);

	mov	ecx, DWORD PTR [esi]
	mov	DWORD PTR $T882[ebp], ecx

; 163  : 	struct buffer_head * bh;

	pushf

; 164  : 	struct super_block * sb;

	mov	edi, DWORD PTR $T882[ebp]

; 165  : 	int i,j;

	mov	ecx, 256				; 00000100H

; 166  : 

	xor	eax, eax

; 167  : // 从设备dev 取超级块，如果指定设备不存在，则出错死机。

	cld

; 168  : 	if (!(sb = get_super(dev)))

	rep	 stosd

; 169  : 		panic("trying to get new block from nonexistant device");

	popf

; 197  : 	bh->b_uptodate = 1;
; 198  : 	bh->b_dirt = 1;
; 199  : 	brelse(bh);

	push	esi
	mov	BYTE PTR [esi+10], 1
	mov	BYTE PTR [esi+11], 1
	call	_brelse
	add	esp, 4

; 200  : 	return j;

	mov	eax, ebx

; 201  : }

	pop	edi
	pop	esi
	pop	ebx
	mov	esp, ebp
	pop	ebp
	ret	0
_new_block ENDP
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
PUBLIC	_free_inode
_DATA	SEGMENT
	ORG $+3
$SG794	DB	'trying to free inode with count=%d', 0aH, 00H
$SG795	DB	'free_inode', 00H
	ORG $+1
$SG797	DB	'trying to free inode with links', 00H
$SG799	DB	'trying to free inode on nonexistent device', 00H
	ORG $+1
$SG802	DB	'trying to free inode 0 or nonexistant inode', 00H
$SG804	DB	'nonexistent imap in superblock', 00H
	ORG $+1
$SG806	DB	'free_inode: bit already cleared.', 0aH, 0dH, 00H
_DATA	ENDS
_TEXT	SEGMENT
_inode$ = 8
$T895 = -8
$T896 = -4
_free_inode PROC NEAR

; 206  : {

	push	ebp
	mov	ebp, esp
	sub	esp, 8
	push	ebx

; 211  : 	if (!inode)

	mov	ebx, DWORD PTR _inode$[ebp]
	push	esi
	push	edi
	test	ebx, ebx
	je	$L899

; 214  : 	if (!inode->i_dev) {

	mov	si, WORD PTR [ebx+44]
	test	si, si
	jne	SHORT $L792

; 207  : 	struct super_block * sb;
; 208  : 	struct buffer_head * bh;

	pushf

; 209  : 

	mov	edi, DWORD PTR _inode$[ebp]

; 210  : 	// 如果i 节点指针=NULL，则退出。

	mov	ecx, 56					; 00000038H

; 211  : 	if (!inode)

	mov	al, 0

; 212  : 		return;

	cld

; 213  : // 如果i 节点上的设备号字段为0，说明该节点无用，则用0 清空对应i 节点所占内存区，并返回。

	rep	 stosb

; 214  : 	if (!inode->i_dev) {

	popf

; 242  : }

	pop	edi
	pop	esi
	pop	ebx
	mov	esp, ebp
	pop	ebp
	ret	0
$L792:

; 215  : 		memset(inode,0,sizeof(*inode));
; 216  : 		return;
; 217  : 	}
; 218  : // 如果此i 节点还有其它程序引用，则不能释放，说明内核有问题，死机。
; 219  : 	if (inode->i_count>1) {

	mov	ax, WORD PTR [ebx+48]
	cmp	ax, 1
	jbe	SHORT $L793

; 220  : 		printk("trying to free inode with count=%d\n",inode->i_count);

	and	eax, 65535				; 0000ffffH
	push	eax
	push	OFFSET FLAT:$SG794
	call	_printk

; 221  : 		panic("free_inode");

	push	OFFSET FLAT:$SG795
	call	_panic
	add	esp, 12					; 0000000cH
$L793:

; 222  : 	}
; 223  : // 如果文件目录项连接数不为0，则表示还有其它文件目录项在使用该节点，
; 224  : // 不应释放，而应该放回等。
; 225  : 	if (inode->i_nlinks)

	mov	al, BYTE PTR [ebx+13]
	test	al, al
	je	SHORT $L796

; 226  : 		panic("trying to free inode with links");

	push	OFFSET FLAT:$SG797
	call	_panic
	add	esp, 4
$L796:

; 227  : // 取i 节点所在设备的超级块，测试设备是否存在。
; 228  : 	if (!(sb = get_super(inode->i_dev)))

	and	esi, 65535				; 0000ffffH
	push	esi
	call	_get_super
	mov	edi, eax
	add	esp, 4
	test	edi, edi
	jne	SHORT $L798

; 229  : 		panic("trying to free inode on nonexistent device");

	push	OFFSET FLAT:$SG799
	call	_panic
	add	esp, 4
$L798:

; 230  : // 如果i 节点号=0 或大于该设备上i 节点总数，则出错（0 号i 节点保留没有使用）。
; 231  : 	if (inode->i_num < 1 || inode->i_num > sb->s_ninodes)

	mov	si, WORD PTR [ebx+46]
	cmp	si, 1
	jb	SHORT $L801
	cmp	si, WORD PTR [edi]
	jbe	SHORT $L800
$L801:

; 232  : 		panic("trying to free inode 0 or nonexistant inode");

	push	OFFSET FLAT:$SG802
	call	_panic
	add	esp, 4
$L800:

; 233  : // 如果该i 节点对应的节点位图不存在，则出错。
; 234  : 	if (!(bh=sb->s_imap[inode->i_num>>13]))

	and	esi, 65535				; 0000ffffH
	mov	eax, esi
	shr	eax, 13					; 0000000dH
	mov	edi, DWORD PTR [edi+eax*4+20]
	test	edi, edi
	jne	SHORT $L803

; 235  : 		panic("nonexistent imap in superblock");

	push	OFFSET FLAT:$SG804
	call	_panic
	add	esp, 4
$L803:

; 236  : // 复位i 节点对应的节点位图中的比特位，如果该比特位已经等于0，则出错。
; 237  : 	if (clear_bit(inode->i_num&8191,bh->b_data))

	mov	ecx, DWORD PTR [edi]
	and	esi, 8191				; 00001fffH
	mov	DWORD PTR $T896[ebp], ecx
	mov	DWORD PTR $T895[ebp], esi

; 209  : 

	xor	eax, eax

; 210  : 	// 如果i 节点指针=NULL，则退出。

	mov	ebx, DWORD PTR $T895[ebp]

; 211  : 	if (!inode)

	mov	edx, DWORD PTR $T896[ebp]

; 212  : 		return;

	btr	DWORD PTR [edx], ebx

; 213  : // 如果i 节点上的设备号字段为0，说明该节点无用，则用0 清空对应i 节点所占内存区，并返回。

	setae	al

; 236  : // 复位i 节点对应的节点位图中的比特位，如果该比特位已经等于0，则出错。
; 237  : 	if (clear_bit(inode->i_num&8191,bh->b_data))

	test	eax, eax
	je	SHORT $L805

; 238  : 		printk("free_inode: bit already cleared.\n\r");

	push	OFFSET FLAT:$SG806
	call	_printk
	add	esp, 4
$L805:

; 239  : // 置i 节点位图所在缓冲区已修改标志，并清空该i 节点结构所占内存区。
; 240  : 	bh->b_dirt = 1;

	mov	BYTE PTR [edi+11], 1

; 207  : 	struct super_block * sb;
; 208  : 	struct buffer_head * bh;

	pushf

; 209  : 

	mov	edi, DWORD PTR _inode$[ebp]

; 210  : 	// 如果i 节点指针=NULL，则退出。

	mov	ecx, 56					; 00000038H

; 211  : 	if (!inode)

	mov	al, 0

; 212  : 		return;

	cld

; 213  : // 如果i 节点上的设备号字段为0，说明该节点无用，则用0 清空对应i 节点所占内存区，并返回。

	rep	 stosb

; 214  : 	if (!inode->i_dev) {

	popf

; 241  : 	memset(inode,0,sizeof(*inode));

$L899:

; 242  : }

	pop	edi
	pop	esi
	pop	ebx
	mov	esp, ebp
	pop	ebp
	ret	0
_free_inode ENDP
_TEXT	ENDS
PUBLIC	_new_inode
EXTRN	_iput:NEAR
EXTRN	_get_empty_inode:NEAR
EXTRN	_current:DWORD
EXTRN	_jiffies:DWORD
EXTRN	_startup_time:DWORD
_DATA	SEGMENT
	ORG $+1
$SG817	DB	'new_inode with unknown device', 00H
	ORG $+2
$SG826	DB	'new_inode: bit already set', 00H
_DATA	ENDS
_TEXT	SEGMENT
_dev$ = 8
_sb$ = -16
_bh$ = -20
_i$ = -4
_j$ = -8
$T909 = -12
$T913 = -16
_new_inode PROC NEAR

; 247  : {

	push	ebp
	mov	ebp, esp
	sub	esp, 20					; 00000014H
	push	ebx
	push	esi
	push	edi

; 254  : 	if (!(inode=get_empty_inode()))

	call	_get_empty_inode
	mov	edi, eax
	test	edi, edi

; 255  : 		return NULL;

	je	$L920

; 257  : 	if (!(sb = get_super(dev)))

	mov	eax, DWORD PTR _dev$[ebp]
	push	eax
	call	_get_super
	mov	ebx, eax
	add	esp, 4
	test	ebx, ebx
	mov	DWORD PTR _sb$[ebp], ebx
	jne	SHORT $L816

; 258  : 		panic("new_inode with unknown device");

	push	OFFSET FLAT:$SG817
	call	_panic
	add	esp, 4
$L816:

; 260  : 	j = 8192;

	mov	esi, 8192				; 00002000H
	add	ebx, 20					; 00000014H
	mov	DWORD PTR _j$[ebp], esi

; 261  : 	for (i=0 ; i<8 ; i++)

	mov	DWORD PTR _i$[ebp], 0
	mov	DWORD PTR -8+[ebp], ebx
$L818:

; 262  : 		if (bh=sb->s_imap[i])

	mov	ecx, DWORD PTR -8+[ebp]
	mov	ebx, DWORD PTR [ecx]
	test	ebx, ebx
	mov	DWORD PTR _bh$[ebp], ebx
	je	SHORT $L819

; 263  : 			if ((j=find_first_zero(bh->b_data))<8192)

	mov	edx, DWORD PTR [ebx]
	mov	DWORD PTR $T909[ebp], edx

; 248  : 	struct m_inode * inode;
; 249  : 	struct super_block * sb;
; 250  : 	struct buffer_head * bh;

	pushf

; 251  : 	int i,j;

	xor	ecx, ecx

; 252  : 

	mov	esi, DWORD PTR $T909[ebp]

; 253  : // 从内存i 节点表(inode_table)中获取一个空闲i 节点项(inode)。

	cld
$l1$905:

; 254  : 	if (!(inode=get_empty_inode()))

	lodsd

; 255  : 		return NULL;

	not	eax

; 256  : // 读取指定设备的超级块结构。

	bsf	edx, eax

; 257  : 	if (!(sb = get_super(dev)))

	je	SHORT $l2$906

; 258  : 		panic("new_inode with unknown device");

	add	ecx, edx

; 259  : // 扫描i 节点位图，寻找首个0 比特位，寻找空闲节点，获取放置该i 节点的节点号。

	jmp	SHORT $l3$907
$l2$906:

; 260  : 	j = 8192;

	add	ecx, 32					; 00000020H

; 261  : 	for (i=0 ; i<8 ; i++)

	cmp	ecx, 8192				; 00002000H

; 262  : 		if (bh=sb->s_imap[i])

	jl	SHORT $l1$905
$l3$907:

; 264  : 				break;

	mov	eax, ecx

; 265  : // 如果全部扫描完还没找到，或者位图所在的缓冲块无效(bh=NULL)则返回0，退出（没有空闲i 节点）。

	popf

; 263  : 			if ((j=find_first_zero(bh->b_data))<8192)

	mov	esi, eax
	cmp	esi, 8192				; 00002000H
	jl	SHORT $L918
$L819:

; 261  : 	for (i=0 ; i<8 ; i++)

	mov	eax, DWORD PTR _i$[ebp]
	mov	edx, DWORD PTR -8+[ebp]
	inc	eax
	add	edx, 4
	cmp	eax, 8
	mov	DWORD PTR _i$[ebp], eax
	mov	DWORD PTR -8+[ebp], edx
	jl	SHORT $L818
$L918:

; 266  : 	if (!bh || j >= 8192 || j+i*8192 > sb->s_ninodes) {

	test	ebx, ebx
	mov	DWORD PTR _j$[ebp], esi
	je	$L824
	cmp	esi, 8192				; 00002000H
	jge	$L824
	mov	eax, DWORD PTR _i$[ebp]
	mov	edx, DWORD PTR _sb$[ebp]
	shl	eax, 13					; 0000000dH
	xor	ecx, ecx
	add	eax, esi
	mov	cx, WORD PTR [edx]
	cmp	eax, ecx
	jg	$L824

; 268  : 		return NULL;
; 269  : 	}
; 270  : // 置位对应新i 节点的i 节点位图相应比特位，如果已经置位，则出错。
; 271  : 	if (set_bit(j,bh->b_data))

	mov	eax, DWORD PTR [ebx]
	mov	DWORD PTR $T913[ebp], eax

; 248  : 	struct m_inode * inode;
; 249  : 	struct super_block * sb;
; 250  : 	struct buffer_head * bh;

	xor	eax, eax

; 251  : 	int i,j;

	mov	ebx, DWORD PTR _j$[ebp]

; 252  : 

	mov	edx, DWORD PTR $T913[ebp]

; 253  : // 从内存i 节点表(inode_table)中获取一个空闲i 节点项(inode)。

	bts	DWORD PTR [edx], ebx

; 254  : 	if (!(inode=get_empty_inode()))

	setb	al

; 268  : 		return NULL;
; 269  : 	}
; 270  : // 置位对应新i 节点的i 节点位图相应比特位，如果已经置位，则出错。
; 271  : 	if (set_bit(j,bh->b_data))

	test	eax, eax
	je	SHORT $L825

; 272  : 		panic("new_inode: bit already set");

	push	OFFSET FLAT:$SG826
	call	_panic
	add	esp, 4
$L825:

; 273  : // 置i 节点位图所在缓冲区已修改标志。
; 274  : 	bh->b_dirt = 1;
; 275  : // 初始化该i 节点结构。
; 276  : 	inode->i_count=1;		// 引用计数。
; 277  : 	inode->i_nlinks=1;		// 文件目录项链接数。
; 278  : 	inode->i_dev=dev;		// i 节点所在的设备号。

	mov	ax, WORD PTR _dev$[ebp]
	mov	edx, DWORD PTR _bh$[ebp]
	mov	WORD PTR [edi+44], ax

; 279  : 	inode->i_uid=current->euid;		// i 节点所属用户id。

	mov	eax, DWORD PTR _current
	mov	ecx, 1
	mov	BYTE PTR [edx+11], cl
	mov	dx, WORD PTR [eax+578]

; 280  : 	inode->i_gid=current->egid;		// 组id。

	mov	al, BYTE PTR [eax+584]
	mov	WORD PTR [edi+48], cx
	mov	BYTE PTR [edi+12], al

; 281  : 	inode->i_dirt=1;			// 已修改标志置位。
; 282  : 	inode->i_num = j + i*8192;	// 对应设备中的i 节点号。

	mov	eax, DWORD PTR _i$[ebp]
	shl	eax, 13					; 0000000dH
	add	eax, esi
	mov	BYTE PTR [edi+13], cl
	mov	WORD PTR [edi+2], dx
	mov	BYTE PTR [edi+51], cl
	mov	WORD PTR [edi+46], ax

; 283  : 	inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME;	// 设置时间。

	mov	ecx, DWORD PTR _jiffies
	mov	eax, 1374389535				; 51eb851fH
	imul	ecx
	mov	eax, DWORD PTR _startup_time
	sar	edx, 5
	mov	ecx, edx
	shr	ecx, 31					; 0000001fH
	add	edx, ecx
	add	eax, edx
	mov	DWORD PTR [edi+40], eax
	mov	DWORD PTR [edi+36], eax
	mov	DWORD PTR [edi+8], eax

; 284  : 	return inode;	// 返回该i 节点指针。

	mov	eax, edi

; 285  : }

	pop	edi
	pop	esi
	pop	ebx
	mov	esp, ebp
	pop	ebp
	ret	0
$L824:

; 267  : 		iput(inode);

	push	edi
	call	_iput
	add	esp, 4
$L920:

; 285  : }

	pop	edi
	pop	esi
	xor	eax, eax
	pop	ebx
	mov	esp, ebp
	pop	ebp
	ret	0
_new_inode ENDP
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

	je	SHORT $l1$672

; 278  : 		xchg ecx,current/* current = task[n]； */

	xchg	ecx, DWORD PTR _current

; 279  : 		/*执行长跳转，造成任务切换 (头大了很长时间，多多包涵)*/
; 280  : 		mov ax, __tmp

	mov	ax, WORD PTR ___tmp$[ebp]

; 281  : 		mov word ptr ds:[lcs],ax

	mov	WORD PTR ds:$lcs$673, ax

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
$lcs$673:

; 287  : lcs:	_emit 0		// cs

	DB	0

; 288  : 		_emit 0

	DB	0

; 289  : // 在任务切换回来后才会继续执行下面的语句。
; 290  : 		cmp last_task_used_math,ecx /* 新任务上次使用过协处理器吗？*/

	cmp	DWORD PTR _last_task_used_math, ecx

; 291  : 		jne l1

	jne	SHORT $l1$672

; 292  : 		clts/* 新任务上次使用过协处理器，则清cr0 的TS 标志。*/

	clts
$l1$672:

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
END
