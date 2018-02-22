	TITLE	..\mm\memory.c
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
;	COMDAT __set_tssldt_desc
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
;	COMDAT __copy_page
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
FLAT	GROUP _DATA, CONST, _BSS
	ASSUME	CS: FLAT, DS: FLAT, SS: FLAT
endif
_BSS	SEGMENT
_HIGH_MEMORY DD	01H DUP (?)
_mem_map DB	0f00H DUP (?)
_BSS	ENDS
_DATA	SEGMENT
$SG574	DB	'out of memory', 0aH, 0dH, 00H
_DATA	ENDS
PUBLIC	_get_free_page
_TEXT	SEGMENT
_get_free_page PROC NEAR

; 101  : {

	push	edi

; 102  : //	unsigned long __res = mem_map+PAGING_PAGES-1;
; 103  : 	__asm {
; 104  : 		pushf

	pushf

; 105  : 		xor eax, eax

	xor	eax, eax

; 106  : 		mov ecx,PAGING_PAGES

	mov	ecx, 3840				; 00000f00H

; 107  : //		mov edi,__res 
; 108  : 		mov edi,offset mem_map + PAGING_PAGES - 1

	mov	edi, OFFSET FLAT:_mem_map+3839

; 109  : 		std

	std

; 110  : 		repne scasb		// ����λ��λ����al(0)���Ӧ(di)ÿ��ҳ������ݱȽϣ�

	repnz	 scasb

; 111  : 		jne l1		// ���û�е���0 ���ֽڣ�����ת����������0����

	jne	SHORT $l1$585

; 112  : 		mov byte ptr [edi+1],1	// ����Ӧҳ����ڴ�ӳ��λ��1��

	mov	BYTE PTR [edi+1], 1

; 113  : 		sal ecx,12	// ҳ����*4K = ���ҳ����ʼ��ַ��

	shl	ecx, 12					; 0000000cH

; 114  : 		add ecx,LOW_MEM	// �ټ��ϵͶ��ڴ��ַ�������ҳ��ʵ��������ʼ��ַ��

	add	ecx, 1048576				; 00100000H

; 115  : 		mov edx,ecx	// ��ҳ��ʵ����ʼ��ַ -> edx �Ĵ�����

	mov	edx, ecx

; 116  : 		mov ecx,1024	// �Ĵ���ecx �ü���ֵ1024��

	mov	ecx, 1024				; 00000400H

; 117  : 		lea edi,[edx+4092]// ��4092+edx ��λ�� -> edi(��ҳ���ĩ��)��

	lea	edi, DWORD PTR [edx+4092]

; 118  : 		rep stosd	// ��edi ��ָ�ڴ����㣨������Ҳ������ҳ�����㣩��

	rep	 stosd

; 119  : //		mov __res,edx	// ��ҳ����ʼ��ַ -> __res������ֵ����
; 120  : 		mov eax,edx

	mov	eax, edx
$l1$585:

; 121  : 	l1:	popf

	popf

; 122  : 	}
; 123  : //	return __res;// ���ؿ���ҳ���ַ������޿���Ҳ�򷵻�0����
; 124  : }

	pop	edi
	ret	0
_get_free_page ENDP
_TEXT	ENDS
PUBLIC	_free_page
EXTRN	_panic:NEAR
_DATA	SEGMENT
$SG591	DB	'trying to free nonexistent page', 00H
$SG593	DB	'trying to free free page', 00H
_DATA	ENDS
_TEXT	SEGMENT
_addr$ = 8
_free_page PROC NEAR

; 153  : {

	push	ebp
	mov	ebp, esp
	push	esi

; 154  : 	if (addr < LOW_MEM) return;// ��������ַaddr С���ڴ�Ͷˣ�1MB�����򷵻ء�

	mov	esi, DWORD PTR _addr$[ebp]
	cmp	esi, 1048576				; 00100000H
	jb	SHORT $L588

; 155  : 	if (addr >= HIGH_MEMORY)// ��������ַaddr>=�ڴ���߶ˣ�����ʾ������Ϣ��

	cmp	esi, DWORD PTR _HIGH_MEMORY
	jb	SHORT $L590

; 156  : 		panic("trying to free nonexistent page");

	push	OFFSET FLAT:$SG591
	call	_panic
	add	esp, 4
$L590:

; 157  : 	addr -= LOW_MEM;// �����ַ��ȥ�Ͷ��ڴ�λ�ã��ٳ���4KB����ҳ��š�

	lea	eax, DWORD PTR [esi-1048576]

; 158  : 	addr >>= 12;

	shr	eax, 12					; 0000000cH

; 159  : 	if (mem_map[addr]--) return;// �����Ӧ�ڴ�ҳ��ӳ���ֽڲ�����0�����1 ���ء�

	mov	cl, BYTE PTR _mem_map[eax]
	mov	dl, cl
	dec	dl
	test	cl, cl
	mov	BYTE PTR _mem_map[eax], dl
	jne	SHORT $L588

; 160  : 	mem_map[addr]=0;// �����ö�Ӧҳ��ӳ���ֽ�Ϊ0������ʾ������Ϣ��������
; 161  : 	panic("trying to free free page");

	push	OFFSET FLAT:$SG593
	mov	BYTE PTR _mem_map[eax], cl
	call	_panic
	add	esp, 4
$L588:
	pop	esi

; 162  : }

	pop	ebp
	ret	0
_free_page ENDP
_TEXT	ENDS
PUBLIC	_free_page_tables
_DATA	SEGMENT
	ORG $+3
$SG603	DB	'free_page_tables called with wrong alignment', 00H
	ORG $+3
$SG605	DB	'Trying to free up swapper memory space', 00H
_DATA	ENDS
_TEXT	SEGMENT
_from$ = 8
_size$ = 12
_dir$ = 8
_free_page_tables PROC NEAR

