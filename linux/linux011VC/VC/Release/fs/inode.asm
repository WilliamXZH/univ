	TITLE	..\fs\inode.c
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
;	COMDAT __set_tssldt_desc
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
FLAT	GROUP _DATA, CONST, _BSS
	ASSUME	CS: FLAT, DS: FLAT, SS: FLAT
endif
PUBLIC	_inode_table
_BSS	SEGMENT
_inode_table DB	0700H DUP (?)
_BSS	ENDS
_DATA	SEGMENT
_?last_inode@?1??get_empty_inode@@9@9 DD FLAT:_inode_table
_DATA	ENDS
PUBLIC	_invalidate_inodes
EXTRN	_sleep_on:NEAR
EXTRN	_printk:NEAR
_DATA	SEGMENT
$SG817	DB	'inode in use on removed disk', 0aH, 0dH, 00H
_DATA	ENDS
_TEXT	SEGMENT
_dev$ = 8
_invalidate_inodes PROC NEAR

; 55   : {

	push	ebp
	mov	ebp, esp
	push	ecx
	push	ebx
	push	esi
	push	edi

; 57   : 	struct m_inode * inode;
; 58   : 
; 59   : 	inode = 0+inode_table;		// ��ָ������ָ��i �ڵ��ָ���������

	mov	esi, OFFSET FLAT:_inode_table+50
	mov	DWORD PTR -4+[ebp], 32			; 00000020H
	xor	ebx, ebx
$L812:

; 56   : 	int i;

	cli

; 60   : 	for(i=0 ; i<NR_INODE ; i++,inode++) {	// ɨ��i �ڵ��ָ�������е�����i �ڵ㡣
; 61   : 		wait_on_inode(inode);				// �ȴ���i �ڵ���ã���������

	cmp	BYTE PTR [esi], bl
	je	SHORT $L1003
	lea	edi, DWORD PTR [esi-18]
$L1002:
	push	edi
	call	_sleep_on
	mov	al, BYTE PTR [esi]
	add	esp, 4
	cmp	al, bl
	jne	SHORT $L1002
$L1003:

; 57   : 	struct m_inode * inode;
; 58   : 
; 59   : 	inode = 0+inode_table;		// ��ָ������ָ��i �ڵ��ָ���������

	sti

; 62   : 		if (inode->i_dev == dev) {			// �����ָ���豸��i �ڵ㣬��

	mov	ecx, DWORD PTR _dev$[ebp]
	xor	eax, eax
	mov	ax, WORD PTR [esi-6]
	cmp	eax, ecx
	jne	SHORT $L813

; 63   : 			if (inode->i_count)				// �������������Ϊ0������ʾ�����棻

	cmp	WORD PTR [esi-2], bx
	je	SHORT $L816

; 64   : 				printk("inode in use on removed disk\n\r");

	push	OFFSET FLAT:$SG817
	call	_printk
	add	esp, 4
$L816:

; 65   : 			inode->i_dev = inode->i_dirt = 0;	// �ͷŸ�i �ڵ�(���豸��Ϊ0 ��)��

	mov	BYTE PTR [esi+1], bl
	mov	WORD PTR [esi-6], bx
$L813:
	mov	eax, DWORD PTR -4+[ebp]
	add	esi, 56					; 00000038H
	dec	eax
	mov	DWORD PTR -4+[ebp], eax
	jne	SHORT $L812
	pop	edi
	pop	esi
	pop	ebx

; 66   : 		}
; 67   : 	}
; 68   : }

	mov	esp, ebp
	pop	ebp
	ret	0
_invalidate_inodes ENDP
_TEXT	ENDS
PUBLIC	_sync_inodes
_TEXT	SEGMENT
_sync_inodes PROC NEAR

; 73   : {

	push	ebx
	push	esi
	push	edi

; 75   : 	struct m_inode * inode;
; 76   : 
; 77   : 	inode = 0+inode_table;		// ��ָ������ָ��i �ڵ��ָ���������

	mov	esi, OFFSET FLAT:_inode_table+50
	mov	ebx, 32					; 00000020H
$L822:

; 74   : 	int i;

	cli

; 78   : 	for(i=0 ; i<NR_INODE ; i++,inode++) {	// ɨ��i �ڵ��ָ�����顣
; 79   : 		wait_on_inode(inode);				// �ȴ���i �ڵ���ã���������

	cmp	BYTE PTR [esi], 0
	je	SHORT $L1013
	lea	edi, DWORD PTR [esi-18]
$L1012:
	push	edi
	call	_sleep_on
	mov	al, BYTE PTR [esi]
	add	esp, 4
	test	al, al
	jne	SHORT $L1012
$L1013:

; 75   : 	struct m_inode * inode;
; 76   : 
; 77   : 	inode = 0+inode_table;		// ��ָ������ָ��i �ڵ��ָ���������

	sti

; 80   : 		if (inode->i_dirt && !inode->i_pipe)	// �����i �ڵ����޸��Ҳ��ǹܵ��ڵ㣬

	mov	al, BYTE PTR [esi+1]
	test	al, al
	je	SHORT $L823
	mov	al, BYTE PTR [esi+2]
	test	al, al
	jne	SHORT $L823

; 81   : 			write_inode(inode);					// ��д�̡�

	lea	eax, DWORD PTR [esi-50]
	push	eax
	call	_write_inode
	add	esp, 4
$L823:
	add	esi, 56					; 00000038H
	dec	ebx
	jne	SHORT $L822
	pop	edi
	pop	esi
	pop	ebx

; 82   : 	}
; 83   : }

	ret	0
_sync_inodes ENDP
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
PUBLIC	_bmap
_TEXT	SEGMENT
_inode$ = 8
_block$ = 12
_bmap	PROC NEAR

; 192  : {

	push	ebp
	mov	ebp, esp

; 193  : 	return _bmap(inode,block,0);

	mov	eax, DWORD PTR _block$[ebp]
	mov	ecx, DWORD PTR _inode$[ebp]
	push	0
	push	eax
	push	ecx
	call	__bmap
	add	esp, 12					; 0000000cH

; 194  : }

	pop	ebp
	ret	0
_bmap	ENDP
_TEXT	ENDS
EXTRN	_brelse:NEAR
EXTRN	_bread:NEAR
EXTRN	_new_block:NEAR
EXTRN	_panic:NEAR
EXTRN	_jiffies:DWORD
EXTRN	_startup_time:DWORD
_DATA	SEGMENT
	ORG $+1
$SG837	DB	'_bmap: block<0', 00H
	ORG $+1
$SG839	DB	'_bmap: block>big', 00H
_DATA	ENDS
_TEXT	SEGMENT
_inode$ = 8
_block$ = 12
_create$ = 16
__bmap	PROC NEAR

