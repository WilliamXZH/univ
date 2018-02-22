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

; 89   : 		cld   /*�巽��λ��*/

	cld
$l1$742:

; 90   : 	l1: lodsd   /*ȡ[esi] -> eax��*/

	lodsd

; 91   : 		not eax   /*eax ��ÿλȡ����*/

	not	eax

; 92   : 		bsf edx,eax   /*��λ0 ɨ��eax ����1 �ĵ�1 ��λ����ƫ��ֵ -> edx��*/

	bsf	edx, eax

; 93   : 		je l2   /*���eax ��ȫ��0������ǰ��ת�����2 ��(40 ��)��*/

	je	SHORT $l2$743

; 94   : 		add ecx,edx   /*ƫ��ֵ����ecx(ecx ����λͼ���׸���0 �ı���λ��ƫ��ֵ)*/

	add	ecx, edx

; 95   : 		jmp l3   /*��ǰ��ת�����3 ������������*/

	jmp	SHORT $l3$744
$l2$743:

; 96   : 	l2: add ecx,32   /*û���ҵ�0 ����λ����ecx ����1 �����ֵ�λƫ����32��*/

	add	ecx, 32					; 00000020H

; 97   : 		cmp ecx,8192   /*�Ѿ�ɨ����8192 λ��1024 �ֽڣ�����*/

	cmp	ecx, 8192				; 00002000H

; 98   : 		jl l1  /*����û��ɨ����1 �����ݣ�����ǰ��ת�����1 ����������*/

	jl	SHORT $l1$742
$l3$744:

; 99   : //	l3: mov __res,ecx  /*��������ʱecx ����λƫ������*/
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

; 135  : // ��hash ����Ѱ�Ҹÿ����ݡ����ҵ������ж�����Ч�ԣ��������޸ĺ͸��±�־���ͷŸ����ݿ顣
; 136  : // �öδ������Ҫ��;��������߼��鵱ǰ�����ڸ��ٻ����У����ͷŶ�Ӧ�Ļ���顣
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
; 144  : 		bh->b_dirt=0;		// ��λ�ࣨ���޸ģ���־λ��
; 145  : 		bh->b_uptodate=0;	// ��λ���±�־��
; 146  : 		brelse(bh);

	push	eax
	mov	BYTE PTR [eax+11], 0
	mov	BYTE PTR [eax+10], 0
	call	_brelse
	add	esp, 4
$L757:

; 147  : 	}
; 148  : // ����block ����������ʼ����������߼���ţ���1 ��ʼ��������Ȼ����߼���(����)λͼ���в�����
; 149  : // ��λ��Ӧ�ı���λ������Ӧ����λԭ������0�������������
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

; 129  : // ȡָ���豸dev �ĳ����飬���ָ���豸�����ڣ������������

	mov	ebx, DWORD PTR $T861[ebp]

; 130  : 	if (!(sb = get_super(dev)))

	mov	edx, DWORD PTR $T862[ebp]

; 131  : 		panic("trying to free block on nonexistent device");

	btr	DWORD PTR [edx], ebx

; 132  : // ���߼����С���׸��߼���Ż��ߴ����豸�����߼������������������

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
; 155  : 	// ����Ӧ�߼���λͼ���ڻ��������޸ı�־��
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

; 167  : // ���豸dev ȡ�����飬���ָ���豸�����ڣ������������

	mov	esi, DWORD PTR $T873[ebp]

; 168  : 	if (!(sb = get_super(dev)))

	cld
$l1$869:

; 169  : 		panic("trying to get new block from nonexistant device");

	lodsd

; 170  : // ɨ���߼���λͼ��Ѱ���׸�0 ����λ��Ѱ�ҿ����߼��飬��ȡ���ø��߼���Ŀ�š�

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

; 176  : // ���ȫ��ɨ���껹û�ҵ�(i>=8 ��j>=8192)����λͼ���ڵĻ������Ч(bh=NULL)�򷵻�0��

	cmp	ecx, 8192				; 00002000H

; 177  : // �˳���û�п����߼��飩��

	jl	SHORT $l1$869
$l3$871:

; 179  : 		return 0;

	mov	eax, ecx

; 180  : // �������߼����Ӧ�߼���λͼ�еı���λ������Ӧ����λ�Ѿ���λ�������������

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

; 167  : // ���豸dev ȡ�����飬���ָ���豸�����ڣ������������

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

