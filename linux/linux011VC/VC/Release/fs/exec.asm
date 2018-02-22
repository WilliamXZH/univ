	TITLE	..\fs\exec.c
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
$l1$44:

; 39   : 	l1:	lodsb	// 加载DS:[esi]处1 字节->al，并更新esi。

	lodsb

; 40   : 		stosb		// 存储字节al->ES:[edi]，并更新edi。

	stosb

; 41   : 		test al,al	// 刚存储的字节是0？

	test	al, al

; 42   : 		jne l1	// 不是则跳转到标号l1 处，否则结束。

	jne	SHORT $l1$44

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
$l1$61:

; 115  : 	l1: lodsb	// 取源字符串字节ds:[esi]->al，并esi++。

	lodsb

; 116  : 		stosb		// 将该字节存到es:[edi]，并edi++。

	stosb

; 117  : 		test al,al	// 该字节是0？

	test	al, al

; 118  : 		jne l1	// 不是，则向后跳转到标号1 处继续拷贝，否则结束。

	jne	SHORT $l1$61

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
$l1$78:

; 201  :   l1: lodsb	// 取字符串2 的字节ds:[esi]??al，并且esi++。

	lodsb

; 202  : 	  scasb		// al 与字符串1 的字节es:[edi]作比较，并且edi++。

	scasb

; 203  : 	  jne l2		// 如果不相等，则向前跳转到标号2。

	jne	SHORT $l2$79

; 204  : 	  test al,al	// 该字节是0 值字节吗（字符串结尾）？

	test	al, al

; 205  : 	  jne l1		// 不是，则向后跳转到标号1，继续比较。

	jne	SHORT $l1$78

; 206  : 	  xor eax,eax	// 是，则返回值eax 清零，

	xor	eax, eax

; 207  : 	  jmp l3		// 向前跳转到标号3，结束。

	jmp	SHORT $l3$80
$l2$79:

; 208  :   l2: mov eax,1	// eax 中置1。

	mov	eax, 1

; 209  : 	  jl l3		// 若前面比较中串2 字符<串1 字符，则返回正值，结束。

	jl	SHORT $l3$80

; 210  : 	  neg eax	// 否则eax = -eax，返回负值，结束。

	neg	eax
$l3$80:

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
PUBLIC	_do_execve
EXTRN	_namei:NEAR
EXTRN	_iput:NEAR
EXTRN	_brelse:NEAR
EXTRN	_bread:NEAR
EXTRN	_free_page:NEAR
EXTRN	_free_page_tables:NEAR
EXTRN	_panic:NEAR
EXTRN	_last_task_used_math:DWORD
EXTRN	_current:DWORD
EXTRN	_sys_close:NEAR
_DATA	SEGMENT
$SG971	DB	'execve called from supervisor mode', 00H
	ORG $+1
$SG1019	DB	'%s: N_TXTOFF != BLOCK_SIZE. See a.out.h.', 00H
_DATA	ENDS
_TEXT	SEGMENT
$T1086 = -12
$T1087 = -16
$T1093 = -12
$T1097 = -36
$T1101 = -40
$T1105 = -12
$T1115 = 24
$T1120 = 24
$T1125 = 24
$T1130 = 24
$T1135 = 24
_eip$ = 8
_filename$ = 16
_argv$ = 20
_envp$ = 24
_ex$ = -72
_page$ = -200
_argc$ = -24
_envc$ = -28
_e_uid$ = -16
_e_gid$ = -12
_sh_bang$ = -32
_p$ = -20
_buf$987 = -1224
_i_name$990 = -8
_i_arg$991 = -4
_old_fs$992 = -16
_do_execve PROC NEAR

; 241  : {

	push	ebp
	mov	ebp, esp
	sub	esp, 1224				; 000004c8H

; 254  : 	if ((0xffff & eip[1]) != 0x000f)

	mov	eax, DWORD PTR _eip$[ebp]
	push	ebx
	push	esi
	push	edi
	mov	ecx, DWORD PTR [eax+4]
	mov	DWORD PTR _sh_bang$[ebp], 0
	and	ecx, 65535				; 0000ffffH
	mov	DWORD PTR _p$[ebp], 131068		; 0001fffcH
	cmp	ecx, 15					; 0000000fH
	je	SHORT $L970

; 255  : 		panic("execve called from supervisor mode");

	push	OFFSET FLAT:$SG971
	call	_panic
	add	esp, 4
$L970:

; 258  : 		page[i]=0;
; 259  : // 取可执行文件的对应i 节点号。
; 260  : 	if (!(inode=namei(filename)))		/* get executables inode */

	mov	edx, DWORD PTR _filename$[ebp]
	mov	ecx, 32					; 00000020H
	xor	eax, eax
	lea	edi, DWORD PTR _page$[ebp]
	rep stosd
	push	edx
	call	_namei
	mov	ebx, eax
	add	esp, 4
	test	ebx, ebx
	jne	SHORT $L975

; 261  : 		return -ENOENT;

	mov	eax, -2					; fffffffeH

; 456  : }

	pop	edi
	pop	esi
	pop	ebx
	mov	esp, ebp
	pop	ebp
	ret	0
$L975:

; 262  : // 计算参数个数和环境变量个数。
; 263  : 	argc = count(argv);

	mov	eax, DWORD PTR _argv$[ebp]
	push	eax
	call	_count

; 264  : 	envc = count(envp);

	mov	ecx, DWORD PTR _envp$[ebp]
	mov	DWORD PTR _argc$[ebp], eax
	push	ecx
	call	_count

; 265  : 	
; 266  : // 执行文件必须是常规文件。若不是常规文件则置出错返回码，跳转到exec_error2(第347 行)。
; 267  : restart_interp:
; 268  : 	if (!S_ISREG(inode->i_mode)) {	/* must be regular file */

	mov	cx, WORD PTR [ebx]
	add	esp, 8
	mov	edx, ecx
	mov	DWORD PTR _envc$[ebp], eax
	and	edx, 61440				; 0000f000H
	cmp	edx, 32768				; 00008000H
	jne	$L1145
$restart_interp$976:

; 271  : 	}
; 272  : // 检查被执行文件的执行权限。根据其属性(对应i 节点的uid 和gid)，看本进程是否有权执行它。
; 273  : 	i = inode->i_mode;
; 274  : 	e_uid = (i & S_ISUID) ? inode->i_uid : current->euid;

	mov	esi, DWORD PTR _current
	mov	eax, ecx
	and	eax, 65535				; 0000ffffH
	test	ah, 8
	je	SHORT $L1077
	xor	edx, edx
	mov	dx, WORD PTR [ebx+2]
	jmp	SHORT $L1161
$L1077:
	xor	edx, edx
	mov	dx, WORD PTR [esi+578]
$L1161:

; 275  : 	e_gid = (i & S_ISGID) ? inode->i_gid : current->egid;

	test	ah, 4
	mov	DWORD PTR _e_uid$[ebp], edx
	je	SHORT $L1079
	xor	edx, edx
	mov	dl, BYTE PTR [ebx+12]
	jmp	SHORT $L1162
$L1079:
	xor	edx, edx
	mov	dx, WORD PTR [esi+584]
$L1162:
	mov	DWORD PTR _e_gid$[ebp], edx

; 276  : 	if (current->euid == inode->i_uid)

	mov	dx, WORD PTR [esi+578]
	cmp	dx, WORD PTR [ebx+2]
	jne	SHORT $L979

; 277  : 		i >>= 6;

	sar	eax, 6

; 278  : 	else if (current->egid == inode->i_gid)

	jmp	SHORT $L981
$L979:
	movzx	di, BYTE PTR [ebx+12]
	cmp	WORD PTR [esi+584], di
	jne	SHORT $L981

; 279  : 		i >>= 3;

	sar	eax, 3
$L981:

; 280  : 	if (!(i & 1) &&
; 281  : 	    !((inode->i_mode & 0111) && suser())) {

	test	al, 1
	jne	SHORT $L982
	test	cl, 73					; 00000049H
	je	$L983
	test	dx, dx
	jne	$L983
$L982:

; 282  : 		retval = -ENOEXEC;
; 283  : 		goto exec_error2;
; 284  : 	}
; 285  : // 读取执行文件的第一块数据到高速缓冲区，若出错则置出错码，跳转到exec_error2 处去处理。
; 286  : 	if (!(bh = bread(inode->i_dev,inode->i_zone[0]))) {

	xor	eax, eax
	xor	ecx, ecx
	mov	ax, WORD PTR [ebx+14]
	mov	cx, WORD PTR [ebx+44]
	push	eax
	push	ecx
	call	_bread
	mov	edx, eax
	add	esp, 8
	test	edx, edx
	je	$L1145

; 287  : 		retval = -EACCES;
; 288  : 		goto exec_error2;
; 289  : 	}
; 290  : // 下面对执行文件的头结构数据进行处理，首先让ex 指向执行头部分的数据结构。
; 291  : 	ex = *((struct exec *) bh->b_data);	/* 读取执行头部分 */

	mov	eax, DWORD PTR [edx]
	mov	ecx, 8
	mov	esi, eax
	lea	edi, DWORD PTR _ex$[ebp]
	rep movsd

