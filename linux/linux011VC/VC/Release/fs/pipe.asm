	TITLE	..\fs\pipe.c
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
PUBLIC	_read_pipe
EXTRN	_sleep_on:NEAR
EXTRN	_wake_up:NEAR
_TEXT	SEGMENT
_inode$ = 8
_buf$ = 12
_count$ = 16
_read$ = -4
$T651 = 19
$T652 = 8
_read_pipe PROC NEAR

; 19   : {

	push	ebp
	mov	ebp, esp
	push	ecx
	push	ebx
	push	esi

; 23   : 	while (count>0) {

	mov	esi, DWORD PTR _inode$[ebp]
	push	edi
	mov	edi, DWORD PTR _count$[ebp]
	mov	DWORD PTR _read$[ebp], 0
	test	edi, edi
	jle	$L573
$L572:

; 24   : // 若当前管道中没有数据(size=0)，则唤醒等待该节点的进程，如果已没有写管道者，则返回已读
; 25   : // 字节数，退出。否则在该i 节点上睡眠，等待信息。
; 26   : 		while (!(size=PIPE_SIZE(*inode))) {

	mov	cx, WORD PTR [esi+14]
	mov	ax, WORD PTR [esi+16]
	sub	ecx, eax
	and	ecx, 4095				; 00000fffH
	jne	SHORT $L576

; 27   : 			wake_up(&inode->i_wait);

	lea	ebx, DWORD PTR [esi+32]
$L575:
	push	ebx
	call	_wake_up
	add	esp, 4

; 28   : 			if (inode->i_count != 2) /* are there any writers? */

	cmp	WORD PTR [esi+48], 2
	jne	$L656

; 29   : 				return read;
; 30   : 			sleep_on(&inode->i_wait);

	push	ebx
	call	_sleep_on
	mov	cx, WORD PTR [esi+14]
	mov	dx, WORD PTR [esi+16]
	sub	ecx, edx
	add	esp, 4
	and	ecx, 4095				; 00000fffH
	je	SHORT $L575
$L576:

; 31   : 		}
; 32   : // 取管道尾到缓冲区末端的字节数chars。如果其大于还需要读取的字节数count，则令其等于count。
; 33   : // 如果chars 大于当前管道中含有数据的长度size，则令其等于size。
; 34   : 		chars = PAGE_SIZE-PIPE_TAIL(*inode);

	xor	eax, eax
	mov	ax, WORD PTR [esi+16]
	mov	edx, eax
	mov	eax, 4096				; 00001000H
	sub	eax, edx

; 35   : 		if (chars > count)

	cmp	eax, edi
	jle	SHORT $L578

; 36   : 			chars = count;

	mov	eax, edi
$L578:

; 37   : 		if (chars > size)

	cmp	eax, ecx
	jle	SHORT $L579

; 38   : 			chars = size;

	mov	eax, ecx
$L579:

; 41   : 		read += chars;

	mov	ecx, DWORD PTR _read$[ebp]

; 42   : // 令size 指向管道尾部，调整当前管道尾指针（前移chars 字节）。
; 43   : 		size = PIPE_TAIL(*inode);

	mov	dx, WORD PTR [esi+16]
	add	ecx, eax
	sub	edi, eax
	mov	DWORD PTR _read$[ebp], ecx
	mov	ecx, edx

; 44   : 		PIPE_TAIL(*inode) += chars;

	add	edx, eax
	and	ecx, 65535				; 0000ffffH

; 45   : 		PIPE_TAIL(*inode) &= (PAGE_SIZE-1);

	and	edx, 4095				; 00000fffH
	mov	WORD PTR [esi+16], dx

; 46   : // 将管道中的数据复制到用户缓冲区中。对于管道i 节点，其i_size 字段中是管道缓冲块指针。
; 47   : 		while (chars-->0)

	mov	edx, eax
	dec	eax
	test	edx, edx
	jle	SHORT $L582

; 39   : // 读字节计数减去此次可读的字节数chars，并累加已读字节数。
; 40   : 		count -= chars;

	lea	edx, DWORD PTR [eax+1]
$L581:

; 48   : 			put_fs_byte(((char *)inode->i_size)[size++],buf++);

	mov	ebx, DWORD PTR [esi+4]
	mov	eax, DWORD PTR _buf$[ebp]
	mov	DWORD PTR $T652[ebp], eax
	mov	bl, BYTE PTR [ebx+ecx]
	inc	ecx
	inc	eax
	mov	BYTE PTR $T651[ebp], bl
	mov	DWORD PTR _buf$[ebp], eax

; 20   : 	int chars, size, read = 0;
; 21   : 

	mov	ebx, DWORD PTR $T652[ebp]

; 22   : // 若欲读取的字节计数值count 大于0，则循环执行以下操作。

	mov	al, BYTE PTR $T651[ebp]

; 23   : 	while (count>0) {

	mov	BYTE PTR fs:[ebx], al

; 48   : 			put_fs_byte(((char *)inode->i_size)[size++],buf++);

	dec	edx
	jne	SHORT $L581
$L582:

; 23   : 	while (count>0) {

	test	edi, edi
	jg	$L572
$L573:

; 49   : 	}
; 50   : // 唤醒等待该管道i 节点的进程，并返回读取的字节数。
; 51   : 	wake_up(&inode->i_wait);

	add	esi, 32					; 00000020H
	push	esi
	call	_wake_up
	add	esp, 4
$L656:

; 52   : 	return read;

	mov	eax, DWORD PTR _read$[ebp]
	pop	edi
	pop	esi
	pop	ebx

; 53   : }

	mov	esp, ebp
	pop	ebp
	ret	0
_read_pipe ENDP
_TEXT	ENDS
PUBLIC	_write_pipe
EXTRN	_current:DWORD
_TEXT	SEGMENT
_inode$ = 8
_buf$ = 12
_count$ = 16
_written$ = -4
$T665 = 8
_write_pipe PROC NEAR

; 58   : {

	push	ebp
	mov	ebp, esp
	push	ecx

; 59   : 	int chars, size, written = 0;
; 60   : 
; 61   : // 若将写入的字节计数值count 还大于0，则循环执行以下操作。
; 62   : 	while (count>0) {

	mov	eax, DWORD PTR _count$[ebp]
	push	ebx
	push	esi
	mov	esi, DWORD PTR _inode$[ebp]
	test	eax, eax
	push	edi
	mov	DWORD PTR _written$[ebp], 0
	jle	$L597

; 64   : // 发送SIGPIPE 信号，并返回已写入的字节数并退出。若写入0 字节，则返回-1。否则在该i 节点上
; 65   : // 睡眠，等待管道腾出空间。
; 66   : 		while (!(size=(PAGE_SIZE-1)-PIPE_SIZE(*inode))) {

	mov	edi, DWORD PTR _buf$[ebp]
$L596:
	mov	ax, WORD PTR [esi+14]
	mov	cx, WORD PTR [esi+16]
	sub	eax, ecx
	mov	ecx, 4095				; 00000fffH
	and	eax, 4095				; 00000fffH
	sub	ecx, eax
	jne	SHORT $L600

; 67   : 			wake_up(&inode->i_wait);

	lea	ebx, DWORD PTR [esi+32]
$L599:
	push	ebx
	call	_wake_up
	add	esp, 4

; 68   : 			if (inode->i_count != 2) { /* no readers */

	cmp	WORD PTR [esi+48], 2
	jne	$L670

; 71   : 			}
; 72   : 			sleep_on(&inode->i_wait);

	push	ebx
	call	_sleep_on
	mov	dx, WORD PTR [esi+14]
	mov	ax, WORD PTR [esi+16]
	sub	edx, eax
	mov	ecx, 4095				; 00000fffH
	and	edx, 4095				; 00000fffH
	add	esp, 4
	sub	ecx, edx
	je	SHORT $L599
$L600:

; 73   : 		}
; 74   : // 取管道头部到缓冲区末端空间字节数chars。如果其大于还需要写入的字节数count，则令其等于
; 75   : // count。如果chars 大于当前管道中空闲空间长度size，则令其等于size。
; 76   : 		chars = PAGE_SIZE-PIPE_HEAD(*inode);

	xor	edx, edx
	mov	eax, 4096				; 00001000H
	mov	dx, WORD PTR [esi+14]
	sub	eax, edx

; 77   : 		if (chars > count)

	mov	edx, DWORD PTR _count$[ebp]
	cmp	eax, edx
	jle	SHORT $L602

; 78   : 			chars = count;

	mov	eax, edx
$L602:

; 79   : 		if (chars > size)

	cmp	eax, ecx
	jle	SHORT $L603

; 80   : 			chars = size;

	mov	eax, ecx
$L603:

; 83   : 		written += chars;

	mov	ecx, DWORD PTR _written$[ebp]
	sub	edx, eax
	mov	DWORD PTR _count$[ebp], edx

; 84   : // 令size 指向管道数据头部，调整当前管道数据头部指针（前移chars 字节）。
; 85   : 		size = PIPE_HEAD(*inode);

	mov	dx, WORD PTR [esi+14]
	add	ecx, eax
	mov	DWORD PTR _written$[ebp], ecx
	mov	ecx, edx

; 86   : 		PIPE_HEAD(*inode) += chars;

	add	edx, eax
	and	ecx, 65535				; 0000ffffH

; 87   : 		PIPE_HEAD(*inode) &= (PAGE_SIZE-1);

	and	edx, 4095				; 00000fffH
	mov	WORD PTR [esi+14], dx

; 88   : // 从用户缓冲区复制chars 个字节到管道中。对于管道i 节点，其i_size 字段中是管道缓冲块指针。
; 89   : 		while (chars-->0)

	mov	edx, eax
	dec	eax
	test	edx, edx
	jle	SHORT $L606

; 81   : // 写入字节计数减去此次可写入的字节数chars，并累加已写字节数到written。
; 82   : 		count -= chars;

	lea	edx, DWORD PTR [eax+1]
$L605:

; 90   : 			((char *)inode->i_size)[size++]=get_fs_byte(buf++);

	mov	DWORD PTR $T665[ebp], edi
	inc	edi

; 59   : 	int chars, size, written = 0;
; 60   : 
; 61   : // 若将写入的字节计数值count 还大于0，则循环执行以下操作。
; 62   : 	while (count>0) {

	mov	ebx, DWORD PTR $T665[ebp]

; 63   : // 若当前管道中没有已经满了(size=0)，则唤醒等待该节点的进程，如果已没有读管道者，则向进程

	mov	al, BYTE PTR fs:[ebx]

; 90   : 			((char *)inode->i_size)[size++]=get_fs_byte(buf++);

	mov	ebx, DWORD PTR [esi+4]
	inc	ecx
	dec	edx
	mov	BYTE PTR [ebx+ecx-1], al
	jne	SHORT $L605
$L606:

; 59   : 	int chars, size, written = 0;
; 60   : 
; 61   : // 若将写入的字节计数值count 还大于0，则循环执行以下操作。
; 62   : 	while (count>0) {

	mov	eax, DWORD PTR _count$[ebp]
	test	eax, eax
	jg	$L596
$L597:

; 91   : 	}
; 92   : // 唤醒等待该i 节点的进程，返回已写入的字节数，退出。
; 93   : 	wake_up(&inode->i_wait);

	add	esi, 32					; 00000020H
	push	esi
	call	_wake_up

; 94   : 	return written;

	mov	eax, DWORD PTR _written$[ebp]
	add	esp, 4
$L591:
	pop	edi
	pop	esi
	pop	ebx

; 95   : }

	mov	esp, ebp
	pop	ebp
	ret	0
$L670:

; 69   : 				current->signal |= (1<<(SIGPIPE-1));

	mov	eax, DWORD PTR _current
	mov	edx, DWORD PTR [eax+12]
	or	dh, 16					; 00000010H
	mov	DWORD PTR [eax+12], edx

; 70   : 				return written?written:-1;

	mov	eax, DWORD PTR _written$[ebp]
	test	eax, eax
	jne	SHORT $L591
	pop	edi
	pop	esi
	or	eax, -1
	pop	ebx

; 95   : }

	mov	esp, ebp
	pop	ebp
	ret	0
_write_pipe ENDP
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
PUBLIC	_sys_pipe
EXTRN	_file_table:BYTE
EXTRN	_get_pipe_inode:NEAR
_TEXT	SEGMENT
_fildes$ = 8
_f$ = -8
_fd$ = -16
$T679 = -4
$T683 = 8
$T684 = -4
_sys_pipe PROC NEAR

; 102  : {

	push	ebp
	mov	ebp, esp
	sub	esp, 16					; 00000010H
	push	ebx
	push	esi
	push	edi

; 107  : 
; 108  : // 从系统文件表中取两个空闲项（引用计数字段为0 的项），并分别设置引用计数为1。
; 109  : 	j=0;

	xor	edi, edi
	xor	ecx, ecx
	lea	edx, DWORD PTR _f$[ebp]
	mov	eax, OFFSET FLAT:_file_table+4
$L617:

; 110  : 	for(i=0;j<2 && i<NR_FILE;i++)

	cmp	eax, OFFSET FLAT:_file_table+1028
	jge	SHORT $L619

; 111  : 		if (!file_table[i].f_count)

	cmp	WORD PTR [eax], di
	jne	SHORT $L618

; 112  : 			(f[j++]=i+file_table)->f_count++;

	inc	WORD PTR [eax]
	lea	esi, DWORD PTR [eax-4]
	mov	DWORD PTR [edx], esi
	inc	ecx
	add	edx, 4
$L618:
	add	eax, 16					; 00000010H
	cmp	ecx, 2
	jl	SHORT $L617
$L619:

; 113  : // 如果只有一个空闲项，则释放该项(引用计数复位)。
; 114  : 	if (j==1)

	cmp	ecx, 1
	jne	SHORT $L621

; 115  : 		f[0]->f_count=0;

	mov	eax, DWORD PTR _f$[ebp]
	mov	WORD PTR [eax+4], di
	pop	edi
	pop	esi

; 118  : 		return -1;

	or	eax, -1
	pop	ebx

; 153  : }

	mov	esp, ebp
	pop	ebp
	ret	0
$L621:

; 116  : // 如果没有找到两个空闲项，则返回-1。
; 117  : 	if (j<2)

	cmp	ecx, 2
	jge	SHORT $L622
	pop	edi
	pop	esi

; 118  : 		return -1;

	or	eax, -1
	pop	ebx

; 153  : }

	mov	esp, ebp
	pop	ebp
	ret	0
$L622:

; 119  : // 针对上面取得的两个文件结构项，分别分配一文件句柄，并使进程的文件结构指针分别指向这两个
; 120  : // 文件结构。
; 121  : 	j=0;

	mov	esi, DWORD PTR _current
	xor	eax, eax

; 122  : 	for(i=0;j<2 && i<NR_OPEN;i++)

	xor	ecx, ecx
	lea	edx, DWORD PTR [esi+640]
$L623:
	cmp	ecx, 20					; 00000014H
	jge	SHORT $L625

; 123  : 		if (!current->filp[i]) {

	cmp	DWORD PTR [edx], edi
	jne	SHORT $L624

; 124  : 			current->filp[ fd[j]=i ] = f[j];

	mov	ebx, DWORD PTR _f$[ebp+eax*4]
	mov	DWORD PTR _fd$[ebp+eax*4], ecx
	mov	DWORD PTR [edx], ebx

; 125  : 			j++;

	inc	eax
$L624:
	inc	ecx
	add	edx, 4
	cmp	eax, 2
	jl	SHORT $L623
$L625:

; 126  : 		}
; 127  : // 如果只有一个空闲文件句柄，则释放该句柄。
; 128  : 	if (j==1)

	cmp	eax, 1
	jne	SHORT $L627

; 129  : 		current->filp[fd[0]]=NULL;

	mov	ecx, DWORD PTR _fd$[ebp]
	mov	DWORD PTR [esi+ecx*4+640], edi

; 130  : // 如果没有找到两个空闲句柄，则释放上面获取的两个文件结构项（复位引用计数值），并返回-1。
; 131  : 	if (j<2) {

	jmp	SHORT $L690
$L627:
	cmp	eax, 2
	jge	SHORT $L628
$L690:

; 132  : 		f[0]->f_count=f[1]->f_count=0;

	mov	edx, DWORD PTR _f$[ebp+4]
	mov	eax, DWORD PTR _f$[ebp]
	mov	WORD PTR [edx+4], di
	mov	WORD PTR [eax+4], di
	pop	edi
	pop	esi

; 133  : 		return -1;

	or	eax, -1
	pop	ebx

; 153  : }

	mov	esp, ebp
	pop	ebp
	ret	0
$L628:

; 134  : 	}
; 135  : // 申请管道i 节点，并为管道分配缓冲区（1 页内存）。如果不成功，则相应释放两个文件句柄和文
; 136  : // 件结构项，并返回-1。
; 137  : 	if (!(inode=get_pipe_inode())) {

	call	_get_pipe_inode
	cmp	eax, edi
	jne	SHORT $L629

; 138  : 		current->filp[fd[0]] =
; 139  : 			current->filp[fd[1]] = NULL;

	mov	eax, DWORD PTR _current
	mov	ecx, DWORD PTR _fd$[ebp+4]
	mov	edx, DWORD PTR _fd$[ebp]
	mov	DWORD PTR [eax+ecx*4+640], edi

; 140  : 		f[0]->f_count = f[1]->f_count = 0;

	mov	ecx, DWORD PTR _f$[ebp]
	mov	DWORD PTR [eax+edx*4+640], edi
	mov	eax, DWORD PTR _f$[ebp+4]
	mov	WORD PTR [eax+4], di
	mov	WORD PTR [ecx+4], di
	pop	edi
	pop	esi

; 141  : 		return -1;

	or	eax, -1
	pop	ebx

; 153  : }

	mov	esp, ebp
	pop	ebp
	ret	0
$L629:

; 142  : 	}
; 143  : // 初始化两个文件结构，都指向同一个i 节点，读写指针都置零。第1 个文件结构的文件模式置为读，
; 144  : // 第2 个文件结构的文件模式置为写。
; 145  : 	f[0]->f_inode = f[1]->f_inode = inode;

	mov	ecx, DWORD PTR _f$[ebp+4]
	mov	edx, DWORD PTR _f$[ebp]
	mov	DWORD PTR [ecx+8], eax
	mov	DWORD PTR [edx+8], eax

