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

; 39   : // ������ʺ��޸�ʱ�����ݽṹָ�벻ΪNULL����ӽṹ�ж�ȡ�û����õ�ʱ��ֵ��
; 40   : 	if (times) {

	mov	esi, DWORD PTR _times$[ebp]
	test	esi, esi
	je	SHORT $L964
	push	ebx

; 33   : 	struct m_inode * inode;
; 34   : 	long actime,modtime;
; 35   : 
; 36   : // �����ļ���Ѱ�Ҷ�Ӧ��i �ڵ㣬���û���ҵ����򷵻س����롣

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
; 36   : // �����ļ���Ѱ�Ҷ�Ӧ��i �ڵ㣬���û���ҵ����򷵻س����롣

	mov	ebx, DWORD PTR $T1106[ebp]

; 37   : 	if (!(inode=namei(filename)))

	mov	eax, DWORD PTR fs:[ebx]

; 41   : 		actime = get_fs_long((unsigned long *) &times->actime);
; 42   : 		modtime = get_fs_long((unsigned long *) &times->modtime);

	pop	ebx

; 43   : // ���򽫷��ʺ��޸�ʱ����Ϊ��ǰʱ�䡣
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

; 46   : // �޸�i �ڵ��еķ���ʱ���ֶκ��޸�ʱ���ֶΡ�
; 47   : 	inode->i_atime = actime;
; 48   : 	inode->i_mtime = modtime;
; 49   : // ��i �ڵ����޸ı�־���ͷŸýڵ㣬������0��
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
; 67   : // �������ɵ�3 λ��ɣ����������и߱���λ��
; 68   : 	mode &= 0007;
; 69   : // ����ļ�����Ӧ��i �ڵ㲻���ڣ��򷵻س����롣
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

; 72   : // ȡ�ļ��������룬���ͷŸ�i �ڵ㡣
; 73   : 	i_mode = res = inode->i_mode & 0777;

	mov	si, WORD PTR [edi]
	and	esi, 511				; 000001ffH

; 74   : 	iput(inode);

	push	edi
	mov	DWORD PTR _i_mode$[ebp], esi
	call	_iput

; 75   : // �����ǰ�����Ǹ��ļ�����������ȡ�ļ��������ԡ�
; 76   : 	if (current->uid == inode->i_uid)

	mov	ecx, DWORD PTR _current
	add	esp, 4
	mov	ax, WORD PTR [ecx+576]
	cmp	ax, WORD PTR [edi+2]

; 77   : 		res >>= 6;
; 78   : // ���������ǰ����������ļ�ͬ��һ�飬��ȡ�ļ������ԡ�
; 79   : 	else if (current->gid == inode->i_gid)

	je	SHORT $L1109
	movzx	dx, BYTE PTR [edi+12]
	cmp	WORD PTR [ecx+582], dx
	jne	SHORT $L980
$L1109:

; 80   : 		res >>= 6;

	sar	esi, 6
$L980:

; 81   : // ����ļ����Ծ��в�ѯ������λ���������ɣ�����0��
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
; 85   :  * XXX ��������������Ĳ��ԣ���Ϊ����ʵ������Ҫ������Ч�û�id ��
; 86   :  * ��ʵ�û�id����ʱ�أ���Ȼ��ŵ���suser()�������������ȷʵҪ����
; 87   :  * suser()����������Ҫ���ű����á� 
; 88   :  */
; 89   : // �����ǰ�û�id Ϊ0�������û�������������ִ��λ��0 ���ļ����Ա��κ��˷��ʣ��򷵻�0��
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

; 93   : 	// ���򷵻س����롣
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
; 104  : // ����ļ�����Ӧ��i �ڵ㲻���ڣ��򷵻س����롣
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

; 107  : // �����i �ڵ㲻��Ŀ¼��i �ڵ㣬���ͷŸýڵ㣬���س����롣
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
; 112  : // �ͷŵ�ǰ����ԭ����Ŀ¼i �ڵ㣬��ָ������õĹ���Ŀ¼i �ڵ㡣����0��
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

; 38   : 		cld		// �巽��λ��

	cld
$l1$42:

; 39   : 	l1:	lodsb	// ����DS:[esi]��1 �ֽ�->al��������esi��

	lodsb

; 40   : 		stosb		// �洢�ֽ�al->ES:[edi]��������edi��

	stosb

; 41   : 		test al,al	// �մ洢���ֽ���0��

	test	al, al

; 42   : 		jne l1	// ��������ת�����l1 �������������

	jne	SHORT $l1$42

; 43   : 		popf

	popf

; 44   : 	}
; 45   : 	return dest;			// ����Ŀ���ַ���ָ�롣

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
; 125  : // ����ļ�����Ӧ��i �ڵ㲻���ڣ��򷵻س����롣
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