; 90   : {

	push	ebp
	mov	ebp, esp
	push	ebx
	push	esi
	push	edi

; 91   : 	struct buffer_head * bh;
; 92   : 	int i;
; 93   : 
; 94   : // ������С��0����������
; 95   : 	if (block<0)

	mov	edi, DWORD PTR _block$[ebp]
	test	edi, edi
	jge	SHORT $L836

; 96   : 		panic("_bmap: block<0");

	push	OFFSET FLAT:$SG837
	call	_panic
	add	esp, 4
$L836:

; 97   : // �����Ŵ���ֱ�ӿ���+ ��ӿ���+ ���μ�ӿ����������ļ�ϵͳ��ʾ��Χ����������
; 98   : 	if (block >= 7+512+512*512)

	cmp	edi, 262663				; 00040207H
	jl	SHORT $L838

; 99   : 		panic("_bmap: block>big");

	push	OFFSET FLAT:$SG839
	call	_panic
	add	esp, 4
$L838:

; 100  : // ����ÿ��С��7����ʹ��ֱ�ӿ��ʾ��
; 101  : 	if (block<7) {

	cmp	edi, 7
	jge	SHORT $L840

; 102  : // ���������־��λ������i �ڵ��ж�Ӧ�ÿ���߼��飨���Σ��ֶ�Ϊ0��������Ӧ�豸����һ����
; 103  : // �飨�߼��飬���飩�����������߼���ţ��̿�ţ������߼����ֶ��С�Ȼ������i �ڵ��޸�ʱ�䣬
; 104  : // ��i �ڵ����޸ı�־����󷵻��߼���š�
; 105  : 		if (create && !inode->i_zone[block])

	mov	eax, DWORD PTR _create$[ebp]
	mov	esi, DWORD PTR _inode$[ebp]
	test	eax, eax
	je	SHORT $L842
	cmp	WORD PTR [esi+edi*2+14], 0
	jne	SHORT $L842

; 106  : 			if (inode->i_zone[block]=new_block(inode->i_dev)) {

	xor	eax, eax
	mov	ax, WORD PTR [esi+44]
	push	eax
	call	_new_block
	add	esp, 4
	mov	WORD PTR [esi+edi*2+14], ax
	test	ax, ax
	je	SHORT $L842

; 107  : 				inode->i_ctime=CURRENT_TIME;

	mov	ecx, DWORD PTR _jiffies
	mov	eax, 1374389535				; 51eb851fH
	imul	ecx
	mov	eax, DWORD PTR _startup_time

; 108  : 				inode->i_dirt=1;

	mov	BYTE PTR [esi+51], 1
	sar	edx, 5
	mov	ecx, edx
	shr	ecx, 31					; 0000001fH
	add	edx, ecx
	add	edx, eax
	mov	DWORD PTR [esi+40], edx
$L842:

; 109  : 			}
; 110  : 		return inode->i_zone[block];

	xor	eax, eax
	mov	ax, WORD PTR [esi+edi*2+14]
	pop	edi
	pop	esi
	pop	ebx

; 188  : }

	pop	ebp
	ret	0
$L840:

; 111  : 	}
; 112  : // ����ÿ��>=7������С��7+512����˵����һ�μ�ӿ顣�����һ�μ�ӿ���д���
; 113  : 	block -= 7;

	sub	edi, 7

; 114  : 	if (block<512) {

	cmp	edi, 512				; 00000200H
	jge	$L843

; 115  : // ����Ǵ��������Ҹ�i �ڵ��ж�Ӧ��ӿ��ֶ�Ϊ0�������ļ����״�ʹ�ü�ӿ飬��������
; 116  : // һ���̿����ڴ�ż�ӿ���Ϣ��������ʵ�ʴ��̿�������ӿ��ֶ��С�Ȼ������i �ڵ�
; 117  : // ���޸ı�־���޸�ʱ�䡣
; 118  : 		if (create && !inode->i_zone[7])

	mov	eax, DWORD PTR _create$[ebp]
	mov	esi, DWORD PTR _inode$[ebp]
	test	eax, eax
	je	SHORT $L845
	cmp	WORD PTR [esi+28], 0
	jne	SHORT $L845

; 119  : 			if (inode->i_zone[7]=new_block(inode->i_dev)) {

	xor	edx, edx
	mov	dx, WORD PTR [esi+44]
	push	edx
	call	_new_block
	add	esp, 4
	mov	WORD PTR [esi+28], ax
	test	ax, ax
	je	SHORT $L845

; 120  : 				inode->i_dirt=1;

	mov	BYTE PTR [esi+51], 1

; 121  : 				inode->i_ctime=CURRENT_TIME;

	mov	ecx, DWORD PTR _jiffies
	mov	eax, 1374389535				; 51eb851fH
	imul	ecx
	sar	edx, 5
	mov	eax, edx
	shr	eax, 31					; 0000001fH
	add	edx, eax
	mov	eax, DWORD PTR _startup_time
	add	edx, eax
	mov	DWORD PTR [esi+40], edx
$L845:

; 122  : 			}
; 123  : // ����ʱi �ڵ��ӿ��ֶ���Ϊ0������������̿�ʧ�ܣ�����0 �˳���
; 124  : 		if (!inode->i_zone[7])

	mov	ax, WORD PTR [esi+28]
	test	ax, ax
	jne	SHORT $L846
	pop	edi
	pop	esi

; 125  : 			return 0;

	xor	eax, eax
	pop	ebx

; 188  : }

	pop	ebp
	ret	0
$L846:

; 126  : // ��ȡ�豸�ϵ�һ�μ�ӿ顣
; 127  : 		if (!(bh = bread(inode->i_dev,inode->i_zone[7])))

	xor	ecx, ecx
	and	eax, 65535				; 0000ffffH
	mov	cx, WORD PTR [esi+44]
	push	eax
	push	ecx
	mov	DWORD PTR 8+[ebp], ecx
	call	_bread
	mov	ebx, eax
	add	esp, 8
	test	ebx, ebx
	jne	SHORT $L847
	pop	edi
	pop	esi
	pop	ebx

; 188  : }

	pop	ebp
	ret	0
$L847:

; 128  : 			return 0;
; 129  : // ȡ�ü�ӿ��ϵ�block ���е��߼���ţ��̿�ţ���
; 130  : 		i = ((unsigned short *) (bh->b_data))[block];

	mov	ecx, DWORD PTR [ebx]

; 131  : // ����Ǵ������Ҽ�ӿ�ĵ�block ���е��߼����Ϊ0 �Ļ���������һ���̿飨�߼��飩������
; 132  : // ��ӿ��еĵ�block ����ڸ����߼����š�Ȼ����λ��ӿ�����޸ı�־��
; 133  : 		if (create && !i)

	mov	eax, DWORD PTR _create$[ebp]
	xor	esi, esi
	mov	si, WORD PTR [ecx+edi*2]
	lea	edi, DWORD PTR [ecx+edi*2]
	test	eax, eax
	je	$L850
	test	esi, esi
	jne	$L850

; 134  : 			if (i=new_block(inode->i_dev)) {

	mov	edx, DWORD PTR 8+[ebp]
	push	edx
	call	_new_block
	mov	esi, eax
	add	esp, 4
	test	esi, esi
	je	$L850

; 135  : 				((unsigned short *) (bh->b_data))[block]=i;
; 136  : 				bh->b_dirt=1;
; 137  : 			}
; 138  : // ����ͷŸü�ӿ飬���ش�����������Ķ�Ӧblock ���߼���Ŀ�š�
; 139  : 		brelse(bh);
; 140  : 		return i;

	jmp	$L1024
