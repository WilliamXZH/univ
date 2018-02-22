	TITLE	..\fs\open.c
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
PUBLIC	_sys_ustat
_TEXT	SEGMENT
_sys_ustat PROC NEAR

; 24   : 	return -ENOSYS;

	mov	eax, -38				; ffffffdaH

; 25   : }

	ret	0
_sys_ustat ENDP
_TEXT	ENDS
PUBLIC	_sys_utime
EXTRN	_namei:NEAR
EXTRN	_iput:NEAR
EXTRN	_jiffies:DWORD
EXTRN	_startup_time:DWORD
_TEXT	SEGMENT
$T1106 = 12
_filename$ = 8
_times$ = 12
_sys_utime PROC NEAR

; 32   : {

	push	ebp
	mov	ebp, esp

; 37   : 	if (!(inode=namei(filename)))

	mov	eax, DWORD PTR _filename$[ebp]
	push	eax
	call	_namei
	mov	ecx, eax
	add	esp, 4
	test	ecx, ecx
	jne	SHORT $L963

; 38   : 		return -ENOENT;

	mov	eax, -2					; fffffffeH

; 53   : }

	pop	ebp
	ret	0
$L963:
	push	esi

; 39   : // 如果访问和修改时间数据结构指针不为NULL，则从结构中读取用户设置的时间值。
; 40   : 	if (times) {

	mov	esi, DWORD PTR _times$[ebp]
	test	esi, esi
	je	SHORT $L964
	push	ebx

; 33   : 	struct m_inode * inode;
; 34   : 	long actime,modtime;
; 35   : 
; 36   : // 根据文件名寻找对应的i 节点，如果没有找到，则返回出错码。

	mov	ebx, DWORD PTR _times$[ebp]

; 37   : 	if (!(inode=namei(filename)))

	mov	eax, DWORD PTR fs:[ebx]

; 41   : 		actime = get_fs_long((unsigned long *) &times->actime);
; 42   : 		modtime = get_fs_long((unsigned long *) &times->modtime);

	add	esi, 4
	mov	edx, eax
	mov	DWORD PTR $T1106[ebp], esi

; 33   : 	struct m_inode * inode;
; 34   : 	long actime,modtime;
; 35   : 
; 36   : // 根据文件名寻找对应的i 节点，如果没有找到，则返回出错码。

	mov	ebx, DWORD PTR $T1106[ebp]

; 37   : 	if (!(inode=namei(filename)))

	mov	eax, DWORD PTR fs:[ebx]

; 41   : 		actime = get_fs_long((unsigned long *) &times->actime);
; 42   : 		modtime = get_fs_long((unsigned long *) &times->modtime);

	pop	ebx

; 43   : // 否则将访问和修改时间置为当前时间。
; 44   : 	} else

	jmp	SHORT $L967
$L964:

; 45   : 		actime = modtime = CURRENT_TIME;

	mov	edx, DWORD PTR _jiffies
	mov	eax, 1374389535				; 51eb851fH
	imul	edx
	sar	edx, 5
	mov	eax, edx
	shr	eax, 31					; 0000001fH
	add	edx, eax
	mov	eax, DWORD PTR _startup_time
	add	edx, eax
	mov	eax, edx
$L967:

; 46   : // 修改i 节点中的访问时间字段和修改时间字段。
; 47   : 	inode->i_atime = actime;
; 48   : 	inode->i_mtime = modtime;
; 49   : // 置i 节点已修改标志，释放该节点，并返回0。
; 50   : 	inode->i_dirt = 1;
; 51   : 	iput(inode);

	push	ecx
	mov	DWORD PTR [ecx+36], edx
	mov	DWORD PTR [ecx+8], eax
	mov	BYTE PTR [ecx+51], 1
	call	_iput
	add	esp, 4

; 52   : 	return 0;

	xor	eax, eax
	pop	esi