; 174  : {

	push	ebp
	mov	ebp, esp
	push	esi

; 175  : 	unsigned long *pg_table;
; 176  : 	unsigned long * dir, nr;
; 177  : 
; 178  : 	if (from & 0x3fffff)// Ҫ�ͷ��ڴ��ĵ�ַ����4M Ϊ�߽硣

	mov	esi, DWORD PTR _from$[ebp]
	test	esi, 4194303				; 003fffffH
	je	SHORT $L602

; 179  : 		panic("free_page_tables called with wrong alignment");

	push	OFFSET FLAT:$SG603
	call	_panic
	add	esp, 4
$L602:

; 180  : 	if (!from)// ������ͼ�ͷ��ں˺ͻ�����ռ�ռ䡣

	test	esi, esi
	jne	SHORT $L604

; 181  : 		panic("Trying to free up swapper memory space");

	push	OFFSET FLAT:$SG605
	call	_panic
	add	esp, 4
$L604:

; 182  : // ������ռҳĿ¼����(4M �Ľ�λ������)��Ҳ����ռҳ������
; 183  : 	size = (size + 0x3fffff) >> 22;

	mov	eax, DWORD PTR _size$[ebp]
	add	eax, 4194303				; 003fffffH
	shr	eax, 22					; 00000016H

; 184  : // ����һ�������ʼĿ¼���Ӧ��Ŀ¼���=from>>22����ÿ��ռ4 �ֽڣ���������ҳĿ¼�Ǵ�
; 185  : // �����ַ0 ��ʼ�����ʵ�ʵ�Ŀ¼��ָ��=Ŀ¼���<<2��Ҳ��(from>>20)������0xffc ȷ��
; 186  : // Ŀ¼��ָ�뷶Χ��Ч��
; 187  : 	dir = (unsigned long *) ((from>>20) & 0xffc); /* _pg_dir = 0 */

	shr	esi, 20					; 00000014H
	and	esi, 4092				; 00000ffcH

; 188  : 	for ( ; size-->0 ; dir++) {// size ��������Ҫ���ͷ��ڴ��Ŀ¼������

	mov	ecx, eax
	dec	eax
	mov	DWORD PTR _dir$[ebp], esi
	test	ecx, ecx
	jbe	SHORT $L609
	inc	eax
	push	ebx
	push	edi
	mov	DWORD PTR 12+[ebp], eax
$L607:

; 189  : 		if (!(1 & *dir))// �����Ŀ¼����Ч(P λ=0)���������

	mov	ebx, DWORD PTR [esi]
	test	bl, 1
	je	SHORT $L608

; 190  : 			continue;// Ŀ¼���λ0(P λ)��ʾ��Ӧҳ���Ƿ���ڡ�
; 191  : 		pg_table = (unsigned long *) (0xfffff000 & *dir);// ȡĿ¼����ҳ���ַ��

	mov	esi, ebx
	mov	edi, 1024				; 00000400H
	and	esi, -4096				; fffff000H
$L612:

; 192  : 		for (nr=0 ; nr<1024 ; nr++) {// ÿ��ҳ����1024 ��ҳ�
; 193  : 			if (1 & *pg_table)// ����ҳ������Ч(P λ=1)�����ͷŶ�Ӧ�ڴ�ҳ��

	mov	eax, DWORD PTR [esi]
	test	al, 1
	je	SHORT $L615

; 194  : 				free_page(0xfffff000 & *pg_table);

	and	eax, -4096				; fffff000H
	push	eax
	call	_free_page
	add	esp, 4
$L615:

; 195  : 			*pg_table = 0;// ��ҳ�����������㡣

	mov	DWORD PTR [esi], 0

; 196  : 			pg_table++;// ָ��ҳ������һ�

	add	esi, 4
	dec	edi
	jne	SHORT $L612

; 197  : 		}
; 198  : 		free_page(0xfffff000 & *dir);// �ͷŸ�ҳ����ռ�ڴ�ҳ�档������ҳ����

	and	ebx, -4096				; fffff000H
	push	ebx
	call	_free_page

; 199  : 										// �����ַ1M ���ڣ��������ʲô��������
; 200  : 		*dir = 0;// ����Ӧҳ���Ŀ¼�����㡣

	mov	edx, DWORD PTR _dir$[ebp]
	add	esp, 4
	mov	DWORD PTR [edx], 0
$L608:
	mov	esi, DWORD PTR _dir$[ebp]
	mov	eax, DWORD PTR 12+[ebp]
	add	esi, 4
	dec	eax
	mov	DWORD PTR _dir$[ebp], esi
	mov	DWORD PTR 12+[ebp], eax
	jne	SHORT $L607
	pop	edi
	pop	ebx
$L609:

; 201  : 	}
; 202  : 	invalidate();// ˢ��ҳ�任���ٻ��塣

	xor	eax, eax
	mov	cr3, eax

; 203  : 	return 0;

	xor	eax, eax
	pop	esi

; 204  : }

	pop	ebp
	ret	0
_free_page_tables ENDP
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
PUBLIC	_copy_page_tables
_DATA	SEGMENT
	ORG $+1
$SG631	DB	'copy_page_tables called with wrong alignment', 00H
	ORG $+3
$SG639	DB	'copy_page_tables: already exist', 00H
_DATA	ENDS
_TEXT	SEGMENT
_from$ = 8
_to$ = 12
_size$ = 16
_copy_page_tables PROC NEAR