; 128  : // �����i �ڵ㲻��Ŀ¼��i �ڵ㣬���ͷŸýڵ㣬���س����롣
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
; 133  : // �ͷŵ�ǰ���̵ĸ�Ŀ¼i �ڵ㣬������Ϊ����ָ��Ŀ¼����i �ڵ㣬����0��
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
; 146  : // ����ļ�����Ӧ��i �ڵ㲻���ڣ��򷵻س����롣
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

; 149  : // �����ǰ���̵���Ч�û�id �������ļ�i �ڵ���û�id�����ҵ�ǰ���̲��ǳ����û������ͷŸ�
; 150  : // �ļ�i �ڵ㣬���س����롣
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
; 155  : // ��������i �ڵ���ļ����ԣ����ø�i �ڵ����޸ı�־���ͷŸ�i �ڵ㣬����0��
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

; 111  : 		cld		// �巽��λ��

	cld

; 112  : 		repne scasb		// �Ƚ�al ��es:[edi]�ֽڣ�������edi++��

	repnz	 scasb

; 113  : 						// ֱ���ҵ�Ŀ�Ĵ�����0 ���ֽڣ���ʱedi �Ѿ�ָ���1 �ֽڡ�
; 114  : 		dec edi		// ��es:[edi]ָ��0 ֵ�ֽڡ�

	dec	edi
$l1$59:

; 115  : 	l1: lodsb	// ȡԴ�ַ����ֽ�ds:[esi]->al����esi++��

	lodsb

; 116  : 		stosb		// �����ֽڴ浽es:[edi]����edi++��

	stosb

; 117  : 		test al,al	// ���ֽ���0��

	test	al, al

; 118  : 		jne l1	// ���ǣ��������ת�����1 ���������������������

	jne	SHORT $l1$59

; 119  : 		popf

	popf

; 120  : 	}
; 121  : 	return dest;			// ����Ŀ���ַ���ָ�롣

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
; 169  : // ����ļ�����Ӧ��i �ڵ㲻���ڣ��򷵻س����롣
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

; 172  : // ����ǰ���̲��ǳ����û������ͷŸ�i �ڵ㣬���س����롣
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
; 177  : // �����ļ���Ӧi �ڵ���û�id ����id������i �ڵ��Ѿ��޸ı�־���ͷŸ�i �ڵ㣬����0��
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
; 198  : // ���û����õ�ģʽ����̵�ģʽ���������룬������ɵ��ļ�ģʽ��
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

; 200  : // �������̽ṹ���ļ��ṹָ�����飬����һ����������Ѿ�û�п�����򷵻س����롣
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

; 206  : // ����ִ��ʱ�ر��ļ����λͼ����λ��Ӧ����λ��
; 207  : 	current->close_on_exec &= ~(1<<fd);

	mov	eax, 1
	mov	ecx, edi
	shl	eax, cl
	mov	ecx, DWORD PTR [edx+636]

; 208  : // ��f ָ���ļ������鿪ʼ�������������ļ��ṹ��(������ü���Ϊ0 ����)�����Ѿ�û�п���
; 209  : // �ļ���ṹ��򷵻س����롣
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

; 215  : // �ý��̵Ķ�Ӧ�ļ�������ļ��ṹָ��ָ�����������ļ��ṹ�����������ü�������1��
; 216  : 	(current->filp[fd]=f)->f_count++;

	inc	WORD PTR [esi+4]

; 217  : // ���ú���ִ�д򿪲�����������ֵС��0����˵�������ͷŸ����뵽���ļ��ṹ�����س����롣
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
; 223  : /* ttys ��Щ���⣨ttyxx ����==4��tty ����==5��*/
; 224  : // ������ַ��豸�ļ�����ô����豸����4 �Ļ��������õ�ǰ���̵�tty ��Ϊ��i �ڵ�����豸�š�
; 225  : // �����õ�ǰ����tty ��Ӧ��tty ����ĸ�������ŵ��ڽ��̵ĸ�������š�
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
; 232  : // ����������ַ��ļ��豸����5 �Ļ�������ǰ����û��tty����˵�������ͷ�i �ڵ�����뵽��
; 233  : // �ļ��ṹ�����س����롣
; 234  : 		} else if (MAJOR(inode->i_zone[0])==5)

	mov	eax, DWORD PTR _inode$[ebp]