; 146  : 	f[0]->f_pos = f[1]->f_pos = 0;

	mov	DWORD PTR [ecx+12], edi
	mov	DWORD PTR [edx+12], edi

; 147  : 	f[0]->f_mode = 1;		/* read */

	mov	WORD PTR [edx], 1

; 148  : 	f[1]->f_mode = 2;		/* write */
; 149  : // 将文件句柄数组复制到对应的用户数组中，并返回0，退出。
; 150  : 	put_fs_long(fd[0],0+fildes);

	mov	edx, DWORD PTR _fd$[ebp]
	mov	WORD PTR [ecx], 2
	mov	DWORD PTR $T679[ebp], edx

; 103  : 	struct m_inode * inode;
; 104  : 	struct file * f[2];

	mov	ebx, DWORD PTR _fildes$[ebp]

; 105  : 	int fd[2];

	mov	eax, DWORD PTR $T679[ebp]

; 106  : 	int i,j;

	mov	DWORD PTR fs:[ebx], eax

; 151  : 	put_fs_long(fd[1],1+fildes);

	mov	eax, DWORD PTR _fildes$[ebp]
	mov	ecx, DWORD PTR _fd$[ebp+4]
	add	eax, 4
	mov	DWORD PTR $T683[ebp], ecx
	mov	DWORD PTR $T684[ebp], eax

; 103  : 	struct m_inode * inode;
; 104  : 	struct file * f[2];

	mov	ebx, DWORD PTR $T684[ebp]

; 105  : 	int fd[2];

	mov	eax, DWORD PTR $T683[ebp]

; 106  : 	int i,j;

	mov	DWORD PTR fs:[ebx], eax

; 151  : 	put_fs_long(fd[1],1+fildes);

	pop	edi
	pop	esi

; 152  : 	return 0;

	xor	eax, eax
	pop	ebx

; 153  : }

	mov	esp, ebp
	pop	ebp
	ret	0
_sys_pipe ENDP
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
END
