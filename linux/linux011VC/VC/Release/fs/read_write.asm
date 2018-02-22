	TITLE	..\fs\read_write.c
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
FLAT	GROUP _DATA, CONST, _BSS
	ASSUME	CS: FLAT, DS: FLAT, SS: FLAT
endif
PUBLIC	_sys_lseek
EXTRN	_current:DWORD
_TEXT	SEGMENT
_fd$ = 8
_offset$ = 12
_origin$ = 16
_sys_lseek PROC NEAR

; 38   : {

	push	ebp
	mov	ebp, esp

; 39   : 	struct file *file;
; 40   : 	int tmp;
; 41   : 
; 42   : // 如果文件句柄值大于程序最多打开文件数NR_OPEN(20)，或者该句柄的文件结构指针为空，或者
; 43   : // 对应文件结构的i 节点字段为空，或者指定设备文件指针是不可定位的，则返回出错码并退出。
; 44   : 	if (fd >= NR_OPEN || !(file = current->filp[fd]) || !(file->f_inode)
; 45   : 			|| !IS_SEEKABLE (MAJOR (file->f_inode->i_dev)))

	mov	eax, DWORD PTR _fd$[ebp]
	cmp	eax, 20					; 00000014H
	jae	$L706
	mov	ecx, DWORD PTR _current
	mov	eax, DWORD PTR [ecx+eax*4+640]
	test	eax, eax
	je	$L706
	mov	edx, DWORD PTR [eax+8]
	test	edx, edx
	je	SHORT $L706
	xor	ecx, ecx
	mov	cx, WORD PTR [edx+44]
	and	cl, 0
	cmp	ecx, 256				; 00000100H
	jb	SHORT $L706
	cmp	ecx, 768				; 00000300H
	ja	SHORT $L706

; 47   : // 如果文件对应的i 节点是管道节点，则返回出错码，退出。管道头尾指针不可随意移动！
; 48   : 	if (file->f_inode->i_pipe)

	mov	cl, BYTE PTR [edx+52]
	test	cl, cl
	je	SHORT $L707

; 49   : 		return -ESPIPE;

	mov	eax, -29				; ffffffe3H

; 79   : }

	pop	ebp
	ret	0
$L707:

; 50   : // 根据设置的定位标志，分别重新定位文件读写指针。
; 51   : 	switch (origin)
; 52   : 	{

	mov	ecx, DWORD PTR _origin$[ebp]
	sub	ecx, 0
	je	SHORT $L712
	dec	ecx
	je	SHORT $L714
	dec	ecx
	je	SHORT $L716

; 73   : 		break;
; 74   : // origin 设置出错，返回出错码退出。
; 75   : 	default:
; 76   : 		return -EINVAL;

	mov	eax, -22				; ffffffeaH

; 79   : }

	pop	ebp
	ret	0
$L716:

; 64   : 			return -EINVAL;
; 65   : 		file->f_pos += offset;
; 66   : 		break;
; 67   : // origin = SEEK_END，要求以文件末尾作为原点重定位读写指针。此时若文件大小加上偏移值小于零
; 68   : // 则返回出错码退出。否则重定位读写指针为文件长度加上偏移值。
; 69   : 	case 2:
; 70   : 		if ((tmp = file->f_inode->i_size + offset) < 0)

	mov	edx, DWORD PTR [edx+4]
	mov	ecx, DWORD PTR _offset$[ebp]
	add	edx, ecx
	jns	SHORT $L717

; 71   : 			return -EINVAL;

	mov	eax, -22				; ffffffeaH

; 79   : }

	pop	ebp
	ret	0
$L717:

; 72   : 		file->f_pos = tmp;

	mov	DWORD PTR [eax+12], edx

; 77   : 	}
; 78   : 	return file->f_pos;		// 返回重定位后的文件读写指针值。

	mov	eax, edx

; 79   : }

	pop	ebp
	ret	0
$L714:

; 59   : 		break;
; 60   : // origin = SEEK_CUR，要求以文件当前读写指针处作为原点重定位读写指针。如果文件当前指针加
; 61   : // 上偏移值小于0，则返回出错码退出。否则在当前读写指针上加上偏移值。
; 62   : 	case 1:
; 63   : 		if (file->f_pos + offset < 0)

	mov	edx, DWORD PTR [eax+12]
	mov	ecx, DWORD PTR _offset$[ebp]
	add	ecx, edx
	test	ecx, ecx
	jge	SHORT $L715

; 57   : 			return -EINVAL;

	mov	eax, -22				; ffffffeaH

; 79   : }

	pop	ebp
	ret	0
$L712:

; 53   : // origin = SEEK_SET，要求以文件起始处作为原点设置文件读写指针。若偏移值小于零，则出错返
; 54   : // 回错误码。否则设置文件读写指针等于offset。
; 55   : 	case 0:
; 56   : 		if (offset < 0)

	mov	ecx, DWORD PTR _offset$[ebp]
	test	ecx, ecx
	jge	SHORT $L715

; 57   : 			return -EINVAL;

	mov	eax, -22				; ffffffeaH

; 79   : }

	pop	ebp
	ret	0
$L715:

; 58   : 		file->f_pos = offset;

	mov	DWORD PTR [eax+12], ecx

; 77   : 	}
; 78   : 	return file->f_pos;		// 返回重定位后的文件读写指针值。

	mov	eax, ecx

; 79   : }

	pop	ebp
	ret	0
$L706:

; 46   : 		return -EBADF;

	mov	eax, -9					; fffffff7H

; 79   : }

	pop	ebp
	ret	0
_sys_lseek ENDP
_TEXT	ENDS
PUBLIC	_sys_read
EXTRN	_verify_area:NEAR
EXTRN	_printk:NEAR
EXTRN	_rw_char:NEAR
EXTRN	_read_pipe:NEAR
EXTRN	_block_read:NEAR
EXTRN	_file_read:NEAR
_DATA	SEGMENT
$SG739	DB	'(Read)inode->i_mode=%06o', 0aH, 0dH, 00H
_DATA	ENDS
_TEXT	SEGMENT
_fd$ = 8
_buf$ = 12
_count$ = 16
_sys_read PROC NEAR

; 84   : {

	push	ebp
	mov	ebp, esp

; 85   : 	struct file *file;
; 86   : 	struct m_inode *inode;
; 87   : 
; 88   : // 如果文件句柄值大于程序最多打开文件数NR_OPEN，或者需要读取的字节计数值小于0，或者该句柄
; 89   : // 的文件结构指针为空，则返回出错码并退出。
; 90   : 	if (fd >= NR_OPEN || count < 0 || !(file = current->filp[fd]))

	mov	eax, DWORD PTR _fd$[ebp]
	push	ebx
	push	esi
	cmp	eax, 20					; 00000014H
	push	edi
	jae	$L730
	mov	esi, DWORD PTR _count$[ebp]
	test	esi, esi
	jl	$L730
	mov	ecx, DWORD PTR _current
	mov	edi, DWORD PTR [ecx+eax*4+640]
	test	edi, edi
	je	$L730

; 91   : 		return -EINVAL;
; 92   : // 若需读取的字节数count 等于0，则返回0，退出
; 93   : 	if (!count)

	test	esi, esi
	jne	SHORT $L731
	pop	edi
	pop	esi

; 94   : 		return 0;

	xor	eax, eax
	pop	ebx

; 121  : 	return -EINVAL;
; 122  : }

	pop	ebp
	ret	0
$L731:

; 95   : // 验证存放数据的缓冲区内存限制。
; 96   : 	verify_area (buf, count);

	mov	ebx, DWORD PTR _buf$[ebp]
	push	esi
	push	ebx
	call	_verify_area

; 97   : // 取文件对应的i 节点。若是管道文件，并且是读管道文件模式，则进行读管道操作，若成功则返回
; 98   : // 读取的字节数，否则返回出错码，退出。
; 99   : 	inode = file->f_inode;

	mov	eax, DWORD PTR [edi+8]
	add	esp, 8