; 53   : }

	pop	ebp
	ret	0
_sys_utime ENDP
_TEXT	ENDS
PUBLIC	_sys_access
EXTRN	_current:DWORD
_TEXT	SEGMENT
_filename$ = 8
_mode$ = 12
_i_mode$ = 12
_sys_access PROC NEAR

; 63   : {

	push	ebp
	mov	ebp, esp

; 64   : 	struct m_inode * inode;
; 65   : 	int res, i_mode;
; 66   : 
; 67   : // 屏蔽码由低3 位组成，因此清除所有高比特位。
; 68   : 	mode &= 0007;
; 69   : // 如果文件名对应的i 节点不存在，则返回出错码。
; 70   : 	if (!(inode=namei(filename)))

	mov	eax, DWORD PTR _filename$[ebp]
	push	ebx
	mov	ebx, DWORD PTR _mode$[ebp]
	push	edi
	push	eax
	and	ebx, 7
	call	_namei
	mov	edi, eax
	add	esp, 4
	test	edi, edi

; 71   : 		return -EACCES;

	je	SHORT $L982
	push	esi

; 72   : // 取文件的属性码，并释放该i 节点。
; 73   : 	i_mode = res = inode->i_mode & 0777;

	mov	si, WORD PTR [edi]
	and	esi, 511				; 000001ffH

; 74   : 	iput(inode);

	push	edi
	mov	DWORD PTR _i_mode$[ebp], esi
	call	_iput

; 75   : // 如果当前进程是该文件的宿主，则取文件宿主属性。
; 76   : 	if (current->uid == inode->i_uid)

	mov	ecx, DWORD PTR _current
	add	esp, 4
	mov	ax, WORD PTR [ecx+576]
	cmp	ax, WORD PTR [edi+2]

; 77   : 		res >>= 6;
; 78   : // 否则如果当前进程是与该文件同属一组，则取文件组属性。
; 79   : 	else if (current->gid == inode->i_gid)

	je	SHORT $L1109
	movzx	dx, BYTE PTR [edi+12]
	cmp	WORD PTR [ecx+582], dx
	jne	SHORT $L980
$L1109:

; 80   : 		res >>= 6;

	sar	esi, 6
$L980:

; 81   : // 如果文件属性具有查询的属性位，则访问许可，返回0。
; 82   : 	if ((res & 0007 & mode) == mode)

	and	esi, ebx
	and	esi, 7
	cmp	esi, ebx
	pop	esi
	jne	SHORT $L981
	pop	edi

; 83   : 		return 0;

	xor	eax, eax
	pop	ebx

; 95   : }

	pop	ebp
	ret	0
$L981:

; 84   : /*
; 85   :  * XXX 我们最后才做下面的测试，因为我们实际上需要交换有效用户id 和
; 86   :  * 真实用户id（临时地），然后才调用suser()函数。如果我们确实要调用
; 87   :  * suser()函数，则需要最后才被调用。 
; 88   :  */
; 89   : // 如果当前用户id 为0（超级用户）并且屏蔽码执行位是0 或文件可以被任何人访问，则返回0。
; 90   : 	if ((!current->uid) &&
; 91   : 	    (!(mode & 1) || (i_mode & 0111)))

	test	ax, ax
	jne	SHORT $L982
	test	bl, 1
	je	SHORT $L983
	test	BYTE PTR _i_mode$[ebp], 73		; 00000049H
	je	SHORT $L982
$L983:
	pop	edi

; 92   : 		return 0;

	xor	eax, eax
	pop	ebx

; 95   : }

	pop	ebp
	ret	0
$L982:
	pop	edi

; 93   : 	// 否则返回出错码。
; 94   : 	return -EACCES;

	mov	eax, -13				; fffffff3H
	pop	ebx

; 95   : }

	pop	ebp
	ret	0
_sys_access ENDP
_TEXT	ENDS
PUBLIC	_sys_chdir
_TEXT	SEGMENT
_filename$ = 8
_sys_chdir PROC NEAR