; 226  : {

	push	ebp
	mov	ebp, esp
	push	ebx
	push	esi

; 227  : 	unsigned long * from_page_table;
; 228  : 	unsigned long * to_page_table;
; 229  : 	unsigned long this_page;
; 230  : 	unsigned long * from_dir, * to_dir;
; 231  : 	unsigned long nr;
; 232  : 
; 233  : 	// Դ��ַ��Ŀ�ĵ�ַ����Ҫ����4Mb ���ڴ�߽��ַ�ϡ��������������
; 234  : 	if ((from&0x3fffff) || (to&0x3fffff))

	mov	esi, DWORD PTR _to$[ebp]
	push	edi
	mov	edi, DWORD PTR _from$[ebp]
	test	edi, 4194303				; 003fffffH
	jne	SHORT $L630
	test	esi, 4194303				; 003fffffH
	je	SHORT $L629
$L630:

; 235  : 		panic("copy_page_tables called with wrong alignment");

	push	OFFSET FLAT:$SG631
	call	_panic
	add	esp, 4
$L629:

; 236  : 	// ȡ��Դ��ַ��Ŀ�ĵ�ַ��Ŀ¼��(from_dir ��to_dir)���μ���115 ���ע�͡�
; 237  : 	from_dir = (unsigned long *) ((from>>20) & 0xffc); /* _pg_dir = 0 */
; 238  : 	to_dir = (unsigned long *) ((to>>20) & 0xffc);
; 239  : 	// ����Ҫ���Ƶ��ڴ��ռ�õ�ҳ������Ҳ��Ŀ¼��������
; 240  : 	size = ((unsigned) (size+0x3fffff)) >> 22;

	mov	edx, DWORD PTR _size$[ebp]
	mov	eax, edi
	shr	eax, 20					; 00000014H
	lea	ebx, DWORD PTR [edx+4194303]
	mov	edi, eax
	mov	ecx, esi
	and	edi, 4092				; 00000ffcH
	shr	ebx, 22					; 00000016H
	shr	ecx, 20					; 00000014H

; 241  : 	// ���濪ʼ��ÿ��ռ�õ�ҳ�����ν��и��Ʋ�����
; 242  : 	for( ; size-->0 ; from_dir++,to_dir++) {

	mov	edx, ebx
	dec	ebx
	test	edx, edx
	jle	$L637
	and	ecx, 4092				; 00000ffcH
	and	eax, 4092				; 00000ffcH
	mov	esi, ecx
	sub	esi, eax
	mov	DWORD PTR 12+[ebp], esi
$L635:

; 243  : 		if (1 & *to_dir)// ���Ŀ��Ŀ¼��ָ����ҳ���Ѿ�����(P=1)�������������

	test	BYTE PTR [esi+edi], 1
	je	SHORT $L638

; 244  : 			panic("copy_page_tables: already exist");

	push	OFFSET FLAT:$SG639
	call	_panic
	add	esp, 4
$L638:

; 245  : 		if (!(1 & *from_dir))// �����ԴĿ¼��δ��ʹ�ã����ø��ƶ�Ӧҳ��������

	mov	eax, DWORD PTR [edi]
	test	al, 1
	je	SHORT $L636

; 246  : 			continue;
; 247  : 		// ȡ��ǰԴĿ¼����ҳ��ĵ�ַ -> from_page_table��
; 248  : 		from_page_table = (unsigned long *) (0xfffff000 & *from_dir);

	and	eax, -4096				; fffff000H
	mov	esi, eax

; 249  : // ΪĿ��ҳ��ȡһҳ�����ڴ棬���������0 ��˵��û�����뵽�����ڴ�ҳ�档����ֵ=-1���˳���
; 250  : 		if (!(to_page_table = (unsigned long *) get_free_page()))

	call	_get_free_page
	test	eax, eax
	je	SHORT $L827

; 252  : 		// ����Ŀ��Ŀ¼����Ϣ��7 �Ǳ�־��Ϣ����ʾ(Usr, R/W, Present)��
; 253  : 		*to_dir = ((unsigned long) to_page_table) | 7;

	mov	edx, DWORD PTR 12+[ebp]
	mov	ecx, eax
	or	ecx, 7
	mov	DWORD PTR [edx+edi], ecx

; 254  : 		// ��Ե�ǰ�����ҳ�������踴�Ƶ�ҳ��������������ں˿ռ䣬����踴��ͷ160 ҳ��
; 255  : 		// ������Ҫ����1 ��ҳ���е�����1024 ҳ�档
; 256  : 		nr = (from==0)?0xA0:1024;

	mov	ecx, DWORD PTR _from$[ebp]
	neg	ecx
	sbb	ecx, ecx
	and	ecx, 864				; 00000360H
	add	ecx, 160				; 000000a0H

; 257  : 		// ���ڵ�ǰҳ����ʼ����ָ����Ŀnr ���ڴ�ҳ�档
; 258  : 		for ( ; nr-- > 0 ; from_page_table++,to_page_table++) {

	mov	edx, ecx
	dec	ecx
	test	edx, edx
	jbe	SHORT $L830

; 252  : 		// ����Ŀ��Ŀ¼����Ϣ��7 �Ǳ�־��Ϣ����ʾ(Usr, R/W, Present)��
; 253  : 		*to_dir = ((unsigned long) to_page_table) | 7;

	lea	edx, DWORD PTR [ecx+1]
$L645:

; 259  : 			this_page = *from_page_table;// ȡԴҳ�������ݡ�

	mov	ecx, DWORD PTR [esi]

; 260  : 			if (!(1 & this_page))// �����ǰԴҳ��û��ʹ�ã����ø��ơ�

	test	cl, 1
	je	SHORT $L646

; 261  : 				continue;
; 262  : // ��λҳ������R/W ��־(��0)��(���U/S λ��0����R/W ��û�����á����U/S ��1����R/W ��0��
; 263  : // ��ô�������û���Ĵ����ֻ�ܶ�ҳ�档���U/S ��R/W ����λ�������д��Ȩ�ޡ�)
; 264  : 			this_page &= ~2;

	and	ecx, -3					; fffffffdH

; 265  : 			*to_page_table = this_page;// ����ҳ����Ƶ�Ŀ��ҳ���С�
; 266  : // �����ҳ������ָҳ��ĵ�ַ��1M ���ϣ�����Ҫ�����ڴ�ҳ��ӳ������mem_map[]�����Ǽ���
; 267  : // ҳ��ţ�������Ϊ������ҳ��ӳ��������Ӧ�����������ô�����
; 268  : 			if (this_page > LOW_MEM) {

	cmp	ecx, 1048576				; 00100000H
	mov	DWORD PTR [eax], ecx
	jbe	SHORT $L646

; 269  : // �������ĺ�������Դҳ������ָ�ڴ�ҳҲΪֻ������Ϊ���ڿ�ʼ���������̹����ڴ����ˡ�
; 270  : // ������һ���ڴ���Ҫ����д�����������ͨ��ҳ�쳣��д��������Ϊִ��д�����Ľ��̷���
; 271  : // һҳ�µĿ���ҳ�棬Ҳ������дʱ���ƵĲ�����
; 272  : 				*from_page_table = this_page;// ��Դҳ����Ҳֻ����

	mov	DWORD PTR [esi], ecx

; 273  : 				this_page -= LOW_MEM;

	add	ecx, -1048576				; fff00000H

; 274  : 				this_page >>= 12;

	shr	ecx, 12					; 0000000cH

; 275  : 				mem_map[this_page]++;

	inc	BYTE PTR _mem_map[ecx]
$L646:
	add	esi, 4
	add	eax, 4
	dec	edx
	jne	SHORT $L645
$L830:

; 257  : 		// ���ڵ�ǰҳ����ʼ����ָ����Ŀnr ���ڴ�ҳ�档
; 258  : 		for ( ; nr-- > 0 ; from_page_table++,to_page_table++) {

	mov	esi, DWORD PTR 12+[ebp]
$L636:

; 241  : 	// ���濪ʼ��ÿ��ռ�õ�ҳ�����ν��и��Ʋ�����
; 242  : 	for( ; size-->0 ; from_dir++,to_dir++) {

	add	edi, 4
	mov	eax, ebx
	dec	ebx
	test	eax, eax
	jg	$L635
$L637:

; 276  : 			}
; 277  : 		}
; 278  : 	}
; 279  : 	invalidate();// ˢ��ҳ�任���ٻ��塣

	xor	eax, eax
	mov	cr3, eax
	pop	edi
	pop	esi

; 280  : 	return 0;

	xor	eax, eax
	pop	ebx

; 281  : }

	pop	ebp
	ret	0
$L827:
	pop	edi
	pop	esi

; 251  : 			return -1;	/* Out of memory, see freeing */

	or	eax, -1
	pop	ebx

; 281  : }

	pop	ebp
	ret	0
_copy_page_tables ENDP
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

	je	SHORT $l1$518

; 278  : 		xchg ecx,current/* current = task[n]�� */

	xchg	ecx, DWORD PTR _current

; 279  : 		/*ִ�г���ת����������л� (ͷ���˺ܳ�ʱ�䣬������)*/
; 280  : 		mov ax, __tmp

	mov	ax, WORD PTR ___tmp$[ebp]

; 281  : 		mov word ptr ds:[lcs],ax

	mov	WORD PTR ds:$lcs$519, ax

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
$lcs$519:

; 287  : lcs:	_emit 0		// cs

	DB	0

; 288  : 		_emit 0

	DB	0

; 289  : // �������л�������Ż����ִ���������䡣
; 290  : 		cmp last_task_used_math,ecx /* �������ϴ�ʹ�ù�Э��������*/

	cmp	DWORD PTR _last_task_used_math, ecx

; 291  : 		jne l1

	jne	SHORT $l1$518

; 292  : 		clts/* �������ϴ�ʹ�ù�Э������������cr0 ��TS ��־��*/

	clts
$l1$518:

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
PUBLIC	_put_page
EXTRN	_printk:NEAR
_DATA	SEGMENT
$SG659	DB	'Trying to put page %p at %p', 0aH, 00H
	ORG $+3
$SG661	DB	'mem_map disagrees with %p at %p', 0aH, 00H
_DATA	ENDS
_TEXT	SEGMENT
_page$ = 8
_address$ = 12
_put_page PROC NEAR

; 290  : {

	push	ebp
	mov	ebp, esp
	push	ebx

; 291  : 	unsigned long tmp, *page_table;
; 292  : 
; 293  : /* ע��!!!����ʹ����ҳĿ¼��ַ_pg_dir=0 ������ */
; 294  : 
; 295  : // ��������ҳ��λ�õ���LOW_MEM(1Mb)�򳬳�ϵͳʵ�ʺ����ڴ�߶�HIGH_MEMORY���򷢳����档
; 296  : 	if (page < LOW_MEM || page >= HIGH_MEMORY)

	mov	ebx, DWORD PTR _page$[ebp]
	push	esi
	push	edi
	mov	edi, DWORD PTR _address$[ebp]
	cmp	ebx, 1048576				; 00100000H
	jb	SHORT $L658
	cmp	ebx, DWORD PTR _HIGH_MEMORY
	jb	SHORT $L657
$L658:

; 297  : 		printk("Trying to put page %p at %p\n",page,address);

	push	edi
	push	ebx
	push	OFFSET FLAT:$SG659
	call	_printk
	add	esp, 12					; 0000000cH
$L657:

; 298  : 	// ��������ҳ�����ڴ�ҳ��ӳ���ֽ�ͼ��û����λ������ʾ������Ϣ��
; 299  : 	if (mem_map[(page-LOW_MEM)>>12] != 1)

	lea	eax, DWORD PTR [ebx-1048576]
	shr	eax, 12					; 0000000cH
	cmp	BYTE PTR _mem_map[eax], 1
	je	SHORT $L660

; 300  : 		printk("mem_map disagrees with %p at %p\n",page,address);

	push	edi
	push	ebx
	push	OFFSET FLAT:$SG661
	call	_printk
	add	esp, 12					; 0000000cH
$L660:

; 301  : 	// ����ָ����ַ��ҳĿ¼���ж�Ӧ��Ŀ¼��ָ�롣
; 302  : 	page_table = (unsigned long *) ((address>>20) & 0xffc);

	mov	esi, edi
	shr	esi, 20					; 00000014H
	and	esi, 4092				; 00000ffcH

; 303  : // �����Ŀ¼����Ч(P=1)(Ҳ��ָ����ҳ�����ڴ���)�������ȡ��ָ��ҳ��ĵ�ַ -> page_table��
; 304  : 	if ((*page_table)&1)

	mov	eax, DWORD PTR [esi]
	test	al, 1
	je	SHORT $L663

; 305  : 		page_table = (unsigned long *) (0xfffff000 & *page_table);

	and	eax, -4096				; fffff000H

; 306  : 	else {

	jmp	SHORT $L665
$L663:

; 307  : // �����������ҳ���ҳ��ʹ�ã����ڶ�ӦĿ¼��������Ӧ��־7��User, U/S, R/W����Ȼ��
; 308  : // ��ҳ��ĵ�ַ -> page_table��
; 309  : 		if (!(tmp=get_free_page()))

	call	_get_free_page
	test	eax, eax
	jne	SHORT $L666
	pop	edi
	pop	esi
	pop	ebx

; 318  : }

	pop	ebp
	ret	0
$L666:

; 310  : 			return 0;
; 311  : 		*page_table = tmp|7;

	mov	ecx, eax
	or	ecx, 7
	mov	DWORD PTR [esi], ecx
$L665:

; 312  : 		page_table = (unsigned long *) tmp;
; 313  : 	}
; 314  : 	// ��ҳ��������ָ����ַ�������ڴ�ҳ���ҳ�������ݡ�ÿ��ҳ������1024 ��(0x3ff)��
; 315  : 	page_table[(address>>12) & 0x3ff] = page | 7;

	mov	edx, ebx
	shr	edi, 12					; 0000000cH
	or	edx, 7
	and	edi, 1023				; 000003ffH
	mov	DWORD PTR [eax+edi*4], edx
	pop	edi

; 316  : /* ����Ҫˢ��ҳ�任���ٻ��� */
; 317  : 	return page;// ����ҳ���ַ��

	mov	eax, ebx
	pop	esi
	pop	ebx

; 318  : }

	pop	ebp
	ret	0