$L843:

; 141  : 	}
; 142  : // �������е��ˣ��������ݿ��Ƕ��μ�ӿ飬���������һ�μ�ӿ����ơ������ǶԶ��μ�ӿ�Ĵ���
; 143  : // ��block �ټ�ȥ��ӿ������ɵĿ���(512)��
; 144  : 	block -= 512;
; 145  : // ������´�������i �ڵ�Ķ��μ�ӿ��ֶ�Ϊ0����������һ���̿����ڴ�Ŷ��μ�ӿ��һ����
; 146  : // ��Ϣ��������ʵ�ʴ��̿��������μ�ӿ��ֶ��С�֮����i �ڵ����޸ı��ƺ��޸�ʱ�䡣
; 147  : 	if (create && !inode->i_zone[8])

	mov	eax, DWORD PTR _create$[ebp]
	mov	esi, DWORD PTR _inode$[ebp]
	sub	edi, 512				; 00000200H
	test	eax, eax
	je	SHORT $L853
	cmp	WORD PTR [esi+30], 0
	jne	SHORT $L853

; 148  : 		if (inode->i_zone[8]=new_block(inode->i_dev)) {

	xor	eax, eax
	mov	ax, WORD PTR [esi+44]
	push	eax
	call	_new_block
	add	esp, 4
	mov	WORD PTR [esi+30], ax
	test	ax, ax
	je	SHORT $L853

; 149  : 			inode->i_dirt=1;

	mov	BYTE PTR [esi+51], 1

; 150  : 			inode->i_ctime=CURRENT_TIME;

	mov	ecx, DWORD PTR _jiffies
	mov	eax, 1374389535				; 51eb851fH
	imul	ecx
	mov	eax, DWORD PTR _startup_time
	sar	edx, 5
	mov	ecx, edx
	shr	ecx, 31					; 0000001fH
	add	edx, ecx
	add	edx, eax
	mov	DWORD PTR [esi+40], edx
$L853:

; 151  : 		}
; 152  : // ����ʱi �ڵ���μ�ӿ��ֶ�Ϊ0������������̿�ʧ�ܣ�����0 �˳���
; 153  : 	if (!inode->i_zone[8])

	mov	ax, WORD PTR [esi+30]
	test	ax, ax
	jne	SHORT $L854
	pop	edi
	pop	esi

; 154  : 		return 0;

	xor	eax, eax
	pop	ebx

; 188  : }

	pop	ebp
	ret	0
$L854:

; 155  : // ��ȡ�ö��μ�ӿ��һ���顣
; 156  : 	if (!(bh=bread(inode->i_dev,inode->i_zone[8])))

	xor	ecx, ecx
	and	eax, 65535				; 0000ffffH
	mov	cx, WORD PTR [esi+44]
	push	eax
	push	ecx
	mov	DWORD PTR 8+[ebp], ecx
	call	_bread
	mov	ebx, eax
	add	esp, 8
	test	ebx, ebx
	jne	SHORT $L855
	pop	edi
	pop	esi
	pop	ebx

; 188  : }

	pop	ebp
	ret	0
$L855:

; 157  : 		return 0;
; 158  : // ȡ�ö��μ�ӿ��һ�����ϵ�(block/512)���е��߼���š�
; 159  : 	i = ((unsigned short *)bh->b_data)[block>>9];

	mov	eax, DWORD PTR [ebx]
	mov	edx, edi
	sar	edx, 9
	xor	esi, esi
	mov	si, WORD PTR [eax+edx*2]
	lea	eax, DWORD PTR [eax+edx*2]
	mov	DWORD PTR 12+[ebp], eax

; 160  : // ����Ǵ������Ҷ��μ�ӿ��һ�����ϵ�(block/512)���е��߼����Ϊ0 �Ļ�����������һ����
; 161  : // �飨�߼��飩��Ϊ���μ�ӿ�Ķ����飬���ö��μ�ӿ��һ�����е�(block/512)����ڸö���
; 162  : // ��Ŀ�š�Ȼ����λ���μ�ӿ��һ�������޸ı�־�����ͷŶ��μ�ӿ��һ���顣
; 163  : 	if (create && !i)

	mov	eax, DWORD PTR _create$[ebp]
	test	eax, eax
	je	SHORT $L858
	test	esi, esi
	jne	SHORT $L858

; 164  : 		if (i=new_block(inode->i_dev)) {

	mov	ecx, DWORD PTR 8+[ebp]
	push	ecx
	call	_new_block
	mov	esi, eax
	add	esp, 4
	test	esi, esi
	je	SHORT $L858

; 165  : 			((unsigned short *) (bh->b_data))[block>>9]=i;

	mov	edx, DWORD PTR 12+[ebp]

; 166  : 			bh->b_dirt=1;

	mov	BYTE PTR [ebx+11], 1
	mov	WORD PTR [edx], si
$L858:

; 167  : 		}
; 168  : 	brelse(bh);

	push	ebx
	call	_brelse
	add	esp, 4

; 169  : // ������μ�ӿ�Ķ�������Ϊ0����ʾ������̿�ʧ�ܣ�����0 �˳���
; 170  : 	if (!i)

	test	esi, esi
	jne	SHORT $L860
	pop	edi
	pop	esi

; 171  : 		return 0;

	xor	eax, eax
	pop	ebx

; 188  : }

	pop	ebp
	ret	0
$L860:

; 172  : // ��ȡ���μ�ӿ�Ķ����顣
; 173  : 	if (!(bh=bread(inode->i_dev,i)))

	mov	eax, DWORD PTR 8+[ebp]
	push	esi
	push	eax
	call	_bread
	mov	ebx, eax
	add	esp, 8
	test	ebx, ebx
	jne	SHORT $L861
	pop	edi
	pop	esi
	pop	ebx

; 188  : }

	pop	ebp
	ret	0
$L861:

; 174  : 		return 0;
; 175  : // ȡ�ö������ϵ�block ���е��߼���š�(����511 ��Ϊ���޶�block ֵ������511)
; 176  : 	i = ((unsigned short *)bh->b_data)[block&511];

	mov	ecx, DWORD PTR [ebx]

; 177  : // ����Ǵ������Ҷ�����ĵ�block ���е��߼����Ϊ0 �Ļ���������һ���̿飨�߼��飩����Ϊ
; 178  : // ���մ��������Ϣ�Ŀ顣���ö������еĵ�block ����ڸ����߼�����(i)��Ȼ����λ�������
; 179  : // ���޸ı�־��
; 180  : 	if (create && !i)

	mov	eax, DWORD PTR _create$[ebp]
	and	edi, 511				; 000001ffH
	xor	esi, esi
	test	eax, eax
	mov	si, WORD PTR [ecx+edi*2]
	lea	edi, DWORD PTR [ecx+edi*2]
	je	SHORT $L850
	test	esi, esi
	jne	SHORT $L850