; 183  : // �ö�Ӧ������������޸ı�־��������߼�����ڸ��豸�ϵ����߼���������˵��ָ���߼�����
; 184  : // ��Ӧ�豸�ϲ����ڡ�����ʧ�ܣ�����0���˳���
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

; 189  : // ��ȡ�豸�ϵĸ����߼������ݣ���֤�������ʧ����������
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

; 192  : // �¿�����ü���ӦΪ1������������
; 193  : 	if (bh->b_count != 1)

	cmp	BYTE PTR [esi+12], 1
	je	SHORT $L784

; 194  : 		panic("new block: count is != 1");

	push	OFFSET FLAT:$SG785
	call	_panic
	add	esp, 4
$L784:

; 195  : // �������߼������㣬����λ���±�־�����޸ı�־��Ȼ���ͷŶ�Ӧ�������������߼���š�
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

; 167  : // ���豸dev ȡ�����飬���ָ���豸�����ڣ������������

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

; 210  : 	// ���i �ڵ�ָ��=NULL�����˳���

	mov	ecx, 56					; 00000038H

; 211  : 	if (!inode)

	mov	al, 0

; 212  : 		return;

	cld

; 213  : // ���i �ڵ��ϵ��豸���ֶ�Ϊ0��˵���ýڵ����ã�����0 ��ն�Ӧi �ڵ���ռ�ڴ����������ء�

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
; 218  : // �����i �ڵ㻹�������������ã������ͷţ�˵���ں������⣬������
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
; 223  : // ����ļ�Ŀ¼����������Ϊ0�����ʾ���������ļ�Ŀ¼����ʹ�øýڵ㣬
; 224  : // ��Ӧ�ͷţ���Ӧ�÷Żصȡ�
; 225  : 	if (inode->i_nlinks)

	mov	al, BYTE PTR [ebx+13]
	test	al, al
	je	SHORT $L796

; 226  : 		panic("trying to free inode with links");

	push	OFFSET FLAT:$SG797
	call	_panic
	add	esp, 4
$L796:

; 227  : // ȡi �ڵ������豸�ĳ����飬�����豸�Ƿ���ڡ�
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

; 230  : // ���i �ڵ��=0 ����ڸ��豸��i �ڵ������������0 ��i �ڵ㱣��û��ʹ�ã���
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

; 233  : // �����i �ڵ��Ӧ�Ľڵ�λͼ�����ڣ������
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

; 236  : // ��λi �ڵ��Ӧ�Ľڵ�λͼ�еı���λ������ñ���λ�Ѿ�����0�������
; 237  : 	if (clear_bit(inode->i_num&8191,bh->b_data))

	mov	ecx, DWORD PTR [edi]
	and	esi, 8191				; 00001fffH
	mov	DWORD PTR $T896[ebp], ecx
	mov	DWORD PTR $T895[ebp], esi

; 209  : 

	xor	eax, eax

; 210  : 	// ���i �ڵ�ָ��=NULL�����˳���

	mov	ebx, DWORD PTR $T895[ebp]

; 211  : 	if (!inode)

	mov	edx, DWORD PTR $T896[ebp]

; 212  : 		return;

	btr	DWORD PTR [edx], ebx

; 213  : // ���i �ڵ��ϵ��豸���ֶ�Ϊ0��˵���ýڵ����ã�����0 ��ն�Ӧi �ڵ���ռ�ڴ����������ء�

	setae	al

; 236  : // ��λi �ڵ��Ӧ�Ľڵ�λͼ�еı���λ������ñ���λ�Ѿ�����0�������
; 237  : 	if (clear_bit(inode->i_num&8191,bh->b_data))

	test	eax, eax
	je	SHORT $L805

; 238  : 		printk("free_inode: bit already cleared.\n\r");

	push	OFFSET FLAT:$SG806
	call	_printk
	add	esp, 4
$L805:

; 239  : // ��i �ڵ�λͼ���ڻ��������޸ı�־������ո�i �ڵ�ṹ��ռ�ڴ�����
; 240  : 	bh->b_dirt = 1;

	mov	BYTE PTR [edi+11], 1

; 207  : 	struct super_block * sb;
; 208  : 	struct buffer_head * bh;

	pushf

; 209  : 

	mov	edi, DWORD PTR _inode$[ebp]

; 210  : 	// ���i �ڵ�ָ��=NULL�����˳���

	mov	ecx, 56					; 00000038H

; 211  : 	if (!inode)

	mov	al, 0

; 212  : 		return;

	cld