$L1048:

; 240  : 			}
; 241  : /* ͬ�����ڿ��豸�ļ�����Ҫ�����Ƭ�Ƿ񱻸��� */
; 242  : // ����򿪵��ǿ��豸�ļ���������Ƭ�Ƿ����������������Ҫ�Ǹ��ٻ����ж�Ӧ���豸������
; 243  : // �����ʧЧ��
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

; 246  : // ��ʼ���ļ��ṹ�����ļ��ṹ���Ժͱ�־���þ�����ü���Ϊ1������i �ڵ��ֶΣ��ļ���дָ��
; 247  : // ��ʼ��Ϊ0�������ļ������
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
; 232  : // ����������ַ��ļ��豸����5 �Ļ�������ǰ����û��tty����˵�������ͷ�i �ڵ�����뵽��
; 233  : // �ļ��ṹ�����س����롣
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

; 195  : //  register int __res;	// __res �ǼĴ�������(eax)��
; 196  :   _asm{
; 197  : 	  pushf

	pushf

; 198  : 	  mov edi,csrc

	mov	edi, DWORD PTR _csrc$[ebp]

; 199  : 	  mov esi,ct

	mov	esi, DWORD PTR _ct$[ebp]

; 200  : 	  cld		// �巽��λ��

	cld
$l1$76:

; 201  :   l1: lodsb	// ȡ�ַ���2 ���ֽ�ds:[esi]??al������esi++��

	lodsb

; 202  : 	  scasb		// al ���ַ���1 ���ֽ�es:[edi]���Ƚϣ�����edi++��

	scasb

; 203  : 	  jne l2		// �������ȣ�����ǰ��ת�����2��

	jne	SHORT $l2$77

; 204  : 	  test al,al	// ���ֽ���0 ֵ�ֽ����ַ�����β����

	test	al, al

; 205  : 	  jne l1		// ���ǣ��������ת�����1�������Ƚϡ�

	jne	SHORT $l1$76

; 206  : 	  xor eax,eax	// �ǣ��򷵻�ֵeax ���㣬

	xor	eax, eax

; 207  : 	  jmp l3		// ��ǰ��ת�����3��������

	jmp	SHORT $l3$78
$l2$77:

; 208  :   l2: mov eax,1	// eax ����1��

	mov	eax, 1

; 209  : 	  jl l3		// ��ǰ��Ƚ��д�2 �ַ�<��1 �ַ����򷵻���ֵ��������

	jl	SHORT $l3$78

; 210  : 	  neg eax	// ����eax = -eax�����ظ�ֵ��������

	neg	eax
$l3$78:

; 211  : //  l3: mov __res,eax
; 212  :   l3: popf

	popf

; 213  :   }
; 214  : //  return __res;			// ���رȽϽ����
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

; 383  :   register char *__res;	// __res �ǼĴ�������(esi)��
; 384  :   _asm{
; 385  : 	  pushf

	pushf

; 386  : 	  xor al,al

	xor	al, al

; 387  : 	  mov ebx,ct

	mov	ebx, DWORD PTR _ct$[ebp]

; 388  : 	  mov edi,ebx	// ���ȼ��㴮2 �ĳ��ȡ���2 ָ�����edi �С�

	mov	edi, ebx

; 389  : 	  mov ecx,0xffffffff

	mov	ecx, -1

; 390  : 	  cld		// �巽��λ��

	cld

; 391  : 	  repne scasb// �Ƚ�al(0)�봮2 �е��ַ���es:[edi]������edi++���������Ⱦͼ����Ƚ�(ecx �𲽵ݼ�)��

	repnz	 scasb

; 392  : 	  not ecx	// ecx ��ÿλȡ����

	not	ecx

; 393  : 	  dec ecx	// ecx--���ô�2 �ĳ���ֵ��-> ecx

	dec	ecx

; 394  : 	  mov edx,ecx	// ����2 �ĳ���ֵ�ݷ���edx �С�

	mov	edx, ecx

; 395  : 	  mov esi,csrc

	mov	esi, DWORD PTR _csrc$[ebp]
$l1$114:

; 396  :   l1: lodsb	// ȡ��1 �ַ�ds:[esi]->al������esi++��

	lodsb

; 397  : 	  test al,al	// ���ַ�����0 ֵ�𣨴�1 ��β����

	test	al, al

; 398  : 	  je l2		// ����ǣ�����ǰ��ת�����2 ����

	je	SHORT $l2$115

; 399  : 	  mov edi,ebx	// ȡ��2 ͷָ�����edi �С�

	mov	edi, ebx

; 400  : 	  mov ecx,edx	// �ٽ���2 �ĳ���ֵ����ecx �С�

	mov	ecx, edx

; 401  : 	  repne scasb	// �Ƚ�al �봮2 ���ַ�es:[edi]������edi++���������Ⱦͼ����Ƚϡ�

	repnz	 scasb

; 402  : 	  je l1		// �����ȣ��������ת�����1 ����

	je	SHORT $l1$114
$l2$115:

; 403  :   l2: dec esi	// esi--��ָ�����һ�������ڴ�2 �е��ַ���

	dec	esi

; 404  : 	  mov __res,esi

	mov	DWORD PTR ___res$[ebp], esi

; 405  : 	  popf

	popf

; 406  :   }
; 407  :   return __res - csrc;		// �����ַ����еĳ���ֵ��

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
; 271  : // ���ļ����ֵ���ڳ���ͬʱ�ܴ򿪵��ļ������򷵻س����롣
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

