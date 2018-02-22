	TITLE	..\kernel\blk_drv\hd.c
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
;	COMDAT ??_C@_0CG@MGAL@harddisk?3?5free?5buffer?5being?5unlo@
_DATA	SEGMENT DWORD USE32 PUBLIC 'DATA'
_DATA	ENDS
;	COMDAT ??_C@_0BF@DOHJ@harddisk?5I?1O?5error?6?$AN?$AA@
_DATA	SEGMENT DWORD USE32 PUBLIC 'DATA'
_DATA	ENDS
;	COMDAT ??_C@_0BF@ONON@dev?5?$CF04x?0?5block?5?$CFd?6?$AN?$AA@
_DATA	SEGMENT DWORD USE32 PUBLIC 'DATA'
_DATA	ENDS
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
;	COMDAT __set_gate
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT __set_tssldt_desc
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT __outb
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT __inb
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT __outb_p
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT __inb_p
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
;	COMDAT _CMOS_READ
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT _port_read
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT _port_write
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
FLAT	GROUP _DATA, CONST, _BSS
	ASSUME	CS: FLAT, DS: FLAT, SS: FLAT
endif
PUBLIC	_do_hd
PUBLIC	_hd_info
_BSS	SEGMENT
_do_hd	DD	01H DUP (?)
_hd_info DB	030H DUP (?)
_NR_HD	DD	01H DUP (?)
_hd	DQ	0aH DUP (?)
_BSS	ENDS
_DATA	SEGMENT
_recalibrate DD	01H
_reset	DD	01H
_?callable@?1??sys_setup@@9@9 DD 01H
_DATA	ENDS
PUBLIC	_sys_setup
EXTRN	_brelse:NEAR
EXTRN	_bread:NEAR
EXTRN	_mount_root:NEAR
EXTRN	_panic:NEAR
EXTRN	_printk:NEAR
EXTRN	_rd_load:NEAR
_BSS	SEGMENT
$SG763	DB	01H DUP (?)
	ALIGN	4

$SG768	DB	01H DUP (?)
	ALIGN	4

$SG775	DB	01H DUP (?)
_BSS	ENDS
_DATA	SEGMENT
$SG762	DB	'Unable to read partition table of drive %d', 0aH, 0dH, 00H
	ORG $+3
$SG767	DB	'Bad partition table on drive %d', 0aH, 0dH, 00H
	ORG $+2
$SG774	DB	's', 00H
	ORG $+2
$SG776	DB	'Partition table%s ok.', 0aH, 0dH, 00H
_DATA	ENDS
_TEXT	SEGMENT
_BIOS$ = 8
$T969 = -4
$T975 = 8
$T987 = 11
_sys_setup PROC NEAR

; 119  : {

	push	ebp
	mov	ebp, esp
	push	ecx

; 127  : 	if (!callable)

	mov	eax, DWORD PTR _?callable@?1??sys_setup@@9@9
	push	esi
	xor	esi, esi
	cmp	eax, esi
	jne	SHORT $L736

; 128  : 		return -1;

	or	eax, -1
	pop	esi

; 212  : }

	mov	esp, ebp
	pop	ebp
	ret	0
$L736:

; 129  : 	callable = 0;

	mov	ecx, DWORD PTR _BIOS$[ebp]
	mov	DWORD PTR _?callable@?1??sys_setup@@9@9, esi
	mov	eax, OFFSET FLAT:_hd_info
$L737:

; 130  : // ���û����config.h �ж���Ӳ�̲������ʹ�0x90080 �����롣
; 131  : #ifndef HD_TYPE
; 132  : 	for (drive = 0; drive < 2; drive++)
; 133  : 	{
; 134  : 		hd_info[drive].cyl = *(unsigned short *) BIOS;	// ��������

	xor	edx, edx
	add	eax, 24					; 00000018H
	mov	dx, WORD PTR [ecx]

; 135  : 		hd_info[drive].head = *(unsigned char *) (2 + BIOS);	// ��ͷ����
; 136  : 		hd_info[drive].wpcom = *(unsigned short *) (5 + BIOS);	// дǰԤ��������š�
; 137  : 		hd_info[drive].ctl = *(unsigned char *) (8 + BIOS);	// �����ֽڡ�
; 138  : 		hd_info[drive].lzone = *(unsigned short *) (12 + BIOS);	// ��ͷ��½������š�
; 139  : 		hd_info[drive].sect = *(unsigned char *) (14 + BIOS);	// ÿ�ŵ���������
; 140  : 		BIOS += 16;		// ÿ��Ӳ�̵Ĳ�����16 �ֽڣ�����BIOS ָ����һ����

	add	ecx, 16					; 00000010H
	mov	DWORD PTR [eax-16], edx
	xor	edx, edx
	mov	dl, BYTE PTR [ecx-14]
	mov	DWORD PTR [eax-24], edx
	xor	edx, edx
	mov	dx, WORD PTR [ecx-11]
	mov	DWORD PTR [eax-12], edx
	xor	edx, edx
	mov	dl, BYTE PTR [ecx-8]
	mov	DWORD PTR [eax-4], edx
	xor	edx, edx
	mov	dx, WORD PTR [ecx-4]
	mov	DWORD PTR [eax-8], edx
	xor	edx, edx
	mov	dl, BYTE PTR [ecx-2]
	cmp	eax, OFFSET FLAT:_hd_info+48
	mov	DWORD PTR [eax-20], edx
	jl	SHORT $L737
	push	edi

; 141  : 	}
; 142  : // setup.s ������ȡBIOS �е�Ӳ�̲�������Ϣʱ�����ֻ��1 ��Ӳ�̣��ͻὫ��Ӧ��2 ��Ӳ�̵�
; 143  : // 16 �ֽ�ȫ�����㡣�������ֻҪ�жϵ�2 ��Ӳ���������Ƿ�Ϊ0 �Ϳ���֪����û�е�2 ��Ӳ���ˡ�
; 144  : 	if (hd_info[1].cyl)

	mov	edi, DWORD PTR _hd_info+32
	xor	edx, edx
	cmp	edi, esi
	setne	dl
	inc	edx

; 145  : 		NR_HD = 2;		// Ӳ������Ϊ2��
; 146  : 	else
; 147  : 		NR_HD = 1;
; 148  : #endif
; 149  : // ����ÿ��Ӳ�̵���ʼ�����ź��������������б��i*5 ����μ����������й�˵����
; 150  : 	for (i = 0; i < NR_HD; i++)

	cmp	edx, esi
	mov	DWORD PTR _NR_HD, edx
	jle	SHORT $L750
	mov	ecx, OFFSET FLAT:_hd+4
	mov	eax, OFFSET FLAT:_hd_info+8
$L748:

; 151  : 	{
; 152  : 		hd[i * 5].start_sect = 0;	// Ӳ����ʼ�����š�
; 153  : 		hd[i * 5].nr_sects = hd_info[i].head * hd_info[i].sect * hd_info[i].cyl;	// Ӳ������������

	mov	edi, DWORD PTR [eax-8]
	mov	DWORD PTR [ecx-4], esi
	imul	edi, DWORD PTR [eax-4]
	imul	edi, DWORD PTR [eax]
	mov	DWORD PTR [ecx], edi
	add	eax, 24					; 00000018H
	add	ecx, 40					; 00000028H
	dec	edx
	jne	SHORT $L748
$L750:

; 154  : 	}
; 155  : 
; 156  : /*
; 157  : * ���Ƕ�CMOS �й�Ӳ�̵���Ϣ��Щ���ɣ����ܻ���������������������һ��SCSI/ESDI/�ȵ�
; 158  : * ��������������ST-506 ��ʽ��BIOS ���ݵģ��������������ǵ�BIOS �������У���ȴ�ֲ�
; 159  : * �ǼĴ������ݵģ������Щ������CMOS ���ֲ����ڡ�
; 160  : * ���⣬���Ǽ���ST-506 ������������еĻ�����ϵͳ�еĻ�����������Ҳ����������1 ��2
; 161  : * ���ֵ���������
; 162  : * ��1 �����������������CMOS �ֽ�0x12 �ĸ߰��ֽ��У���2 ������ڵͰ��ֽ��С���4 λ�ֽ�
; 163  : * ��Ϣ���������������ͣ�Ҳ���ܽ���0xf��0xf ��ʾʹ��CMOS ��0x19 �ֽ���Ϊ������1 ��8 λ
; 164  : * �����ֽڣ�ʹ��CMOS ��0x1A �ֽ���Ϊ������2 �������ֽڡ�
; 165  : * ��֮��һ������ֵ��ζ��������һ��AT ������Ӳ�̼��ݵ���������
; 166  : */
; 167  : 
; 168  : // �����������ԭ�������Ӳ�̵����Ƿ���AT ���������ݵġ��й�CMOS ��Ϣ��μ�4.2.3.1 �ڡ�
; 169  : 	if ((cmos_disks = CMOS_READ (0x12)) & 0xf0)

	mov	BYTE PTR $T987[ebp], 18			; 00000012H
	mov	DWORD PTR $T969[ebp], 112		; 00000070H

; 120  : 	static int callable = 1;

	mov	al, BYTE PTR $T987[ebp]

; 121  : 	int i, drive;

	mov	dx, WORD PTR $T969[ebp]

; 122  : 	unsigned char cmos_disks;

	out	dx, al

; 123  : 	struct partition *p;

	jmp	SHORT $l1$980
$l1$980:

; 124  : 	struct buffer_head *bh;

	jmp	SHORT $l2$981
$l2$981:

; 154  : 	}
; 155  : 
; 156  : /*
; 157  : * ���Ƕ�CMOS �й�Ӳ�̵���Ϣ��Щ���ɣ����ܻ���������������������һ��SCSI/ESDI/�ȵ�
; 158  : * ��������������ST-506 ��ʽ��BIOS ���ݵģ��������������ǵ�BIOS �������У���ȴ�ֲ�
; 159  : * �ǼĴ������ݵģ������Щ������CMOS ���ֲ����ڡ�
; 160  : * ���⣬���Ǽ���ST-506 ������������еĻ�����ϵͳ�еĻ�����������Ҳ����������1 ��2
; 161  : * ���ֵ���������
; 162  : * ��1 �����������������CMOS �ֽ�0x12 �ĸ߰��ֽ��У���2 ������ڵͰ��ֽ��С���4 λ�ֽ�
; 163  : * ��Ϣ���������������ͣ�Ҳ���ܽ���0xf��0xf ��ʾʹ��CMOS ��0x19 �ֽ���Ϊ������1 ��8 λ
; 164  : * �����ֽڣ�ʹ��CMOS ��0x1A �ֽ���Ϊ������2 �������ֽڡ�
; 165  : * ��֮��һ������ֵ��ζ��������һ��AT ������Ӳ�̼��ݵ���������
; 166  : */
; 167  : 
; 168  : // �����������ԭ�������Ӳ�̵����Ƿ���AT ���������ݵġ��й�CMOS ��Ϣ��μ�4.2.3.1 �ڡ�
; 169  : 	if ((cmos_disks = CMOS_READ (0x12)) & 0xf0)

	mov	DWORD PTR $T975[ebp], 113		; 00000071H

; 122  : 	unsigned char cmos_disks;

	mov	dx, WORD PTR $T975[ebp]

; 123  : 	struct partition *p;

	in	al, dx

; 125  : 

	jmp	SHORT $l1$984
$l1$984:

; 126  : // ��ʼ��ʱcallable=1�������иú���ʱ��������Ϊ0��ʹ������ֻ��ִ��һ�Ρ�

	jmp	SHORT $l2$985
$l2$985:

; 154  : 	}
; 155  : 
; 156  : /*
; 157  : * ���Ƕ�CMOS �й�Ӳ�̵���Ϣ��Щ���ɣ����ܻ���������������������һ��SCSI/ESDI/�ȵ�
; 158  : * ��������������ST-506 ��ʽ��BIOS ���ݵģ��������������ǵ�BIOS �������У���ȴ�ֲ�
; 159  : * �ǼĴ������ݵģ������Щ������CMOS ���ֲ����ڡ�
; 160  : * ���⣬���Ǽ���ST-506 ������������еĻ�����ϵͳ�еĻ�����������Ҳ����������1 ��2
; 161  : * ���ֵ���������
; 162  : * ��1 �����������������CMOS �ֽ�0x12 �ĸ߰��ֽ��У���2 ������ڵͰ��ֽ��С���4 λ�ֽ�
; 163  : * ��Ϣ���������������ͣ�Ҳ���ܽ���0xf��0xf ��ʾʹ��CMOS ��0x19 �ֽ���Ϊ������1 ��8 λ
; 164  : * �����ֽڣ�ʹ��CMOS ��0x1A �ֽ���Ϊ������2 �������ֽڡ�
; 165  : * ��֮��һ������ֵ��ζ��������һ��AT ������Ӳ�̼��ݵ���������
; 166  : */
; 167  : 
; 168  : // �����������ԭ�������Ӳ�̵����Ƿ���AT ���������ݵġ��й�CMOS ��Ϣ��μ�4.2.3.1 �ڡ�
; 169  : 	if ((cmos_disks = CMOS_READ (0x12)) & 0xf0)

	test	al, 240					; 000000f0H
	je	SHORT $L751

; 170  : 		if (cmos_disks & 0x0f)

	and	al, 15					; 0000000fH
	neg	al
	sbb	eax, eax
	neg	eax
	inc	eax
	mov	ecx, eax

; 171  : 			NR_HD = 2;
; 172  : 		else
; 173  : 			NR_HD = 1;
; 174  : 	else

	jmp	SHORT $L999
$L751:

; 175  : 		NR_HD = 0;

	xor	ecx, ecx
$L999:

; 176  : // ��NR_HD=0��������Ӳ�̶�����AT ���������ݵģ�Ӳ�����ݽṹ���㡣
; 177  : // ��NR_HD=1���򽫵�2 ��Ӳ�̵Ĳ������㡣
; 178  : 	for (i = NR_HD; i < 2; i++)

	cmp	ecx, 2
	mov	DWORD PTR _NR_HD, ecx
	jge	SHORT $L757
	lea	eax, DWORD PTR [ecx+ecx*4]
	lea	eax, DWORD PTR _hd[eax*8+4]
$L755:

; 179  : 	{
; 180  : 		hd[i * 5].start_sect = 0;

	mov	DWORD PTR [eax-4], esi

; 181  : 		hd[i * 5].nr_sects = 0;

	mov	DWORD PTR [eax], esi
	add	eax, 40					; 00000028H
	cmp	eax, OFFSET FLAT:_hd+84
	jl	SHORT $L755
$L757:

; 182  : 	}
; 183  : // ��ȡÿһ��Ӳ���ϵ�1 �����ݣ���1 ���������ã�����ȡ���еķ�������Ϣ��
; 184  : // �������ú���bread()��Ӳ�̵�1 ������(fs/buffer.c,267)�������е�0x300 ��Ӳ�̵����豸��
; 185  : // (�μ��б���˵��)��Ȼ�����Ӳ��ͷ1 ������λ��0x1fe ���������ֽ��Ƿ�Ϊ'55AA'���ж�
; 186  : // ��������λ��0x1BE ��ʼ�ķ������Ƿ���Ч����󽫷�������Ϣ����Ӳ�̷������ݽṹhd �С�
; 187  : 	for (drive = 0; drive < NR_HD; drive++)

	xor	edi, edi
	cmp	ecx, esi
	jle	$L760
	push	ebx
	mov	DWORD PTR -4+[ebp], OFFSET FLAT:_hd+12
	mov	DWORD PTR 8+[ebp], 768			; 00000300H
	jmp	SHORT $L758
$L998:
	xor	esi, esi
$L758:

; 188  : 	{
; 189  : 		if (!(bh = bread (0x300 + drive * 5, 0)))

	mov	ecx, DWORD PTR 8+[ebp]
	push	esi
	push	ecx
	call	_bread
	mov	ebx, eax
	add	esp, 8
	cmp	ebx, esi
	jne	SHORT $L761

; 190  : 		{			// 0x300, 0x305 �߼��豸�š�
; 191  : 			printk ("Unable to read partition table of drive %d\n\r", drive);

	push	edi
	push	OFFSET FLAT:$SG762
	call	_printk

; 192  : 			panic ("");

	push	OFFSET FLAT:$SG763
	call	_panic
	add	esp, 12					; 0000000cH
$L761:

; 193  : 		}
; 194  : 		if (bh->b_data[510] != 0x55 || (unsigned char) bh->b_data[511] != 0xAA)

	mov	esi, DWORD PTR [ebx]
	cmp	BYTE PTR [esi+510], 85			; 00000055H
	jne	SHORT $L766
	cmp	BYTE PTR [esi+511], 170			; 000000aaH
	je	SHORT $L765
$L766:

; 195  : 		{			// �ж�Ӳ����Ϣ��Ч��־'55AA'��
; 196  : 			printk ("Bad partition table on drive %d\n\r", drive);

	push	edi
	push	OFFSET FLAT:$SG767
	call	_printk

; 197  : 			panic ("");

	push	OFFSET FLAT:$SG768
	call	_panic
	add	esp, 12					; 0000000cH
$L765:

; 198  : 		}
; 199  : 		p = (struct partition *)(0x1BE + bh->b_data);	// ������λ��Ӳ�̵�1 ������0x1BE ����

	mov	eax, DWORD PTR -4+[ebp]
	lea	ecx, DWORD PTR [esi+458]
	mov	edx, 4
$L770:

; 200  : 		for (i = 1; i < 5; i++, p++)
; 201  : 		{
; 202  : 			hd[i + 5 * drive].start_sect = p->start_sect;

	mov	esi, DWORD PTR [ecx-4]
	add	ecx, 16					; 00000010H
	mov	DWORD PTR [eax-4], esi

; 203  : 			hd[i + 5 * drive].nr_sects = p->nr_sects;

	mov	esi, DWORD PTR [ecx-16]
	mov	DWORD PTR [eax], esi
	add	eax, 8
	dec	edx
	jne	SHORT $L770

; 204  : 		}
; 205  : 		brelse (bh);		// �ͷ�Ϊ���Ӳ�̿��������ڴ滺����ҳ��

	push	ebx
	call	_brelse
	mov	ecx, DWORD PTR -4+[ebp]
	mov	edx, DWORD PTR 8+[ebp]
	add	ecx, 40					; 00000028H
	add	esp, 4
	mov	DWORD PTR -4+[ebp], ecx
	mov	ecx, DWORD PTR _NR_HD
	inc	edi
	add	edx, 5
	cmp	edi, ecx
	mov	DWORD PTR 8+[ebp], edx
	jl	$L998
	xor	esi, esi
	pop	ebx
$L760:

; 206  : 	}
; 207  : 	if (NR_HD)			// �����Ӳ�̴��ڲ����Ѷ�����������ӡ������������Ϣ��

	cmp	ecx, esi
	pop	edi
	je	SHORT $L773

; 208  : 		printk ("Partition table%s ok.\n\r", (NR_HD > 1) ? "s" : "");

	cmp	ecx, 1
	mov	eax, OFFSET FLAT:$SG774
	jg	SHORT $L962
	mov	eax, OFFSET FLAT:$SG775
$L962:
	push	eax
	push	OFFSET FLAT:$SG776
	call	_printk
	add	esp, 8
$L773:

; 209  : 	rd_load ();			// ���أ�������RAMDISK(kernel/blk_drv/ramdisk.c,71)��

	call	_rd_load

; 210  : 	mount_root ();		// ��װ���ļ�ϵͳ(fs/super.c,242)��

	call	_mount_root

; 211  : 	return (0);

	xor	eax, eax
	pop	esi

; 212  : }

	mov	esp, ebp
	pop	ebp
	ret	0
_sys_setup ENDP
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

	je	SHORT $l1$500

; 278  : 		xchg ecx,current/* current = task[n]�� */

	xchg	ecx, DWORD PTR _current