_put_page ENDP
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
PUBLIC	_un_wp_page
EXTRN	_do_exit:NEAR
_TEXT	SEGMENT
_table_entry$ = 8
_old_page$ = -4
_new_page$ = 8
_un_wp_page PROC NEAR

; 324  : {

	push	ebp
	mov	ebp, esp
	push	ecx
	push	ebx

; 327  : 	old_page = 0xfffff000 & *table_entry;// ȡԭҳ���Ӧ��Ŀ¼��š�

	mov	ebx, DWORD PTR _table_entry$[ebp]
	push	esi
	push	edi
	mov	eax, DWORD PTR [ebx]
	mov	esi, eax
	and	esi, -4096				; fffff000H

; 331  : 	if (old_page >= LOW_MEM && mem_map[MAP_NR(old_page)]==1) {

	cmp	esi, 1048576				; 00100000H
	mov	DWORD PTR _old_page$[ebp], esi
	jb	SHORT $L674
	lea	ecx, DWORD PTR [esi-1048576]
	shr	ecx, 12					; 0000000cH
	cmp	BYTE PTR _mem_map[ecx], 1
	jne	SHORT $L674

; 332  : 		*table_entry |= 2;

	or	al, 2
	mov	DWORD PTR [ebx], eax

; 333  : 		invalidate();

	xor	eax, eax
	mov	cr3, eax

; 346  : 	copy_page(old_page,new_page);
; 347  : }	

	pop	edi
	pop	esi
	pop	ebx
	mov	esp, ebp
	pop	ebp
	ret	0
$L674:

; 334  : 		return;
; 335  : 	}
; 336  : 	// ���������ڴ���������һҳ����ҳ�档
; 337  : 	if (!(new_page=get_free_page()))

	call	_get_free_page
	mov	edi, eax
	test	edi, edi
	mov	DWORD PTR _new_page$[ebp], edi
	jne	SHORT $L838

; 338  : 		oom();// Out of Memory���ڴ治������

	push	OFFSET FLAT:$SG574
	call	_printk
	push	11					; 0000000bH
	call	_do_exit
	add	esp, 8
$L838:

; 339  : // ���ԭҳ������ڴ�Ͷˣ�����ζ��mem_map[]>1��ҳ���ǹ���ģ�����ԭҳ���ҳ��ӳ��
; 340  : // ����ֵ�ݼ�1��Ȼ��ָ��ҳ�������ݸ���Ϊ��ҳ��ĵ�ַ�����ÿɶ�д�ȱ�־(U/S, R/W, P)��
; 341  : // ˢ��ҳ�任���ٻ��塣���ԭҳ�����ݸ��Ƶ���ҳ�档
; 342  : 	if (old_page >= LOW_MEM)

	cmp	esi, 1048576				; 00100000H
	jb	SHORT $L676

; 343  : 		mem_map[MAP_NR(old_page)]--;

	add	esi, -1048576				; fff00000H
	shr	esi, 12					; 0000000cH
	mov	cl, BYTE PTR _mem_map[esi]
	lea	eax, DWORD PTR _mem_map[esi]
	dec	cl
	mov	BYTE PTR [eax], cl
$L676:

; 344  : 	*table_entry = new_page | 7;

	or	edi, 7
	mov	DWORD PTR [ebx], edi

; 345  : 	invalidate();

	xor	eax, eax
	mov	cr3, eax

; 325  : 	unsigned long old_page,new_page;

	pushf

; 326  : 

	mov	ecx, 1024				; 00000400H

; 327  : 	old_page = 0xfffff000 & *table_entry;// ȡԭҳ���Ӧ��Ŀ¼��š�

	mov	esi, DWORD PTR _old_page$[ebp]

; 328  : // ���ԭҳ���ַ�����ڴ�Ͷ�LOW_MEM(1Mb)����������ҳ��ӳ���ֽ�ͼ������ֵΪ1����ʾ��

	mov	edi, DWORD PTR _new_page$[ebp]