; 274  : // ��λ���̵�ִ��ʱ�ر��ļ����λͼ��Ӧλ��
; 275  : 	current->close_on_exec &= ~(1<<fd);

	mov	eax, DWORD PTR _current
	mov	edx, 1
	shl	edx, cl
	mov	esi, DWORD PTR [eax+636]
	not	edx
	and	esi, edx
	mov	DWORD PTR [eax+636], esi

; 276  : // �����ļ������Ӧ���ļ��ṹָ����NULL���򷵻س����롣
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

; 279  : // �ø��ļ�������ļ��ṹָ��ΪNULL��
; 280  : 	current->filp[fd] = NULL;
; 281  : // ���ڹر��ļ�֮ǰ����Ӧ�ļ��ṹ�еľ�����ü����Ѿ�Ϊ0����˵���ں˳���������
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

; 284  : // ���򽫶�Ӧ�ļ��ṹ�ľ�����ü�����1���������Ϊ0���򷵻�0���ɹ��������ѵ���0��˵����
; 285  : // �ļ��Ѿ�û�о�����ã����ͷŸ��ļ�i �ڵ㣬����0��
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

; 441  :   register char *__res;	// __res �ǼĴ�������(esi)��
; 442  : 	_asm{
; 443  : 		pushf

	pushf

; 444  : 		xor al,al

	xor	al, al

; 445  : 		mov ecx,0xffffffff

	mov	ecx, -1

; 446  : 		mov ebx,ct

	mov	ebx, DWORD PTR _ct$[ebp]

; 447  : 		mov edi,ebx	// ���ȼ��㴮2 �ĳ��ȡ���2 ָ�����edi �С�

	mov	edi, ebx

; 448  : 		cld		// �巽��λ��

	cld

; 449  : 		repne scasb// �Ƚ�al(0)�봮2 �е��ַ���es:[edi]������edi++���������Ⱦͼ����Ƚ�(ecx �𲽵ݼ�)��

	repnz	 scasb

; 450  : 		not ecx	// ecx ��ÿλȡ����

	not	ecx

; 451  : 		dec ecx	// ecx--���ô�2 �ĳ���ֵ��

	dec	ecx

; 452  : 		mov edx,ecx	// ����2 �ĳ���ֵ�ݷ���edx �С�

	mov	edx, ecx

; 453  : 		mov esi,csrc

	mov	esi, DWORD PTR _csrc$[ebp]
$l1$123:

; 454  : 	l1: lodsb	// ȡ��1 �ַ�ds:[esi]->al������esi++��

	lodsb

; 455  : 		test al,al	// ���ַ�����0 ֵ�𣨴�1 ��β����

	test	al, al

; 456  : 		je l2		// ����ǣ�����ǰ��ת�����2 ����

	je	SHORT $l2$124

; 457  : 		mov edi,ebx	// ȡ��2 ͷָ�����edi �С�

	mov	edi, ebx

; 458  : 		mov ecx,edx 	// �ٽ���2 �ĳ���ֵ����ecx �С�

	mov	ecx, edx

; 459  : 		repne scasb	// �Ƚ�al �봮2 ���ַ�es:[edi]������edi++���������Ⱦͼ����Ƚϡ�

	repnz	 scasb

; 460  : 		jne l1		// �������ȣ��������ת�����1 ����

	jne	SHORT $l1$123
$l2$124:

; 461  : 	l2: dec esi

	dec	esi

; 462  : 		mov __res,esi	// esi--��ָ�����һ�������ڴ�2 �е��ַ���

	mov	DWORD PTR ___res$[ebp], esi

; 463  : 		popf

	popf

; 464  : 	}
; 465  :   return __res - csrc;		// �����ַ����еĳ���ֵ��

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