; 101  : {

	push	ebp
	mov	ebp, esp

; 102  : 	struct m_inode * inode;
; 103  : 
; 104  : // 如果文件名对应的i 节点不存在，则返回出错码。
; 105  : 	if (!(inode = namei(filename)))

	mov	eax, DWORD PTR _filename$[ebp]
	push	esi
	push	eax
	call	_namei
	mov	esi, eax
	add	esp, 4
	test	esi, esi
	jne	SHORT $L989

; 106  : 		return -ENOENT;

	mov	eax, -2					; fffffffeH
	pop	esi

; 116  : }

	pop	ebp
	ret	0
$L989:

; 107  : // 如果该i 节点不是目录的i 节点，则释放该节点，返回出错码。
; 108  : 	if (!S_ISDIR(inode->i_mode)) {

	mov	cx, WORD PTR [esi]
	and	ecx, 61440				; 0000f000H
	cmp	ecx, 16384				; 00004000H
	je	SHORT $L990

; 109  : 		iput(inode);

	push	esi
	call	_iput
	add	esp, 4

; 110  : 		return -ENOTDIR;

	mov	eax, -20				; ffffffecH
	pop	esi

; 116  : }

	pop	ebp
	ret	0
$L990:

; 111  : 	}
; 112  : // 释放当前进程原工作目录i 节点，并指向该新置的工作目录i 节点。返回0。
; 113  : 	iput(current->pwd);

	mov	edx, DWORD PTR _current
	mov	eax, DWORD PTR [edx+624]
	push	eax
	call	_iput

; 114  : 	current->pwd = inode;

	mov	ecx, DWORD PTR _current
	add	esp, 4

; 115  : 	return (0);

	xor	eax, eax
	mov	DWORD PTR [ecx+624], esi
	pop	esi

; 116  : }

	pop	ebp
	ret	0
_sys_chdir ENDP
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
PUBLIC	_sys_chroot
_TEXT	SEGMENT
_filename$ = 8
_sys_chroot PROC NEAR

; 122  : {

	push	ebp
	mov	ebp, esp

; 123  : 	struct m_inode * inode;
; 124  : 
; 125  : // 如果文件名对应的i 节点不存在，则返回出错码。
; 126  : 	if (!(inode=namei(filename)))

	mov	eax, DWORD PTR _filename$[ebp]
	push	esi
	push	eax
	call	_namei
	mov	esi, eax
	add	esp, 4
	test	esi, esi
	jne	SHORT $L996

; 127  : 		return -ENOENT;

	mov	eax, -2					; fffffffeH
	pop	esi

; 137  : }

	pop	ebp
	ret	0
$L996:

; 128  : // 如果该i 节点不是目录的i 节点，则释放该节点，返回出错码。
; 129  : 	if (!S_ISDIR(inode->i_mode)) {

	mov	cx, WORD PTR [esi]
	and	ecx, 61440				; 0000f000H
	cmp	ecx, 16384				; 00004000H
	je	SHORT $L997

; 130  : 		iput(inode);

	push	esi
	call	_iput
	add	esp, 4

; 131  : 		return -ENOTDIR;

	mov	eax, -20				; ffffffecH
	pop	esi

; 137  : }

	pop	ebp
	ret	0
$L997:

; 132  : 	}
; 133  : // 释放当前进程的根目录i 节点，并重置为这里指定目录名的i 节点，返回0。
; 134  : 	iput(current->root);

	mov	edx, DWORD PTR _current
	mov	eax, DWORD PTR [edx+628]
	push	eax
	call	_iput

; 135  : 	current->root = inode;

	mov	ecx, DWORD PTR _current
	add	esp, 4

; 136  : 	return (0);

	xor	eax, eax
	mov	DWORD PTR [ecx+628], esi
	pop	esi