; 100  : 	if (inode->i_pipe)

	mov	cl, BYTE PTR [eax+52]
	test	cl, cl
	je	SHORT $L732

; 101  : 		return (file->f_mode & 1) ? read_pipe (inode, buf, count) : -EIO;

	test	BYTE PTR [edi], 1
	je	SHORT $L778
	push	esi
	push	ebx
	push	eax
	call	_read_pipe
	add	esp, 12					; 0000000cH
	pop	edi
	pop	esi
	pop	ebx

; 121  : 	return -EINVAL;
; 122  : }

	pop	ebp
	ret	0
$L778:
	pop	edi
	pop	esi

; 101  : 		return (file->f_mode & 1) ? read_pipe (inode, buf, count) : -EIO;

	mov	eax, -5					; fffffffbH
	pop	ebx

; 121  : 	return -EINVAL;
; 122  : }

	pop	ebp
	ret	0
$L732:

; 102  : // 如果是字符型文件，则进行读字符设备操作，返回读取的字符数。
; 103  : 	if (S_ISCHR (inode->i_mode))

	mov	dx, WORD PTR [eax]
	mov	ecx, edx
	and	ecx, 61440				; 0000f000H
	cmp	cx, 8192				; 00002000H
	jne	SHORT $L733

; 104  : 		return rw_char (READ, inode->i_zone[0], buf, count, &file->f_pos);

	add	edi, 12					; 0000000cH
	xor	edx, edx
	mov	dx, WORD PTR [eax+14]
	push	edi
	push	esi
	push	ebx
	push	edx
	push	0
	call	_rw_char
	add	esp, 20					; 00000014H
	pop	edi
	pop	esi
	pop	ebx

; 121  : 	return -EINVAL;
; 122  : }

	pop	ebp
	ret	0
$L733:

; 105  : // 如果是块设备文件，则执行块设备读操作，并返回读取的字节数。
; 106  : 	if (S_ISBLK (inode->i_mode))

	cmp	cx, 24576				; 00006000H
	jne	SHORT $L734

; 107  : 		return block_read (inode->i_zone[0], &file->f_pos, buf, count);

	xor	ecx, ecx
	push	esi
	mov	cx, WORD PTR [eax+14]
	add	edi, 12					; 0000000cH
	push	ebx
	push	edi
	push	ecx
	call	_block_read
	add	esp, 16					; 00000010H
	pop	edi
	pop	esi
	pop	ebx

; 121  : 	return -EINVAL;
; 122  : }

	pop	ebp
	ret	0
$L734:

; 108  : // 如果是目录文件或者是常规文件，则首先验证读取数count 的有效性并进行调整（若读取字节数加上
; 109  : // 文件当前读写指针值大于文件大小，则重新设置读取字节数为文件长度-当前读写指针值，若读取数
; 110  : // 等于0，则返回0 退出），然后执行文件读操作，返回读取的字节数并退出。
; 111  : 	if (S_ISDIR (inode->i_mode) || S_ISREG (inode->i_mode))

	cmp	cx, 16384				; 00004000H
	je	SHORT $L736
	cmp	cx, 32768				; 00008000H
	je	SHORT $L736

; 118  : 	}
; 119  : // 否则打印节点文件属性，并返回出错码退出。
; 120  : 	printk ("(Read)inode->i_mode=%06o\n\r", inode->i_mode);

	and	edx, 65535				; 0000ffffH
	push	edx
	push	OFFSET FLAT:$SG739
	call	_printk
	add	esp, 8
$L730:
	pop	edi
	pop	esi
	mov	eax, -22				; ffffffeaH
	pop	ebx

; 121  : 	return -EINVAL;
; 122  : }

	pop	ebp
	ret	0
$L736:

; 112  : 	{
; 113  : 		if (count + file->f_pos > inode->i_size)

	mov	edx, DWORD PTR [edi+12]
	mov	ecx, DWORD PTR [eax+4]
	add	edx, esi
	cmp	edx, ecx
	jbe	SHORT $L737

; 114  : 			count = inode->i_size - file->f_pos;

	sub	ecx, DWORD PTR [edi+12]
	mov	esi, ecx
$L737:

; 115  : 		if (count <= 0)

	test	esi, esi
	jg	SHORT $L738
	pop	edi
	pop	esi

; 116  : 			return 0;

	xor	eax, eax
	pop	ebx

; 121  : 	return -EINVAL;
; 122  : }

	pop	ebp
	ret	0
$L738:

; 117  : 		return file_read (inode, file, buf, count);

	push	esi
	push	ebx
	push	edi
	push	eax
	call	_file_read
	add	esp, 16					; 00000010H
	pop	edi
	pop	esi
	pop	ebx

; 121  : 	return -EINVAL;
; 122  : }

	pop	ebp
	ret	0
_sys_read ENDP
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
PUBLIC	_sys_write
EXTRN	_write_pipe:NEAR
EXTRN	_block_write:NEAR
EXTRN	_file_write:NEAR
_DATA	SEGMENT
	ORG $+1
$SG757	DB	'(Write)inode->i_mode=%06o', 0aH, 0dH, 00H
_DATA	ENDS
_TEXT	SEGMENT
_fd$ = 8
_buf$ = 12
_count$ = 16
_sys_write PROC NEAR

; 125  : {

	push	ebp
	mov	ebp, esp

; 126  : 	struct file *file;
; 127  : 	struct m_inode *inode;
; 128  : 
; 129  : // 如果文件句柄值大于程序最多打开文件数NR_OPEN，或者需要写入的字节计数小于0，或者该句柄
; 130  : // 的文件结构指针为空，则返回出错码并退出。
; 131  : 	if (fd >= NR_OPEN || count < 0 || !(file = current->filp[fd]))

	mov	eax, DWORD PTR _fd$[ebp]
	push	esi
	cmp	eax, 20					; 00000014H
	push	edi
	jae	$L751
	mov	esi, DWORD PTR _count$[ebp]
	test	esi, esi
	jl	$L751
	mov	ecx, DWORD PTR _current
	mov	ecx, DWORD PTR [ecx+eax*4+640]
	test	ecx, ecx
	je	$L751

; 132  : 		return -EINVAL;
; 133  : // 若需读取的字节数count 等于0，则返回0，退出
; 134  : 	if (!count)

	test	esi, esi
	jne	SHORT $L752
	pop	edi

; 135  : 		return 0;

	xor	eax, eax
	pop	esi

; 152  : 	return -EINVAL;
; 153  : }

	pop	ebp
	ret	0
$L752:

; 136  : // 取文件对应的i 节点。若是管道文件，并且是写管道文件模式，则进行写管道操作，若成功则返回
; 137  : // 写入的字节数，否则返回出错码，退出。
; 138  : 	inode = file->f_inode;

	mov	eax, DWORD PTR [ecx+8]

; 139  : 	if (inode->i_pipe)

	mov	dl, BYTE PTR [eax+52]
	test	dl, dl
	je	SHORT $L753

; 140  : 		return (file->f_mode & 2) ? write_pipe (inode, buf, count) : -EIO;

	test	BYTE PTR [ecx], 2
	je	SHORT $L782
	mov	edx, DWORD PTR _buf$[ebp]
	push	esi
	push	edx
	push	eax
	call	_write_pipe
	add	esp, 12					; 0000000cH
	pop	edi
	pop	esi

; 152  : 	return -EINVAL;
; 153  : }

	pop	ebp
	ret	0
$L782:
	pop	edi

; 140  : 		return (file->f_mode & 2) ? write_pipe (inode, buf, count) : -EIO;

	mov	eax, -5					; fffffffbH
	pop	esi

; 152  : 	return -EINVAL;
; 153  : }

	pop	ebp
	ret	0