; 499  : //  register char *__res;	// __res �ǼĴ�������(esi)��
; 500  : 	_asm{
; 501  : 		pushf

	pushf

; 502  : 		xor al,al

	xor	al, al

; 503  : 		mov ebx,ct

	mov	ebx, DWORD PTR _ct$[ebp]

; 504  : 		mov edi,ebx	// ���ȼ��㴮2 �ĳ��ȡ���2 ָ�����edi �С�

	mov	edi, ebx

; 505  : 		mov ecx,0xffffffff

	mov	ecx, -1

; 506  : 		cld		// �巽��λ��

	cld

; 507  : 		repne scasb// �Ƚ�al(0)�봮2 �е��ַ���es:[edi]������edi++���������Ⱦͼ����Ƚ�(ecx �𲽵ݼ�)��

	repnz	 scasb

; 508  : 		not ecx	// ecx ��ÿλȡ����

	not	ecx

; 509  : 		dec ecx	// ecx--���ô�2 �ĳ���ֵ��

	dec	ecx

; 510  : 		mov edx,ecx	// ����2 �ĳ���ֵ�ݷ���edx �С�

	mov	edx, ecx

; 511  : 		mov esi,csrc

	mov	esi, DWORD PTR _csrc$[ebp]
$l1$131:

; 512  : 	l1: lodsb	// ȡ��1 �ַ�ds:[esi]??al������esi++��

	lodsb

; 513  : 		test al,al	// ���ַ�����0 ֵ�𣨴�1 ��β����

	test	al, al

; 514  : 		je l2		// ����ǣ�����ǰ��ת�����2 ����

	je	SHORT $l2$132

; 515  : 		mov edi,ebx	// ȡ��2 ͷָ�����edi �С�

	mov	edi, ebx

; 516  : 		mov ecx,edx	// �ٽ���2 �ĳ���ֵ����ecx �С�

	mov	ecx, edx

; 517  : 		repne scasb		// �Ƚ�al �봮2 ���ַ�es:[edi]������edi++���������Ⱦͼ����Ƚϡ�

	repnz	 scasb

; 518  : 		jne l1	// �������ȣ��������ת�����1 ����

	jne	SHORT $l1$131

; 519  : 		dec esi	// esi--��ָ��һ�������ڴ�2 �е��ַ���

	dec	esi

; 520  : 		jmp l3		// ��ǰ��ת�����3 ����

	jmp	SHORT $l3$133
$l2$132:

; 521  : 	l2: xor esi,esi	// û���ҵ����������ģ�������ֵΪNULL��

	xor	esi, esi
$l3$133:

; 522  : //	l3: mov __res,esi
; 523  : 	l3: mov eax,esi

	mov	eax, esi

; 524  : 		popf

	popf

; 525  : 	}
; 526  : //  return __res;			// ����ָ��ֵ��
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