; 292  : // 如果执行文件开始的两个字节为'#!'，并且sh_bang 标志没有置位，则处理脚本文件的执行。
; 293  : 	if ((bh->b_data[0] == '#') && (bh->b_data[1] == '!') && (!sh_bang)) {

	cmp	BYTE PTR [eax], 35			; 00000023H
	jne	$L986
	cmp	BYTE PTR [eax+1], 33			; 00000021H
	jne	$L986
	mov	ecx, DWORD PTR _sh_bang$[ebp]
	test	ecx, ecx
	jne	$L986

; 294  : 		/*
; 295  : 		 * 这部分处理对'#!'的解释，有些复杂，但希望能工作。-TYT
; 296  : 		 */
; 297  : 
; 298  : 		char buf[1023], *cp, *interp, *i_name, *i_arg;
; 299  : 		unsigned long old_fs;
; 300  : 
; 301  : // 复制执行程序头一行字符'#!'后面的字符串到buf 中，其中含有脚本处理程序名。
; 302  : 		strncpy(buf, bh->b_data+2, 1022);

	add	eax, 2
	mov	DWORD PTR $T1087[ebp], eax
	lea	eax, DWORD PTR _buf$987[ebp]
	mov	DWORD PTR $T1086[ebp], eax

; 242  : 	struct m_inode * inode;				// 内存中I 节点指针结构变量。
; 243  : 	struct buffer_head * bh;			// 高速缓存块头指针。

	pushf

; 244  : 	struct exec ex;						// 执行文件头部数据结构变量。

	mov	esi, DWORD PTR $T1087[ebp]

; 245  : 	unsigned long page[MAX_ARG_PAGES];	// 参数和环境字符串空间的页面指针数组。

	mov	edi, DWORD PTR $T1086[ebp]

; 246  : 	int i,argc,envc;

	mov	ecx, 1022				; 000003feH

; 247  : 	int e_uid, e_gid;					// 有效用户id 和有效组id。

	cld
$l1$1083:

; 248  : 	int retval;							// 返回值。

	dec	ecx

; 249  : 	int sh_bang = 0;					// 控制是否需要执行脚本处理代码。

	js	SHORT $l2$1084

; 250  : // 参数和环境字符串空间中的偏移指针，初始化为指向该空间的最后一个长字处。

	lodsb

; 251  : 	unsigned long p=PAGE_SIZE*MAX_ARG_PAGES-4;

	stosb

; 252  : 

	test	al, al

; 253  : // eip[1]中是原代码段寄存器cs，其中的选择符不可以是内核段选择符，也即内核不能调用本函数。

	jne	SHORT $l1$1083

; 254  : 	if ((0xffff & eip[1]) != 0x000f)

	rep	 stosb
$l2$1084:

; 255  : 		panic("execve called from supervisor mode");

	popf

; 303  : // 释放高速缓冲块和该执行文件i 节点。
; 304  : 		brelse(bh);

	push	edx
	call	_brelse

; 305  : 		iput(inode);

	push	ebx
	call	_iput

; 306  : // 取第一行内容，并删除开始的空格、制表符。
; 307  : 		buf[1022] = '\0';
; 308  : 		if (cp = strchr(buf, '\n')) {

	lea	ecx, DWORD PTR _buf$987[ebp]
	add	esp, 8
	mov	BYTE PTR _buf$987[ebp+1022], 0
	mov	DWORD PTR $T1093[ebp], ecx

; 244  : 	struct exec ex;						// 执行文件头部数据结构变量。

	pushf

; 245  : 	unsigned long page[MAX_ARG_PAGES];	// 参数和环境字符串空间的页面指针数组。

	mov	esi, DWORD PTR $T1093[ebp]

; 246  : 	int i,argc,envc;

	mov	ah, 10					; 0000000aH

; 247  : 	int e_uid, e_gid;					// 有效用户id 和有效组id。

	cld
$l1$1091:

; 248  : 	int retval;							// 返回值。

	lodsb

; 249  : 	int sh_bang = 0;					// 控制是否需要执行脚本处理代码。

	cmp	al, ah

; 250  : // 参数和环境字符串空间中的偏移指针，初始化为指向该空间的最后一个长字处。

	je	SHORT $l2$1092

; 251  : 	unsigned long p=PAGE_SIZE*MAX_ARG_PAGES-4;

	test	al, al

; 252  : 

	jne	SHORT $l1$1091

; 253  : // eip[1]中是原代码段寄存器cs，其中的选择符不可以是内核段选择符，也即内核不能调用本函数。

	mov	esi, 1
$l2$1092:

; 254  : 	if ((0xffff & eip[1]) != 0x000f)

	mov	eax, esi

; 255  : 		panic("execve called from supervisor mode");

	dec	eax

; 256  : // 初始化参数和环境串空间的页面指针数组（表）。
; 257  : 	for (i=0 ; i<MAX_ARG_PAGES ; i++)	/* clear page-table */

	popf

; 306  : // 取第一行内容，并删除开始的空格、制表符。
; 307  : 		buf[1022] = '\0';
; 308  : 		if (cp = strchr(buf, '\n')) {

	test	eax, eax
	je	$L999

; 309  : 			*cp = '\0';

	mov	BYTE PTR [eax], 0

; 310  : 			for (cp = buf; (*cp == ' ') || (*cp == '\t'); cp++);

	lea	eax, DWORD PTR _buf$987[ebp]
$L994:
	mov	cl, BYTE PTR [eax]
	cmp	cl, 32					; 00000020H
	je	SHORT $L995
	cmp	cl, 9
	jne	SHORT $L996
$L995:
	inc	eax
	jmp	SHORT $L994
$L996:

; 311  : 		}
; 312  : // 若该行没有其它内容，则出错。置出错码，跳转到exec_error1 处。
; 313  : 		if (!cp || *cp == '\0') {

	test	eax, eax
	je	$L999
	cmp	BYTE PTR [eax], 0
	je	$L999

; 316  : 		}
; 317  : // 否则就得到了开头是脚本解释执行程序名称的一行内容。
; 318  : 		interp = i_name = cp;

	mov	DWORD PTR _i_name$990[ebp], eax

; 319  : // 下面分析该行。首先取第一个字符串，其应该是脚本解释程序名，iname 指向该名称。
; 320  : 		i_arg = 0;

	mov	DWORD PTR _i_arg$991[ebp], 0

; 321  : 		for ( ; *cp && (*cp != ' ') && (*cp != '\t'); cp++) {

	mov	cl, BYTE PTR [eax]
	mov	edi, eax
	test	cl, cl
	je	SHORT $L1003
$L1001:
	cmp	cl, 32					; 00000020H
	je	SHORT $L1003
	cmp	cl, 9
	je	SHORT $L1003

; 322  :  			if (*cp == '/')

	cmp	cl, 47					; 0000002fH
	jne	SHORT $L1002
	lea	edx, DWORD PTR [eax+1]

; 323  : 				i_name = cp+1;

	mov	DWORD PTR _i_name$990[ebp], edx
$L1002:
	mov	cl, BYTE PTR [eax+1]
	inc	eax
	test	cl, cl
	jne	SHORT $L1001
$L1003:

; 324  : 		}
; 325  : // 若文件名后还有字符，则应该是参数串，令i_arg 指向该串。
; 326  : 		if (*cp) {

	cmp	BYTE PTR [eax], 0
	je	SHORT $L1005

; 327  : 			*cp++ = '\0';

	mov	BYTE PTR [eax], 0
	inc	eax

; 328  : 			i_arg = cp;

	mov	DWORD PTR _i_arg$991[ebp], eax
$L1005:

; 329  : 		}
; 330  : 		/*
; 331  : 		 * OK，我们已经解析出解释程序的文件名以及(可选的)参数。
; 332  : 		 */
; 333  : // 若sh_bang 标志没有设置，则设置它，并复制指定个数的环境变量串和参数串到参数和环境空间中。
; 334  : 		if (sh_bang++ == 0) {
; 335  : 			p = copy_strings(envc, envp, page, p, 0);

	mov	eax, DWORD PTR _p$[ebp]
	mov	edx, DWORD PTR _envp$[ebp]
	push	0
	lea	ecx, DWORD PTR _page$[ebp]
	push	eax
	mov	eax, DWORD PTR _envc$[ebp]
	push	ecx
	push	edx
	push	eax
	mov	DWORD PTR _sh_bang$[ebp], 1
	call	_copy_strings

; 336  : 			p = copy_strings(--argc, argv+1, page, p, 0);

	mov	edx, DWORD PTR _argv$[ebp]
	mov	esi, DWORD PTR _argc$[ebp]
	push	0
	lea	ecx, DWORD PTR _page$[ebp]
	push	eax
	add	edx, 4
	dec	esi
	push	ecx
	push	edx
	push	esi
	call	_copy_strings

; 337  : 		}
; 338  : 		/*
; 339  : 		 * 拼接(1) argv[0]中放解释程序的名称
; 340  : 		 * (2) (可选的)解释程序的参数
; 341  : 		 * (3) 脚本程序的名称
; 342  : 		 *
; 343  : 		 * 这是以逆序进行处理的，是由于用户环境和参数的存放方式造成的。
; 344  : 		 */
; 345  : // 复制脚本程序文件名到参数和环境空间中。
; 346  : 		p = copy_strings(1, &filename, page, p, 1);

	push	1
	push	eax
	lea	eax, DWORD PTR _page$[ebp]
	lea	ecx, DWORD PTR _filename$[ebp]
	push	eax
	push	ecx
	push	1
	call	_copy_strings

; 347  : // 复制解释程序的参数到参数和环境空间中。
; 348  : 		argc++;
; 349  : 		if (i_arg) {

	mov	ecx, DWORD PTR _i_arg$991[ebp]
	add	esp, 60					; 0000003cH
	inc	esi
	test	ecx, ecx
	je	SHORT $L1007

; 350  : 			p = copy_strings(1, &i_arg, page, p, 2);

	push	2
	push	eax
	lea	edx, DWORD PTR _page$[ebp]
	lea	eax, DWORD PTR _i_arg$991[ebp]
	push	edx
	push	eax
	push	1
	call	_copy_strings
	add	esp, 20					; 00000014H

; 351  : 			argc++;

	inc	esi
$L1007:

; 352  : 		}
; 353  : // 复制解释程序文件名到参数和环境空间中。若出错，则置出错码，跳转到exec_error1。
; 354  : 		p = copy_strings(1, &i_name, page, p, 2);

	push	2
	lea	ecx, DWORD PTR _page$[ebp]
	push	eax
	lea	edx, DWORD PTR _i_name$990[ebp]
	push	ecx
	push	edx
	push	1
	call	_copy_strings
	add	esp, 20					; 00000014H

; 355  : 		argc++;

	inc	esi

; 356  : 		if (!p) {

	test	eax, eax
	mov	DWORD PTR _p$[ebp], eax
	mov	DWORD PTR _argc$[ebp], esi
	je	SHORT $L1147

; 244  : 	struct exec ex;						// 执行文件头部数据结构变量。

	mov	ax, fs

; 359  : 		}
; 360  : 		/*
; 361  : 		 * OK，现在使用解释程序的i 节点重启进程。
; 362  : 		 */
; 363  : // 保留原fs 段寄存器（原指向用户数据段），现置其指向内核数据段。
; 364  : 		old_fs = get_fs();

	mov	WORD PTR $T1097[ebp], ax
	mov	eax, DWORD PTR $T1097[ebp]
	and	eax, 65535				; 0000ffffH
	mov	DWORD PTR _old_fs$992[ebp], eax

; 244  : 	struct exec ex;						// 执行文件头部数据结构变量。

	mov	ax, fs

; 365  : 		set_fs(get_ds());

	mov	WORD PTR $T1101[ebp], ax
	mov	ecx, DWORD PTR $T1101[ebp]
	and	ecx, 65535				; 0000ffffH
	mov	DWORD PTR $T1105[ebp], ecx

; 242  : 	struct m_inode * inode;				// 内存中I 节点指针结构变量。
; 243  : 	struct buffer_head * bh;			// 高速缓存块头指针。

	mov	eax, DWORD PTR $T1105[ebp]

; 244  : 	struct exec ex;						// 执行文件头部数据结构变量。

	mov	fs, ax

; 366  : // 取解释程序的i 节点，并跳转到restart_interp 处重新处理。
; 367  : 		if (!(inode=namei(interp))) { /* get executables inode */

	push	edi
	call	_namei
	mov	ebx, eax
	add	esp, 4
	test	ebx, ebx
	je	SHORT $L1148

; 242  : 	struct m_inode * inode;				// 内存中I 节点指针结构变量。
; 243  : 	struct buffer_head * bh;			// 高速缓存块头指针。

	mov	eax, DWORD PTR _old_fs$992[ebp]

; 244  : 	struct exec ex;						// 执行文件头部数据结构变量。

	mov	fs, ax

; 371  : 		}
; 372  : 		set_fs(old_fs);

	mov	cx, WORD PTR [ebx]
	mov	edx, ecx
	and	edx, 61440				; 0000f000H
	cmp	edx, 32768				; 00008000H
	je	$restart_interp$976
$L1145:

; 269  : 		retval = -EACCES;

	mov	edi, -13				; fffffff3H

; 270  : 		goto exec_error2;

	jmp	$exec_error2$978
$L1147:

; 357  : 			retval = -ENOMEM;

	mov	edi, -12				; fffffff4H

; 358  : 			goto exec_error1;

	jmp	$exec_error1$1000
$L1148:

; 242  : 	struct m_inode * inode;				// 内存中I 节点指针结构变量。
; 243  : 	struct buffer_head * bh;			// 高速缓存块头指针。

	mov	eax, DWORD PTR _old_fs$992[ebp]

; 244  : 	struct exec ex;						// 执行文件头部数据结构变量。

	mov	fs, ax

; 368  : 			set_fs(old_fs);
; 369  : 			retval = -ENOENT;

	mov	edi, -2					; fffffffeH

; 370  : 			goto exec_error1;

	jmp	$exec_error1$1000
$L999:

; 314  : 			retval = -ENOEXEC; /* No interpreter name found */

	mov	edi, -8					; fffffff8H

; 315  : 			goto exec_error1;

	jmp	$exec_error1$1000
$L986:

; 373  : 		goto restart_interp;
; 374  : 	}
; 375  : // 释放该缓冲区。
; 376  : 	brelse(bh);

	push	edx
	call	_brelse

; 377  : // 下面对执行头信息进行处理。
; 378  : // 对于下列情况，将不执行程序：如果执行文件不是需求页可执行文件(ZMAGIC)、或者代码重定位部分
; 379  : // 长度a_trsize 不等于0、或者数据重定位信息长度不等于0、或者代码段+数据段+堆段长度超过50MB、
; 380  : // 或者i 节点表明的该执行文件长度小于代码段+数据段+符号表长度+执行头部分长度的总和。
; 381  : 	if (N_MAGIC(ex) != ZMAGIC || ex.a_trsize || ex.a_drsize ||
; 382  : 		ex.a_text+ex.a_data+ex.a_bss>0x3000000 ||
; 383  : 		inode->i_size < ex.a_text+ex.a_data+ex.a_syms+N_TXTOFF(ex)) {

	mov	eax, DWORD PTR _ex$[ebp]
	add	esp, 4
	cmp	eax, 267				; 0000010bH
	jne	$L983
	mov	eax, DWORD PTR _ex$[ebp+24]
	test	eax, eax
	jne	$L983
	mov	eax, DWORD PTR _ex$[ebp+28]
	test	eax, eax
	jne	$L983
	mov	ecx, DWORD PTR _ex$[ebp+12]
	mov	eax, DWORD PTR _ex$[ebp+8]
	mov	esi, DWORD PTR _ex$[ebp+4]
	add	ecx, eax
	add	ecx, esi
	cmp	ecx, 50331648				; 03000000H
	ja	$L983
	mov	edx, DWORD PTR _ex$[ebp+16]
	mov	ecx, DWORD PTR [ebx+4]
	add	edx, eax
	lea	eax, DWORD PTR [edx+esi+1024]
	cmp	ecx, eax
	jb	$L983

; 385  : 		goto exec_error2;
; 386  : 	}
; 387  : // 如果执行文件执行头部分长度不等于一个内存块大小（1024 字节），也不能执行。转exec_error2。
; 388  : 	if (N_TXTOFF(ex) != BLOCK_SIZE) {
; 389  : 		printk("%s: N_TXTOFF != BLOCK_SIZE. See a.out.h.", filename);
; 390  : 		retval = -ENOEXEC;
; 391  : 		goto exec_error2;
; 392  : 	}
; 393  : // 如果sh_bang 标志没有设置，则复制指定个数的环境变量字符串和参数到参数和环境空间中。
; 394  : // 若sh_bang 标志已经设置，则表明是将运行脚本程序，此时环境变量页面已经复制，无须再复制。
; 395  : 	if (!sh_bang) {

	mov	eax, DWORD PTR _sh_bang$[ebp]
	test	eax, eax
	jne	SHORT $L1021

; 396  : 		p = copy_strings(envc,envp,page,p,0);

	mov	ecx, DWORD PTR _p$[ebp]
	mov	eax, DWORD PTR _envp$[ebp]
	push	0
	lea	edx, DWORD PTR _page$[ebp]
	push	ecx
	mov	ecx, DWORD PTR _envc$[ebp]
	push	edx
	push	eax
	push	ecx
	call	_copy_strings

; 397  : 		p = copy_strings(argc,argv,page,p,0);

	mov	ecx, DWORD PTR _argc$[ebp]
	push	0
	push	eax
	mov	eax, DWORD PTR _argv$[ebp]
	lea	edx, DWORD PTR _page$[ebp]
	push	edx
	push	eax
	push	ecx
	call	_copy_strings
	add	esp, 40					; 00000028H
	mov	DWORD PTR _p$[ebp], eax

; 398  : // 如果p=0，则表示环境变量与参数空间页面已经被占满，容纳不下了。转至出错处理处。
; 399  : 		if (!p) {

	test	eax, eax
	jne	SHORT $L1021

; 400  : 			retval = -ENOMEM;

	mov	edi, -12				; fffffff4H

; 401  : 			goto exec_error2;

	jmp	$exec_error2$978
$L1021:

; 402  : 		}
; 403  : 	}
; 404  : /* OK，下面开始就没有返回的地方了 */
; 405  : // 如果原程序也是一个执行程序，则释放其i 节点，并让进程executable 字段指向新程序i 节点。
; 406  : 	if (current->executable)

	mov	eax, DWORD PTR _current
	mov	ecx, DWORD PTR [eax+632]
	test	ecx, ecx
	je	SHORT $L1022

; 407  : 		iput(current->executable);

	push	ecx
	call	_iput
	mov	eax, DWORD PTR _current
	add	esp, 4
$L1022:

; 408  : 	current->executable = inode;

	mov	DWORD PTR [eax+632], ebx
	lea	ecx, DWORD PTR [eax+16]
	mov	edx, 32					; 00000020H
$L1023:

; 409  : // 清复位所有信号处理句柄。但对于SIG_IGN 句柄不能复位，因此在322 与323 行之间需添加一条
; 410  : // if 语句：if (current->sa[I].sa_handler != SIG_IGN)。这是源代码中的一个bug。
; 411  : 	for (i=0 ; i<32 ; i++)
; 412  : 		current->sigaction[i].sa_handler = NULL;

	mov	DWORD PTR [ecx], 0
	add	ecx, 16					; 00000010H
	dec	edx
	jne	SHORT $L1023

; 413  : // 根据执行时关闭(close_on_exec)文件句柄位图标志，关闭指定的打开文件，并复位该标志。
; 414  : 	for (i=0 ; i<NR_OPEN ; i++)

	xor	edi, edi
$L1026:

; 415  : 		if ((current->close_on_exec>>i)&1)

	mov	edx, DWORD PTR [eax+636]
	mov	ecx, edi
	shr	edx, cl
	test	dl, 1
	je	SHORT $L1027

; 416  : 			sys_close(i);

	push	edi
	call	_sys_close
	mov	eax, DWORD PTR _current
	add	esp, 4
$L1027:
	inc	edi
	cmp	edi, 20					; 00000014H
	jl	SHORT $L1026

; 417  : 	current->close_on_exec = 0;

	mov	DWORD PTR [eax+636], 0

; 418  : // 根据指定的基地址和限长，释放原来程序代码段和数据段所对应的内存页表指定的内存块及页表本身。
; 419  : 	free_page_tables(get_base(current->ldt[1]),get_limit(0x0f));

	mov	DWORD PTR $T1115[ebp], 15		; 0000000fH

; 244  : 	struct exec ex;						// 执行文件头部数据结构变量。

	mov	eax, DWORD PTR $T1115[ebp]

; 245  : 	unsigned long page[MAX_ARG_PAGES];	// 参数和环境字符串空间的页面指针数组。

	lsl	eax, eax

; 418  : // 根据指定的基地址和限长，释放原来程序代码段和数据段所对应的内存页表指定的内存块及页表本身。
; 419  : 	free_page_tables(get_base(current->ldt[1]),get_limit(0x0f));

	mov	ecx, eax
	mov	eax, DWORD PTR _current
	add	eax, 728				; 000002d8H
	mov	DWORD PTR $T1120[ebp], eax

; 244  : 	struct exec ex;						// 执行文件头部数据结构变量。

	mov	ebx, DWORD PTR $T1120[ebp]

; 245  : 	unsigned long page[MAX_ARG_PAGES];	// 参数和环境字符串空间的页面指针数组。

	mov	ah, BYTE PTR [ebx+7]

; 246  : 	int i,argc,envc;

	mov	al, BYTE PTR [ebx+4]

; 247  : 	int e_uid, e_gid;					// 有效用户id 和有效组id。

	shl	eax, 16					; 00000010H

; 248  : 	int retval;							// 返回值。

	mov	ax, WORD PTR [ebx+2]

; 418  : // 根据指定的基地址和限长，释放原来程序代码段和数据段所对应的内存页表指定的内存块及页表本身。
; 419  : 	free_page_tables(get_base(current->ldt[1]),get_limit(0x0f));

	push	ecx
	push	eax
	call	_free_page_tables

; 420  : 	free_page_tables(get_base(current->ldt[2]),get_limit(0x17));

	mov	DWORD PTR $T1125[ebp], 23		; 00000017H

; 244  : 	struct exec ex;						// 执行文件头部数据结构变量。

	mov	eax, DWORD PTR $T1125[ebp]

; 245  : 	unsigned long page[MAX_ARG_PAGES];	// 参数和环境字符串空间的页面指针数组。

	lsl	eax, eax

; 420  : 	free_page_tables(get_base(current->ldt[2]),get_limit(0x17));

	mov	edx, DWORD PTR _current
	mov	ecx, eax
	add	edx, 736				; 000002e0H
	mov	DWORD PTR $T1130[ebp], edx

; 244  : 	struct exec ex;						// 执行文件头部数据结构变量。

	mov	ebx, DWORD PTR $T1130[ebp]

; 245  : 	unsigned long page[MAX_ARG_PAGES];	// 参数和环境字符串空间的页面指针数组。

	mov	ah, BYTE PTR [ebx+7]

; 246  : 	int i,argc,envc;

	mov	al, BYTE PTR [ebx+4]

; 247  : 	int e_uid, e_gid;					// 有效用户id 和有效组id。

	shl	eax, 16					; 00000010H

; 248  : 	int retval;							// 返回值。

	mov	ax, WORD PTR [ebx+2]

; 420  : 	free_page_tables(get_base(current->ldt[2]),get_limit(0x17));

	push	ecx
	push	eax
	call	_free_page_tables

; 421  : // 如果“上次任务使用了协处理器”指向的是当前进程，则将其置空，并复位使用了协处理器的标志。
; 422  : 	if (last_task_used_math == current)

	mov	eax, DWORD PTR _current
	mov	ecx, DWORD PTR _last_task_used_math
	add	esp, 16					; 00000010H
	cmp	ecx, eax
	jne	SHORT $L1032

; 423  : 		last_task_used_math = NULL;

	mov	DWORD PTR _last_task_used_math, 0
$L1032:

; 424  : 	current->used_math = 0;

	mov	WORD PTR [eax+612], 0

; 425  : // 根据a_text 修改局部表中描述符基址和段限长，并将参数和环境空间页面放置在数据段末端。
; 426  : // 执行下面语句之后，p 此时是以数据段起始处为原点的偏移值，仍指向参数和环境空间数据开始处，
; 427  : // 也即转换成为堆栈的指针。
; 428  : 	p += change_ldt(ex.a_text,page)-MAX_ARG_PAGES*PAGE_SIZE;

	lea	eax, DWORD PTR _page$[ebp]
	push	eax
	push	esi
	call	_change_ldt
	mov	ecx, DWORD PTR _p$[ebp]

; 429  : // create_tables()在新用户堆栈中创建环境和参数变量指针表，并返回该堆栈指针。
; 430  : 	p = (unsigned long) create_tables((char *)p,argc,envc);

	mov	edx, DWORD PTR _envc$[ebp]
	push	edx
	lea	eax, DWORD PTR [ecx+eax-131072]
	mov	ecx, DWORD PTR _argc$[ebp]
	push	ecx
	push	eax
	call	_create_tables

; 431  : // 修改当前进程各字段为新执行程序的信息。令进程代码段尾值字段end_code = a_text；令进程数据
; 432  : // 段尾字段end_data = a_data + a_text；令进程堆结尾字段brk = a_text + a_data + a_bss。
; 433  : 	current->brk = ex.a_bss +
; 434  : 		(current->end_data = ex.a_data +
; 435  : 		(current->end_code = ex.a_text));

	mov	ecx, DWORD PTR _ex$[ebp+8]
	mov	edx, eax
	mov	eax, DWORD PTR _current
	add	ecx, esi
	add	esp, 20					; 00000014H
	mov	DWORD PTR [eax+540], esi
	mov	esi, DWORD PTR _ex$[ebp+12]
	add	esi, ecx
	mov	DWORD PTR [eax+544], ecx
	mov	DWORD PTR [eax+548], esi

; 436  : // 设置进程堆栈开始字段为堆栈指针所在的页面，并重新设置进程的用户id 和组id。
; 437  : 	current->start_stack = p & 0xfffff000;

	mov	esi, edx
	and	esi, -4096				; fffff000H
	mov	DWORD PTR [eax+552], esi

; 438  : 	current->euid = e_uid;

	mov	si, WORD PTR _e_uid$[ebp]
	mov	WORD PTR [eax+578], si

; 439  : 	current->egid = e_gid;

	mov	si, WORD PTR _e_gid$[ebp]

; 440  : // 初始化一页bss 段数据，全为零。
; 441  : 	i = ex.a_text+ex.a_data;
; 442  : 	while (i&0xfff)

	test	ecx, 4095				; 00000fffH
	mov	WORD PTR [eax+584], si
	je	SHORT $L1037
$L1036:

; 443  : 		put_fs_byte(0,(char *) (i++));

	mov	DWORD PTR $T1135[ebp], ecx
	inc	ecx

; 242  : 	struct m_inode * inode;				// 内存中I 节点指针结构变量。
; 243  : 	struct buffer_head * bh;			// 高速缓存块头指针。

	mov	ebx, DWORD PTR $T1135[ebp]

; 244  : 	struct exec ex;						// 执行文件头部数据结构变量。

	mov	al, 0

; 245  : 	unsigned long page[MAX_ARG_PAGES];	// 参数和环境字符串空间的页面指针数组。

	mov	BYTE PTR fs:[ebx], al

; 443  : 		put_fs_byte(0,(char *) (i++));

	test	ecx, 4095				; 00000fffH
	jne	SHORT $L1036
$L1037:

; 444  : // 将原调用系统中断的程序在堆栈上的代码指针替换为指向新执行程序的入口点，并将堆栈指针替换
; 445  : // 为新执行程序的堆栈指针。返回指令将弹出这些堆栈数据并使得CPU 去执行新的执行程序，因此不会
; 446  : // 返回到原调用系统中断的程序中去了。
; 447  : 	eip[0] = ex.a_entry;		/* eip，魔法起作用了 :-) */

	mov	eax, DWORD PTR _eip$[ebp]
	mov	ecx, DWORD PTR _ex$[ebp+20]
	mov	DWORD PTR [eax], ecx

; 448  : 	eip[3] = p;			/* esp，堆栈指针 */

	mov	DWORD PTR [eax+12], edx

; 449  : 	return 0;

	xor	eax, eax

; 456  : }

	pop	edi
	pop	esi
	pop	ebx
	mov	esp, ebp
	pop	ebp
	ret	0