; 137  : }

	pop	ebp
	ret	0
_sys_chroot ENDP
_TEXT	ENDS
PUBLIC	_sys_chmod
_TEXT	SEGMENT
_filename$ = 8
_mode$ = 12
_sys_chmod PROC NEAR

; 143  : {

	push	ebp
	mov	ebp, esp

; 144  : 	struct m_inode * inode;
; 145  : 
; 146  : // 如果文件名对应的i 节点不存在，则返回出错码。
; 147  : 	if (!(inode=namei(filename)))

	mov	eax, DWORD PTR _filename$[ebp]
	push	eax
	call	_namei
	add	esp, 4
	test	eax, eax
	jne	SHORT $L1005

; 148  : 		return -ENOENT;

	mov	eax, -2					; fffffffeH

; 160  : }

	pop	ebp
	ret	0
$L1005:

; 149  : // 如果当前进程的有效用户id 不等于文件i 节点的用户id，并且当前进程不是超级用户，则释放该
; 150  : // 文件i 节点，返回出错码。
; 151  : 	if ((current->euid != inode->i_uid) && !suser()) {

	mov	ecx, DWORD PTR _current
	mov	cx, WORD PTR [ecx+578]
	cmp	cx, WORD PTR [eax+2]
	je	SHORT $L1006
	test	cx, cx
	je	SHORT $L1006

; 152  : 		iput(inode);

	push	eax
	call	_iput
	add	esp, 4

; 153  : 		return -EACCES;

	mov	eax, -13				; fffffff3H

; 160  : }

	pop	ebp
	ret	0
$L1006:

; 154  : 	}
; 155  : // 重新设置i 节点的文件属性，并置该i 节点已修改标志。释放该i 节点，返回0。
; 156  : 	inode->i_mode = (mode & 07777) | (inode->i_mode & ~07777);

	mov	cx, WORD PTR [eax]
	push	esi
	mov	esi, DWORD PTR _mode$[ebp]
	mov	edx, ecx
	xor	edx, esi

; 157  : 	inode->i_dirt = 1;
; 158  : 	iput(inode);

	push	eax
	and	edx, 4095				; 00000fffH
	mov	BYTE PTR [eax+51], 1
	xor	edx, ecx
	mov	WORD PTR [eax], dx
	call	_iput
	add	esp, 4

; 159  : 	return 0;

	xor	eax, eax
	pop	esi

; 160  : }

	pop	ebp
	ret	0
_sys_chmod ENDP
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
PUBLIC	_sys_chown
_TEXT	SEGMENT
_filename$ = 8
_uid$ = 12
_gid$ = 16
_sys_chown PROC NEAR

; 166  : {

	push	ebp
	mov	ebp, esp

; 167  : 	struct m_inode * inode;
; 168  : 
; 169  : // 如果文件名对应的i 节点不存在，则返回出错码。
; 170  : 	if (!(inode=namei(filename)))

	mov	eax, DWORD PTR _filename$[ebp]
	push	eax
	call	_namei
	add	esp, 4
	test	eax, eax
	jne	SHORT $L1016

; 171  : 		return -ENOENT;

	mov	eax, -2					; fffffffeH

; 183  : }

	pop	ebp
	ret	0
$L1016:

; 172  : // 若当前进程不是超级用户，则释放该i 节点，返回出错码。
; 173  : 	if (!suser()) {

	mov	ecx, DWORD PTR _current
	cmp	WORD PTR [ecx+578], 0
	je	SHORT $L1017

; 174  : 		iput(inode);

	push	eax
	call	_iput
	add	esp, 4

; 175  : 		return -EACCES;

	mov	eax, -13				; fffffff3H

; 183  : }

	pop	ebp
	ret	0
$L1017:

; 176  : 	}
; 177  : // 设置文件对应i 节点的用户id 和组id，并置i 节点已经修改标志，释放该i 节点，返回0。
; 178  : 	inode->i_uid=uid;

	mov	dx, WORD PTR _uid$[ebp]