; 181  : 		if (i=new_block(inode->i_dev)) {

	mov	edx, DWORD PTR 8+[ebp]
	push	edx
	call	_new_block
	mov	esi, eax
	add	esp, 4
	test	esi, esi
	je	SHORT $L850
$L1024:

; 182  : 			((unsigned short *) (bh->b_data))[block&511]=i;

	mov	WORD PTR [edi], si

; 183  : 			bh->b_dirt=1;

	mov	BYTE PTR [ebx+11], 1
$L850:

; 184  : 		}
; 185  : // ����ͷŸö��μ�ӿ�Ķ����飬���ش�����������Ķ�Ӧblock ���߼���Ŀ�š�
; 186  : 	brelse(bh);

	push	ebx
	call	_brelse
	add	esp, 4

; 187  : 	return i;

	mov	eax, esi
	pop	edi
	pop	esi
	pop	ebx

; 188  : }

	pop	ebp
	ret	0
__bmap	ENDP
_TEXT	ENDS
PUBLIC	_create_block
_TEXT	SEGMENT
_inode$ = 8
_block$ = 12
_create_block PROC NEAR

; 198  : {

	push	ebp
	mov	ebp, esp

; 199  : 	return _bmap(inode,block,1);

	mov	eax, DWORD PTR _block$[ebp]
	mov	ecx, DWORD PTR _inode$[ebp]
	push	1
	push	eax
	push	ecx
	call	__bmap
	add	esp, 12					; 0000000cH

; 200  : }

	pop	ebp
	ret	0
_create_block ENDP
_TEXT	ENDS
PUBLIC	_iput
EXTRN	_truncate:NEAR
EXTRN	_free_inode:NEAR
EXTRN	_sync_dev:NEAR
EXTRN	_free_page:NEAR
EXTRN	_wake_up:NEAR
_DATA	SEGMENT
	ORG $+3
$SG881	DB	'iput: trying to free free inode', 00H
_DATA	ENDS
_TEXT	SEGMENT
_inode$ = 8
_iput	PROC NEAR

; 204  : {

	push	ebp
	mov	ebp, esp
	push	esi

; 205  : 	if (!inode)

	mov	esi, DWORD PTR _inode$[ebp]
	test	esi, esi
	push	edi
	je	$L878
	cli

; 206  : 		return;
; 207  : 	wait_on_inode(inode);	// �ȴ�inode �ڵ����(����������Ļ�)��

	mov	al, BYTE PTR [esi+50]
	test	al, al
	je	SHORT $L1031
	lea	edi, DWORD PTR [esi+32]
$L1030:
	push	edi
	call	_sleep_on
	mov	al, BYTE PTR [esi+50]
	add	esp, 4
	test	al, al
	jne	SHORT $L1030
$L1031:

; 208  : 	if (!inode->i_count)

	sti
	mov	di, WORD PTR [esi+48]
	test	di, di
	jne	SHORT $L880

; 209  : 		panic("iput: trying to free free inode");

	push	OFFSET FLAT:$SG881
	call	_panic
	add	esp, 4
$L880:

; 210  : // ����ǹܵ�i �ڵ㣬���ѵȴ��ùܵ��Ľ��̣����ô�����1��������������򷵻ء������ͷ�
; 211  : // �ܵ�ռ�õ��ڴ�ҳ�棬����λ�ýڵ�����ü���ֵ�����޸ı�־�͹ܵ���־�������ء�
; 212  : // ����pipe �ڵ㣬inode->i_size ����������ڴ�ҳ��ַ���μ�get_pipe_inode()��228��234 �С�
; 213  : 	if (inode->i_pipe) {

	mov	al, BYTE PTR [esi+52]
	test	al, al
	je	SHORT $L882

; 214  : 		wake_up(&inode->i_wait);

	lea	eax, DWORD PTR [esi+32]
	push	eax
	call	_wake_up
	add	esp, 4

; 215  : 		if (--inode->i_count)

	dec	WORD PTR [esi+48]
	cmp	WORD PTR [esi+48], 0
	jne	$L878

; 216  : 			return;
; 217  : 		free_page(inode->i_size);

	mov	ecx, DWORD PTR [esi+4]
	push	ecx
	call	_free_page
	add	esp, 4

; 218  : 		inode->i_count=0;

	mov	WORD PTR [esi+48], 0

; 219  : 		inode->i_dirt=0;

	mov	BYTE PTR [esi+51], 0

; 220  : 		inode->i_pipe=0;

	mov	BYTE PTR [esi+52], 0
	pop	edi
	pop	esi

; 253  : 	return;
; 254  : }

	pop	ebp
	ret	0
$L882:

; 221  : 		return;
; 222  : 	}
; 223  : // ���i �ڵ��Ӧ���豸��=0���򽫴˽ڵ�����ü����ݼ�1�����ء�
; 224  : 	if (!inode->i_dev) {

	cmp	WORD PTR [esi+44], 0
	jne	SHORT $L884

; 225  : 		inode->i_count--;

	dec	edi
	mov	WORD PTR [esi+48], di
	pop	edi
	pop	esi

; 253  : 	return;
; 254  : }

	pop	ebp
	ret	0
$L884:

; 226  : 		return;
; 227  : 	}
; 228  : // ����ǿ��豸�ļ���i �ڵ㣬��ʱ�߼����ֶ�0 �����豸�ţ���ˢ�¸��豸�����ȴ�i �ڵ������
; 229  : 	if (S_ISBLK(inode->i_mode)) {

	mov	dx, WORD PTR [esi]
	and	edx, 61440				; 0000f000H
	cmp	edx, 24576				; 00006000H
	jne	SHORT $L1044

; 230  : 		sync_dev(inode->i_zone[0]);

	xor	eax, eax
	mov	ax, WORD PTR [esi+14]
	push	eax
	call	_sync_dev
	add	esp, 4

; 205  : 	if (!inode)

	cli

; 231  : 		wait_on_inode(inode);

	mov	al, BYTE PTR [esi+50]
	test	al, al
	je	SHORT $L1036
	lea	edi, DWORD PTR [esi+32]
$L1035:
	push	edi
	call	_sleep_on
	mov	al, BYTE PTR [esi+50]
	add	esp, 4
	test	al, al
	jne	SHORT $L1035
$L1036:

; 208  : 	if (!inode->i_count)

	sti
$L1044:

; 232  : 	}
; 233  : repeat:
; 234  : // ���i �ڵ�����ü�������1����ݼ�1��
; 235  : 	if (inode->i_count>1) {

	cmp	WORD PTR [esi+48], 1
	ja	SHORT $L1046
$repeat$886:

; 236  : 		inode->i_count--;
; 237  : 		return;
; 238  : 	}
; 239  : // ���i �ڵ��������Ϊ0�����ͷŸ�i �ڵ�������߼��飬���ͷŸ�i �ڵ㡣
; 240  : 	if (!inode->i_nlinks) {

	mov	al, BYTE PTR [esi+13]
	test	al, al
	je	SHORT $L1047

; 243  : 		return;
; 244  : 	}
; 245  : // �����i �ڵ��������޸ģ�����¸�i �ڵ㣬���ȴ���i �ڵ������
; 246  : 	if (inode->i_dirt) {

	mov	al, BYTE PTR [esi+51]
	test	al, al
	je	SHORT $L1046

; 247  : 		write_inode(inode);	/* we can sleep - so do again */

	push	esi
	call	_write_inode
	add	esp, 4

; 205  : 	if (!inode)

	cli

; 248  : 		wait_on_inode(inode);

	mov	al, BYTE PTR [esi+50]
	test	al, al
	je	SHORT $L1041
	lea	edi, DWORD PTR [esi+32]
$L1040:
	push	edi
	call	_sleep_on
	mov	al, BYTE PTR [esi+50]
	add	esp, 4
	test	al, al
	jne	SHORT $L1040
$L1041:

; 208  : 	if (!inode->i_count)

	sti

; 248  : 		wait_on_inode(inode);

	cmp	WORD PTR [esi+48], 1
	jbe	SHORT $repeat$886
$L1046:

; 249  : 		goto repeat;
; 250  : 	}
; 251  : // i �ڵ����ü����ݼ�1��
; 252  : 	inode->i_count--;

	dec	WORD PTR [esi+48]