$L983:

; 384  : 		retval = -ENOEXEC;

	mov	edi, -8					; fffffff8H
$exec_error2$978:

; 450  : exec_error2:
; 451  : 	iput(inode);

	push	ebx
	call	_iput
	add	esp, 4
$exec_error1$1000:

; 452  : exec_error1:
; 453  : 	for (i=0 ; i<MAX_ARG_PAGES ; i++)

	lea	esi, DWORD PTR _page$[ebp]
	mov	ebx, 32					; 00000020H
$L1039:

; 454  : 		free_page(page[i]);

	mov	edx, DWORD PTR [esi]
	push	edx
	call	_free_page
	add	esp, 4
	add	esi, 4
	dec	ebx
	jne	SHORT $L1039

; 455  : 	return(retval);

	mov	eax, edi

; 456  : }

	pop	edi
	pop	esi
	pop	ebx
	mov	esp, ebp
	pop	ebp
	ret	0
_do_execve ENDP
$T1176 = 12
$T1180 = 8
$T1188 = 12
$T1192 = 8
_p$ = 8
_argc$ = 12
_envc$ = 16
_argv$ = -12
_envp$ = -8
_sp$ = -4
_create_tables PROC NEAR

; 50   : {

	push	ebp
	mov	ebp, esp
	sub	esp, 12					; 0000000cH

; 56   : // sp 向下移动，空出环境参数占用的空间个数，并让环境参数指针envp 指向该处。
; 57   : 	sp -= envc+1;

	mov	eax, DWORD PTR _envc$[ebp]
	push	ebx
	push	esi

; 58   : 	envp = sp;
; 59   : // sp 向下移动，空出命令行参数指针占用的空间个数，并让argv 指针指向该处。
; 60   : // 下面指针加1，sp 将递增指针宽度字节值。
; 61   : 	sp -= argc+1;

	or	esi, -1
	lea	ecx, DWORD PTR [eax*4+4]
	push	edi
	mov	edx, ecx
	mov	ecx, DWORD PTR _p$[ebp]
	mov	eax, ecx
	and	al, -4					; fffffffcH
	sub	eax, edx
	mov	edx, DWORD PTR _argc$[ebp]
	sub	esi, edx
	mov	DWORD PTR _envp$[ebp], eax
	lea	esi, DWORD PTR [eax+esi*4]

; 62   : 	argv = sp;

	mov	edi, esi

; 63   : // 将环境参数指针envp 和命令行参数指针以及命令行参数个数压入堆栈。
; 64   : 	put_fs_long((unsigned long)envp,--sp);

	sub	esi, 4
	mov	DWORD PTR _argv$[ebp], edi
	mov	DWORD PTR _sp$[ebp], esi

; 51   : 	unsigned long *argv,*envp;
; 52   : 	unsigned long * sp;

	mov	ebx, DWORD PTR _sp$[ebp]

; 53   : 

	mov	eax, DWORD PTR _envp$[ebp]

; 54   : // 堆栈指针是以4 字节（1 节）为边界寻址的，因此这里让sp 为4 的整数倍。

	mov	DWORD PTR fs:[ebx], eax

; 65   : 	put_fs_long((unsigned long)argv,--sp);

	sub	esi, 4
	mov	DWORD PTR _sp$[ebp], esi

; 51   : 	unsigned long *argv,*envp;
; 52   : 	unsigned long * sp;

	mov	ebx, DWORD PTR _sp$[ebp]

; 53   : 

	mov	eax, DWORD PTR _argv$[ebp]

; 54   : // 堆栈指针是以4 字节（1 节）为边界寻址的，因此这里让sp 为4 的整数倍。

	mov	DWORD PTR fs:[ebx], eax

; 66   : 	put_fs_long((unsigned long)argc,--sp);

	sub	esi, 4
	mov	DWORD PTR _sp$[ebp], esi

; 51   : 	unsigned long *argv,*envp;
; 52   : 	unsigned long * sp;

	mov	ebx, DWORD PTR _sp$[ebp]

; 53   : 

	mov	eax, DWORD PTR _argc$[ebp]

; 54   : // 堆栈指针是以4 字节（1 节）为边界寻址的，因此这里让sp 为4 的整数倍。

	mov	DWORD PTR fs:[ebx], eax

; 67   : // 将命令行各参数指针放入前面空出来的相应地方，最后放置一个NULL 指针。
; 68   : 	while (argc-->0) {

	mov	eax, edx
	dec	edx
	test	eax, eax
	jle	SHORT $L855

; 77   : 	}
; 78   : 	put_fs_long(0,envp);
; 79   : 	return sp;		// 返回构造的当前新堆栈指针。

	inc	edx
$L854:

; 69   : 		put_fs_long((unsigned long) p,argv++);

	mov	DWORD PTR $T1176[ebp], edi
	add	edi, 4

; 51   : 	unsigned long *argv,*envp;
; 52   : 	unsigned long * sp;

	mov	ebx, DWORD PTR $T1176[ebp]

; 53   : 

	mov	eax, DWORD PTR _p$[ebp]

; 54   : // 堆栈指针是以4 字节（1 节）为边界寻址的，因此这里让sp 为4 的整数倍。

	mov	DWORD PTR fs:[ebx], eax

; 69   : 		put_fs_long((unsigned long) p,argv++);

$L858:

; 70   : 		while (get_fs_byte(p++)) /* nothing */ ;// p 指针前移4 字节。

	mov	DWORD PTR $T1180[ebp], ecx
	inc	ecx

; 54   : // 堆栈指针是以4 字节（1 节）为边界寻址的，因此这里让sp 为4 的整数倍。

	mov	ebx, DWORD PTR $T1180[ebp]

; 55   : 	sp = (unsigned long *) (0xfffffffc & (unsigned long) p);

	mov	al, BYTE PTR fs:[ebx]

; 70   : 		while (get_fs_byte(p++)) /* nothing */ ;// p 指针前移4 字节。

	test	al, al
	jne	SHORT $L858
	dec	edx
	mov	DWORD PTR _p$[ebp], ecx
	jne	SHORT $L854

; 69   : 		put_fs_long((unsigned long) p,argv++);

	mov	DWORD PTR _argv$[ebp], edi
$L855:

; 51   : 	unsigned long *argv,*envp;
; 52   : 	unsigned long * sp;

	mov	ebx, DWORD PTR _argv$[ebp]

; 53   : 

	mov	eax, 0

; 54   : // 堆栈指针是以4 字节（1 节）为边界寻址的，因此这里让sp 为4 的整数倍。

	mov	DWORD PTR fs:[ebx], eax

; 73   : // 将环境变量各指针放入前面空出来的相应地方，最后放置一个NULL 指针。
; 74   : 	while (envc-->0) {

	mov	eax, DWORD PTR _envc$[ebp]
	mov	edx, eax
	dec	eax
	test	edx, edx
	jle	SHORT $L862

; 71   : 	}
; 72   : 	put_fs_long(0,argv);

	lea	edx, DWORD PTR [eax+1]
$L861:

; 75   : 		put_fs_long((unsigned long) p,envp++);

	mov	eax, DWORD PTR _envp$[ebp]
	mov	DWORD PTR $T1188[ebp], eax
	add	eax, 4
	mov	DWORD PTR _envp$[ebp], eax

; 51   : 	unsigned long *argv,*envp;
; 52   : 	unsigned long * sp;

	mov	ebx, DWORD PTR $T1188[ebp]

; 53   : 

	mov	eax, DWORD PTR _p$[ebp]

; 54   : // 堆栈指针是以4 字节（1 节）为边界寻址的，因此这里让sp 为4 的整数倍。

	mov	DWORD PTR fs:[ebx], eax

; 75   : 		put_fs_long((unsigned long) p,envp++);

$L865:

; 76   : 		while (get_fs_byte(p++)) /* nothing */ ;

	mov	DWORD PTR $T1192[ebp], ecx
	inc	ecx

; 54   : // 堆栈指针是以4 字节（1 节）为边界寻址的，因此这里让sp 为4 的整数倍。

	mov	ebx, DWORD PTR $T1192[ebp]

; 55   : 	sp = (unsigned long *) (0xfffffffc & (unsigned long) p);

	mov	al, BYTE PTR fs:[ebx]

; 76   : 		while (get_fs_byte(p++)) /* nothing */ ;

	test	al, al
	jne	SHORT $L865
	dec	edx
	mov	DWORD PTR _p$[ebp], ecx
	jne	SHORT $L861
$L862:

; 51   : 	unsigned long *argv,*envp;
; 52   : 	unsigned long * sp;

	mov	ebx, DWORD PTR _envp$[ebp]

; 53   : 

	mov	eax, 0

; 54   : // 堆栈指针是以4 字节（1 节）为边界寻址的，因此这里让sp 为4 的整数倍。

	mov	DWORD PTR fs:[ebx], eax

; 77   : 	}
; 78   : 	put_fs_long(0,envp);
; 79   : 	return sp;		// 返回构造的当前新堆栈指针。

	mov	eax, esi
	pop	edi
	pop	esi
	pop	ebx