; 329  : // ������1 �Σ�ҳ��û�б����������ڸ�ҳ���ҳ��������R/W ��־����д������ˢ��ҳ�任

	cld

; 330  : // ���ٻ��壬Ȼ�󷵻ء�

	rep	 movsd

; 331  : 	if (old_page >= LOW_MEM && mem_map[MAP_NR(old_page)]==1) {

	popf

; 346  : 	copy_page(old_page,new_page);
; 347  : }	

	pop	edi
	pop	esi
	pop	ebx
	mov	esp, ebp
	pop	ebp
	ret	0
_un_wp_page ENDP
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
PUBLIC	_do_wp_page
_TEXT	SEGMENT
_address$ = 12
_do_wp_page PROC NEAR

; 359  : {

	push	ebp
	mov	ebp, esp

; 360  : #if 0
; 361  : /* �������ڻ���������������Ϊestdio ����ڴ���ռ�ִ��д���� */
; 362  : /* ����̫�޴��ˡ��������GNU �õ�libc.a �⡣ */
; 363  : 	if (CODE_SPACE(address))	// �����ַλ�ڴ���ռ䣬����ִֹ�г���
; 364  : 		do_exit(SIGSEGV);
; 365  : #endif
; 366  : // ����ȡ��ҳ�汣��������ָ��ҳ����ҳ���е�ҳ����ָ�룬����㷽���ǣ�
; 367  : // ((address>>10) & 0xffc)������ָ����ַ��ҳ����ҳ���е�ƫ�Ƶ�ַ��
; 368  : // (0xfffff000 &((address>>20) &0xffc))��ȡĿ¼����ҳ��ĵ�ֵַ��
; 369  : // ����((address>>20) &0xffc)����ҳ������ҳ���Ŀ¼��ָ�룻
; 370  : // ������Ӽ���ָ����ַ��Ӧҳ���ҳ����ָ�롣����Թ����ҳ����и��ơ�
; 371  : 	un_wp_page(
; 372  : 		(unsigned long *)(((address>>10) & 0xffc) + 
; 373  : 		(0xfffff000 & *((unsigned long *) ((address>>20) &0xffc))))
; 374  : 	);

	mov	eax, DWORD PTR _address$[ebp]
	mov	ecx, eax
	shr	ecx, 20					; 00000014H
	and	ecx, 4092				; 00000ffcH
	shr	eax, 10					; 0000000aH
	mov	edx, DWORD PTR [ecx]
	and	eax, 4092				; 00000ffcH
	and	edx, -4096				; fffff000H
	add	edx, eax
	push	edx
	call	_un_wp_page
	add	esp, 4

; 375  : 
; 376  : }

	pop	ebp
	ret	0
_do_wp_page ENDP
_TEXT	ENDS
PUBLIC	_write_verify
_TEXT	SEGMENT
_address$ = 8
_write_verify PROC NEAR

; 381  : {

	push	ebp
	mov	ebp, esp

; 382  : 	unsigned long page;
; 383  : 
; 384  : // �ж�ָ����ַ����ӦҳĿ¼���ҳ���Ƿ����(P)����������(P=0)�򷵻ء�
; 385  : 	if (!( (page = *((unsigned long *) ((address>>20) & 0xffc)) )&1))

	mov	eax, DWORD PTR _address$[ebp]
	mov	ecx, eax
	shr	ecx, 20					; 00000014H
	and	ecx, 4092				; 00000ffcH
	mov	ecx, DWORD PTR [ecx]
	test	cl, 1
	je	SHORT $L695

; 386  : 		return;
; 387  : // ȡҳ��ĵ�ַ������ָ����ַ��ҳ����ҳ���е�ҳ����ƫ��ֵ���ö�Ӧ����ҳ���ҳ����ָ�롣
; 388  : 	page &= 0xfffff000;
; 389  : 	page += ((address>>10) & 0xffc);

	shr	eax, 10					; 0000000aH
	and	eax, 4092				; 00000ffcH
	and	ecx, -4096				; fffff000H
	add	eax, ecx

; 390  : // �����ҳ�治��д(��־R/W û����λ)����ִ�й������͸���ҳ�������дʱ���ƣ���
; 391  : 	if ((3 & *(unsigned long *) page) == 1)  /* non-writeable, present */

	mov	edx, DWORD PTR [eax]
	and	edx, 3
	cmp	dl, 1
	jne	SHORT $L695

; 392  : 		un_wp_page((unsigned long *) page);

	push	eax
	call	_un_wp_page
	add	esp, 4
$L695:

; 393  : 	return;
; 394  : }

	pop	ebp
	ret	0
_write_verify ENDP
_TEXT	ENDS
PUBLIC	_get_empty_page
_TEXT	SEGMENT
_address$ = 8
_get_empty_page PROC NEAR

; 401  : {

	push	ebp
	mov	ebp, esp
	push	esi

; 402  : 	unsigned long tmp;
; 403  : 
; 404  : // ������ȡ��һ����ҳ�棬���߲��ܽ�ҳ����õ�ָ����ַ��������ʾ�ڴ治������Ϣ��
; 405  : // 279 ����Ӣ��ע�͵ĺ����ǣ���ʹִ��get_free_page()����0 Ҳ����ν����Ϊput_page()
; 406  : // �л���Դ�����ٴ������������ҳ��ģ���210 �С�
; 407  : 	if (!(tmp=get_free_page()) || !put_page(tmp,address)) {

	call	_get_free_page
	mov	esi, eax
	test	esi, esi
	je	SHORT $L703
	mov	eax, DWORD PTR _address$[ebp]
	push	eax
	push	esi
	call	_put_page
	add	esp, 8
	test	eax, eax
	jne	SHORT $L849
$L703:

; 408  : 		free_page(tmp);		/* 0 is ok - ignored */

	push	esi
	call	_free_page

; 409  : 		oom();

	push	OFFSET FLAT:$SG574
	call	_printk
	push	11					; 0000000bH
	call	_do_exit
	add	esp, 12					; 0000000cH
$L849:
	pop	esi

; 410  : 	}
; 411  : }

	pop	ebp
	ret	0
_get_empty_page ENDP
_TEXT	ENDS
PUBLIC	_do_no_page
EXTRN	_bmap:NEAR
EXTRN	_bread_page:NEAR
_TEXT	SEGMENT
_address$ = 12
_nr$ = -24
_page$ = -8
_do_no_page PROC NEAR