$L878:
	pop	edi
	pop	esi

; 253  : 	return;
; 254  : }

	pop	ebp
	ret	0
$L1047:

; 241  : 		truncate(inode);

	push	esi
	call	_truncate

; 242  : 		free_inode(inode);

	push	esi
	call	_free_inode
	add	esp, 8
	pop	edi
	pop	esi

; 253  : 	return;
; 254  : }

	pop	ebp
	ret	0
_iput	ENDP
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
PUBLIC	_get_empty_inode
_DATA	SEGMENT
$SG909	DB	'%04x: %6d', 09H, 00H
	ORG $+1
$SG910	DB	'No free inodes in mem', 00H
_DATA	ENDS
_TEXT	SEGMENT
_inode$ = -4
_get_empty_inode PROC NEAR

; 259  : {

	push	ebp
	mov	ebp, esp
	push	ecx
	push	esi
	push	edi
$L896:

; 267  : 		for (i = NR_INODE; i ; i--) {

	mov	eax, DWORD PTR _?last_inode@?1??get_empty_inode@@9@9
	xor	esi, esi
	mov	DWORD PTR _inode$[ebp], esi
	mov	ecx, 32					; 00000020H
$L1079:

; 268  : // ���last_inode �Ѿ�ָ��i �ڵ������1 ��֮������������ָ��i �ڵ��ʼ����
; 269  : 			if (++last_inode >= inode_table + NR_INODE)

	add	eax, 56					; 00000038H
	cmp	eax, OFFSET FLAT:_inode_table+1792
	jb	SHORT $L902

; 270  : 				last_inode = inode_table;

	mov	eax, OFFSET FLAT:_inode_table
$L902:

; 271  : // ���last_inode ��ָ���i �ڵ�ļ���ֵΪ0����˵�������ҵ�����i �ڵ����inode ָ��
; 272  : // ��i �ڵ㡣�����i �ڵ�����޸ı�־��������־��Ϊ0�������ǿ���ʹ�ø�i �ڵ㣬�����˳�ѭ����
; 273  : 			if (!last_inode->i_count) {

	cmp	WORD PTR [eax+48], 0
	jne	SHORT $L900

; 274  : 				inode = last_inode;
; 275  : 				if (!inode->i_dirt && !inode->i_lock)

	mov	dl, BYTE PTR [eax+51]
	mov	esi, eax
	test	dl, dl
	jne	SHORT $L900
	mov	dl, BYTE PTR [eax+50]
	test	dl, dl
	je	SHORT $L1085
$L900:

; 267  : 		for (i = NR_INODE; i ; i--) {

	dec	ecx
	jne	SHORT $L1079
$L1085:

; 276  : 					break;
; 277  : 			}
; 278  : 		}
; 279  : // ���û���ҵ�����i �ڵ�(inode=NULL)��������i �ڵ���ӡ����������ʹ�ã���������
; 280  : 		if (!inode) {

	test	esi, esi
	mov	DWORD PTR _inode$[ebp], esi
	mov	DWORD PTR _?last_inode@?1??get_empty_inode@@9@9, eax
	jne	SHORT $L905

; 281  : 			for (i=0 ; i<NR_INODE ; i++)

	mov	edi, OFFSET FLAT:_inode_table+44
$L906:

; 282  : 				printk("%04x: %6d\t",inode_table[i].i_dev,
; 283  : 					inode_table[i].i_num);

	xor	eax, eax
	xor	ecx, ecx
	mov	ax, WORD PTR [edi+2]
	mov	cx, WORD PTR [edi]
	push	eax
	push	ecx
	push	OFFSET FLAT:$SG909
	call	_printk
	add	edi, 56					; 00000038H
	add	esp, 12					; 0000000cH
	cmp	edi, OFFSET FLAT:_inode_table+1836
	jl	SHORT $L906

; 284  : 			panic("No free inodes in mem");

	push	OFFSET FLAT:$SG910
	call	_panic
	add	esp, 4
$L905:

; 260  : 	struct m_inode * inode;

	cli

; 285  : 		}
; 286  : // �ȴ���i �ڵ����������ֱ������Ļ�����
; 287  : 		wait_on_inode(inode);

	mov	al, BYTE PTR [esi+50]
	test	al, al
	je	SHORT $L1058
	lea	edi, DWORD PTR [esi+32]
$L1057:
	push	edi
	call	_sleep_on
	mov	al, BYTE PTR [esi+50]
	add	esp, 4
	test	al, al
	jne	SHORT $L1057
$L1058:

; 263  : 

	sti

; 288  : // �����i �ڵ����޸ı�־����λ�Ļ����򽫸�i �ڵ�ˢ�£����ȴ���i �ڵ������
; 289  : 		while (inode->i_dirt) {

	mov	al, BYTE PTR [esi+51]
	test	al, al
	je	SHORT $L897
$L912:

; 290  : 			write_inode(inode);

	push	esi
	call	_write_inode
	add	esp, 4

; 260  : 	struct m_inode * inode;

	cli

; 291  : 			wait_on_inode(inode);

	mov	al, BYTE PTR [esi+50]
	test	al, al
	je	SHORT $L1063
	lea	edi, DWORD PTR [esi+32]
$L1062:
	push	edi
	call	_sleep_on
	mov	al, BYTE PTR [esi+50]
	add	esp, 4
	test	al, al
	jne	SHORT $L1062
$L1063:

; 263  : 

	sti

; 291  : 			wait_on_inode(inode);

	mov	al, BYTE PTR [esi+51]
	test	al, al
	jne	SHORT $L912
$L897:

; 292  : 		}
; 293  : 	} while (inode->i_count);// ���i �ڵ��ֱ�����ռ�õĻ���������Ѱ�ҿ���i �ڵ㡣

	cmp	WORD PTR [esi+48], 0
	jne	$L896

; 261  : 	static struct m_inode * last_inode = inode_table;// last_inode ָ��i �ڵ���һ�

	pushf

; 262  : 	int i;

	mov	edi, DWORD PTR _inode$[ebp]

; 263  : 

	mov	ecx, 56					; 00000038H

; 264  : 	do {

	mov	al, 0

; 265  : 		// ɨ��i �ڵ��

	cld

; 266  : 		inode = NULL;

	rep	 stosb

; 267  : 		for (i = NR_INODE; i ; i--) {

	popf

; 294  : // ���ҵ�����i �ڵ���򽫸�i �ڵ����������㣬�������ñ�־Ϊ1�����ظ�i �ڵ�ָ�롣
; 295  : 	memset(inode,0,sizeof(*inode));
; 296  : 	inode->i_count = 1;

	mov	WORD PTR [esi+48], 1

; 297  : 	return inode;

	mov	eax, esi

; 298  : }

	pop	edi
	pop	esi
	mov	esp, ebp
	pop	ebp
	ret	0
_get_empty_inode ENDP
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
PUBLIC	_get_pipe_inode
EXTRN	_get_free_page:NEAR
_TEXT	SEGMENT
_get_pipe_inode PROC NEAR

; 304  : {

	push	esi

; 305  : 	struct m_inode * inode;
; 306  : 
; 307  : 	if (!(inode = get_empty_inode()))	// ����Ҳ�������i �ڵ��򷵻�NULL��

	call	_get_empty_inode
	mov	esi, eax
	test	esi, esi
	jne	SHORT $L917
	pop	esi

; 317  : }

	ret	0
$L917:

; 308  : 		return NULL;
; 309  : 	if (!(inode->i_size=get_free_page())) {// �ڵ��i_size �ֶ�ָ�򻺳�����

	call	_get_free_page
	test	eax, eax
	mov	DWORD PTR [esi+4], eax
	jne	SHORT $L918

; 310  : 		inode->i_count = 0;					// �����û�п����ڴ棬��

	mov	WORD PTR [esi+48], ax
	pop	esi

; 317  : }

	ret	0
$L918:

; 311  : 		return NULL;						// �ͷŸ�i �ڵ㣬������NULL��
; 312  : 	}
; 313  : 	inode->i_count = 2;	/* ��/д�����ܼ� */

	mov	WORD PTR [esi+48], 2

; 314  : 	PIPE_HEAD(*inode) = PIPE_TAIL(*inode) = 0;// ��λ�ܵ�ͷβָ�롣

	mov	WORD PTR [esi+16], 0
	mov	WORD PTR [esi+14], 0

; 315  : 	inode->i_pipe = 1;			// �ýڵ�Ϊ�ܵ�ʹ�õı�־��

	mov	BYTE PTR [esi+52], 1

; 316  : 	return inode;		// ����i �ڵ�ָ�롣

	mov	eax, esi
	pop	esi

; 317  : }

	ret	0