; 179  : 	inode->i_gid=gid;

	mov	cl, BYTE PTR _gid$[ebp]

; 180  : 	inode->i_dirt=1;
; 181  : 	iput(inode);

	push	eax
	mov	WORD PTR [eax+2], dx
	mov	BYTE PTR [eax+12], cl
	mov	BYTE PTR [eax+51], 1
	call	_iput
	add	esp, 4

; 182  : 	return 0;

	xor	eax, eax

; 183  : }

	pop	ebp
	ret	0
_sys_chown ENDP
_TEXT	ENDS
PUBLIC	_sys_open
EXTRN	_file_table:BYTE
EXTRN	_check_disk_change:NEAR
EXTRN	_open_namei:NEAR
EXTRN	_tty_table:BYTE
_TEXT	SEGMENT
_inode$ = 16
_filename$ = 8
_flag$ = 12
_mode$ = 16
_sys_open PROC NEAR

; 193  : {

	push	ebp
	mov	ebp, esp

; 194  : 	struct m_inode * inode;
; 195  : 	struct file * f;
; 196  : 	int i,fd;
; 197  : 
; 198  : // 将用户设置的模式与进程的模式屏蔽码相与，产生许可的文件模式。
; 199  : 	mode &= 0777 & ~current->umask;

	mov	edx, DWORD PTR _current
	push	ebx
	mov	ebx, DWORD PTR _mode$[ebp]
	push	esi
	mov	ax, WORD PTR [edx+620]
	push	edi
	not	eax
	and	eax, 511				; 000001ffH
	and	ebx, eax

; 200  : // 搜索进程结构中文件结构指针数组，查找一个空闲项，若已经没有空闲项，则返回出错码。
; 201  : 	for(fd=0 ; fd<NR_OPEN ; fd++)

	xor	edi, edi
	lea	eax, DWORD PTR [edx+640]
$L1030:

; 202  : 		if (!current->filp[fd])

	cmp	DWORD PTR [eax], 0
	je	SHORT $L1119
	inc	edi
	add	eax, 4
	cmp	edi, 20					; 00000014H
	jl	SHORT $L1030
	pop	edi
	pop	esi

; 205  : 		return -EINVAL;

	mov	eax, -22				; ffffffeaH
	pop	ebx

; 254  : }

	pop	ebp
	ret	0
$L1119:

; 203  : 			break;
; 204  : 	if (fd>=NR_OPEN)

	cmp	edi, 20					; 00000014H
	jl	SHORT $L1034
	pop	edi
	pop	esi

; 205  : 		return -EINVAL;

	mov	eax, -22				; ffffffeaH
	pop	ebx

; 254  : }

	pop	ebp
	ret	0
$L1034:

; 206  : // 设置执行时关闭文件句柄位图，复位对应比特位。
; 207  : 	current->close_on_exec &= ~(1<<fd);

	mov	eax, 1
	mov	ecx, edi
	shl	eax, cl
	mov	ecx, DWORD PTR [edx+636]

; 208  : // 令f 指向文件表数组开始处。搜索空闲文件结构项(句柄引用计数为0 的项)，若已经没有空闲
; 209  : // 文件表结构项，则返回出错码。
; 210  : 	f=0+file_table;

	mov	esi, OFFSET FLAT:_file_table
	not	eax
	and	ecx, eax

; 211  : 	for (i=0 ; i<NR_FILE ; i++,f++)

	xor	eax, eax
	mov	DWORD PTR [edx+636], ecx
$L1035:

; 212  : 		if (!f->f_count) break;

	cmp	WORD PTR [esi+4], 0
	je	SHORT $L1120
	inc	eax
	add	esi, 16					; 00000010H
	cmp	eax, 64					; 00000040H
	jl	SHORT $L1035
	pop	edi
	pop	esi