; 517  : {

	push	ebp
	mov	ebp, esp
	sub	esp, 24					; 00000018H

; 518  : 	int nr[4];
; 519  : 	unsigned long tmp;
; 520  : 	unsigned long page;
; 521  : 	int block,i;
; 522  : 
; 523  : 	address &= 0xfffff000;// ҳ���ַ��

	mov	ecx, DWORD PTR _address$[ebp]

; 524  : // �������ָ�����Ե�ַ�ڽ��̿ռ�������ڽ��̻�ַ��ƫ�Ƴ���ֵ��
; 525  : 	tmp = address - current->start_code;

	mov	eax, DWORD PTR _current
	push	esi
	and	ecx, -4096				; fffff000H
	mov	esi, DWORD PTR [eax+536]

; 526  : // ����ǰ���̵�executable �գ�����ָ����ַ��������+���ݳ��ȣ�������һҳ�����ڴ棬��ӳ��
; 527  : // Ӱ�䵽ָ�������Ե�ַ����executable �ǽ��̵�i �ڵ�ṹ����ֵΪ0���������̸տ�ʼ���ã�
; 528  : // ��Ҫ�ڴ棻��ָ�������Ե�ַ������������ݳ��ȣ����������������µ��ڴ�ռ䣬Ҳ��Ҫ���衣
; 529  : // ��˾�ֱ�ӵ���get_empty_page()����������һҳ�����ڴ沢ӳ�䵽ָ�����Ե�ַ�����ɡ�
; 530  : // start_code �ǽ��̴���ε�ַ��end_data �Ǵ�������ݳ��ȡ�����linux �ںˣ����Ĵ���κ�
; 531  : // ���ݶ�����ʼ��ַ����ͬ�ġ�
; 532  : 	if (!current->executable || tmp >= current->end_data) {

	mov	edx, DWORD PTR [eax+632]
	push	edi
	mov	edi, ecx
	sub	edi, esi
	mov	DWORD PTR _address$[ebp], ecx
	test	edx, edx
	je	$L758
	cmp	edi, DWORD PTR [eax+544]
	jae	$L758

; 534  : 		return;
; 535  : 	}
; 536  : // ������Թ���ҳ��ɹ������˳���
; 537  : 	if (share_page(tmp))

	push	edi
	call	_share_page
	add	esp, 4
	test	eax, eax
	jne	$L856

; 538  : 		return;
; 539  : // ȡ����ҳ�棬����ڴ治���ˣ�����ʾ�ڴ治������ֹ���̡�
; 540  : 	if (!(page = get_free_page()))

	call	_get_free_page
	test	eax, eax
	mov	DWORD PTR _page$[ebp], eax
	jne	SHORT $L853

; 541  : 		oom();

	push	OFFSET FLAT:$SG574
	call	_printk
	push	11					; 0000000bH
	call	_do_exit
	add	esp, 8
$L853:

; 542  : /* ��ס��������ͷҪʹ��1 �����ݿ� */
; 543  : // ���ȼ���ȱҳ���ڵ����ݿ��BLOCK_SIZE = 1024 �ֽڣ����һҳ�ڴ���Ҫ4 �����ݿ顣
; 544  : 	block = 1 + tmp/BLOCK_SIZE;

	mov	eax, edi
	push	ebx
	shr	eax, 10					; 0000000aH
	inc	eax

; 545  : // ����i �ڵ���Ϣ��ȡ���ݿ����豸�ϵĶ�Ӧ���߼���š�
; 546  : 	for (i=0 ; i<4 ; block++,i++)

	xor	esi, esi
	mov	DWORD PTR -4+[ebp], eax
	lea	ebx, DWORD PTR _nr$[ebp]
$L761:

; 547  : 		nr[i] = bmap(current->executable,block);

	mov	ecx, DWORD PTR -4+[ebp]
	mov	edx, DWORD PTR _current
	add	ecx, esi
	mov	eax, DWORD PTR [edx+632]
	push	ecx
	push	eax
	call	_bmap
	add	esp, 8
	mov	DWORD PTR [ebx], eax
	inc	esi
	add	ebx, 4
	cmp	esi, 4
	jl	SHORT $L761

; 548  : // ���豸��һ��ҳ������ݣ�4 ���߼��飩��ָ�������ַpage ����
; 549  : 	bread_page(page,current->executable->i_dev,nr);

	mov	edx, DWORD PTR _current
	mov	esi, DWORD PTR _page$[ebp]
	lea	ecx, DWORD PTR _nr$[ebp]
	mov	eax, DWORD PTR [edx+632]
	push	ecx
	xor	ecx, ecx
	mov	cx, WORD PTR [eax+44]
	push	ecx
	push	esi
	call	_bread_page

; 550  : // ��������һҳ�ڴ�󣬸�ҳ�ڴ�Ĳ��ֿ��ܻᳬ�����̵�end_data λ�á������ѭ�����Ƕ�����
; 551  : // ҳ�泬���Ĳ��ֽ������㴦��
; 552  : 	i = tmp + 4096 - current->end_data;

	mov	edx, DWORD PTR _current
	add	esp, 12					; 0000000cH

; 553  : 	tmp = page + 4096;

	lea	eax, DWORD PTR [esi+4096]
	mov	ecx, DWORD PTR [edx+544]
	pop	ebx
	sub	edi, ecx
	add	edi, 4096				; 00001000H

; 554  : 	while (i-- > 0) {

	mov	ecx, edi
	dec	edi
	test	ecx, ecx
	jle	SHORT $L766

; 548  : // ���豸��һ��ҳ������ݣ�4 ���߼��飩��ָ�������ַpage ����
; 549  : 	bread_page(page,current->executable->i_dev,nr);

	lea	ecx, DWORD PTR [edi+1]
$L765:

; 555  : 		tmp--;

	dec	eax
	dec	ecx

; 556  : 		*(char *)tmp = 0;

	mov	BYTE PTR [eax], 0
	jne	SHORT $L765
$L766:

; 557  : 	}
; 558  : // ���������ҳ��ӳ�䵽ָ�����Ե�ַ�Ĳ����ɹ����ͷ��ء�������ͷ��ڴ�ҳ����ʾ�ڴ治����
; 559  : 	if (put_page(page,address))

	mov	edx, DWORD PTR _address$[ebp]
	push	edx
	push	esi
	call	_put_page
	add	esp, 8
	test	eax, eax
	jne	SHORT $L856

; 560  : 		return;
; 561  : 	free_page(page);

	push	esi
	call	_free_page

; 562  : 	oom();

	push	OFFSET FLAT:$SG574
	call	_printk
	push	11					; 0000000bH
	call	_do_exit
	add	esp, 12					; 0000000cH
	pop	edi
	pop	esi

; 563  : }

	mov	esp, ebp
	pop	ebp
	ret	0
$L758:

; 533  : 		get_empty_page(address);

	push	ecx
	call	_get_empty_page
	add	esp, 4

; 562  : 	oom();

$L856:
	pop	edi
	pop	esi

; 563  : }

	mov	esp, ebp
	pop	ebp
	ret	0
_do_no_page ENDP
_address$ = 8
_share_page PROC NEAR