_get_pipe_inode ENDP
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
PUBLIC	_iget
EXTRN	_super_block:BYTE
_DATA	SEGMENT
	ORG $+2
$SG927	DB	'iget with dev==0', 00H
	ORG $+3
$SG942	DB	'Mounted inode hasn''t got sb', 0aH, 00H
_DATA	ENDS
_TEXT	SEGMENT
_dev$ = 8
_nr$ = 12
_empty$ = 8
_iget	PROC NEAR

; 322  : {

	push	ebp
	mov	ebp, esp
	push	ebx
	push	esi
	push	edi

; 324  : 
; 325  : 	if (!dev)

	mov	edi, DWORD PTR _dev$[ebp]
	test	edi, edi
	jne	SHORT $L926

; 326  : 		panic("iget with dev==0");

	push	OFFSET FLAT:$SG927
	call	_panic
	add	esp, 4
$L926:

; 327  : // ��i �ڵ����ȡһ������i �ڵ㡣
; 328  : 	empty = get_empty_inode();

	call	_get_empty_inode
	mov	DWORD PTR _empty$[ebp], eax
$L934:

; 329  : // ɨ��i �ڵ��Ѱ��ָ���ڵ�ŵ�i �ڵ㡣�������ýڵ�����ô�����
; 330  : 	inode = inode_table;

	mov	esi, OFFSET FLAT:_inode_table
$L929:

; 332  : // �����ǰɨ���i �ڵ���豸�Ų�����ָ�����豸�Ż��߽ڵ�Ų�����ָ���Ľڵ�ţ������ɨ�衣
; 333  : 		if (inode->i_dev != dev || inode->i_num != nr) {

	xor	ecx, ecx
	mov	cx, WORD PTR [esi+44]
	cmp	ecx, edi
	jne	$L932
	mov	ecx, DWORD PTR _nr$[ebp]
	xor	edx, edx
	mov	dx, WORD PTR [esi+46]
	cmp	edx, ecx
	jne	$L932

; 323  : 	struct m_inode * inode, * empty;

	cli

; 335  : 			continue;
; 336  : 		}
; 337  : // �ҵ�ָ���豸�źͽڵ�ŵ�i �ڵ㣬�ȴ��ýڵ����������������Ļ�����
; 338  : 		wait_on_inode(inode);

	mov	cl, BYTE PTR [esi+50]
	test	cl, cl
	je	SHORT $L1095
	lea	ebx, DWORD PTR [esi+32]
$L1094:
	push	ebx
	call	_sleep_on
	mov	al, BYTE PTR [esi+50]
	add	esp, 4
	test	al, al
	jne	SHORT $L1094
	mov	eax, DWORD PTR _empty$[ebp]
$L1095:

; 326  : 		panic("iget with dev==0");

	sti

; 339  : // �ڵȴ��ýڵ�����Ľ׶Σ��ڵ����ܻᷢ���仯�������ٴ��жϣ���������˱仯�����ٴ�����
; 340  : // ɨ������i �ڵ��
; 341  : 		if (inode->i_dev != dev || inode->i_num != nr) {

	xor	ecx, ecx
	mov	cx, WORD PTR [esi+44]
	cmp	ecx, edi
	jne	SHORT $L934
	mov	ecx, DWORD PTR _nr$[ebp]
	xor	edx, edx
	mov	dx, WORD PTR [esi+46]
	cmp	edx, ecx
	jne	SHORT $L934

; 342  : 			inode = inode_table;
; 343  : 			continue;
; 344  : 		}
; 345  : // ����i �ڵ����ü�����1��
; 346  : 		inode->i_count++;

	inc	WORD PTR [esi+48]

; 347  : 		if (inode->i_mount) {

	mov	cl, BYTE PTR [esi+53]
	test	cl, cl
	je	SHORT $L935

; 348  : 			int i;
; 349  : 
; 350  : // �����i �ڵ��������ļ�ϵͳ�İ�װ�㣬���ڳ����������Ѱ��װ�ڴ�i �ڵ�ĳ����顣���û��
; 351  : // �ҵ�������ʾ������Ϣ�����ͷź�����ʼ��ȡ�Ŀ��нڵ㣬���ظ�i �ڵ�ָ�롣
; 352  : 			for (i = 0 ; i<NR_SUPER ; i++)

	xor	edi, edi
	mov	eax, OFFSET FLAT:_super_block+92
$L937:

; 353  : 				if (super_block[i].s_imount==inode)

	cmp	DWORD PTR [eax], esi
	je	SHORT $L1099
	add	eax, 108				; 0000006cH
	inc	edi
	cmp	eax, OFFSET FLAT:_super_block+956
	jge	SHORT $L1100

; 348  : 			int i;
; 349  : 
; 350  : // �����i �ڵ��������ļ�ϵͳ�İ�װ�㣬���ڳ����������Ѱ��װ�ڴ�i �ڵ�ĳ����顣���û��
; 351  : // �ҵ�������ʾ������Ϣ�����ͷź�����ʼ��ȡ�Ŀ��нڵ㣬���ظ�i �ڵ�ָ�롣
; 352  : 			for (i = 0 ; i<NR_SUPER ; i++)

	jmp	SHORT $L937
$L1099:

; 354  : 					break;
; 355  : 			if (i >= NR_SUPER) {

	cmp	edi, 8
	jge	SHORT $L1100

; 360  : 			}
; 361  : // ����i �ڵ�д�̡��Ӱ�װ�ڴ�i �ڵ��ļ�ϵͳ�ĳ�������ȡ�豸�ţ�����i �ڵ��Ϊ1��Ȼ������
; 362  : // ɨ������i �ڵ��ȡ�ñ���װ�ļ�ϵͳ�ĸ��ڵ㡣
; 363  : 			iput(inode);

	push	esi
	call	_iput

; 364  : 			dev = super_block[i].s_dev;

	lea	eax, DWORD PTR [edi+edi*2]
	add	esp, 4
	xor	edi, edi

; 365  : 			nr = ROOT_INO;

	mov	DWORD PTR _nr$[ebp], 1
	lea	eax, DWORD PTR [eax+eax*8]

; 366  : 			inode = inode_table;

	mov	esi, OFFSET FLAT:_inode_table
	mov	di, WORD PTR _super_block[eax*4+84]

; 367  : 			continue;

	mov	eax, DWORD PTR _empty$[ebp]
	jmp	$L929
$L932:

; 334  : 			inode++;

	add	esi, 56					; 00000038H
	cmp	esi, OFFSET FLAT:_inode_table+1792
	jae	SHORT $L930

; 331  : 	while (inode < NR_INODE+inode_table) {

	jmp	$L929
$L1100:

; 356  : 				printk("Mounted inode hasn't got sb\n");

	push	OFFSET FLAT:$SG942
	call	_printk

; 357  : 				if (empty)

	mov	eax, DWORD PTR _empty$[ebp]
	add	esp, 4
$L935:
	test	eax, eax
	je	SHORT $L943

; 358  : 					iput(empty);

	push	eax
	call	_iput
	add	esp, 4
$L943:

; 359  : 				return inode;

	mov	eax, esi
	pop	edi
	pop	esi
	pop	ebx

; 383  : }

	pop	ebp
	ret	0
$L930:

; 368  : 		}
; 369  : // �Ѿ��ҵ���Ӧ��i �ڵ㣬��˷�����ʱ����Ŀ��нڵ㣬���ظ��ҵ���i �ڵ㡣
; 370  : 		if (empty)
; 371  : 			iput(empty);
; 372  : 		return inode;
; 373  : 	}
; 374  : // �����i �ڵ����û���ҵ�ָ����i �ڵ㣬������ǰ������Ŀ���i �ڵ���i �ڵ���н����ýڵ㡣
; 375  : // ������Ӧ�豸�϶�ȡ��i �ڵ���Ϣ�����ظ�i �ڵ㡣
; 376  : 	if (!empty)

	test	eax, eax
	jne	SHORT $L945
	pop	edi
	pop	esi
	pop	ebx