; 214  : 		return -EINVAL;

	mov	eax, -22				; ffffffeaH
	pop	ebx

; 254  : }

	pop	ebp
	ret	0
$L1120:

; 213  : 	if (i>=NR_FILE)

	cmp	eax, 64					; 00000040H
	jl	SHORT $L1039
	pop	edi
	pop	esi

; 214  : 		return -EINVAL;

	mov	eax, -22				; ffffffeaH
	pop	ebx

; 254  : }

	pop	ebp
	ret	0
$L1039:

; 215  : // 让进程的对应文件句柄的文件结构指针指向搜索到的文件结构，并令句柄引用计数递增1。
; 216  : 	(current->filp[fd]=f)->f_count++;

	inc	WORD PTR [esi+4]

; 217  : // 调用函数执行打开操作，若返回值小于0，则说明出错，释放刚申请到的文件结构，返回出错码。
; 218  : 	if ((i=open_namei(filename,flag,mode,&inode))<0) {

	lea	ecx, DWORD PTR _inode$[ebp]
	push	ecx
	push	ebx
	mov	ebx, DWORD PTR _flag$[ebp]
	mov	DWORD PTR [edx+edi*4+640], esi
	mov	edx, DWORD PTR _filename$[ebp]
	push	ebx
	push	edx
	call	_open_namei
	xor	ecx, ecx
	add	esp, 16					; 00000010H
	cmp	eax, ecx
	jge	SHORT $L1040

; 219  : 		current->filp[fd]=NULL;

	mov	edx, DWORD PTR _current

; 220  : 		f->f_count=0;

	mov	WORD PTR [esi+4], cx
	mov	DWORD PTR [edx+edi*4+640], ecx
	pop	edi
	pop	esi
	pop	ebx

; 254  : }

	pop	ebp
	ret	0
$L1040:

; 221  : 		return i;
; 222  : 	}
; 223  : /* ttys 有些特殊（ttyxx 主号==4，tty 主号==5）*/
; 224  : // 如果是字符设备文件，那么如果设备号是4 的话，则设置当前进程的tty 号为该i 节点的子设备号。
; 225  : // 并设置当前进程tty 对应的tty 表项的父进程组号等于进程的父进程组号。
; 226  : 	if (S_ISCHR(inode->i_mode))

	mov	eax, DWORD PTR _inode$[ebp]
	mov	cx, WORD PTR [eax]
	and	ecx, 61440				; 0000f000H
	cmp	ecx, 8192				; 00002000H
	jne	SHORT $L1048

; 227  : 		if (MAJOR(inode->i_zone[0])==4) {

	xor	ecx, ecx
	mov	cx, WORD PTR [eax+14]
	mov	edx, ecx
	and	dl, 0
	cmp	edx, 1024				; 00000400H
	jne	$L1043

; 228  : 			if (current->leader && current->tty<0) {

	mov	edx, DWORD PTR _current
	cmp	DWORD PTR [edx+572], 0
	je	SHORT $L1048
	cmp	DWORD PTR [edx+616], 0
	jge	SHORT $L1048

; 229  : 				current->tty = MINOR(inode->i_zone[0]);

	and	ecx, 255				; 000000ffH

; 230  : 				tty_table[current->tty].pgrp = current->pgrp;

	mov	eax, ecx
	mov	DWORD PTR [edx+616], ecx
	shl	eax, 5
	add	eax, ecx
	mov	ecx, DWORD PTR [edx+564]
	lea	eax, DWORD PTR [eax+eax*2]
	shl	eax, 5
	mov	DWORD PTR _tty_table[eax+36], ecx

; 231  : 			}
; 232  : // 否则如果该字符文件设备号是5 的话，若当前进程没有tty，则说明出错，释放i 节点和申请到的
; 233  : // 文件结构，返回出错码。
; 234  : 		} else if (MAJOR(inode->i_zone[0])==5)

	mov	eax, DWORD PTR _inode$[ebp]