; 490  : {

	push	ebp
	mov	ebp, esp

; 491  : 	struct task_struct ** p;
; 492  : 
; 493  : // ����ǲ���ִ�еģ��򷵻ء�excutable ��ִ�н��̵��ڴ�i �ڵ�ṹ��
; 494  : 	if (!current->executable)

	mov	ecx, DWORD PTR _current
	push	ebx
	push	esi
	push	edi
	mov	eax, DWORD PTR [ecx+632]
	test	eax, eax

; 495  : 		return 0;

	je	SHORT $L741

; 496  : // ���ֻ�ܵ���ִ��(executable->i_count=1)��Ҳ�˳���
; 497  : 	if (current->executable->i_count < 2)

	cmp	WORD PTR [eax+48], 2

; 498  : 		return 0;

	jb	SHORT $L741

; 499  : // ����������������������Ѱ���뵱ǰ���̿ɹ���ҳ��Ľ��̣�
; 500  : // �����Զ�ָ����ַ��ҳ����й���
; 501  : 	for (p = &LAST_TASK ; p > &FIRST_TASK ; --p) {

	mov	edi, DWORD PTR _address$[ebp]
	mov	esi, OFFSET FLAT:_task+252
$L739:

; 502  : 		if (!*p)// �������������У������Ѱ�ҡ�

	mov	eax, DWORD PTR [esi]
	test	eax, eax
	je	SHORT $L740

; 503  : 			continue;
; 504  : 		if (current == *p)// ������ǵ�ǰ����Ҳ����Ѱ�ҡ�

	cmp	ecx, eax
	je	SHORT $L740

; 505  : 			continue;
; 506  : 		if ((*p)->executable != current->executable)// ���executable ���ȣ�Ҳ������

	mov	edx, DWORD PTR [eax+632]
	mov	ebx, DWORD PTR [ecx+632]
	cmp	edx, ebx
	jne	SHORT $L740

; 507  : 			continue;
; 508  : 		if (try_to_share(address,*p))// ���Թ���ҳ�档

	push	eax
	push	edi
	call	_try_to_share
	add	esp, 8
	test	eax, eax
	jne	SHORT $L865
	mov	ecx, DWORD PTR _current
$L740:

; 499  : // ����������������������Ѱ���뵱ǰ���̿ɹ���ҳ��Ľ��̣�
; 500  : // �����Զ�ָ����ַ��ҳ����й���
; 501  : 	for (p = &LAST_TASK ; p > &FIRST_TASK ; --p) {

	sub	esi, 4
	cmp	esi, OFFSET FLAT:_task
	ja	SHORT $L739
$L741:
	pop	edi
	pop	esi

; 510  : 	}
; 511  : 	return 0;

	xor	eax, eax
	pop	ebx

; 512  : }

	pop	ebp
	ret	0
$L865:
	pop	edi
	pop	esi

; 509  : 			return 1;

	mov	eax, 1
	pop	ebx

; 512  : }

	pop	ebp
	ret	0
_share_page ENDP
_TEXT	ENDS
_DATA	SEGMENT
	ORG $+3
$SG728	DB	'try_to_share: to_page already exists', 00H
_DATA	ENDS
_TEXT	SEGMENT
_address$ = 8
_p$ = 12
_phys_addr$ = 8
_try_to_share PROC NEAR

; 423  : {

	push	ebp
	mov	ebp, esp

; 424  : 	unsigned long from;
; 425  : 	unsigned long to;
; 426  : 	unsigned long from_page;
; 427  : 	unsigned long to_page;
; 428  : 	unsigned long phys_addr;
; 429  : 
; 430  : // ��ָ���ڴ��ַ��ҳĿ¼�
; 431  : 	from_page = to_page = ((address>>20) & 0xffc);
; 432  : // �������p �Ĵ�����ʼ��ַ����Ӧ��ҳĿ¼�
; 433  : 	from_page += ((p->start_code>>20) & 0xffc);

	mov	eax, DWORD PTR _p$[ebp]
	mov	ecx, DWORD PTR _address$[ebp]

; 434  : // ���㵱ǰ�����д�����ʼ��ַ����Ӧ��ҳĿ¼�
; 435  : 	to_page += ((current->start_code>>20) & 0xffc);

	mov	edx, DWORD PTR _current
	push	esi
	mov	eax, DWORD PTR [eax+536]
	mov	esi, ecx
	mov	edx, DWORD PTR [edx+536]
	push	edi
	shr	esi, 20					; 00000014H
	shr	eax, 20					; 00000014H
	and	esi, 4092				; 00000ffcH
	and	eax, 4092				; 00000ffcH
	add	eax, esi
	shr	edx, 20					; 00000014H

; 436  : /* ��from ���Ƿ����ҳĿ¼�� */
; 437  : // *** ��p ����ҳ����в�����
; 438  : // ȡҳĿ¼�����ݡ������Ŀ¼����Ч(P=0)���򷵻ء�����ȡ��Ŀ¼���Ӧҳ���ַ-> from��
; 439  : 	from = *(unsigned long *) from_page;

	mov	eax, DWORD PTR [eax]
	and	edx, 4092				; 00000ffcH
	add	esi, edx

; 440  : 	if (!(from & 1))

	test	al, 1

; 441  : 		return 0;

	je	$L720

; 453  : 		return 0;

	shr	ecx, 10					; 0000000aH
	and	ecx, 4092				; 00000ffcH
	and	eax, -4096				; fffff000H
	add	eax, ecx
	mov	DWORD PTR 12+[ebp], ecx
	mov	edi, eax
	mov	edx, DWORD PTR [edi]
	mov	eax, edx
	and	eax, 65					; 00000041H
	cmp	al, 1
	jne	$L720
	mov	eax, DWORD PTR _HIGH_MEMORY
	and	edx, -4096				; fffff000H
	cmp	edx, eax
	mov	DWORD PTR _phys_addr$[ebp], edx
	jae	$L720

; 442  : 	from &= 0xfffff000;
; 443  : // �����ַ��Ӧ��ҳ����ָ��ֵ����ȡ����ҳ�������� -> phys_addr��
; 444  : 	from_page = from + ((address>>10) & 0xffc);
; 445  : 	phys_addr = *(unsigned long *) from_page;
; 446  : /* ҳ��ɾ����Ҵ����� */
; 447  : // 0x41 ��Ӧҳ�����е�Dirty ��Present ��־�����ҳ�治�ɾ�����Ч�򷵻ء�
; 448  : 	if ((phys_addr & 0x41) != 0x01)
; 449  : 		return 0;
; 450  : // ȡҳ��ĵ�ַ -> phys_addr�������ҳ���ַ�����ڻ�С���ڴ�Ͷ�(1M)Ҳ�����˳���
; 451  : 	phys_addr &= 0xfffff000;
; 452  : 	if (phys_addr >= HIGH_MEMORY || phys_addr < LOW_MEM)

	cmp	edx, 1048576				; 00100000H
	jb	$L720
	push	ebx

; 454  : // *** �Ե�ǰ����ҳ����в�����
; 455  : // ȡҳĿ¼������ -> to�������Ŀ¼����Ч(P=0)����ȡ����ҳ�棬������to_page ��ָ��Ŀ¼�
; 456  : 	to = *(unsigned long *) to_page;

	mov	ebx, DWORD PTR [esi]

; 457  : 	if (!(to & 1))

	test	bl, 1
	jne	SHORT $L869

; 458  : 		if (to = get_free_page())

	call	_get_free_page
	mov	ebx, eax
	test	ebx, ebx
	je	SHORT $L723

; 459  : 			*(unsigned long *) to_page = to | 7;

	mov	ecx, ebx
	or	ecx, 7
	mov	DWORD PTR [esi], ecx

; 460  : 		else

	jmp	SHORT $L871
$L723:

; 461  : 			oom();

	push	OFFSET FLAT:$SG574
	call	_printk
	push	11					; 0000000bH
	call	_do_exit
	add	esp, 8
$L871:
	mov	edx, DWORD PTR _phys_addr$[ebp]
	mov	ecx, DWORD PTR 12+[ebp]
$L869:

; 462  : // ȡ��Ӧҳ���ַ -> to��ҳ�����ַ to_page�������Ӧ��ҳ���Ѿ����ڣ������������
; 463  : 	to &= 0xfffff000;

	and	ebx, -4096				; fffff000H

; 464  : 	to_page = to + ((address>>10) & 0xffc);

	add	ebx, ecx

; 465  : 	if (1 & *(unsigned long *) to_page)

	test	BYTE PTR [ebx], 1
	je	SHORT $L727

; 466  : 		panic("try_to_share: to_page already exists");

	push	OFFSET FLAT:$SG728
	call	_panic
	mov	edx, DWORD PTR _phys_addr$[ebp]
	add	esp, 4
$L727:

; 467  : /* �����ǽ��й�����д���� */
; 468  : // ��p ������ҳ����д������־(��R/W=0 ֻ��)�����ҵ�ǰ�����еĶ�Ӧҳ����ָ������
; 469  : 	*(unsigned long *) from_page &= ~2;

	mov	esi, DWORD PTR [edi]
	and	esi, -3					; fffffffdH
	mov	DWORD PTR [edi], esi
	mov	edi, esi

; 470  : 	*(unsigned long *) to_page = *(unsigned long *) from_page;

	mov	DWORD PTR [ebx], edi

; 471  : 	// ˢ��ҳ�任���ٻ��塣
; 472  : 	invalidate();

	xor	eax, eax
	mov	cr3, eax

; 473  : 	// ����������ҳ���ҳ��ţ�������Ӧҳ��ӳ���������е����õ���1��
; 474  : 	phys_addr -= LOW_MEM;

	lea	eax, DWORD PTR [edx-1048576]
	pop	ebx

; 475  : 	phys_addr >>= 12;

	shr	eax, 12					; 0000000cH
	pop	edi
	pop	esi

; 476  : 	mem_map[phys_addr]++;

	mov	cl, BYTE PTR _mem_map[eax]
	inc	cl
	mov	BYTE PTR _mem_map[eax], cl

; 477  : 	return 1;

	mov	eax, 1

; 478  : }

	pop	ebp
	ret	0