; 80   : }

	mov	esp, ebp
	pop	ebp
	ret	0
_create_tables ENDP
$T1207 = 8
_argv$ = 8
_count	PROC NEAR

; 89   : {

	push	ebp
	mov	ebp, esp

; 90   : 	int i=0;
; 91   : 	char ** tmp;
; 92   : 
; 93   : 	if (tmp = argv)

	mov	ecx, DWORD PTR _argv$[ebp]
	xor	edx, edx
	test	ecx, ecx
	je	SHORT $L1211
	push	ebx
$L876:

; 94   : 		while (get_fs_long((unsigned long *) (tmp++)))

	mov	DWORD PTR $T1207[ebp], ecx
	add	ecx, 4

; 90   : 	int i=0;
; 91   : 	char ** tmp;
; 92   : 
; 93   : 	if (tmp = argv)

	mov	ebx, DWORD PTR $T1207[ebp]

; 94   : 		while (get_fs_long((unsigned long *) (tmp++)))

	mov	eax, DWORD PTR fs:[ebx]
	test	eax, eax
	je	SHORT $L1210

; 95   : 			i++;

	inc	edx
	jmp	SHORT $L876
$L1210:

; 96   : 
; 97   : 	return i;

	mov	eax, edx
	pop	ebx

; 98   : }

	pop	ebp
	ret	0