; 562  : //  register char *__res;	// __res �ǼĴ�������(eax)��
; 563  : 	_asm {
; 564  : 		pushf

	pushf

; 565  : 		mov ebx,ct

	mov	ebx, DWORD PTR _ct$[ebp]

; 566  : 		mov edi,ebx	// ���ȼ��㴮2 �ĳ��ȡ���2 ָ�����edi �С�

	mov	edi, ebx

; 567  : 		mov ecx,0xffffffff

	mov	ecx, -1

; 568  : 		xor al,al	// al = 0

	xor	al, al

; 569  : 		cld 		// �巽��λ��

	cld

; 570  : 		repne scasb// �Ƚ�al(0)�봮2 �е��ַ���es:[edi]������edi++���������Ⱦͼ����Ƚ�(ecx �𲽵ݼ�)��

	repnz	 scasb

; 571  : 		not ecx	// ecx ��ÿλȡ����

	not	ecx

; 572  : 		dec ecx

	dec	ecx

; 573  : // ע�⣡���������Ϊ�գ�������Z ��־ // �ô�2 �ĳ���ֵ��
; 574  : 		mov edx,ecx	// ����2 �ĳ���ֵ�ݷ���edx �С�

	mov	edx, ecx

; 575  : 		mov esi,csrc

	mov	esi, DWORD PTR _csrc$[ebp]
$l1$140:

; 576  : 	l1: mov edi,ebx	// ȡ��2 ͷָ�����edi �С�

	mov	edi, ebx

; 577  : 		mov ecx,edx	// �ٽ���2 �ĳ���ֵ����ecx �С�

	mov	ecx, edx

; 578  : 		mov eax,esi	// ����1 ��ָ�븴�Ƶ�eax �С�

	mov	eax, esi

; 579  : 		repe cmpsb// �Ƚϴ�1 �ʹ�2 �ַ�(ds:[esi],es:[edi])��esi++,edi++������Ӧ�ַ���Ⱦ�һֱ�Ƚ���ȥ��

	rep	 cmpsb

; 580  : 		je l2

	je	SHORT $l2$141

; 581  : // �Կմ�ͬ����Ч�������� // ��ȫ��ȣ���ת�����2��
; 582  : 		xchg esi,eax	// ��1 ͷָ��->esi���ȽϽ���Ĵ�1 ָ��->eax��

	xchg	esi, eax

; 583  : 		inc esi	// ��1 ͷָ��ָ����һ���ַ���

	inc	esi

; 584  : 		cmp [eax-1],0	// ��1 ָ��(eax-1)��ָ�ֽ���0 ��

	cmp	BYTE PTR [eax-1], 0

; 585  : 		jne l1	// ��������ת�����1�������Ӵ�1 �ĵ�2 ���ַ���ʼ�Ƚϡ�

	jne	SHORT $l1$140

; 586  : 		xor eax,eax	// ��eax����ʾû���ҵ�ƥ�䡣

	xor	eax, eax
$l2$141:

; 587  : //	l2: mov __res,eax
; 588  : 	l2:	popf

	popf

; 589  : 	}
; 590  : //  return __res;			// ���رȽϽ����
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

; 628  : //  register int __res;	// __res �ǼĴ�������(ecx)��
; 629  : 	_asm{
; 630  : 		pushf

	pushf

; 631  : 		mov edi,s

	mov	edi, DWORD PTR _s$[ebp]

; 632  : 		mov ecx,0xffffffff

	mov	ecx, -1

; 633  : 		xor al,al

	xor	al, al

; 634  : 		cld		// �巽��λ��

	cld

; 635  : 		repne scasb		// al(0)���ַ������ַ�es:[edi]�Ƚϣ�������Ⱦ�һֱ�Ƚϡ�

	repnz	 scasb

; 636  : 		not ecx	// ecx ȡ����

	not	ecx

; 637  : 		dec ecx		// ecx--�����ַ����ó���ֵ��

	dec	ecx

; 638  : //		mov __res,ecx
; 639  : 		mov eax,ecx

	mov	eax, ecx

; 640  : 		popf

	popf

; 641  : 	}
; 642  : //  return __res;			// �����ַ�������ֵ��
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

; 676  : 		test esi,esi	// ���Ȳ���esi(�ַ���1 ָ��s)�Ƿ���NULL��

	test	esi, esi

; 677  : 		jne l1		// ������ǣ���������״ε��ñ���������ת���1��

	jne	SHORT $l1$153

; 678  : 		mov ebx,strtok

	mov	ebx, DWORD PTR _strtok

; 679  : 		test ebx,ebx	// �����NULL�����ʾ�˴��Ǻ������ã���ebx(__strtok)��

	test	ebx, ebx

; 680  : 		je l8		// ���ebx ָ����NULL�����ܴ�����ת������

	je	SHORT $l8$154

; 681  : 		mov esi,ebx	// ��ebx ָ�븴�Ƶ�esi��

	mov	esi, ebx
$l1$153:

; 682  : 	l1: xor ebx,ebx	// ��ebx ָ�롣

	xor	ebx, ebx

; 683  : 		mov edi,ct	// �������ַ���2 �ĳ��ȡ�edi ָ���ַ���2��

	mov	edi, DWORD PTR _ct$[ebp]

; 684  : 		mov ecx,0xffffffff 	// ��ecx = 0xffffffff��

	mov	ecx, -1

; 685  : 		xor eax,eax	// ����eax��

	xor	eax, eax

; 686  : 		cld

	cld

; 687  : 		repne scasb// ��al(0)��es:[edi]�Ƚϣ�����edi++��ֱ���ҵ��ַ���2 �Ľ���null �ַ��������ecx==0��

	repnz	 scasb