; 279  : 		/*ִ�г���ת����������л� (ͷ���˺ܳ�ʱ�䣬������)*/
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

; 289  : // �������л�������Ż����ִ���������䡣
; 290  : 		cmp last_task_used_math,ecx /* �������ϴ�ʹ�ù�Э��������*/

	cmp	DWORD PTR _last_task_used_math, ecx

; 291  : 		jne l1

	jne	SHORT $l1$500

; 292  : 		clts/* �������ϴ�ʹ�ù�Э������������cr0 ��TS ��־��*/

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
PUBLIC	_unexpected_hd_interrupt
_DATA	SEGMENT
$SG867	DB	'Unexpected HD interrupt', 0aH, 0dH, 00H
_DATA	ENDS
_TEXT	SEGMENT
_unexpected_hd_interrupt PROC NEAR

; 312  : 	printk ("Unexpected HD interrupt\n\r");

	push	OFFSET FLAT:$SG867
	call	_printk
	pop	ecx

; 313  : }

	ret	0
_unexpected_hd_interrupt ENDP
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
PUBLIC	??_C@_0CG@MGAL@harddisk?3?5free?5buffer?5being?5unlo@ ; `string'
EXTRN	_wake_up:NEAR
;	COMDAT ??_C@_0CG@MGAL@harddisk?3?5free?5buffer?5being?5unlo@
; File ..\kernel\blk_drv\blk.h
_DATA	SEGMENT
??_C@_0CG@MGAL@harddisk?3?5free?5buffer?5being?5unlo@ DB 'harddisk: free '
	DB	'buffer being unlocked', 0aH, 00H		; `string'
_DATA	ENDS
;	COMDAT _unlock_buffer
_TEXT	SEGMENT
_bh$ = 8
_unlock_buffer PROC NEAR				; COMDAT

; 102  : {

	push	ebp
	mov	ebp, esp
	push	esi

; 103  :   if (!bh->b_lock)		// ���ָ���Ļ�����bh ��û�б�����������ʾ������Ϣ��

	mov	esi, DWORD PTR _bh$[ebp]
	mov	al, BYTE PTR [esi+13]
	test	al, al
	jne	SHORT $L671

; 104  :     printk (DEVICE_NAME ": free buffer being unlocked\n");

	push	OFFSET FLAT:??_C@_0CG@MGAL@harddisk?3?5free?5buffer?5being?5unlo@ ; `string'
	call	_printk
	add	esp, 4
$L671:

; 105  :   bh->b_lock = 0;		// ���򽫸û�����������

	mov	BYTE PTR [esi+13], 0

; 106  :   wake_up (&bh->b_wait);	// ���ѵȴ��û������Ľ��̡�

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
PUBLIC	??_C@_0BF@DOHJ@harddisk?5I?1O?5error?6?$AN?$AA@	; `string'
PUBLIC	??_C@_0BF@ONON@dev?5?$CF04x?0?5block?5?$CFd?6?$AN?$AA@ ; `string'
EXTRN	_blk_dev:BYTE
EXTRN	_wait_for_request:DWORD
;	COMDAT ??_C@_0BF@DOHJ@harddisk?5I?1O?5error?6?$AN?$AA@
; File ..\kernel\blk_drv\blk.h
_DATA	SEGMENT
??_C@_0BF@DOHJ@harddisk?5I?1O?5error?6?$AN?$AA@ DB 'harddisk I/O error', 0aH
	DB	0dH, 00H					; `string'
_DATA	ENDS
;	COMDAT ??_C@_0BF@ONON@dev?5?$CF04x?0?5block?5?$CFd?6?$AN?$AA@
_DATA	SEGMENT
??_C@_0BF@ONON@dev?5?$CF04x?0?5block?5?$CFd?6?$AN?$AA@ DB 'dev %04x, bloc'
	DB	'k %d', 0aH, 0dH, 00H			; `string'
_DATA	ENDS
;	COMDAT _end_request
_TEXT	SEGMENT
_uptodate$ = 8
_end_request PROC NEAR					; COMDAT

; 112  : {

	push	ebp
	mov	ebp, esp

; 113  :   DEVICE_OFF (CURRENT->dev);	// �ر��豸��
; 114  :   if (CURRENT->bh)

	mov	eax, DWORD PTR _blk_dev+28
	push	ebx
	mov	ebx, DWORD PTR _uptodate$[ebp]
	push	esi
	mov	esi, DWORD PTR [eax+28]
	test	esi, esi
	je	SHORT $L1022

; 115  :     {				// CURRENT Ϊָ�����豸�ŵĵ�ǰ����ṹ��
; 116  :       CURRENT->bh->b_uptodate = uptodate;	// �ø��±�־��
; 117  :       unlock_buffer (CURRENT->bh);	// ������������

	mov	al, BYTE PTR [esi+13]
	mov	BYTE PTR [esi+10], bl
	test	al, al
	jne	SHORT $L1023
	push	OFFSET FLAT:??_C@_0CG@MGAL@harddisk?3?5free?5buffer?5being?5unlo@ ; `string'
	call	_printk
	add	esp, 4
$L1023:
	mov	BYTE PTR [esi+13], 0
	add	esi, 16					; 00000010H
	push	esi
	call	_wake_up
	add	esp, 4
$L1022:
	pop	esi

; 118  :     }
; 119  :   if (!uptodate)

	test	ebx, ebx
	pop	ebx
	jne	SHORT $L678

; 120  :     {				// ������±�־Ϊ0 ����ʾ�豸������Ϣ��
; 121  :       printk (DEVICE_NAME " I/O error\n\r");

	push	OFFSET FLAT:??_C@_0BF@DOHJ@harddisk?5I?1O?5error?6?$AN?$AA@ ; `string'
	call	_printk

; 122  :       printk ("dev %04x, block %d\n\r", CURRENT->dev, CURRENT->bh->b_blocknr);

	mov	eax, DWORD PTR _blk_dev+28
	mov	ecx, DWORD PTR [eax+28]
	mov	eax, DWORD PTR [eax]
	mov	edx, DWORD PTR [ecx+4]
	push	edx
	push	eax
	push	OFFSET FLAT:??_C@_0BF@ONON@dev?5?$CF04x?0?5block?5?$CFd?6?$AN?$AA@ ; `string'
	call	_printk
	add	esp, 16					; 00000010H
$L678:

; 123  :     }
; 124  :   wake_up (&CURRENT->waiting);	// ���ѵȴ���������Ľ��̡�

	mov	ecx, DWORD PTR _blk_dev+28
	add	ecx, 24					; 00000018H
	push	ecx
	call	_wake_up

; 125  :   wake_up (&wait_for_request);	// ���ѵȴ�����Ľ��̡�

	push	OFFSET FLAT:_wait_for_request
	call	_wake_up

; 126  :   CURRENT->dev = -1;		// �ͷŸ������

	mov	eax, DWORD PTR _blk_dev+28
	add	esp, 8
	mov	DWORD PTR [eax], -1

; 127  :   CURRENT = CURRENT->next;	// ������������ɾ���������

	mov	edx, DWORD PTR [eax+32]
	mov	DWORD PTR _blk_dev+28, edx

; 128  : }

	pop	ebp
	ret	0
_end_request ENDP
_TEXT	ENDS
PUBLIC	_hd_init
EXTRN	_idt:BYTE
EXTRN	_hd_interrupt:NEAR
_TEXT	SEGMENT
$T1036 = -8
$T1043 = -1
$T1044 = -8
$T1050 = -8
$T1055 = -1
$T1056 = -8
_hd_init PROC NEAR

; 471  : {

	push	ebp
	mov	ebp, esp
	sub	esp, 8

; 473  : 	set_intr_gate (0x2E, &hd_interrupt);	// ����Ӳ���ж������� int 0x2E(46)��

	mov	ecx, OFFSET FLAT:_hd_interrupt
	mov	eax, OFFSET FLAT:_hd_interrupt
	and	ecx, -65536				; ffff0000H
	and	eax, 65535				; 0000ffffH
	add	ecx, 36352				; 00008e00H
	add	eax, 524288				; 00080000H
	mov	DWORD PTR _idt+372, ecx

; 475  : 	outb_p (inb_p (0x21) & 0xfb, 0x21);	// ��λ��������8259A int2 ������λ�������Ƭ

	mov	ecx, 33					; 00000021H
	mov	DWORD PTR _blk_dev+24, OFFSET FLAT:_do_hd_request
	mov	DWORD PTR _idt+368, eax
	mov	DWORD PTR $T1036[ebp], ecx

; 474  : // hd_interrupt ��(kernel/system_call.s,221)��

	mov	dx, WORD PTR $T1036[ebp]

; 475  : 	outb_p (inb_p (0x21) & 0xfb, 0x21);	// ��λ��������8259A int2 ������λ�������Ƭ

	in	al, dx

; 477  : 	outb (inb_p (0xA1) & 0xbf, 0xA1);	// ��λӲ�̵��ж���������λ���ڴ�Ƭ�ϣ�������

	jmp	SHORT $l1$1034
$l1$1034:

; 478  : // Ӳ�̿����������ж������źš�

	jmp	SHORT $l2$1035
$l2$1035:

; 475  : 	outb_p (inb_p (0x21) & 0xfb, 0x21);	// ��λ��������8259A int2 ������λ�������Ƭ

	and	al, 251					; 000000fbH
	mov	DWORD PTR $T1044[ebp], ecx
	mov	BYTE PTR $T1043[ebp], al

; 472  : 	blk_dev[MAJOR_NR].request_fn = DEVICE_REQUEST;	// do_hd_request()��

	mov	al, BYTE PTR $T1043[ebp]

; 473  : 	set_intr_gate (0x2E, &hd_interrupt);	// ����Ӳ���ж������� int 0x2E(46)��

	mov	dx, WORD PTR $T1044[ebp]

; 474  : // hd_interrupt ��(kernel/system_call.s,221)��

	out	dx, al

; 475  : 	outb_p (inb_p (0x21) & 0xfb, 0x21);	// ��λ��������8259A int2 ������λ�������Ƭ

	jmp	SHORT $l1$1041
$l1$1041:

; 476  : // �����ж������źš�

	jmp	SHORT $l2$1042
$l2$1042:

; 477  : 	outb (inb_p (0xA1) & 0xbf, 0xA1);	// ��λӲ�̵��ж���������λ���ڴ�Ƭ�ϣ�������

	mov	ecx, 161				; 000000a1H
	mov	DWORD PTR $T1050[ebp], ecx

; 474  : // hd_interrupt ��(kernel/system_call.s,221)��

	mov	dx, WORD PTR $T1050[ebp]

; 475  : 	outb_p (inb_p (0x21) & 0xfb, 0x21);	// ��λ��������8259A int2 ������λ�������Ƭ

	in	al, dx

; 477  : 	outb (inb_p (0xA1) & 0xbf, 0xA1);	// ��λӲ�̵��ж���������λ���ڴ�Ƭ�ϣ�������

	jmp	SHORT $l1$1048
$l1$1048:

; 478  : // Ӳ�̿����������ж������źš�

	jmp	SHORT $l2$1049
$l2$1049:

; 477  : 	outb (inb_p (0xA1) & 0xbf, 0xA1);	// ��λӲ�̵��ж���������λ���ڴ�Ƭ�ϣ�������

	and	al, 191					; 000000bfH
	mov	DWORD PTR $T1056[ebp], ecx
	mov	BYTE PTR $T1055[ebp], al

; 472  : 	blk_dev[MAJOR_NR].request_fn = DEVICE_REQUEST;	// do_hd_request()��

	mov	dx, WORD PTR $T1056[ebp]

; 473  : 	set_intr_gate (0x2E, &hd_interrupt);	// ����Ӳ���ж������� int 0x2E(46)��

	mov	al, BYTE PTR $T1055[ebp]

; 474  : // hd_interrupt ��(kernel/system_call.s,221)��

	out	dx, al

; 479  : }

	mov	esp, ebp
	pop	ebp
	ret	0