$L1211:

; 96   : 
; 97   : 	return i;

	mov	eax, edx

; 98   : }

	pop	ebp
	ret	0
_count	ENDP
_TEXT	ENDS
EXTRN	_get_free_page:NEAR
_DATA	SEGMENT
	ORG $+3
$SG905	DB	'argc is wrong', 00H
_DATA	ENDS
_TEXT	SEGMENT
$T1216 = -12
$T1220 = -12
$T1230 = 12
$T1238 = -16
_argc$ = 8
_argv$ = 12
_page$ = 16
_p$ = 20
_from_kmem$ = 24
_tmp$ = 12
_pag$ = 24
_len$ = -16
_old_fs$ = -12
_new_fs$ = -4
_copy_strings PROC NEAR

; 123  : {

	push	ebp
	mov	ebp, esp
	sub	esp, 16					; 00000010H

; 128  : 	if (!p)

	mov	edx, DWORD PTR _p$[ebp]
	push	ebx
	push	esi
	push	edi
	xor	edi, edi
	test	edx, edx
	jne	SHORT $L896
$L1259:
	pop	edi
	pop	esi

; 129  : 		return 0;	/* 偏移指针验证 */

	xor	eax, eax
	pop	ebx

; 188  : }

	mov	esp, ebp
	pop	ebp
	ret	0