$L1048:

; 240  : 			}
; 241  : /* 同样对于块设备文件：需要检查盘片是否被更换 */
; 242  : // 如果打开的是块设备文件，则检查盘片是否更换，若更换则需要是高速缓冲中对应该设备的所有
; 243  : // 缓冲块失效。
; 244  : 	if (S_ISBLK(inode->i_mode))

	mov	dx, WORD PTR [eax]
	and	edx, 61440				; 0000f000H
	cmp	edx, 24576				; 00006000H
	jne	SHORT $L1049

; 245  : 		check_disk_change(inode->i_zone[0]);

	xor	ecx, ecx
	mov	cx, WORD PTR [eax+14]
	push	ecx
	call	_check_disk_change
	mov	eax, DWORD PTR _inode$[ebp]
	add	esp, 4
$L1049:

; 246  : // 初始化文件结构。置文件结构属性和标志，置句柄引用计数为1，设置i 节点字段，文件读写指针
; 247  : // 初始化为0。返回文件句柄。
; 248  : 	f->f_mode = inode->i_mode;

	mov	dx, WORD PTR [eax]
	mov	WORD PTR [esi], dx

; 249  : 	f->f_flags = flag;

	mov	WORD PTR [esi+2], bx

; 250  : 	f->f_count = 1;

	mov	WORD PTR [esi+4], 1

; 251  : 	f->f_inode = inode;

	mov	DWORD PTR [esi+8], eax

; 252  : 	f->f_pos = 0;
; 253  : 	return (fd);

	mov	eax, edi
	mov	DWORD PTR [esi+12], 0
	pop	edi
	pop	esi
	pop	ebx

; 254  : }

	pop	ebp
	ret	0
$L1043:

; 231  : 			}
; 232  : // 否则如果该字符文件设备号是5 的话，若当前进程没有tty，则说明出错，释放i 节点和申请到的
; 233  : // 文件结构，返回出错码。
; 234  : 		} else if (MAJOR(inode->i_zone[0])==5)

	cmp	edx, 1280				; 00000500H
	jne	SHORT $L1048

; 235  : 			if (current->tty<0) {

	mov	edx, DWORD PTR _current
	mov	ecx, DWORD PTR [edx+616]
	test	ecx, ecx
	jge	SHORT $L1048

; 236  : 				iput(inode);

	push	eax
	call	_iput

; 237  : 				current->filp[fd]=NULL;

	mov	ecx, DWORD PTR _current
	add	esp, 4
	xor	eax, eax
	mov	DWORD PTR [ecx+edi*4+640], eax

; 238  : 				f->f_count=0;

	mov	WORD PTR [esi+4], ax
	pop	edi
	pop	esi

; 239  : 				return -EPERM;

	or	eax, -1
	pop	ebx

; 254  : }

	pop	ebp
	ret	0
_sys_open ENDP
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
PUBLIC	_sys_creat
_TEXT	SEGMENT
_pathname$ = 8
_mode$ = 12
_sys_creat PROC NEAR

; 260  : {

	push	ebp
	mov	ebp, esp

; 261  : 	return sys_open(pathname, O_CREAT | O_TRUNC, mode);

	mov	eax, DWORD PTR _mode$[ebp]
	mov	ecx, DWORD PTR _pathname$[ebp]
	push	eax
	push	576					; 00000240H
	push	ecx
	call	_sys_open
	add	esp, 12					; 0000000cH

; 262  : }

	pop	ebp
	ret	0
_sys_creat ENDP
_TEXT	ENDS
PUBLIC	_sys_close
EXTRN	_panic:NEAR
_DATA	SEGMENT
$SG1064	DB	'Close: file count is 0', 00H
_DATA	ENDS
_TEXT	SEGMENT
_fd$ = 8
_sys_close PROC NEAR