_hd_init ENDP
_TEXT	ENDS
_DATA	SEGMENT
	ORG $+2
$SG900	DB	'harddisk: request list destroyed', 00H
	ORG $+3
$SG903	DB	'harddisk: block not locked', 00H
	ORG $+1
$SG917	DB	'unknown hd-command', 00H
_DATA	ENDS
_TEXT	SEGMENT
$T1077 = -12
$T1082 = -8
$T1083 = -12
$T1084 = -16
_r$ = -12
_block$ = -8
_sec$ = -12
_head$ = -4
_cyl$ = -16
_do_hd_request PROC NEAR

; 381  : {

	push	ebp
	mov	ebp, esp
	sub	esp, 16					; 00000010H

; 387  : 	INIT_REQUEST;		// ���������ĺϷ���(�μ�kernel/blk_drv/blk.h,127)��

	mov	edx, DWORD PTR _blk_dev+28
	push	ebx
	xor	ebx, ebx
	push	esi
	cmp	edx, ebx
	je	$L916
$repeat$896:
	mov	eax, DWORD PTR [edx]
	and	al, 0
	cmp	eax, 768				; 00000300H
	je	SHORT $L899
	push	OFFSET FLAT:$SG900
	call	_panic
	mov	edx, DWORD PTR _blk_dev+28
	add	esp, 4
$L899:
	mov	eax, DWORD PTR [edx+28]
	cmp	eax, ebx
	je	SHORT $L902
	cmp	BYTE PTR [eax+13], bl
	jne	SHORT $L902
	push	OFFSET FLAT:$SG903
	call	_panic
	mov	edx, DWORD PTR _blk_dev+28
	add	esp, 4
$L902:

; 389  : 	dev = MINOR (CURRENT->dev);	// CURRENT ����Ϊ(blk_dev[MAJOR_NR].current_request)��
; 390  : 	block = CURRENT->sector;	// �������ʼ������
; 391  : // ������豸�Ų����ڻ�����ʼ�������ڸ÷���������-2������������󣬲���ת�����repeat ��
; 392  : // ��������INIT_REQUEST ��ʼ��������Ϊһ��Ҫ���д2 ��������512*2 �ֽڣ������������������
; 393  : // ���ܴ��ڷ�����������ڶ��������š�
; 394  : 	if (dev >= 5 * NR_HD || block + 2 > hd[dev].nr_sects)

	mov	esi, DWORD PTR _NR_HD
	mov	ecx, DWORD PTR [edx]
	mov	eax, DWORD PTR [edx+12]
	and	ecx, 255				; 000000ffH
	lea	esi, DWORD PTR [esi+esi*4]
	cmp	ecx, esi
	jae	$L905
	lea	esi, DWORD PTR [eax+2]
	cmp	esi, DWORD PTR _hd[ecx*8+4]
	ja	$L905

; 397  : 		goto repeat;		// �ñ����blk.h ����档
; 398  : 	}
; 399  : 	block += hd[dev].start_sect;	// ��������Ŀ��Ӧ������Ӳ���ϵľ��������š�

	add	eax, DWORD PTR _hd[ecx*8]
	mov	DWORD PTR _block$[ebp], eax

; 400  : 	dev /= 5;			// ��ʱdev ����Ӳ�̺ţ�0 ��1����

	mov	eax, -858993459				; cccccccdH
	mul	ecx
	mov	ecx, edx
	shr	ecx, 2

; 401  : // ����Ƕ�������������Ӳ����Ϣ�ṹ�и�����ʼ�����ź�ÿ�ŵ������������ڴŵ��е�
; 402  : // ������(sec)�����������(cyl)�ʹ�ͷ��(head)��
; 403  : 	sec = hd_info[dev].sect;

	lea	esi, DWORD PTR [ecx+ecx*2]
	shl	esi, 3
	mov	edx, DWORD PTR _hd_info[esi+4]
	mov	DWORD PTR _sec$[ebp], edx

; 404  : 	_asm {
; 405  : 		mov eax,block

	mov	eax, DWORD PTR _block$[ebp]

; 406  : 		xor edx,edx

	xor	edx, edx

; 407  : 		mov ebx,sec

	mov	ebx, DWORD PTR _sec$[ebp]

; 408  : 		div ebx

	div	ebx

; 409  : 		mov block,eax

	mov	DWORD PTR _block$[ebp], eax

; 410  : 		mov sec,edx

	mov	DWORD PTR _sec$[ebp], edx

; 411  : 	}
; 412  : //__asm__ ("divl %4": "=a" (block), "=d" (sec):"" (block), "1" (0),
; 413  : //	   "r" (hd_info[dev].
; 414  : //		sect));
; 415  : 	head = hd_info[dev].head;

	mov	eax, DWORD PTR _hd_info[esi]
	mov	DWORD PTR _head$[ebp], eax

; 416  : 	_asm {
; 417  : 		mov eax,block

	mov	eax, DWORD PTR _block$[ebp]

; 418  : 		xor edx,edx

	xor	edx, edx

; 419  : 		mov ebx,head

	mov	ebx, DWORD PTR _head$[ebp]

; 420  : 		div ebx

	div	ebx

; 421  : 		mov cyl,eax

	mov	DWORD PTR _cyl$[ebp], eax

; 422  : 		mov head,edx

	mov	DWORD PTR _head$[ebp], edx

; 423  : 	}
; 424  : //__asm__ ("divl %4": "=a" (cyl), "=d" (head):"" (block), "1" (0),
; 425  : //	   "r" (hd_info[dev].
; 426  : //		head));
; 427  : 	sec++;

	mov	edx, DWORD PTR _sec$[ebp]

; 428  : 	nsect = CURRENT->nr_sectors;	// ����/д����������

	mov	eax, DWORD PTR _blk_dev+28

; 429  : // ���reset ��1����ִ�и�λ��������λӲ�̺Ϳ�������������Ҫ����У����־�����ء�
; 430  : 	if (reset)

	mov	ebx, DWORD PTR _reset
	inc	edx
	mov	esi, DWORD PTR [eax+16]
	test	ebx, ebx
	jne	$L1090

; 435  : 		return;
; 436  : 	}
; 437  : // �������У����־(recalibrate)��λ�������ȸ�λ�ñ�־��Ȼ����Ӳ�̿�������������У�����
; 438  : 	if (recalibrate)

	mov	ebx, DWORD PTR _recalibrate
	test	ebx, ebx
	jne	$L1091

; 443  : 		return;
; 444  : 	}
; 445  : // �����ǰ������д��������������д���ѭ����ȡ״̬�Ĵ�����Ϣ���ж���������־
; 446  : // DRQ_STAT �Ƿ���λ��DRQ_STAT ��Ӳ��״̬�Ĵ������������λ��include/linux/hdreg.h��27����
; 447  : 	if (CURRENT->cmd == WRITE)

	cmp	DWORD PTR [eax+4], 1
	jne	$L908