; 688  : 		not ecx	// ��ecx ȡ����

	not	ecx

; 689  : 		dec ecx	// ecx--���õ��ַ���2 �ĳ���ֵ��

	dec	ecx

; 690  : 		je l7	// �ָ���ַ����� // ����2 ����Ϊ0����ת���7��

	je	SHORT $l7$155

; 691  : 		mov edx,ecx	// ����2 �����ݴ���edx��

	mov	edx, ecx
$l2$156:

; 692  : 	l2: lodsb	// ȡ��1 ���ַ�ds:[esi]->al������esi++��

	lodsb

; 693  : 		test al,al	// ���ַ�Ϊ0 ֵ��(��1 ����)��

	test	al, al

; 694  : 		je l7		// ����ǣ�����ת���7��

	je	SHORT $l7$155

; 695  : 		mov edi,ct	// edi �ٴ�ָ��2 �ס�

	mov	edi, DWORD PTR _ct$[ebp]

; 696  : 		mov ecx,edx	// ȡ��2 �ĳ���ֵ���������ecx��

	mov	ecx, edx

; 697  : 		repne scasb// ��al �д�1 ���ַ��봮2 �������ַ��Ƚϣ��жϸ��ַ��Ƿ�Ϊ�ָ����

	repnz	 scasb

; 698  : 		je l2		// �����ڴ�2 ���ҵ���ͬ�ַ����ָ����������ת���2��

	je	SHORT $l2$156

; 699  : 		dec esi	// �����Ƿָ������1 ָ��esi ָ���ʱ�ĸ��ַ���

	dec	esi

; 700  : 		cmp [esi],0	// ���ַ���NULL �ַ���

	cmp	BYTE PTR [esi], 0

; 701  : 		je l7		// ���ǣ�����ת���7 ����

	je	SHORT $l7$155

; 702  : 		mov ebx,esi	// �����ַ���ָ��esi �����ebx��

	mov	ebx, esi
$l3$157:

; 703  : 	l3: lodsb	// ȡ��1 ��һ���ַ�ds:[esi]->al������esi++��

	lodsb

; 704  : 		test al,al	// ���ַ���NULL �ַ���

	test	al, al

; 705  : 		je l5		// ���ǣ���ʾ��1 ��������ת�����5��

	je	SHORT $l5$158

; 706  : 		mov edi,ct	// edi �ٴ�ָ��2 �ס�

	mov	edi, DWORD PTR _ct$[ebp]

; 707  : 		mov ecx,edx	// ��2 ����ֵ���������ecx��

	mov	ecx, edx

; 708  : 		repne scasb // ��al �д�1 ���ַ��봮2 ��ÿ���ַ��Ƚϣ�����al �ַ��Ƿ��Ƿָ����

	repnz	 scasb

; 709  : 		jne l3		// �����Ƿָ������ת���3����⴮1 ����һ���ַ���

	jne	SHORT $l3$157

; 710  : 		dec esi	// ���Ƿָ������esi--��ָ��÷ָ���ַ���

	dec	esi

; 711  : 		cmp [esi],0	// �÷ָ����NULL �ַ���

	cmp	BYTE PTR [esi], 0

; 712  : 		je l5		// ���ǣ�����ת�����5��

	je	SHORT $l5$158

; 713  : 		mov [esi],0	// �����ǣ��򽫸÷ָ����NULL �ַ��滻����

	mov	BYTE PTR [esi], 0

; 714  : 		inc esi	// esi ָ��1 ����һ���ַ���Ҳ��ʣ�മ�ס�

	inc	esi

; 715  : 		jmp l6		// ��ת���6 ����

	jmp	SHORT $l6$159
$l5$158:

; 716  : 	l5: xor esi,esi	// esi ���㡣

	xor	esi, esi
$l6$159:

; 717  : 	l6: cmp [ebx],0	// ebx ָ��ָ��NULL �ַ���

	cmp	BYTE PTR [ebx], 0

; 718  : 		jne l7	// �����ǣ�����ת���7��

	jne	SHORT $l7$155

; 719  : 		xor ebx,ebx	// ���ǣ�����ebx=NULL��

	xor	ebx, ebx
$l7$155:

; 720  : 	l7: test ebx,ebx	// ebx ָ��ΪNULL ��

	test	ebx, ebx

; 721  : 		jne l8	// ����������ת8�����������롣

	jne	SHORT $l8$154

; 722  : 		mov esi,ebx	// ��esi ��ΪNULL��

	mov	esi, ebx