$L753:

; 141  : // 如果是字符型文件，则进行写字符设备操作，返回写入的字符数，退出。
; 142  : 	if (S_ISCHR (inode->i_mode))

	mov	di, WORD PTR [eax]
	mov	edx, edi
	and	edx, 61440				; 0000f000H
	cmp	dx, 8192				; 00002000H
	jne	SHORT $L754

; 143  : 		return rw_char (WRITE, inode->i_zone[0], buf, count, &file->f_pos);

	add	ecx, 12					; 0000000cH
	xor	edx, edx
	mov	dx, WORD PTR [eax+14]
	push	ecx
	mov	ecx, DWORD PTR _buf$[ebp]
	push	esi
	push	ecx
	push	edx
	push	1
	call	_rw_char
	add	esp, 20					; 00000014H
	pop	edi
	pop	esi

; 152  : 	return -EINVAL;
; 153  : }

	pop	ebp
	ret	0
$L754:

; 144  : // 如果是块设备文件，则进行块设备写操作，并返回写入的字节数，退出。
; 145  : 	if (S_ISBLK (inode->i_mode))

	cmp	dx, 24576				; 00006000H
	jne	SHORT $L755

; 146  : 		return block_write (inode->i_zone[0], &file->f_pos, buf, count);

	mov	edx, DWORD PTR _buf$[ebp]
	push	esi
	add	ecx, 12					; 0000000cH
	push	edx
	push	ecx
	xor	ecx, ecx
	mov	cx, WORD PTR [eax+14]
	push	ecx
	call	_block_write
	add	esp, 16					; 00000010H
	pop	edi
	pop	esi

; 152  : 	return -EINVAL;
; 153  : }

	pop	ebp
	ret	0
$L755:

; 147  : // 若是常规文件，则执行文件写操作，并返回写入的字节数，退出。
; 148  : 	if (S_ISREG (inode->i_mode))

	cmp	dx, 32768				; 00008000H
	jne	SHORT $L756

; 149  : 		return file_write (inode, file, buf, count);

	mov	edx, DWORD PTR _buf$[ebp]
	push	esi
	push	edx
	push	ecx
	push	eax
	call	_file_write
	add	esp, 16					; 00000010H
	pop	edi
	pop	esi

; 152  : 	return -EINVAL;
; 153  : }

	pop	ebp
	ret	0
$L756:

; 150  : // 否则，显示对应节点的文件模式，返回出错码，退出。
; 151  : 	printk ("(Write)inode->i_mode=%06o\n\r", inode->i_mode);

	and	edi, 65535				; 0000ffffH
	push	edi
	push	OFFSET FLAT:$SG757
	call	_printk
	add	esp, 8
$L751:
	pop	edi
	mov	eax, -22				; ffffffeaH
	pop	esi

; 152  : 	return -EINVAL;
; 153  : }

	pop	ebp
	ret	0
_sys_write ENDP
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

	je	SHORT $l1$570

; 278  : 		xchg ecx,current/* current = task[n]； */

	xchg	ecx, DWORD PTR _current

; 279  : 		/*执行长跳转，造成任务切换 (头大了很长时间，多多包涵)*/
; 280  : 		mov ax, __tmp

	mov	ax, WORD PTR ___tmp$[ebp]

; 281  : 		mov word ptr ds:[lcs],ax

	mov	WORD PTR ds:$lcs$571, ax

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
$lcs$571:

; 287  : lcs:	_emit 0		// cs

	DB	0

; 288  : 		_emit 0

	DB	0

; 289  : // 在任务切换回来后才会继续执行下面的语句。
; 290  : 		cmp last_task_used_math,ecx /* 新任务上次使用过协处理器吗？*/

	cmp	DWORD PTR _last_task_used_math, ecx

; 291  : 		jne l1

	jne	SHORT $l1$570

; 292  : 		clts/* 新任务上次使用过协处理器，则清cr0 的TS 标志。*/

	clts
$l1$570:

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
END