; 383  : }

	pop	ebp
	ret	0
$L945:

; 377  : 		return (NULL);
; 378  : 	inode=empty;
; 379  : 	inode->i_dev = dev;
; 380  : 	inode->i_num = nr;

	mov	cx, WORD PTR _nr$[ebp]

; 381  : 	read_inode(inode);

	push	eax
	mov	WORD PTR [eax+44], di
	mov	WORD PTR [eax+46], cx
	call	_read_inode

; 382  : 	return inode;

	mov	eax, DWORD PTR _empty$[ebp]
	add	esp, 4
	pop	edi
	pop	esi
	pop	ebx

; 383  : }

	pop	ebp
	ret	0
_iget	ENDP
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
EXTRN	_get_super:NEAR
_DATA	SEGMENT
	ORG $+3
$SG953	DB	'trying to read inode without dev', 00H
	ORG $+3
$SG956	DB	'unable to read i-node block', 00H
_DATA	ENDS
_TEXT	SEGMENT
_inode$ = 8
_sb$ = 8
_bh$ = 8
_read_inode PROC NEAR

; 387  : {

	push	ebp
	mov	ebp, esp
	push	ebx
	push	esi
	push	edi

; 388  : 	struct super_block * sb;

	cli

; 393  : 	lock_inode(inode);

	mov	ebx, DWORD PTR _inode$[ebp]
	mov	al, BYTE PTR [ebx+50]
	test	al, al
	je	SHORT $L1114
	lea	esi, DWORD PTR [ebx+32]
$L1113:
	push	esi
	call	_sleep_on
	mov	al, BYTE PTR [ebx+50]
	add	esp, 4
	test	al, al
	jne	SHORT $L1113
$L1114:
	mov	BYTE PTR [ebx+50], 1

; 389  : 	struct buffer_head * bh;
; 390  : 	int block;
; 391  : 
; 392  : // ����������i �ڵ㣬ȡ�ýڵ������豸�ĳ����顣

	sti

; 394  : 	if (!(sb=get_super(inode->i_dev)))

	xor	edi, edi
	mov	di, WORD PTR [ebx+44]
	push	edi
	call	_get_super
	add	esp, 4
	mov	DWORD PTR _sb$[ebp], eax
	test	eax, eax
	jne	SHORT $L952

; 395  : 		panic("trying to read inode without dev");

	push	OFFSET FLAT:$SG953
	call	_panic
	add	esp, 4
$L952:

; 396  : // ��i �ڵ����ڵ��߼����= (������+������) + i �ڵ�λͼռ�õĿ���+ �߼���λͼռ�õĿ���+
; 397  : // (i �ڵ��-1)/ÿ�麬�е�i �ڵ�����
; 398  : 	block = 2 + sb->s_imap_blocks + sb->s_zmap_blocks +
; 399  : 		(inode->i_num-1)/INODES_PER_BLOCK;
; 400  : // ���豸�϶�ȡ��i �ڵ����ڵ��߼��飬������inode ָ��ָ���Ӧi �ڵ���Ϣ��
; 401  : 	if (!(bh=bread(inode->i_dev,block)))

	mov	eax, DWORD PTR _sb$[ebp]

; 402  : 		panic("unable to read i-node block");
; 403  : 	*(struct d_inode *)inode =
; 404  : 		((struct d_inode *)bh->b_data)
; 405  : 			[(inode->i_num-1)%INODES_PER_BLOCK];
; 406  : // ����ͷŶ���Ļ���������������i �ڵ㡣
; 407  : 	brelse(bh);
; 408  : 	unlock_inode(inode);

	xor	esi, esi
	mov	si, WORD PTR [ebx+46]
	xor	edx, edx
	mov	dx, WORD PTR [eax+6]
	lea	ecx, DWORD PTR [esi-1]
	shr	ecx, 5
	add	ecx, edx
	xor	edx, edx
	mov	dx, WORD PTR [eax+4]
	lea	eax, DWORD PTR [ecx+edx+2]
	push	eax
	push	edi
	call	_bread
	mov	edi, eax
	add	esp, 8
	test	edi, edi
	mov	DWORD PTR _bh$[ebp], edi
	jne	SHORT $L955
	push	OFFSET FLAT:$SG956
	call	_panic
	add	esp, 4
$L955:
	mov	eax, DWORD PTR [edi]
	dec	esi
	and	esi, 31					; 0000001fH
	mov	ecx, 8
	shl	esi, 5
	add	esi, eax
	mov	edi, ebx
	rep movsd
	mov	ecx, DWORD PTR _bh$[ebp]
	push	ecx
	call	_brelse
	mov	BYTE PTR [ebx+50], 0
	add	ebx, 32					; 00000020H
	push	ebx
	call	_wake_up
	add	esp, 8
	pop	edi
	pop	esi
	pop	ebx

; 409  : }

	pop	ebp
	ret	0