$L896:

; 126  : 	unsigned long old_fs, new_fs;

	mov	ax, fs

; 130  : // 取ds 寄存器值到new_fs，并保存原fs 寄存器值到old_fs。
; 131  : 	new_fs = get_ds();

	mov	WORD PTR $T1216[ebp], ax
	mov	eax, DWORD PTR $T1216[ebp]
	and	eax, 65535				; 0000ffffH
	mov	DWORD PTR _new_fs$[ebp], eax

; 126  : 	unsigned long old_fs, new_fs;

	mov	ax, fs

; 132  : 	old_fs = get_fs();

	mov	WORD PTR $T1220[ebp], ax
	mov	ecx, DWORD PTR $T1220[ebp]

; 133  : // 如果字符串和字符串数组来自内核空间，则设置fs 段寄存器指向内核数据段（ds）。
; 134  : 	if (from_kmem==2)

	mov	eax, DWORD PTR _from_kmem$[ebp]
	and	ecx, 65535				; 0000ffffH
	cmp	eax, 2
	mov	DWORD PTR _old_fs$[ebp], ecx
	jne	SHORT $L1256

; 124  : 	char *tmp, *pag;
; 125  : 	int len, offset = 0;

	mov	eax, DWORD PTR _new_fs$[ebp]

; 126  : 	unsigned long old_fs, new_fs;

	mov	fs, ax
$L1256:

; 135  : 		set_fs(new_fs);
; 136  : // 循环处理各个参数，从最后一个参数逆向开始复制，复制到指定偏移地址处。
; 137  : 	while (argc-- > 0) {

	mov	eax, DWORD PTR _argc$[ebp]
	mov	ecx, eax
	dec	eax
	test	ecx, ecx
	mov	DWORD PTR _argc$[ebp], eax
	jle	$L900
	mov	ecx, DWORD PTR _argv$[ebp]
	mov	esi, DWORD PTR _pag$[ebp]
	lea	eax, DWORD PTR [ecx+eax*4]
	mov	DWORD PTR -8+[ebp], eax
$L899:

; 138  : // 如果字符串在用户空间而字符串数组在内核空间，则设置fs 段寄存器指向内核数据段（ds）。
; 139  : 		if (from_kmem == 1)

	cmp	DWORD PTR _from_kmem$[ebp], 1
	jne	SHORT $L1226

; 124  : 	char *tmp, *pag;
; 125  : 	int len, offset = 0;

	mov	eax, DWORD PTR _new_fs$[ebp]

; 126  : 	unsigned long old_fs, new_fs;

	mov	fs, ax

; 140  : 			set_fs(new_fs);

$L1226:

; 141  : // 从最后一个参数开始逆向操作，取fs 段中最后一参数指针到tmp，如果为空，则出错死机。
; 142  : 		if (!(tmp = (char *)get_fs_long(((unsigned long *)argv)+argc)))

	mov	ecx, DWORD PTR -8+[ebp]
	mov	DWORD PTR $T1230[ebp], ecx

; 127  : 

	mov	ebx, DWORD PTR $T1230[ebp]

; 128  : 	if (!p)

	mov	eax, DWORD PTR fs:[ebx]

; 141  : // 从最后一个参数开始逆向操作，取fs 段中最后一参数指针到tmp，如果为空，则出错死机。
; 142  : 		if (!(tmp = (char *)get_fs_long(((unsigned long *)argv)+argc)))

	mov	ebx, eax
	test	ebx, ebx
	jne	SHORT $L904

; 143  : 			panic("argc is wrong");

	push	OFFSET FLAT:$SG905
	call	_panic
	mov	edx, DWORD PTR _p$[ebp]
	add	esp, 4
$L904:

; 144  : // 如果字符串在用户空间而字符串数组在内核空间，则恢复fs 段寄存器原值。
; 145  : 		if (from_kmem == 1)

	cmp	DWORD PTR _from_kmem$[ebp], 1
	jne	SHORT $L1234

; 124  : 	char *tmp, *pag;
; 125  : 	int len, offset = 0;

	mov	eax, DWORD PTR _old_fs$[ebp]

; 126  : 	unsigned long old_fs, new_fs;

	mov	fs, ax

; 146  : 			set_fs(old_fs);

$L1234:

; 147  : // 计算该参数字符串长度len，并使tmp 指向该参数字符串末端。
; 148  : 		len=0;		/* 我们知道串是以NULL 字节结尾的 */

	xor	ecx, ecx
	jmp	SHORT $L907
$L1262:
	mov	ebx, DWORD PTR _tmp$[ebp]
$L907:

; 149  : 		do {
; 150  : 			len++;

	inc	ecx

; 151  : 		} while (get_fs_byte(tmp++));

	mov	DWORD PTR $T1238[ebp], ebx
	inc	ebx
	mov	DWORD PTR _tmp$[ebp], ebx

; 127  : 

	mov	ebx, DWORD PTR $T1238[ebp]

; 128  : 	if (!p)

	mov	al, BYTE PTR fs:[ebx]

; 151  : 		} while (get_fs_byte(tmp++));

	test	al, al
	jne	SHORT $L1262

; 152  : // 如果该字符串长度超过此时参数和环境空间中还剩余的空闲长度，则恢复fs 段寄存器并返回0。
; 153  : 		if (p-len < 0) {	/* 不会发生-因为有128kB 的空间 */
; 154  : 			set_fs(old_fs);
; 155  : 			return 0;
; 156  : 		}
; 157  : // 复制fs 段中当前指定的参数字符串，是从该字符串尾逆向开始复制。
; 158  : 		while (len) {

	test	ecx, ecx
	je	SHORT $L913
$L912:

; 159  : 			--p; --tmp; --len;

	mov	eax, DWORD PTR _tmp$[ebp]
	dec	edx
	dec	eax
	dec	ecx

; 160  : // 函数刚开始执行时，偏移变量offset 被初始化为0，因此若offset-1<0，说明是首次复制字符串，
; 161  : // 则令其等于p 指针在页面内的偏移值，并申请空闲页面。
; 162  : 			if (--offset < 0) {

	dec	edi
	mov	DWORD PTR _p$[ebp], edx
	mov	DWORD PTR _tmp$[ebp], eax
	mov	DWORD PTR _len$[ebp], ecx
	jns	SHORT $L1248

; 163  : 				offset = p % PAGE_SIZE;
; 164  : // 如果字符串和字符串数组在内核空间，则恢复fs 段寄存器原值。
; 165  : 				if (from_kmem==2)

	mov	eax, DWORD PTR _from_kmem$[ebp]
	mov	edi, edx
	and	edi, 4095				; 00000fffH
	cmp	eax, 2
	jne	SHORT $L1245

; 124  : 	char *tmp, *pag;
; 125  : 	int len, offset = 0;

	mov	eax, DWORD PTR _old_fs$[ebp]

; 126  : 	unsigned long old_fs, new_fs;

	mov	fs, ax

; 166  : 					set_fs(old_fs);

$L1245:

; 167  : // 如果当前偏移值p 所在的串空间页面指针数组项page[p/PAGE_SIZE]==0，表示相应页面还不存在，
; 168  : // 则需申请新的内存空闲页面，将该页面指针填入指针数组，并且也使pag 指向该新页面，若申请不
; 169  : // 到空闲页面则返回0。
; 170  : 				if (!(pag = (char *) page[p/PAGE_SIZE]) &&
; 171  : 				    !(pag = (char *) page[p/PAGE_SIZE] = 
; 172  : 				      (char *) get_free_page())) 

	mov	esi, DWORD PTR _page$[ebp]
	mov	eax, edx
	shr	eax, 12					; 0000000cH
	lea	ebx, DWORD PTR [esi+eax*4]
	mov	esi, DWORD PTR [esi+eax*4]
	test	esi, esi
	jne	SHORT $L919
	call	_get_free_page
	mov	esi, eax
	mov	DWORD PTR [ebx], eax
	test	esi, esi
	je	$L1259
	mov	edx, DWORD PTR _p$[ebp]
	mov	ecx, DWORD PTR _len$[ebp]
$L919:

; 173  : 					return 0;
; 174  : // 如果字符串和字符串数组来自内核空间，则设置fs 段寄存器指向内核数据段（ds）。
; 175  : 				if (from_kmem==2)

	cmp	DWORD PTR _from_kmem$[ebp], 2
	jne	SHORT $L1248

; 124  : 	char *tmp, *pag;
; 125  : 	int len, offset = 0;

	mov	eax, DWORD PTR _new_fs$[ebp]

; 126  : 	unsigned long old_fs, new_fs;

	mov	fs, ax

; 176  : 					set_fs(new_fs);

$L1248:

; 127  : 

	mov	ebx, DWORD PTR _tmp$[ebp]

; 128  : 	if (!p)

	mov	al, BYTE PTR fs:[ebx]

; 177  : 
; 178  : 			}
; 179  : // 从fs 段中复制参数字符串中一字节到pag+offset 处。
; 180  : 			*(pag + offset) = get_fs_byte(tmp);

	test	ecx, ecx
	mov	BYTE PTR [esi+edi], al
	jne	SHORT $L912
$L913:

; 135  : 		set_fs(new_fs);
; 136  : // 循环处理各个参数，从最后一个参数逆向开始复制，复制到指定偏移地址处。
; 137  : 	while (argc-- > 0) {

	mov	eax, DWORD PTR _argc$[ebp]
	mov	ebx, DWORD PTR -8+[ebp]
	mov	ecx, eax
	dec	eax
	sub	ebx, 4
	mov	DWORD PTR _argc$[ebp], eax
	test	ecx, ecx
	mov	DWORD PTR -8+[ebp], ebx
	jg	$L899
$L900:

; 181  : 		}
; 182  : 	}
; 183  : // 如果字符串和字符串数组在内核空间，则恢复fs 段寄存器原值。
; 184  : 	if (from_kmem==2)

	cmp	DWORD PTR _from_kmem$[ebp], 2
	jne	SHORT $L1255