$L720:
	pop	edi

; 453  : 		return 0;

	xor	eax, eax
	pop	esi

; 478  : }

	pop	ebp
	ret	0
_try_to_share ENDP
_TEXT	ENDS
PUBLIC	_mem_init
_TEXT	SEGMENT
_start_mem$ = 8
_end_mem$ = 12
_mem_init PROC NEAR

; 571  : {

	push	ebp
	mov	ebp, esp

; 572  : 	int i;
; 573  : 
; 574  : 	HIGH_MEMORY = end_mem;// �����ڴ���߶ˡ�

	mov	edx, DWORD PTR _end_mem$[ebp]
	push	edi

; 575  : 	for (i=0 ; i<PAGING_PAGES ; i++)// ����������ҳ��Ϊ��ռ��(USED=100)״̬��
; 576  : 		mem_map[i] = USED;// ����ҳ��ӳ������ȫ�ó�USED��

	mov	ecx, 960				; 000003c0H
	mov	eax, 1684300900				; 64646464H
	mov	edi, OFFSET FLAT:_mem_map
	mov	DWORD PTR _HIGH_MEMORY, edx
	rep stosd

; 577  : 	i = MAP_NR(start_mem);// Ȼ������ʹ����ʼ�ڴ��ҳ��š�

	mov	ecx, DWORD PTR _start_mem$[ebp]

; 578  : 	end_mem -= start_mem;// �ټ���ɷ�ҳ������ڴ���С��

	sub	edx, ecx
	lea	eax, DWORD PTR [ecx-1048576]

; 579  : 	end_mem >>= 12;// �Ӷ�����������ڷ�ҳ�����ҳ������

	sar	edx, 12					; 0000000cH
	sar	eax, 12					; 0000000cH

; 580  : 	while (end_mem-->0)// �����Щ����ҳ���Ӧ��ҳ��ӳ���������㡣

	mov	ecx, edx
	dec	edx
	test	ecx, ecx
	jle	SHORT $L780
	lea	ecx, DWORD PTR [edx+1]
	lea	edi, DWORD PTR _mem_map[eax]
	mov	edx, ecx
	xor	eax, eax
	shr	ecx, 2
	rep stosd
	mov	ecx, edx
	and	ecx, 3
	rep stosb
$L780:
	pop	edi

; 581  : 		mem_map[i++]=0;
; 582  : }

	pop	ebp
	ret	0
_mem_init ENDP
_TEXT	ENDS
PUBLIC	_calc_mem
EXTRN	_pg_dir:BYTE
_DATA	SEGMENT
	ORG $+3
$SG794	DB	'%d pages free (of %d)', 0aH, 0dH, 00H
$SG804	DB	'Pg-dir[%d] uses %d pages', 0aH, 00H
_DATA	ENDS
_TEXT	SEGMENT
_calc_mem PROC NEAR

; 587  : 	int i,j,k,free=0;

	xor	ecx, ecx

; 588  : 	long * pg_tbl;
; 589  : 
; 590  : // ɨ���ڴ�ҳ��ӳ������mem_map[]����ȡ����ҳ��������ʾ��
; 591  : 	for(i=0 ; i<PAGING_PAGES ; i++)

	xor	eax, eax
$L790:

; 592  : 		if (!mem_map[i]) free++;

	mov	dl, BYTE PTR _mem_map[eax]
	test	dl, dl
	jne	SHORT $L791
	inc	ecx
$L791:

; 588  : 	long * pg_tbl;
; 589  : 
; 590  : // ɨ���ڴ�ҳ��ӳ������mem_map[]����ȡ����ҳ��������ʾ��
; 591  : 	for(i=0 ; i<PAGING_PAGES ; i++)

	inc	eax
	cmp	eax, 3840				; 00000f00H
	jl	SHORT $L790
	push	esi
	push	edi

; 593  : 	printk("%d pages free (of %d)\n\r",free,PAGING_PAGES);

	push	3840					; 00000f00H
	push	ecx
	push	OFFSET FLAT:$SG794
	call	_printk
	add	esp, 12					; 0000000cH

; 594  : // ɨ������ҳĿ¼���0��1 ������ҳĿ¼����Ч����ͳ�ƶ�Ӧҳ������Чҳ����������ʾ��
; 595  : 	for(i=2 ; i<1024 ; i++) {

	mov	edi, 2
	mov	esi, OFFSET FLAT:_pg_dir+8
$L795:

; 596  : 		if (1&pg_dir[i]) {

	mov	eax, DWORD PTR [esi]
	test	al, 1
	je	SHORT $L796

; 597  : 			pg_tbl=(long *) (0xfffff000 & pg_dir[i]);

	and	eax, -4096				; fffff000H

; 598  : 			for(j=k=0 ; j<1024 ; j++)

	xor	edx, edx
	mov	ecx, 1024				; 00000400H
$L800:

; 599  : 				if (pg_tbl[j]&1)

	test	BYTE PTR [eax], 1
	je	SHORT $L801

; 600  : 					k++;

	inc	edx
$L801:

; 598  : 			for(j=k=0 ; j<1024 ; j++)

	add	eax, 4
	dec	ecx
	jne	SHORT $L800

; 601  : 			printk("Pg-dir[%d] uses %d pages\n",i,k);

	push	edx
	push	edi
	push	OFFSET FLAT:$SG804
	call	_printk
	add	esp, 12					; 0000000cH
$L796:
	add	esi, 4
	inc	edi
	cmp	esi, OFFSET FLAT:_pg_dir+4096
	jl	SHORT $L795
	pop	edi
	pop	esi

; 602  : 		}
; 603  : 	}
; 604  : }

	ret	0
_calc_mem ENDP
_TEXT	ENDS
END