_read_inode ENDP
_TEXT	ENDS
_DATA	SEGMENT
$SG969	DB	'trying to write inode without device', 00H
	ORG $+3
$SG972	DB	'unable to read i-node block', 00H
_DATA	ENDS
_TEXT	SEGMENT
_inode$ = 8
_bh$ = 8
_write_inode PROC NEAR

; 413  : {

	push	ebp
	mov	ebp, esp
	push	ebx
	push	esi

; 414  : 	struct super_block * sb;

	cli

; 419  : // ���˳���
; 420  : 	lock_inode(inode);

	mov	ebx, DWORD PTR _inode$[ebp]
	mov	al, BYTE PTR [ebx+50]
	test	al, al
	je	SHORT $L1125
	lea	esi, DWORD PTR [ebx+32]
$L1124:
	push	esi
	call	_sleep_on
	mov	al, BYTE PTR [ebx+50]
	add	esp, 4
	test	al, al
	jne	SHORT $L1124
$L1125:
	mov	BYTE PTR [ebx+50], 1

; 415  : 	struct buffer_head * bh;
; 416  : 	int block;
; 417  : 
; 418  : // ����������i �ڵ㣬�����i �ڵ�û�б��޸Ĺ����߸�i �ڵ���豸�ŵ����㣬�������i �ڵ㣬

	sti

; 421  : 	if (!inode->i_dirt || !inode->i_dev) {

	mov	al, BYTE PTR [ebx+51]
	test	al, al
	je	$L967
	mov	ax, WORD PTR [ebx+44]
	test	ax, ax
	je	$L967

; 423  : 		return;
; 424  : 	}
; 425  : // ��ȡ��i �ڵ�ĳ����顣
; 426  : 	if (!(sb=get_super(inode->i_dev)))

	and	eax, 65535				; 0000ffffH
	push	eax
	mov	DWORD PTR 8+[ebp], eax
	call	_get_super
	mov	esi, eax
	add	esp, 4
	test	esi, esi
	jne	SHORT $L968

; 427  : 		panic("trying to write inode without device");

	push	OFFSET FLAT:$SG969
	call	_panic
	add	esp, 4
$L968:
	push	edi
	xor	edi, edi
	mov	di, WORD PTR [ebx+46]

; 428  : // ��i �ڵ����ڵ��߼����= (������+������) + i �ڵ�λͼռ�õĿ���+ �߼���λͼռ�õĿ���+
; 429  : // (i �ڵ��-1)/ÿ�麬�е�i �ڵ�����
; 430  : 	block = 2 + sb->s_imap_blocks + sb->s_zmap_blocks +
; 431  : 		(inode->i_num-1)/INODES_PER_BLOCK;
; 432  : // ���豸�϶�ȡ��i �ڵ����ڵ��߼��顣
; 433  : 	if (!(bh=bread(inode->i_dev,block)))

	xor	ecx, ecx
	mov	cx, WORD PTR [esi+6]
	xor	edx, edx
	mov	dx, WORD PTR [esi+4]
	lea	eax, DWORD PTR [edi-1]
	shr	eax, 5
	add	eax, ecx
	mov	ecx, DWORD PTR 8+[ebp]
	lea	eax, DWORD PTR [eax+edx+2]
	push	eax
	push	ecx
	call	_bread
	mov	esi, eax
	add	esp, 8
	test	esi, esi
	mov	DWORD PTR _bh$[ebp], esi
	jne	SHORT $L971

; 434  : 		panic("unable to read i-node block");

	push	OFFSET FLAT:$SG972
	call	_panic
	add	esp, 4
$L971:

; 435  : // ����i �ڵ���Ϣ���Ƶ��߼����Ӧ��i �ڵ�����С�
; 436  : 	((struct d_inode *)bh->b_data)
; 437  : 		[(inode->i_num-1)%INODES_PER_BLOCK] =
; 438  : 			*(struct d_inode *)inode;

	mov	eax, DWORD PTR [esi]
	dec	edi
	and	edi, 31					; 0000001fH
	mov	ecx, 8
	shl	edi, 5
	add	edi, eax

; 439  : // �û��������޸ı�־����i �ڵ��޸ı�־���㡣Ȼ���ͷŸú���i �ڵ�Ļ���������������i �ڵ㡣
; 440  : 	bh->b_dirt=1;

	mov	eax, DWORD PTR _bh$[ebp]
	mov	esi, ebx

; 441  : 	inode->i_dirt=0;
; 442  : 	brelse(bh);

	push	eax
	rep movsd
	mov	BYTE PTR [eax+11], 1
	mov	BYTE PTR [ebx+51], 0
	call	_brelse

; 443  : 	unlock_inode(inode);

	mov	BYTE PTR [ebx+50], 0
	add	ebx, 32					; 00000020H
	push	ebx
	call	_wake_up
	add	esp, 8
	pop	edi
	pop	esi
	pop	ebx

; 444  : }

	pop	ebp
	ret	0
$L967:

; 422  : 		unlock_inode(inode);

	mov	BYTE PTR [ebx+50], 0
	add	ebx, 32					; 00000020H
	push	ebx
	call	_wake_up
	add	esp, 4
	pop	esi
	pop	ebx

; 444  : }

	pop	ebp
	ret	0
_write_inode ENDP
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

	je	SHORT $l1$713

; 278  : 		xchg ecx,current/* current = task[n]�� */

	xchg	ecx, DWORD PTR _current

; 279  : 		/*ִ�г���ת����������л� (ͷ���˺ܳ�ʱ�䣬������)*/
; 280  : 		mov ax, __tmp

	mov	ax, WORD PTR ___tmp$[ebp]

; 281  : 		mov word ptr ds:[lcs],ax

	mov	WORD PTR ds:$lcs$714, ax

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
$lcs$714:

; 287  : lcs:	_emit 0		// cs

	DB	0

; 288  : 		_emit 0

	DB	0

; 289  : // �������л�������Ż����ִ���������䡣
; 290  : 		cmp last_task_used_math,ecx /* �������ϴ�ʹ�ù�Э��������*/

	cmp	DWORD PTR _last_task_used_math, ecx

; 291  : 		jne l1

	jne	SHORT $l1$713

; 292  : 		clts/* �������ϴ�ʹ�ù�Э������������cr0 ��TS ��־��*/

	clts
$l1$713:

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
END