; 213  : // ���i �ڵ��ϵ��豸���ֶ�Ϊ0��˵���ýڵ����ã�����0 ��ն�Ӧi �ڵ���ռ�ڴ����������ء�

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

; 253  : // ���ڴ�i �ڵ��(inode_table)�л�ȡһ������i �ڵ���(inode)��

	cld
$l1$905:

; 254  : 	if (!(inode=get_empty_inode()))

	lodsd

; 255  : 		return NULL;

	not	eax

; 256  : // ��ȡָ���豸�ĳ�����ṹ��

	bsf	edx, eax

; 257  : 	if (!(sb = get_super(dev)))

	je	SHORT $l2$906

; 258  : 		panic("new_inode with unknown device");

	add	ecx, edx

; 259  : // ɨ��i �ڵ�λͼ��Ѱ���׸�0 ����λ��Ѱ�ҿ��нڵ㣬��ȡ���ø�i �ڵ�Ľڵ�š�

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

; 265  : // ���ȫ��ɨ���껹û�ҵ�������λͼ���ڵĻ������Ч(bh=NULL)�򷵻�0���˳���û�п���i �ڵ㣩��

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
; 270  : // ��λ��Ӧ��i �ڵ��i �ڵ�λͼ��Ӧ����λ������Ѿ���λ�������
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

; 253  : // ���ڴ�i �ڵ��(inode_table)�л�ȡһ������i �ڵ���(inode)��

	bts	DWORD PTR [edx], ebx

; 254  : 	if (!(inode=get_empty_inode()))

	setb	al

; 268  : 		return NULL;
; 269  : 	}
; 270  : // ��λ��Ӧ��i �ڵ��i �ڵ�λͼ��Ӧ����λ������Ѿ���λ�������
; 271  : 	if (set_bit(j,bh->b_data))

	test	eax, eax
	je	SHORT $L825

; 272  : 		panic("new_inode: bit already set");

	push	OFFSET FLAT:$SG826
	call	_panic
	add	esp, 4
$L825:

; 273  : // ��i �ڵ�λͼ���ڻ��������޸ı�־��
; 274  : 	bh->b_dirt = 1;
; 275  : // ��ʼ����i �ڵ�ṹ��
; 276  : 	inode->i_count=1;		// ���ü�����
; 277  : 	inode->i_nlinks=1;		// �ļ�Ŀ¼����������
; 278  : 	inode->i_dev=dev;		// i �ڵ����ڵ��豸�š�

	mov	ax, WORD PTR _dev$[ebp]
	mov	edx, DWORD PTR _bh$[ebp]
	mov	WORD PTR [edi+44], ax

; 279  : 	inode->i_uid=current->euid;		// i �ڵ������û�id��

	mov	eax, DWORD PTR _current
	mov	ecx, 1
	mov	BYTE PTR [edx+11], cl
	mov	dx, WORD PTR [eax+578]

; 280  : 	inode->i_gid=current->egid;		// ��id��

	mov	al, BYTE PTR [eax+584]
	mov	WORD PTR [edi+48], cx
	mov	BYTE PTR [edi+12], al

; 281  : 	inode->i_dirt=1;			// ���޸ı�־��λ��
; 282  : 	inode->i_num = j + i*8192;	// ��Ӧ�豸�е�i �ڵ�š�

	mov	eax, DWORD PTR _i$[ebp]
	shl	eax, 13					; 0000000dH
	add	eax, esi
	mov	BYTE PTR [edi+13], cl
	mov	WORD PTR [edi+2], dx
	mov	BYTE PTR [edi+51], cl
	mov	WORD PTR [edi+46], ax

; 283  : 	inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME;	// ����ʱ�䡣

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

; 284  : 	return inode;	// ���ظ�i �ڵ�ָ�롣

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

	je	SHORT $l1$672

; 278  : 		xchg ecx,current/* current = task[n]�� */

	xchg	ecx, DWORD PTR _current

; 279  : 		/*ִ�г���ת����������л� (ͷ���˺ܳ�ʱ�䣬������)*/
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

; 289  : // �������л�������Ż����ִ���������䡣
; 290  : 		cmp last_task_used_math,ecx /* �������ϴ�ʹ�ù�Э��������*/

	cmp	DWORD PTR _last_task_used_math, ecx

; 291  : 		jne l1

	jne	SHORT $l1$672

; 292  : 		clts/* �������ϴ�ʹ�ù�Э������������cr0 ��TS ��־��*/

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
END