; 268  : {	

	push	ebp
	mov	ebp, esp

; 269  : 	struct file * filp;
; 270  : 
; 271  : // 若文件句柄值大于程序同时能打开的文件数，则返回出错码。
; 272  : 	if (fd >= NR_OPEN)

	mov	ecx, DWORD PTR _fd$[ebp]
	push	esi
	cmp	ecx, 20					; 00000014H
	jb	SHORT $L1061

; 273  : 		return -EINVAL;

	mov	eax, -22				; ffffffeaH
	pop	esi

; 290  : }

	pop	ebp
	ret	0
$L1061:

; 274  : // 复位进程的执行时关闭文件句柄位图对应位。
; 275  : 	current->close_on_exec &= ~(1<<fd);

	mov	eax, DWORD PTR _current
	mov	edx, 1
	shl	edx, cl
	mov	esi, DWORD PTR [eax+636]
	not	edx
	and	esi, edx
	mov	DWORD PTR [eax+636], esi

; 276  : // 若该文件句柄对应的文件结构指针是NULL，则返回出错码。
; 277  : 	if (!(filp = current->filp[fd]))

	mov	esi, DWORD PTR [eax+ecx*4+640]
	test	esi, esi
	jne	SHORT $L1062

; 278  : 		return -EINVAL;

	mov	eax, -22				; ffffffeaH
	pop	esi

; 290  : }

	pop	ebp
	ret	0
$L1062:
	push	edi

; 279  : // 置该文件句柄的文件结构指针为NULL。
; 280  : 	current->filp[fd] = NULL;
; 281  : // 若在关闭文件之前，对应文件结构中的句柄引用计数已经为0，则说明内核出错，死机。
; 282  : 	if (filp->f_count == 0)

	mov	di, WORD PTR [esi+4]
	test	di, di
	mov	DWORD PTR [eax+ecx*4+640], 0
	jne	SHORT $L1063

; 283  : 		panic("Close: file count is 0");

	push	OFFSET FLAT:$SG1064
	call	_panic
	add	esp, 4
$L1063:

; 284  : // 否则将对应文件结构的句柄引用计数减1，如果还不为0，则返回0（成功）。若已等于0，说明该
; 285  : // 文件已经没有句柄引用，则释放该文件i 节点，返回0。
; 286  : 	if (--filp->f_count)

	lea	eax, DWORD PTR [edi-1]
	pop	edi
	test	ax, ax
	mov	WORD PTR [esi+4], ax

; 287  : 		return (0);

	jne	SHORT $L1130

; 288  : 	iput(filp->f_inode);

	mov	eax, DWORD PTR [esi+8]
	push	eax
	call	_iput
	add	esp, 4
$L1130:

; 289  : 	return (0);

	xor	eax, eax
	pop	esi

; 290  : }

	pop	ebp
	ret	0
_sys_close ENDP
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

	je	SHORT $l1$746

; 278  : 		xchg ecx,current/* current = task[n]； */

	xchg	ecx, DWORD PTR _current

; 279  : 		/*执行长跳转，造成任务切换 (头大了很长时间，多多包涵)*/
; 280  : 		mov ax, __tmp

	mov	ax, WORD PTR ___tmp$[ebp]

; 281  : 		mov word ptr ds:[lcs],ax

	mov	WORD PTR ds:$lcs$747, ax

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
$lcs$747:

; 287  : lcs:	_emit 0		// cs

	DB	0

; 288  : 		_emit 0

	DB	0

; 289  : // 在任务切换回来后才会继续执行下面的语句。
; 290  : 		cmp last_task_used_math,ecx /* 新任务上次使用过协处理器吗？*/

	cmp	DWORD PTR _last_task_used_math, ecx

; 291  : 		jne l1

	jne	SHORT $l1$746

; 292  : 		clts/* 新任务上次使用过协处理器，则清cr0 的TS 标志。*/

	clts
$l1$746:

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