; 124  : 	char *tmp, *pag;
; 125  : 	int len, offset = 0;

	mov	eax, DWORD PTR _old_fs$[ebp]

; 126  : 	unsigned long old_fs, new_fs;

	mov	fs, ax

; 185  : 		set_fs(old_fs);

$L1255:
	pop	edi
	pop	esi

; 186  : // 最后，返回参数和环境空间中已复制参数信息的头部偏移值。
; 187  : 	return p;

	mov	eax, edx
	pop	ebx

; 188  : }

	mov	esp, ebp
	pop	ebp
	ret	0
_copy_strings ENDP
_TEXT	ENDS
EXTRN	_put_page:NEAR
_TEXT	SEGMENT
$T1268 = -4
$T1272 = -8
$T1276 = -8
$T1277 = 8
$T1281 = 8
$T1285 = -12
$T1286 = 8
_text_size$ = 8
_page$ = 12
_code_base$ = -4
_data_base$ = -12
_change_ldt PROC NEAR

; 195  : {

	push	ebp
	mov	ebp, esp
	sub	esp, 12					; 0000000cH

; 204  : 	code_base = get_base(current->ldt[1]);

	mov	eax, DWORD PTR _current
	push	ebx
	add	eax, 728				; 000002d8H
	push	esi
	push	edi
	mov	DWORD PTR $T1268[ebp], eax

; 196  : 	unsigned long code_limit,data_limit,code_base,data_base;
; 197  : 	int i;
; 198  : 

	mov	ebx, DWORD PTR $T1268[ebp]

; 199  : // 根据执行文件头部a_text 值，计算以页面长度为边界的代码段限长。并设置数据段长度为64MB。

	mov	ah, BYTE PTR [ebx+7]

; 200  : 	code_limit = text_size+PAGE_SIZE -1;

	mov	al, BYTE PTR [ebx+4]

; 201  : 	code_limit &= 0xFFFFF000;

	shl	eax, 16					; 00000010H

; 202  : 	data_limit = 0x4000000;

	mov	ax, WORD PTR [ebx+2]

; 206  : // 重新设置局部表中代码段和数据段描述符的基址和段限长。
; 207  : 	set_base(current->ldt[1],code_base);

	mov	ecx, DWORD PTR _current
	mov	DWORD PTR _code_base$[ebp], eax
	add	ecx, 728				; 000002d8H
	mov	DWORD PTR _data_base$[ebp], eax
	mov	DWORD PTR $T1272[ebp], ecx

; 199  : // 根据执行文件头部a_text 值，计算以页面长度为边界的代码段限长。并设置数据段长度为64MB。

	mov	ebx, DWORD PTR $T1272[ebp]

; 200  : 	code_limit = text_size+PAGE_SIZE -1;

	mov	edx, DWORD PTR _code_base$[ebp]

; 201  : 	code_limit &= 0xFFFFF000;

	mov	WORD PTR [ebx+2], dx

; 202  : 	data_limit = 0x4000000;

	ror	edx, 16					; 00000010H

; 203  : // 取当前进程中局部描述符表代码段描述符中代码段基址，代码段基址与数据段基址相同。

	mov	BYTE PTR [ebx+4], dl

; 204  : 	code_base = get_base(current->ldt[1]);

	mov	BYTE PTR [ebx+7], dh

; 206  : // 重新设置局部表中代码段和数据段描述符的基址和段限长。
; 207  : 	set_base(current->ldt[1],code_base);

	mov	edx, DWORD PTR _text_size$[ebp]

; 208  : 	set_limit(current->ldt[1],code_limit);

	mov	ecx, DWORD PTR _current
	add	edx, 4095				; 00000fffH
	add	ecx, 728				; 000002d8H
	and	edx, -4096				; fffff000H
	mov	DWORD PTR $T1276[ebp], ecx
	dec	edx
	shr	edx, 12					; 0000000cH
	mov	DWORD PTR $T1277[ebp], edx

; 196  : 	unsigned long code_limit,data_limit,code_base,data_base;
; 197  : 	int i;
; 198  : 

	mov	ebx, DWORD PTR $T1276[ebp]

; 199  : // 根据执行文件头部a_text 值，计算以页面长度为边界的代码段限长。并设置数据段长度为64MB。

	mov	edx, DWORD PTR $T1277[ebp]

; 200  : 	code_limit = text_size+PAGE_SIZE -1;

	mov	WORD PTR [ebx], dx

; 201  : 	code_limit &= 0xFFFFF000;

	ror	edx, 16					; 00000010H

; 202  : 	data_limit = 0x4000000;

	mov	dh, BYTE PTR [ebx+6]

; 203  : // 取当前进程中局部描述符表代码段描述符中代码段基址，代码段基址与数据段基址相同。

	and	dh, -16					; fffffff0H

; 204  : 	code_base = get_base(current->ldt[1]);

	or	dl, dh

; 205  : 	data_base = code_base;

	mov	BYTE PTR [ebx+6], dl

; 209  : 	set_base(current->ldt[2],data_base);

	mov	edx, DWORD PTR _current
	add	edx, 736				; 000002e0H
	mov	DWORD PTR $T1281[ebp], edx

; 199  : // 根据执行文件头部a_text 值，计算以页面长度为边界的代码段限长。并设置数据段长度为64MB。

	mov	ebx, DWORD PTR $T1281[ebp]

; 200  : 	code_limit = text_size+PAGE_SIZE -1;

	mov	edx, DWORD PTR _data_base$[ebp]

; 201  : 	code_limit &= 0xFFFFF000;

	mov	WORD PTR [ebx+2], dx

; 202  : 	data_limit = 0x4000000;

	ror	edx, 16					; 00000010H

; 203  : // 取当前进程中局部描述符表代码段描述符中代码段基址，代码段基址与数据段基址相同。

	mov	BYTE PTR [ebx+4], dl

; 204  : 	code_base = get_base(current->ldt[1]);

	mov	BYTE PTR [ebx+7], dh

; 210  : 	set_limit(current->ldt[2],data_limit);

	mov	ecx, DWORD PTR _current
	mov	DWORD PTR $T1286[ebp], 16383		; 00003fffH
	add	ecx, 736				; 000002e0H
	mov	DWORD PTR $T1285[ebp], ecx

; 196  : 	unsigned long code_limit,data_limit,code_base,data_base;
; 197  : 	int i;
; 198  : 

	mov	ebx, DWORD PTR $T1285[ebp]

; 199  : // 根据执行文件头部a_text 值，计算以页面长度为边界的代码段限长。并设置数据段长度为64MB。

	mov	edx, DWORD PTR $T1286[ebp]

; 200  : 	code_limit = text_size+PAGE_SIZE -1;

	mov	WORD PTR [ebx], dx

; 201  : 	code_limit &= 0xFFFFF000;

	ror	edx, 16					; 00000010H

; 202  : 	data_limit = 0x4000000;

	mov	dh, BYTE PTR [ebx+6]

; 203  : // 取当前进程中局部描述符表代码段描述符中代码段基址，代码段基址与数据段基址相同。

	and	dh, -16					; fffffff0H

; 204  : 	code_base = get_base(current->ldt[1]);

	or	dl, dh

; 205  : 	data_base = code_base;

	mov	BYTE PTR [ebx+6], dl

; 211  : /* 要确信fs 段寄存器已指向新的数据段 */
; 212  : // fs 段寄存器中放入局部表数据段描述符的选择符(0x17)。
; 213  : //	__asm__("pushl $0x17\n\tpop %%fs"::);
; 214  : 	_asm {
; 215  : 		push 0x17

	push	23					; 00000017H

; 216  : 		pop fs

	pop	fs

; 210  : 	set_limit(current->ldt[2],data_limit);

	mov	edx, DWORD PTR _page$[ebp]

; 217  : 	}
; 218  : // 将参数和环境空间已存放数据的页面（共可有MAX_ARG_PAGES 页，128kB）放到数据段线性地址的
; 219  : // 末端。是调用函数put_page()进行操作的（mm/memory.c, 197）。
; 220  : 	data_base += data_limit;

	lea	edi, DWORD PTR [eax+67108864]
	mov	ebx, 32					; 00000020H
	lea	esi, DWORD PTR [edx+124]
$L942:

; 221  : 	for (i=MAX_ARG_PAGES-1 ; i>=0 ; i--) {
; 222  : 		data_base -= PAGE_SIZE;
; 223  : 		if (page[i])						// 如果该页面存在，

	mov	eax, DWORD PTR [esi]
	sub	edi, 4096				; 00001000H
	test	eax, eax
	je	SHORT $L943

; 224  : 			put_page(page[i],data_base);	// 就放置该页面。

	push	edi
	push	eax
	call	_put_page
	add	esp, 8
$L943:
	sub	esi, 4
	dec	ebx
	jne	SHORT $L942

; 225  : 	}
; 226  : 	return data_limit;		// 最后返回数据段限长(64MB)。
; 227  : }

	pop	edi
	pop	esi
	mov	eax, 67108864				; 04000000H
	pop	ebx
	mov	esp, ebp
	pop	ebp
	ret	0
_change_ldt ENDP
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
$l1$116:

; 396  :   l1: lodsb	// 取串1 字符ds:[esi]->al，并且esi++。

	lodsb

; 397  : 	  test al,al	// 该字符等于0 值吗（串1 结尾）？

	test	al, al

; 398  : 	  je l2		// 如果是，则向前跳转到标号2 处。

	je	SHORT $l2$117

; 399  : 	  mov edi,ebx	// 取串2 头指针放入edi 中。

	mov	edi, ebx

; 400  : 	  mov ecx,edx	// 再将串2 的长度值放入ecx 中。

	mov	ecx, edx