; 448  : 	{
; 449  : 		hd_out (dev, nsect, sec, head, cyl, WIN_WRITE, &write_intr);

	mov	eax, DWORD PTR _cyl$[ebp]
	push	OFFSET FLAT:_write_intr
	push	48					; 00000030H
	push	eax
	mov	eax, DWORD PTR _head$[ebp]
	push	eax
	push	edx
	push	esi
	push	ecx
	call	_hd_out
	add	esp, 28					; 0000001cH

; 450  : 		for (i = 0; i < 3000 && !(r = inb_p (HD_STATUS) & DRQ_STAT); i++)

	mov	DWORD PTR $T1077[ebp], 503		; 000001f7H

; 384  : 	unsigned int sec, head, cyl;

	mov	dx, WORD PTR $T1077[ebp]

; 385  : 	unsigned int nsect;

	in	al, dx

; 387  : 	INIT_REQUEST;		// ���������ĺϷ���(�μ�kernel/blk_drv/blk.h,127)��

	jmp	SHORT $l1$1075
$l1$1075:

; 388  : // ȡ�豸���е����豸��(���б���Ӳ���豸�ŵ�˵��)�����豸�ż���Ӳ���ϵķ����š�

	jmp	SHORT $l2$1076
$l2$1076:

; 450  : 		for (i = 0; i < 3000 && !(r = inb_p (HD_STATUS) & DRQ_STAT); i++)

	and	eax, 8
	mov	DWORD PTR _r$[ebp], eax
	jne	$L912

; 451  : // ����������λ��λ���˳�ѭ�������ȵ�ѭ������Ҳû����λ����˴�дӲ�̲���ʧ�ܣ�ȥ����
; 452  : // ��һ��Ӳ�����󡣷�����Ӳ�̿��������ݼĴ����˿�HD_DATA д��1 �����������ݡ�
; 453  : 		if (!r)
; 454  : 		{
; 455  : 			bad_rw_intr ();

	call	_bad_rw_intr

; 456  : 			goto repeat;		// �ñ����blk.h ����棬Ҳ������301 �С�

	mov	edx, DWORD PTR _blk_dev+28
	xor	ebx, ebx
	jmp	$L1092
$L905:

; 395  : 	{
; 396  : 		end_request (0);

	mov	esi, DWORD PTR [edx+28]
	cmp	esi, ebx
	je	SHORT $L1093
	mov	al, BYTE PTR [esi+13]
	mov	BYTE PTR [esi+10], bl
	cmp	al, bl
	jne	SHORT $L1067
	push	OFFSET FLAT:??_C@_0CG@MGAL@harddisk?3?5free?5buffer?5being?5unlo@ ; `string'
	call	_printk
	add	esp, 4
$L1067:
	mov	BYTE PTR [esi+13], bl
	add	esi, 16					; 00000010H
	push	esi
	call	_wake_up
	add	esp, 4
$L1093:
	push	OFFSET FLAT:??_C@_0BF@DOHJ@harddisk?5I?1O?5error?6?$AN?$AA@ ; `string'
	call	_printk
	mov	eax, DWORD PTR _blk_dev+28
	mov	ecx, DWORD PTR [eax+28]
	mov	eax, DWORD PTR [eax]
	mov	edx, DWORD PTR [ecx+4]
	push	edx
	push	eax
	push	OFFSET FLAT:??_C@_0BF@ONON@dev?5?$CF04x?0?5block?5?$CFd?6?$AN?$AA@ ; `string'
	call	_printk
	mov	ecx, DWORD PTR _blk_dev+28
	add	ecx, 24					; 00000018H
	push	ecx
	call	_wake_up
	push	OFFSET FLAT:_wait_for_request
	call	_wake_up
	mov	eax, DWORD PTR _blk_dev+28
	add	esp, 24					; 00000018H
	mov	DWORD PTR [eax], -1
	mov	edx, DWORD PTR [eax+32]
	mov	DWORD PTR _blk_dev+28, edx
$L1092:

; 387  : 	INIT_REQUEST;		// ���������ĺϷ���(�μ�kernel/blk_drv/blk.h,127)��

	cmp	edx, ebx
	jne	$repeat$896

; 467  : }

	pop	esi
	pop	ebx
	mov	esp, ebp
	pop	ebp
	ret	0
$L1090:

; 431  : 	{
; 432  : 		reset = 0;
; 433  : 		recalibrate = 1;
; 434  : 		reset_hd (CURRENT_DEV);

	mov	ecx, DWORD PTR [eax]
	mov	eax, 1717986919				; 66666667H
	and	ecx, 255				; 000000ffH
	mov	DWORD PTR _reset, 0
	imul	ecx
	sar	edx, 1
	mov	eax, edx
	mov	DWORD PTR _recalibrate, 1
	shr	eax, 31					; 0000001fH
	add	edx, eax
	push	edx
	call	_reset_hd

; 464  : 	}
; 465  : 	else
; 466  : 		panic ("unknown hd-command");

	add	esp, 4

; 467  : }

	pop	esi
	pop	ebx
	mov	esp, ebp
	pop	ebp
	ret	0
$L1091:

; 439  : 	{
; 440  : 		recalibrate = 0;
; 441  : 		hd_out (dev, hd_info[CURRENT_DEV].sect, 0, 0, 0,
; 442  : 		  WIN_RESTORE, &recal_intr);

	mov	edx, DWORD PTR [eax]
	mov	eax, 1717986919				; 66666667H
	and	edx, 255				; 000000ffH
	push	OFFSET FLAT:_recal_intr
	imul	edx
	sar	edx, 1
	mov	eax, edx
	push	16					; 00000010H
	shr	eax, 31					; 0000001fH
	add	edx, eax
	push	0
	push	0
	push	0
	lea	edx, DWORD PTR [edx+edx*2]
	mov	DWORD PTR _recalibrate, 0
	mov	eax, DWORD PTR _hd_info[edx*8+4]
	push	eax
	push	ecx
	call	_hd_out
	add	esp, 28					; 0000001cH

; 467  : }

	pop	esi
	pop	ebx
	mov	esp, ebp
	pop	ebp
	ret	0
$L912:

; 457  : 		}
; 458  : 		port_write (HD_DATA, CURRENT->buffer, 256);

	mov	ecx, DWORD PTR _blk_dev+28
	mov	DWORD PTR $T1084[ebp], 256		; 00000100H
	mov	DWORD PTR $T1082[ebp], 496		; 000001f0H
	mov	edx, DWORD PTR [ecx+20]
	mov	DWORD PTR $T1083[ebp], edx

; 382  : 	int i, r;

	pushf

; 383  : 	unsigned int block, dev;

	mov	dx, WORD PTR $T1082[ebp]

; 384  : 	unsigned int sec, head, cyl;

	mov	esi, DWORD PTR $T1083[ebp]

; 385  : 	unsigned int nsect;

	mov	ecx, DWORD PTR $T1084[ebp]

; 386  : 

	cld

; 387  : 	INIT_REQUEST;		// ���������ĺϷ���(�μ�kernel/blk_drv/blk.h,127)��

	rep	 outsw

; 388  : // ȡ�豸���е����豸��(���б���Ӳ���豸�ŵ�˵��)�����豸�ż���Ӳ���ϵķ����š�

	popf

; 467  : }

	pop	esi
	pop	ebx
	mov	esp, ebp
	pop	ebp
	ret	0
$L908:

; 459  : // �����ǰ�����Ƕ�Ӳ������������Ӳ�̿��������Ͷ��������
; 460  : 	}
; 461  : 	else if (CURRENT->cmd == READ)

	mov	ebx, DWORD PTR [eax+4]
	test	ebx, ebx
	jne	SHORT $L915

; 462  : 	{
; 463  : 		hd_out (dev, nsect, sec, head, cyl, WIN_READ, &read_intr);

	mov	eax, DWORD PTR _cyl$[ebp]
	push	OFFSET FLAT:_read_intr
	push	32					; 00000020H
	push	eax
	mov	eax, DWORD PTR _head$[ebp]
	push	eax
	push	edx
	push	esi
	push	ecx
	call	_hd_out
	add	esp, 28					; 0000001cH

; 467  : }

	pop	esi
	pop	ebx
	mov	esp, ebp
	pop	ebp
	ret	0
$L915:

; 464  : 	}
; 465  : 	else
; 466  : 		panic ("unknown hd-command");

	push	OFFSET FLAT:$SG917
	call	_panic
	add	esp, 4
$L916:

; 467  : }

	pop	esi
	pop	ebx
	mov	esp, ebp
	pop	ebp
	ret	0
_do_hd_request ENDP
_TEXT	ENDS
_DATA	SEGMENT
	ORG $+1
$SG813	DB	'Trying to write bad sector', 00H
	ORG $+1
$SG815	DB	'HD controller not ready', 00H
_DATA	ENDS
_TEXT	SEGMENT
$T1101 = 11
$T1102 = 32
$T1108 = 11
$T1129 = 27
$T1135 = 27
_drive$ = 8
_nsect$ = 12
_sect$ = 16
_head$ = 20
_cyl$ = 24
_cmd$ = 28
_intr_addr$ = 32
_port$ = 32
_hd_out	PROC NEAR

; 247  : {

	push	ebp
	mov	ebp, esp
	push	ebx

; 250  : 	if (drive > 1 || head > 15)	// �����������(0,1)>1 ���ͷ��>15�������֧�֡�

	mov	ebx, DWORD PTR _drive$[ebp]
	cmp	ebx, 1
	ja	SHORT $L812
	cmp	DWORD PTR _head$[ebp], 15		; 0000000fH
	jbe	SHORT $L811
$L812:

; 251  : 		panic ("Trying to write bad sector");

	push	OFFSET FLAT:$SG813
	call	_panic
	add	esp, 4
$L811:

; 252  : 	if (!controller_ready ())	// ����ȴ�һ��ʱ�����δ���������������

	call	_controller_ready
	test	eax, eax
	jne	SHORT $L814

; 253  : 		panic ("HD controller not ready");

	push	OFFSET FLAT:$SG815
	call	_panic
	add	esp, 4
$L814:

; 254  : 	do_hd = intr_addr;		// do_hd ����ָ�뽫��Ӳ���жϳ����б����á�

	mov	eax, DWORD PTR _intr_addr$[ebp]

; 255  : 	outb_p (hd_info[drive].ctl, HD_CMD);	// ����ƼĴ���(0x3f6)��������ֽڡ�

	lea	ecx, DWORD PTR [ebx+ebx*2]
	shl	ecx, 3
	mov	DWORD PTR _do_hd, eax
	mov	DWORD PTR $T1102[ebp], 1014		; 000003f6H
	mov	dl, BYTE PTR _hd_info[ecx+20]
	mov	BYTE PTR $T1101[ebp], dl

; 248  : 	register int port; //asm ("dx");	// port ������Ӧ�Ĵ���dx��

	mov	al, BYTE PTR $T1101[ebp]

; 249  : 

	mov	dx, WORD PTR $T1102[ebp]

; 250  : 	if (drive > 1 || head > 15)	// �����������(0,1)>1 ���ͷ��>15�������֧�֡�

	out	dx, al

; 251  : 		panic ("Trying to write bad sector");

	jmp	SHORT $l1$1099
$l1$1099:

; 252  : 	if (!controller_ready ())	// ����ȴ�һ��ʱ�����δ���������������

	jmp	SHORT $l2$1100
$l2$1100:

; 256  : 	port = HD_DATA;		// ��dx Ϊ���ݼĴ����˿�(0x1f0)��
; 257  : 	outb_p (hd_info[drive].wpcom >> 2, ++port);	// ������дԤ���������(���4)��

	mov	eax, DWORD PTR _hd_info[ecx+12]
	mov	DWORD PTR _port$[ebp], 497		; 000001f1H
	sar	eax, 2
	mov	BYTE PTR $T1108[ebp], al

; 248  : 	register int port; //asm ("dx");	// port ������Ӧ�Ĵ���dx��

	mov	al, BYTE PTR $T1108[ebp]

; 249  : 

	mov	dx, WORD PTR _port$[ebp]

; 250  : 	if (drive > 1 || head > 15)	// �����������(0,1)>1 ���ͷ��>15�������֧�֡�

	out	dx, al

; 251  : 		panic ("Trying to write bad sector");

	jmp	SHORT $l1$1106
$l1$1106:

; 252  : 	if (!controller_ready ())	// ����ȴ�һ��ʱ�����δ���������������

	jmp	SHORT $l2$1107
$l2$1107:

; 258  : 	outb_p (nsect, ++port);	// ��������/д����������

	mov	DWORD PTR _port$[ebp], 498		; 000001f2H

; 248  : 	register int port; //asm ("dx");	// port ������Ӧ�Ĵ���dx��

	mov	al, BYTE PTR _nsect$[ebp]

; 249  : 

	mov	dx, WORD PTR _port$[ebp]

; 250  : 	if (drive > 1 || head > 15)	// �����������(0,1)>1 ���ͷ��>15�������֧�֡�

	out	dx, al

; 251  : 		panic ("Trying to write bad sector");

	jmp	SHORT $l1$1112
$l1$1112:

; 252  : 	if (!controller_ready ())	// ����ȴ�һ��ʱ�����δ���������������

	jmp	SHORT $l2$1113
$l2$1113:

; 259  : 	outb_p (sect, ++port);	// ��������ʼ������

	mov	DWORD PTR _port$[ebp], 499		; 000001f3H

; 248  : 	register int port; //asm ("dx");	// port ������Ӧ�Ĵ���dx��

	mov	al, BYTE PTR _sect$[ebp]

; 249  : 

	mov	dx, WORD PTR _port$[ebp]

; 250  : 	if (drive > 1 || head > 15)	// �����������(0,1)>1 ���ͷ��>15�������֧�֡�

	out	dx, al

; 251  : 		panic ("Trying to write bad sector");

	jmp	SHORT $l1$1117
$l1$1117:

; 252  : 	if (!controller_ready ())	// ����ȴ�һ��ʱ�����δ���������������

	jmp	SHORT $l2$1118
$l2$1118:

; 260  : 	outb_p (cyl, ++port);		// ����������ŵ�8 λ��

	mov	DWORD PTR _port$[ebp], 500		; 000001f4H

; 248  : 	register int port; //asm ("dx");	// port ������Ӧ�Ĵ���dx��

	mov	al, BYTE PTR _cyl$[ebp]

; 249  : 

	mov	dx, WORD PTR _port$[ebp]

; 250  : 	if (drive > 1 || head > 15)	// �����������(0,1)>1 ���ͷ��>15�������֧�֡�

	out	dx, al

; 251  : 		panic ("Trying to write bad sector");

	jmp	SHORT $l1$1122
$l1$1122:

; 252  : 	if (!controller_ready ())	// ����ȴ�һ��ʱ�����δ���������������

	jmp	SHORT $l2$1123
$l2$1123:

; 261  : 	outb_p (cyl >> 8, ++port);	// ����������Ÿ�8 λ��

	mov	ecx, DWORD PTR _cyl$[ebp]
	mov	DWORD PTR _port$[ebp], 501		; 000001f5H
	shr	ecx, 8
	mov	BYTE PTR $T1129[ebp], cl

; 248  : 	register int port; //asm ("dx");	// port ������Ӧ�Ĵ���dx��

	mov	al, BYTE PTR $T1129[ebp]

; 249  : 

	mov	dx, WORD PTR _port$[ebp]

; 250  : 	if (drive > 1 || head > 15)	// �����������(0,1)>1 ���ͷ��>15�������֧�֡�

	out	dx, al

; 251  : 		panic ("Trying to write bad sector");

	jmp	SHORT $l1$1127
$l1$1127:

; 252  : 	if (!controller_ready ())	// ����ȴ�һ��ʱ�����δ���������������

	jmp	SHORT $l2$1128
$l2$1128:

; 262  : 	outb_p (0xA0 | (drive << 4) | head, ++port);	// ��������������+��ͷ�š�

	mov	al, BYTE PTR _head$[ebp]
	or	bl, 250					; 000000faH
	shl	bl, 4
	or	bl, al
	mov	DWORD PTR _port$[ebp], 502		; 000001f6H
	mov	BYTE PTR $T1135[ebp], bl

; 248  : 	register int port; //asm ("dx");	// port ������Ӧ�Ĵ���dx��

	mov	al, BYTE PTR $T1135[ebp]

; 249  : 

	mov	dx, WORD PTR _port$[ebp]

; 250  : 	if (drive > 1 || head > 15)	// �����������(0,1)>1 ���ͷ��>15�������֧�֡�

	out	dx, al

; 251  : 		panic ("Trying to write bad sector");

	jmp	SHORT $l1$1133
$l1$1133:

; 252  : 	if (!controller_ready ())	// ����ȴ�һ��ʱ�����δ���������������

	jmp	SHORT $l2$1134
$l2$1134:

; 263  : 	outb (cmd, ++port);		// ���Ӳ�̿������

	mov	DWORD PTR _port$[ebp], 503		; 000001f7H

; 248  : 	register int port; //asm ("dx");	// port ������Ӧ�Ĵ���dx��

	mov	dx, WORD PTR _port$[ebp]

; 249  : 

	mov	al, BYTE PTR _cmd$[ebp]

; 250  : 	if (drive > 1 || head > 15)	// �����������(0,1)>1 ���ͷ��>15�������֧�֡�

	out	dx, al

; 263  : 	outb (cmd, ++port);		// ���Ӳ�̿������

	pop	ebx

; 264  : }

	pop	ebp
	ret	0
_hd_out	ENDP
$T1145 = -4
_controller_ready PROC NEAR

; 217  : {

	push	ebp
	mov	ebp, esp
	push	ecx

; 220  : 	while (--retries && (inb_p (HD_STATUS) & 0xc0) != 0x40);

	mov	ecx, 9999				; 0000270fH
	mov	DWORD PTR $T1145[ebp], 503		; 000001f7H
$L783:
	mov	dx, WORD PTR $T1145[ebp]

; 221  : 		return (retries);		// ���صȴ�ѭ���Ĵ�����

	in	al, dx
; File ..\include\asm/io.h

; 82   : {

	jmp	SHORT $l1$1143
$l1$1143:

; 83   : //	volatile unsigned char _v; 

	jmp	SHORT $l2$1144
$l2$1144:
; File ..\kernel\blk_drv\hd.c

; 220  : // ��������λ��0x1BE ��ʼ�ķ������Ƿ���Ч����󽫷�������Ϣ����Ӳ�̷������ݽṹhd �С�

	and	al, 192					; 000000c0H
	cmp	al, 64					; 00000040H
	je	SHORT $L1149
	dec	ecx
	jne	SHORT $L783
$L1149:

; 221  : 	for (drive = 0; drive < NR_HD; drive++)

	mov	eax, ecx

; 222  : 	{

	mov	esp, ebp
	pop	ebp
	ret	0
_controller_ready ENDP
_nr$ = 8
_reset_hd PROC NEAR

; 301  : // ��λ����ɹ�������0��������һ��ʱ����Ϊæ���򷵻�1��

	push	ebp
	mov	ebp, esp
	push	esi

; 302  : static int drive_busy (void)

	call	_reset_controller

; 303  : {
; 304  : 	unsigned int i;

	mov	ecx, DWORD PTR _nr$[ebp]
	push	OFFSET FLAT:_recal_intr
	push	145					; 00000091H
	lea	eax, DWORD PTR [ecx+ecx*2]
	shl	eax, 3
	mov	edx, DWORD PTR _hd_info[eax+4]
	mov	esi, DWORD PTR _hd_info[eax+8]
	mov	eax, DWORD PTR _hd_info[eax]
	push	esi
	dec	eax
	push	eax
	push	edx
	push	edx
	push	ecx
	call	_hd_out
	add	esp, 28					; 0000001cH
	pop	esi

; 305  : 

	pop	ebp
	ret	0
_reset_hd ENDP
_TEXT	ENDS
_DATA	SEGMENT
$SG856	DB	'HD-controller still busy', 0aH, 0dH, 00H
	ORG $+1
$SG859	DB	'HD-controller reset failed: %02x', 0aH, 0dH, 00H
_DATA	ENDS
_TEXT	SEGMENT
$T1155 = -1
$T1156 = -8
$T1160 = -1
$T1161 = -8
$T1165 = -8
$T1166 = -8
_reset_controller PROC NEAR

; 285  : {

	push	ebp
	mov	ebp, esp
	sub	esp, 8

; 288  : 	outb (4, HD_CMD);		// ����ƼĴ����˿ڷ��Ϳ����ֽ�(4-��λ)��

	mov	ecx, 1014				; 000003f6H
	mov	BYTE PTR $T1155[ebp], 4
	mov	DWORD PTR $T1156[ebp], ecx

; 286  : 	int i;

	mov	dx, WORD PTR $T1156[ebp]

; 287  : 

	mov	al, BYTE PTR $T1155[ebp]

; 288  : 	outb (4, HD_CMD);		// ����ƼĴ����˿ڷ��Ϳ����ֽ�(4-��λ)��

	out	dx, al
	mov	eax, 100				; 00000064H
$L850:

; 290  : 		nop ();			// �ȴ�һ��ʱ�䣨ѭ���ղ�������

	npad	1

; 289  : 	for (i = 0; i < 100; i++)

	dec	eax
	jne	SHORT $L850

; 291  : 	outb (hd_info[0].ctl & 0x0f, HD_CMD);	// �ٷ��������Ŀ����ֽ�(����ֹ���ԡ��ض�)��

	mov	al, BYTE PTR _hd_info+20
	mov	DWORD PTR $T1161[ebp], ecx
	and	al, 15					; 0000000fH
	mov	BYTE PTR $T1160[ebp], al

; 286  : 	int i;

	mov	dx, WORD PTR $T1161[ebp]

; 287  : 

	mov	al, BYTE PTR $T1160[ebp]

; 288  : 	outb (4, HD_CMD);		// ����ƼĴ����˿ڷ��Ϳ����ֽ�(4-��λ)��

	out	dx, al

; 292  : 	if (drive_busy ())		// ���ȴ�Ӳ�̾�����ʱ������ʾ������Ϣ��

	call	_drive_busy
	test	eax, eax
	je	SHORT $L855

; 293  : 		printk ("HD-controller still busy\n\r");

	push	OFFSET FLAT:$SG856
	call	_printk
	add	esp, 4
$L855:

; 294  : 	if ((i = inb (HD_ERROR)) != 1)	// ȡ����Ĵ�������������1���޴��������

	mov	DWORD PTR $T1165[ebp], 497		; 000001f1H

; 287  : 

	mov	dx, WORD PTR $T1165[ebp]

; 288  : 	outb (4, HD_CMD);		// ����ƼĴ����˿ڷ��Ϳ����ֽ�(4-��λ)��

	in	al, dx

; 294  : 	if ((i = inb (HD_ERROR)) != 1)	// ȡ����Ĵ�������������1���޴��������

	mov	BYTE PTR $T1166[ebp], al
	mov	eax, DWORD PTR $T1166[ebp]
	and	eax, 255				; 000000ffH
	cmp	eax, 1
	je	SHORT $L858

; 295  : 		printk ("HD-controller reset failed: %02x\n\r", i);

	push	eax
	push	OFFSET FLAT:$SG859
	call	_printk
	add	esp, 8
$L858:

; 296  : }

	mov	esp, ebp
	pop	ebp
	ret	0
_reset_controller ENDP
_TEXT	ENDS
_DATA	SEGMENT
	ORG $+1
$SG843	DB	'HD controller times out', 0aH, 0dH, 00H
_DATA	ENDS
_TEXT	SEGMENT
$T1175 = -4
$T1180 = -4
_drive_busy PROC NEAR

; 269  : {

	push	ebp
	mov	ebp, esp
	push	ecx

; 272  : 	for (i = 0; i < 10000; i++)	// ѭ���ȴ�������־λ��λ��

	xor	ecx, ecx

; 273  : 		if (READY_STAT == (inb_p (HD_STATUS) & (BUSY_STAT | READY_STAT)))

	mov	DWORD PTR $T1175[ebp], 503		; 000001f7H
$L836:

; 272  : 	for (i = 0; i < 10000; i++)	// ѭ���ȴ�������־λ��λ��

	mov	dx, WORD PTR $T1175[ebp]

; 273  : 		if (READY_STAT == (inb_p (HD_STATUS) & (BUSY_STAT | READY_STAT)))

	in	al, dx

; 274  : 			break;
; 275  : 	i = inb (HD_STATUS);	// ��ȡ��������״̬�ֽڡ�

	jmp	SHORT $l1$1173
$l1$1173:

; 276  : 	i &= BUSY_STAT | READY_STAT | SEEK_STAT;	// ���æλ������λ��Ѱ������λ��

	jmp	SHORT $l2$1174
$l2$1174:

; 273  : 		if (READY_STAT == (inb_p (HD_STATUS) & (BUSY_STAT | READY_STAT)))

	and	al, 192					; 000000c0H
	cmp	al, 64					; 00000040H
	je	SHORT $L1183
	inc	ecx
	cmp	ecx, 10000				; 00002710H
	jb	SHORT $L836
$L1183:

; 274  : 			break;
; 275  : 	i = inb (HD_STATUS);	// ��ȡ��������״̬�ֽڡ�

	mov	DWORD PTR $T1180[ebp], 503		; 000001f7H

; 270  : 	unsigned int i;
; 271  : 

	mov	dx, WORD PTR $T1180[ebp]

; 272  : 	for (i = 0; i < 10000; i++)	// ѭ���ȴ�������־λ��λ��

	in	al, dx

; 276  : 	i &= BUSY_STAT | READY_STAT | SEEK_STAT;	// ���æλ������λ��Ѱ������λ��

	and	al, 208					; 000000d0H

; 277  : 	if (i == READY_STAT | SEEK_STAT)	// �����о�����Ѱ��������־���򷵻�0��

	xor	ecx, ecx
	cmp	al, 64					; 00000040H
	sete	cl
	or	ecx, 16					; 00000010H
	je	SHORT $L842

; 278  : 		return (0);

	xor	eax, eax

; 281  : }

	mov	esp, ebp
	pop	ebp
	ret	0
$L842:

; 279  : 	printk ("HD controller times out\n\r");	// ����ȴ���ʱ����ʾ��Ϣ��������1��

	push	OFFSET FLAT:$SG843
	call	_printk
	add	esp, 4

; 280  : 	return (1);

	mov	eax, 1

; 281  : }

	mov	esp, ebp
	pop	ebp
	ret	0
_drive_busy ENDP
_bad_rw_intr PROC NEAR

; 318  : 	if (++CURRENT->errors >= MAX_ERRORS)	// ���������ʱ�ĳ���������ڻ����7 ��ʱ��

	mov	eax, DWORD PTR _blk_dev+28
	mov	edx, DWORD PTR [eax+8]
	inc	edx
	mov	ecx, edx
	mov	DWORD PTR [eax+8], edx
	cmp	ecx, 7
	jl	$L1196
	push	esi

; 319  : 		end_request (0);		// ��������󲢻��ѵȴ�������Ľ��̣�����

	mov	esi, DWORD PTR [eax+28]
	test	esi, esi
	je	SHORT $L1200
	mov	al, BYTE PTR [esi+13]
	mov	BYTE PTR [esi+10], 0
	test	al, al
	jne	SHORT $L1195
	push	OFFSET FLAT:??_C@_0CG@MGAL@harddisk?3?5free?5buffer?5being?5unlo@ ; `string'
	call	_printk
	add	esp, 4
$L1195:
	mov	BYTE PTR [esi+13], 0
	add	esi, 16					; 00000010H
	push	esi
	call	_wake_up
	add	esp, 4
$L1200:
	push	OFFSET FLAT:??_C@_0BF@DOHJ@harddisk?5I?1O?5error?6?$AN?$AA@ ; `string'
	call	_printk
	mov	eax, DWORD PTR _blk_dev+28
	mov	ecx, DWORD PTR [eax+28]
	mov	eax, DWORD PTR [eax]
	mov	edx, DWORD PTR [ecx+4]
	push	edx
	push	eax
	push	OFFSET FLAT:??_C@_0BF@ONON@dev?5?$CF04x?0?5block?5?$CFd?6?$AN?$AA@ ; `string'
	call	_printk
	mov	ecx, DWORD PTR _blk_dev+28
	add	ecx, 24					; 00000018H
	push	ecx
	call	_wake_up
	push	OFFSET FLAT:_wait_for_request
	call	_wake_up
	mov	eax, DWORD PTR _blk_dev+28
	add	esp, 24					; 00000018H
	mov	DWORD PTR [eax], -1
	mov	eax, DWORD PTR [eax+32]
	mov	DWORD PTR _blk_dev+28, eax
	pop	esi
$L1196:

; 320  : // ��Ӧ���������±�־��λ��û�и��£���
; 321  : 	if (CURRENT->errors > MAX_ERRORS / 2)	// �����һ����ʱ�ĳ�������Ѿ�����3 �Σ�

	cmp	DWORD PTR [eax+8], 3
	jle	SHORT $L872

; 322  : 		reset = 1;			// ��Ҫ��ִ�и�λӲ�̿�����������

	mov	DWORD PTR _reset, 1
$L872:

; 323  : }

	ret	0
_bad_rw_intr ENDP
$T1205 = -12
$T1206 = -8
$T1207 = -4
_read_intr PROC NEAR

; 327  : {

	push	ebp
	mov	ebp, esp
	sub	esp, 12					; 0000000cH
	push	esi
	push	edi

; 328  : 	if (win_result ())

	call	_win_result
	test	eax, eax
	je	SHORT $L876

; 330  : 		bad_rw_intr ();		// ����ж�дӲ��ʧ�ܴ���

	call	_bad_rw_intr

; 344  : 	do_hd_request ();		// ִ������Ӳ�����������

	call	_do_hd_request

; 345  : }

	pop	edi
	pop	esi
	mov	esp, ebp
	pop	ebp
	ret	0
$L876:

; 334  : 	port_read (HD_DATA, CURRENT->buffer, 256);	// �����ݴ����ݼĴ����ڶ�������ṹ��������

	mov	eax, DWORD PTR _blk_dev+28
	mov	DWORD PTR $T1207[ebp], 256		; 00000100H
	mov	DWORD PTR $T1205[ebp], 496		; 000001f0H
	mov	ecx, DWORD PTR [eax+20]
	mov	DWORD PTR $T1206[ebp], ecx

; 328  : 	if (win_result ())

	pushf

; 329  : 	{				// ��������æ����д�������ִ�д�

	mov	dx, WORD PTR $T1205[ebp]

; 330  : 		bad_rw_intr ();		// ����ж�дӲ��ʧ�ܴ���

	mov	edi, DWORD PTR $T1206[ebp]

; 331  : 		do_hd_request ();		// Ȼ���ٴ�����Ӳ������Ӧ(��λ)����

	mov	ecx, DWORD PTR $T1207[ebp]

; 332  : 		return;

	cld

; 333  : 	}

	rep	 insw

; 334  : 	port_read (HD_DATA, CURRENT->buffer, 256);	// �����ݴ����ݼĴ����ڶ�������ṹ��������

	popf

; 335  : 	CURRENT->errors = 0;		// ����������

	mov	eax, DWORD PTR _blk_dev+28
	mov	DWORD PTR [eax+8], 0

; 336  : 	CURRENT->buffer += 512;	// ����������ָ�룬ָ���µĿ�����

	mov	esi, DWORD PTR [eax+20]
	add	esi, 512				; 00000200H
	mov	DWORD PTR [eax+20], esi

; 337  : 	CURRENT->sector++;		// ��ʼ�����ż�1��

	mov	edx, DWORD PTR [eax+12]
	inc	edx
	mov	DWORD PTR [eax+12], edx

; 338  : 	if (--CURRENT->nr_sectors)

	mov	ecx, DWORD PTR [eax+16]
	dec	ecx
	mov	DWORD PTR [eax+16], ecx
	je	SHORT $L877

; 339  : 	{				// ��������������������û�ж��꣬��
; 340  : 		do_hd = &read_intr;	// �ٴ���Ӳ�̵���C ����ָ��Ϊread_intr()

	mov	DWORD PTR _do_hd, OFFSET FLAT:_read_intr

; 345  : }

	pop	edi
	pop	esi
	mov	esp, ebp
	pop	ebp
	ret	0
$L877:

; 341  : 		return;			// ��ΪӲ���жϴ������ÿ�ε���do_hd ʱ
; 342  : 	}				// ���Ὣ�ú���ָ���ÿա��μ�system_call.s
; 343  : 	end_request (1);		// ��ȫ�����������Ѿ����꣬��������������ˣ�

	mov	esi, DWORD PTR [eax+28]
	test	esi, esi
	je	SHORT $L1220
	mov	al, BYTE PTR [esi+13]
	mov	BYTE PTR [esi+10], 1
	test	al, al
	jne	SHORT $L1217
	push	OFFSET FLAT:??_C@_0CG@MGAL@harddisk?3?5free?5buffer?5being?5unlo@ ; `string'
	call	_printk
	add	esp, 4
$L1217:
	mov	BYTE PTR [esi+13], 0
	add	esi, 16					; 00000010H
	push	esi
	call	_wake_up
	mov	eax, DWORD PTR _blk_dev+28
	add	esp, 4
$L1220:
	add	eax, 24					; 00000018H
	push	eax
	call	_wake_up
	push	OFFSET FLAT:_wait_for_request
	call	_wake_up
	mov	eax, DWORD PTR _blk_dev+28
	add	esp, 8
	mov	DWORD PTR [eax], -1
	mov	edx, DWORD PTR [eax+32]
	mov	DWORD PTR _blk_dev+28, edx

; 344  : 	do_hd_request ();		// ִ������Ӳ�����������

	call	_do_hd_request

; 345  : }

	pop	edi
	pop	esi
	mov	esp, ebp
	pop	ebp
	ret	0
_read_intr ENDP
$T1229 = -4
$T1230 = -4
$T1234 = -4
_win_result PROC NEAR

; 228  : {

	push	ebp
	mov	ebp, esp
	push	ecx

; 229  : 	int i = inb_p (HD_STATUS);	// ȡ״̬��Ϣ��

	mov	DWORD PTR $T1229[ebp], 503		; 000001f7H

; 231  : 	if ((i & (BUSY_STAT | READY_STAT | WRERR_STAT | SEEK_STAT | ERR_STAT))

	mov	dx, WORD PTR $T1229[ebp]

; 232  : 		== (READY_STAT | SEEK_STAT))

	in	al, dx

; 234  : 	if (i & 1)

	jmp	SHORT $l1$1227
$l1$1227:

; 235  : 		i = inb (HD_ERROR);	// ��ERR_STAT ��λ�����ȡ����Ĵ�����

	jmp	SHORT $l2$1228
$l2$1228:

; 229  : 	int i = inb_p (HD_STATUS);	// ȡ״̬��Ϣ��

	mov	BYTE PTR $T1230[ebp], al
	mov	eax, DWORD PTR $T1230[ebp]
	and	eax, 255				; 000000ffH

; 232  : 		== (READY_STAT | SEEK_STAT))

	mov	ecx, eax
	and	ecx, 241				; 000000f1H
	cmp	cl, 80					; 00000050H
	jne	SHORT $L790

; 233  : 		return (0);		/* ok */

	xor	eax, eax

; 237  : }

	mov	esp, ebp
	pop	ebp
	ret	0
$L790:

; 234  : 	if (i & 1)

	test	al, 1
	je	SHORT $L791

; 235  : 		i = inb (HD_ERROR);	// ��ERR_STAT ��λ�����ȡ����Ĵ�����

	mov	DWORD PTR $T1234[ebp], 497		; 000001f1H

; 230  : 

	mov	dx, WORD PTR $T1234[ebp]

; 231  : 	if ((i & (BUSY_STAT | READY_STAT | WRERR_STAT | SEEK_STAT | ERR_STAT))

	in	al, dx

; 235  : 		i = inb (HD_ERROR);	// ��ERR_STAT ��λ�����ȡ����Ĵ�����

$L791:

; 236  : 	return (1);

	mov	eax, 1

; 237  : }

	mov	esp, ebp
	pop	ebp
	ret	0
_win_result ENDP
$T1240 = -12
$T1241 = -8
$T1242 = -4
_write_intr PROC NEAR

; 351  : {

	push	ebp
	mov	ebp, esp
	sub	esp, 12					; 0000000cH
	push	esi

; 352  : 	if (win_result ())

	call	_win_result
	test	eax, eax
	je	SHORT $L881

; 354  : 		bad_rw_intr ();		// �����Ƚ���Ӳ�̶�дʧ�ܴ���

	call	_bad_rw_intr

; 367  : 	do_hd_request ();		// ִ������Ӳ�����������

	call	_do_hd_request

; 368  : }

	pop	esi
	mov	esp, ebp
	pop	ebp
	ret	0
$L881:

; 358  : 	if (--CURRENT->nr_sectors)

	mov	eax, DWORD PTR _blk_dev+28
	mov	ecx, DWORD PTR [eax+16]
	dec	ecx
	mov	DWORD PTR [eax+16], ecx
	je	SHORT $L882

; 359  : 	{				// ������д��������1������������Ҫд����
; 360  : 		CURRENT->sector++;	// ��ǰ������ʼ������+1��

	mov	edx, DWORD PTR [eax+12]

; 361  : 		CURRENT->buffer += 512;	// �������󻺳���ָ�룬
; 362  : 		do_hd = &write_intr;	// ��Ӳ���жϳ�����ú���ָ��Ϊwrite_intr()��

	mov	DWORD PTR _do_hd, OFFSET FLAT:_write_intr
	inc	edx

; 363  : 		port_write (HD_DATA, CURRENT->buffer, 256);	// �������ݼĴ����˿�д256 �ֽڡ�

	mov	DWORD PTR $T1242[ebp], 256		; 00000100H
	mov	DWORD PTR [eax+12], edx
	mov	ecx, DWORD PTR [eax+20]
	add	ecx, 512				; 00000200H
	mov	DWORD PTR $T1240[ebp], 496		; 000001f0H
	mov	DWORD PTR [eax+20], ecx
	mov	eax, ecx
	mov	DWORD PTR $T1241[ebp], eax

; 352  : 	if (win_result ())

	pushf

; 353  : 	{				// ���Ӳ�̿��������ش�����Ϣ��

	mov	dx, WORD PTR $T1240[ebp]

; 354  : 		bad_rw_intr ();		// �����Ƚ���Ӳ�̶�дʧ�ܴ���

	mov	esi, DWORD PTR $T1241[ebp]

; 355  : 		do_hd_request ();		// Ȼ���ٴ�����Ӳ������Ӧ(��λ)����

	mov	ecx, DWORD PTR $T1242[ebp]

; 356  : 		return;			// Ȼ�󷵻أ�Ҳ�˳��˴˴�Ӳ���жϣ���

	cld

; 357  : 	}

	rep	 outsw

; 358  : 	if (--CURRENT->nr_sectors)

	popf

; 368  : }

	pop	esi
	mov	esp, ebp
	pop	ebp
	ret	0
$L882:

; 364  : 		return;			// ���صȴ�Ӳ���ٴ����д��������жϴ���
; 365  : 	}
; 366  : 	end_request (1);		// ��ȫ�����������Ѿ�д�꣬��������������ˣ�

	mov	esi, DWORD PTR [eax+28]
	test	esi, esi
	je	SHORT $L1255
	mov	al, BYTE PTR [esi+13]
	mov	BYTE PTR [esi+10], 1
	test	al, al
	jne	SHORT $L1252
	push	OFFSET FLAT:??_C@_0CG@MGAL@harddisk?3?5free?5buffer?5being?5unlo@ ; `string'
	call	_printk
	add	esp, 4
$L1252:
	mov	BYTE PTR [esi+13], 0
	add	esi, 16					; 00000010H
	push	esi
	call	_wake_up
	mov	eax, DWORD PTR _blk_dev+28
	add	esp, 4
$L1255:
	add	eax, 24					; 00000018H
	push	eax
	call	_wake_up
	push	OFFSET FLAT:_wait_for_request
	call	_wake_up
	mov	eax, DWORD PTR _blk_dev+28
	add	esp, 8
	mov	DWORD PTR [eax], -1
	mov	eax, DWORD PTR [eax+32]
	mov	DWORD PTR _blk_dev+28, eax

; 367  : 	do_hd_request ();		// ִ������Ӳ�����������

	call	_do_hd_request

; 368  : }

	pop	esi
	mov	esp, ebp
	pop	ebp
	ret	0
_write_intr ENDP
_recal_intr PROC NEAR

; 374  : 	if (win_result ())

	call	_win_result
	test	eax, eax
	je	SHORT $L885

; 375  : 		bad_rw_intr ();

	call	_bad_rw_intr
$L885:

; 376  : 	do_hd_request ();

	jmp	_do_hd_request
_recal_intr ENDP
_TEXT	ENDS
END