$l8$154:

; 723  : //	l8: mov __res,esi
; 724  : 	l8: mov eax,esi

	mov	eax, esi

; 725  : 		popf

	popf

; 726  : 	}
; 727  : //  return __res;			// ����ָ����token ��ָ�롣
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

; 799  : 		cld		// �巽��λ��

	cld

; 800  : 		rep movsb	// �ظ�ִ�и���ecx ���ֽڣ���ds:[esi]��es:[edi]��esi++��edi++��

	rep	 movsb

; 801  : 		popf

	popf

; 802  : 	}
; 803  : 	return dest;			// ����Ŀ�ĵ�ַ��

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

; 829  : 		cld		// �巽��λ��

	cld

; 830  : 		rep movsb// ��ds:[esi]��es:[edi]������esi++��edi++���ظ�ִ�и���ecx �ֽڡ�

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

; 841  : 		std		// �÷���λ����ĩ�˿�ʼ���ơ�

	std

; 842  : 		rep movsb// ��ds:[esi]��es:[edi]������esi--��edi--������ecx ���ֽڡ�

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

; 871  : //  register int __res; //__asm__ ("ax")	 __res �ǼĴ���������
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

; 878  : 		cld		// �巽��λ��

	cld

; 879  : 		repe cmpsb// �Ƚ�ds:[esi]��es:[edi]�����ݣ�����esi++��edi++�����������ظ���

	rep	 cmpsb

; 880  : 		je l1		// �������ͬ������ת�����1������0(eax)ֵ

	je	SHORT $l1$186

; 881  : 		mov eax,1	// ����eax ��1��

	mov	eax, 1

; 882  : 		jl l1		// ���ڴ��2 ���ݵ�ֵ<�ڴ��1������ת���1��

	jl	SHORT $l1$186

; 883  : 		neg eax	// ����eax = -eax��

	neg	eax
$l1$186:

; 884  : //	l1: mov __res,eax
; 885  : 	l1:	popf

	popf

; 886  : 	}
; 887  : //  return __res;			// ���رȽϽ����
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

; 912  : //  register void *__res;	// __res �ǼĴ���������
; 913  :   if (!count)			// ����ڴ�鳤��==0���򷵻�NULL��û���ҵ���

	mov	eax, DWORD PTR _count$[ebp]
	push	edi
	test	eax, eax
	jne	SHORT $L195

; 914  :     return NULL;

	xor	eax, eax

; 928  : 	}
; 929  : //  return __res;			// �����ַ�ָ�롣
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

; 920  : 		cld		// �巽��λ��

	cld

; 921  : 		repne scasb// al ���ַ���es:[edi]�ַ����Ƚϣ�����edi++�������������ظ�ִ��������䣬

	repnz	 scasb

; 922  : 		je l1		// ����������ǰ��ת�����1 ����

	je	SHORT $l1$196

; 923  : 		mov edi,1	// ����edi ����1��

	mov	edi, 1
$l1$196:

; 924  : 	l1: dec edi	// ��edi ָ���ҵ����ַ�������NULL����

	dec	edi

; 925  : //		mov __res,edi
; 926  : 		mov eax,edi

	mov	eax, edi

; 927  : 		popf

	popf

; 928  : 	}
; 929  : //  return __res;			// �����ַ�ָ�롣
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

; 958  : 		cld		// �巽��λ��

	cld

; 959  : 		rep stosb// ��al ���ַ�����es:[edi]�У�����edi++���ظ�ecx ָ���Ĵ�����ִ��

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

; 276  : 		cmp ecx, current/* ����n �ǵ�ǰ������?(current ==task[n]?) */ 

	cmp	ecx, DWORD PTR _current

; 277  : 		je l1 /* �ǣ���ʲô���������˳���*/ 

	je	SHORT $l1$746

; 278  : 		xchg ecx,current/* current = task[n]�� */

	xchg	ecx, DWORD PTR _current

; 279  : 		/*ִ�г���ת����������л� (ͷ���˺ܳ�ʱ�䣬������)*/
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

; 289  : // �������л�������Ż����ִ���������䡣
; 290  : 		cmp last_task_used_math,ecx /* �������ϴ�ʹ�ù�Э��������*/

	cmp	DWORD PTR _last_task_used_math, ecx

; 291  : 		jne l1

	jne	SHORT $l1$746

; 292  : 		clts/* �������ϴ�ʹ�ù�Э������������cr0 ��TS ��־��*/

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