; 401  : 	  repne scasb	// 比较al 与串2 中字符es:[edi]，并且edi++。如果不相等就继续比较。

	repnz	 scasb

; 402  : 	  je l1		// 如果相等，则向后跳转到标号1 处。

	je	SHORT $l1$116
$l2$117:

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
$l1$125:

; 454  : 	l1: lodsb	// 取串1 字符ds:[esi]->al，并且esi++。

	lodsb

; 455  : 		test al,al	// 该字符等于0 值吗（串1 结尾）？

	test	al, al

; 456  : 		je l2		// 如果是，则向前跳转到标号2 处。

	je	SHORT $l2$126

; 457  : 		mov edi,ebx	// 取串2 头指针放入edi 中。

	mov	edi, ebx

; 458  : 		mov ecx,edx 	// 再将串2 的长度值放入ecx 中。

	mov	ecx, edx

; 459  : 		repne scasb	// 比较al 与串2 中字符es:[edi]，并且edi++。如果不相等就继续比较。

	repnz	 scasb

; 460  : 		jne l1		// 如果不相等，则向后跳转到标号1 处。

	jne	SHORT $l1$125
$l2$126:

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
$l1$133:

; 512  : 	l1: lodsb	// 取串1 字符ds:[esi]??al，并且esi++。

	lodsb

; 513  : 		test al,al	// 该字符等于0 值吗（串1 结尾）？

	test	al, al

; 514  : 		je l2		// 如果是，则向前跳转到标号2 处。

	je	SHORT $l2$134

; 515  : 		mov edi,ebx	// 取串2 头指针放入edi 中。

	mov	edi, ebx

; 516  : 		mov ecx,edx	// 再将串2 的长度值放入ecx 中。

	mov	ecx, edx

; 517  : 		repne scasb		// 比较al 与串2 中字符es:[edi]，并且edi++。如果不相等就继续比较。

	repnz	 scasb

; 518  : 		jne l1	// 如果不相等，则向后跳转到标号1 处。

	jne	SHORT $l1$133

; 519  : 		dec esi	// esi--，指向一个包含在串2 中的字符。

	dec	esi

; 520  : 		jmp l3		// 向前跳转到标号3 处。

	jmp	SHORT $l3$135
$l2$134:

; 521  : 	l2: xor esi,esi	// 没有找到符合条件的，将返回值为NULL。

	xor	esi, esi
$l3$135:

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
$l1$142:

; 576  : 	l1: mov edi,ebx	// 取串2 头指针放入edi 中。

	mov	edi, ebx

; 577  : 		mov ecx,edx	// 再将串2 的长度值放入ecx 中。

	mov	ecx, edx

; 578  : 		mov eax,esi	// 将串1 的指针复制到eax 中。

	mov	eax, esi

; 579  : 		repe cmpsb// 比较串1 和串2 字符(ds:[esi],es:[edi])，esi++,edi++。若对应字符相等就一直比较下去。

	rep	 cmpsb

; 580  : 		je l2

	je	SHORT $l2$143

; 581  : // 对空串同样有效，见上面 // 若全相等，则转到标号2。
; 582  : 		xchg esi,eax	// 串1 头指针->esi，比较结果的串1 指针->eax。

	xchg	esi, eax

; 583  : 		inc esi	// 串1 头指针指向下一个字符。

	inc	esi

; 584  : 		cmp [eax-1],0	// 串1 指针(eax-1)所指字节是0 吗？

	cmp	BYTE PTR [eax-1], 0

; 585  : 		jne l1	// 不是则跳转到标号1，继续从串1 的第2 个字符开始比较。

	jne	SHORT $l1$142

; 586  : 		xor eax,eax	// 清eax，表示没有找到匹配。

	xor	eax, eax
$l2$143:

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

	jne	SHORT $l1$155

; 678  : 		mov ebx,strtok

	mov	ebx, DWORD PTR _strtok

; 679  : 		test ebx,ebx	// 如果是NULL，则表示此次是后续调用，测ebx(__strtok)。

	test	ebx, ebx

; 680  : 		je l8		// 如果ebx 指针是NULL，则不能处理，跳转结束。

	je	SHORT $l8$156

; 681  : 		mov esi,ebx	// 将ebx 指针复制到esi。

	mov	esi, ebx
$l1$155:

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

	je	SHORT $l7$157

; 691  : 		mov edx,ecx	// 将串2 长度暂存入edx。

	mov	edx, ecx
$l2$158:

; 692  : 	l2: lodsb	// 取串1 的字符ds:[esi]->al，并且esi++。

	lodsb

; 693  : 		test al,al	// 该字符为0 值吗(串1 结束)？

	test	al, al

; 694  : 		je l7		// 如果是，则跳转标号7。

	je	SHORT $l7$157

; 695  : 		mov edi,ct	// edi 再次指向串2 首。

	mov	edi, DWORD PTR _ct$[ebp]

; 696  : 		mov ecx,edx	// 取串2 的长度值置入计数器ecx。

	mov	ecx, edx

; 697  : 		repne scasb// 将al 中串1 的字符与串2 中所有字符比较，判断该字符是否为分割符。

	repnz	 scasb

; 698  : 		je l2		// 若能在串2 中找到相同字符（分割符），则跳转标号2。

	je	SHORT $l2$158

; 699  : 		dec esi	// 若不是分割符，则串1 指针esi 指向此时的该字符。

	dec	esi

; 700  : 		cmp [esi],0	// 该字符是NULL 字符吗？

	cmp	BYTE PTR [esi], 0

; 701  : 		je l7		// 若是，则跳转标号7 处。

	je	SHORT $l7$157

; 702  : 		mov ebx,esi	// 将该字符的指针esi 存放在ebx。

	mov	ebx, esi
$l3$159:

; 703  : 	l3: lodsb	// 取串1 下一个字符ds:[esi]->al，并且esi++。

	lodsb

; 704  : 		test al,al	// 该字符是NULL 字符吗？

	test	al, al

; 705  : 		je l5		// 若是，表示串1 结束，跳转到标号5。

	je	SHORT $l5$160

; 706  : 		mov edi,ct	// edi 再次指向串2 首。

	mov	edi, DWORD PTR _ct$[ebp]

; 707  : 		mov ecx,edx	// 串2 长度值置入计数器ecx。

	mov	ecx, edx

; 708  : 		repne scasb // 将al 中串1 的字符与串2 中每个字符比较，测试al 字符是否是分割符。

	repnz	 scasb

; 709  : 		jne l3		// 若不是分割符则跳转标号3，检测串1 中下一个字符。

	jne	SHORT $l3$159

; 710  : 		dec esi	// 若是分割符，则esi--，指向该分割符字符。

	dec	esi

; 711  : 		cmp [esi],0	// 该分割符是NULL 字符吗？

	cmp	BYTE PTR [esi], 0

; 712  : 		je l5		// 若是，则跳转到标号5。

	je	SHORT $l5$160

; 713  : 		mov [esi],0	// 若不是，则将该分割符用NULL 字符替换掉。

	mov	BYTE PTR [esi], 0

; 714  : 		inc esi	// esi 指向串1 中下一个字符，也即剩余串首。

	inc	esi

; 715  : 		jmp l6		// 跳转标号6 处。

	jmp	SHORT $l6$161
$l5$160:

; 716  : 	l5: xor esi,esi	// esi 清零。

	xor	esi, esi
$l6$161:

; 717  : 	l6: cmp [ebx],0	// ebx 指针指向NULL 字符吗？

	cmp	BYTE PTR [ebx], 0

; 718  : 		jne l7	// 若不是，则跳转标号7。

	jne	SHORT $l7$157

; 719  : 		xor ebx,ebx	// 若是，则让ebx=NULL。

	xor	ebx, ebx
$l7$157:

; 720  : 	l7: test ebx,ebx	// ebx 指针为NULL 吗？

	test	ebx, ebx

; 721  : 		jne l8	// 若不是则跳转8，结束汇编代码。

	jne	SHORT $l8$156

; 722  : 		mov esi,ebx	// 将esi 置为NULL。

	mov	esi, ebx
$l8$156:

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
	jae	SHORT $L178

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
$L178:

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

	je	SHORT $l1$188

; 881  : 		mov eax,1	// 否则eax 置1，

	mov	eax, 1

; 882  : 		jl l1		// 若内存块2 内容的值<内存块1，则跳转标号1。

	jl	SHORT $l1$188

; 883  : 		neg eax	// 否则eax = -eax。

	neg	eax
$l1$188:

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
	jne	SHORT $L197

; 914  :     return NULL;

	xor	eax, eax

; 928  : 	}
; 929  : //  return __res;			// 返回字符指针。
; 930  : }

	pop	edi
	pop	ebp
	ret	0
$L197:

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

	je	SHORT $l1$198

; 923  : 		mov edi,1	// 否则edi 中置1。

	mov	edi, 1
$l1$198:

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

	je	SHORT $l1$742

; 278  : 		xchg ecx,current/* current = task[n]； */

	xchg	ecx, DWORD PTR _current

; 279  : 		/*执行长跳转，造成任务切换 (头大了很长时间，多多包涵)*/
; 280  : 		mov ax, __tmp

	mov	ax, WORD PTR ___tmp$[ebp]

; 281  : 		mov word ptr ds:[lcs],ax

	mov	WORD PTR ds:$lcs$743, ax

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
$lcs$743:

; 287  : lcs:	_emit 0		// cs

	DB	0

; 288  : 		_emit 0

	DB	0

; 289  : // 在任务切换回来后才会继续执行下面的语句。
; 290  : 		cmp last_task_used_math,ecx /* 新任务上次使用过协处理器吗？*/

	cmp	DWORD PTR _last_task_used_math, ecx

; 291  : 		jne l1

	jne	SHORT $l1$742

; 292  : 		clts/* 新任务上次使用过协处理器，则清cr0 的TS 标志。*/

	clts
$l1$742:

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
