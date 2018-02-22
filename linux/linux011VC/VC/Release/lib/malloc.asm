	TITLE	..\lib\malloc.c
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
FLAT	GROUP _DATA, CONST, _BSS
	ASSUME	CS: FLAT, DS: FLAT, SS: FLAT
endif
PUBLIC	_bucket_dir
PUBLIC	_free_bucket_desc
_BSS	SEGMENT
_free_bucket_desc DD 01H DUP (?)
_BSS	ENDS
_DATA	SEGMENT
_bucket_dir DD	010H
	DD	00H
	DD	020H
	DD	00H
	DD	040H
	DD	00H
	DD	080H
	DD	00H
	DD	0100H
	DD	00H
	DD	0200H
	DD	00H
	DD	0400H
	DD	00H
	DD	0800H
	DD	00H
	DD	01000H
	DD	00H
	DD	00H
	DD	00H
$SG120	DB	'Out of memory in init_bucket_desc()', 00H
_DATA	ENDS
PUBLIC	_malloc
EXTRN	_panic:NEAR
EXTRN	_printk:NEAR
EXTRN	_get_free_page:NEAR
_DATA	SEGMENT
$SG136	DB	'malloc called with impossibly large argument (%d)', 0aH, 00H
	ORG $+1
$SG137	DB	'malloc: bad arg', 00H
$SG149	DB	'Out of memory in kernel malloc()', 00H
_DATA	ENDS
_TEXT	SEGMENT
_len$ = 8
_malloc	PROC NEAR

; 112  : {

	push	ebp
	mov	ebp, esp

; 113  : 	struct _bucket_dir	*bdir;
; 114  : 	struct bucket_desc	*bdesc;
; 115  : 	void			*retval;
; 116  : 
; 117  : /*
; 118  :  * �������������洢ͰĿ¼bucket_dir ��Ѱ���ʺ������Ͱ��С��
; 119  :  */
; 120  : // �����洢ͰĿ¼��Ѱ���ʺ������ڴ���С��Ͱ�������������Ŀ¼���Ͱ�ֽ�
; 121  : // ������������ֽ��������ҵ��˶�Ӧ��ͰĿ¼�
; 122  : 	for (bdir = bucket_dir; bdir->size; bdir++)

	mov	eax, DWORD PTR _bucket_dir
	mov	ecx, DWORD PTR _len$[ebp]
	push	ebx
	push	esi
	test	eax, eax
	mov	ebx, OFFSET FLAT:_bucket_dir
	je	SHORT $L210
$L131:

; 123  : 		if (bdir->size >= len)

	cmp	eax, ecx
	jae	SHORT $L210
	mov	eax, DWORD PTR [ebx+8]
	add	ebx, 8
	test	eax, eax
	jne	SHORT $L131
$L210:

; 124  : 			break;
; 125  : // �������������Ŀ¼��û���ҵ����ʴ�С��Ŀ¼��������������ڴ���С̫�󣬳����˸�
; 126  : // ����ķ�������(�Ϊ1 ��ҳ��)��������ʾ������Ϣ��������
; 127  : 	if (!bdir->size) {

	cmp	DWORD PTR [ebx], 0
	jne	SHORT $L135

; 128  : 		printk("malloc called with impossibly large argument (%d)\n",
; 129  : 			len);

	push	ecx
	push	OFFSET FLAT:$SG136
	call	_printk

; 130  : 		panic("malloc: bad arg");

	push	OFFSET FLAT:$SG137
	call	_panic
	add	esp, 12					; 0000000cH
$L135:

; 131  : 	}
; 132  : 	/*
; 133  : 	 * �����������������п��пռ��Ͱ��������
; 134  : 	 */
; 135  : 	cli();	/* Ϊ�˱�����־������������ȹ��ж� */

	cli

; 136  : // ������ӦͰĿ¼�����������������Ҿ��п��пռ��Ͱ�����������Ͱ�������Ŀ����ڴ�ָ��
; 137  : // freeptr ��Ϊ�գ����ʾ�ҵ�����Ӧ��Ͱ��������
; 138  : 	for (bdesc = bdir->chain; bdesc; bdesc = bdesc->next) 

	mov	esi, DWORD PTR [ebx+4]
	test	esi, esi
	je	SHORT $L216
$L138:

; 139  : 		if (bdesc->freeptr)

	mov	eax, DWORD PTR [esi+8]
	test	eax, eax
	jne	SHORT $L211
	mov	esi, DWORD PTR [esi+4]
	test	esi, esi
	jne	SHORT $L138

; 140  : 			break;
; 141  : 	/*
; 142  : 	 * ���û���ҵ����п��пռ��Ͱ����������ô���Ǿ�Ҫ�½���һ����Ŀ¼�����������
; 143  : 	 */
; 144  : 	if (!bdesc) {

	jmp	SHORT $L216
$L211:
	test	esi, esi
	jne	$L142
$L216:

; 145  : 		char		*cp;
; 146  : 		int		i;
; 147  : 
; 148  : // ��free_bucket_desc ��Ϊ��ʱ����ʾ��һ�ε��øó������������������г�ʼ����
; 149  : // free_bucket_desc ָ���һ������Ͱ��������
; 150  : 		if (!free_bucket_desc)	

	mov	esi, DWORD PTR _free_bucket_desc
	push	edi
	test	esi, esi
	jne	SHORT $L197

; 151  : 			init_bucket_desc();

	call	_get_free_page
	mov	esi, eax
	test	esi, esi
	mov	edi, esi
	jne	SHORT $L201
	push	OFFSET FLAT:$SG120
	call	_panic
	add	esp, 4
$L201:
	mov	ecx, 255				; 000000ffH
$L202:
	lea	eax, DWORD PTR [esi+16]
	dec	ecx
	mov	DWORD PTR [esi+4], eax
	mov	esi, eax
	jne	SHORT $L202
	mov	eax, DWORD PTR _free_bucket_desc
	mov	DWORD PTR [esi+4], eax
	mov	esi, edi
$L197:

; 152  : // ȡfree_bucket_desc ָ��Ŀ���Ͱ������������free_bucket_desc ָ����һ������Ͱ��������
; 153  : 		bdesc = free_bucket_desc;
; 154  : 		free_bucket_desc = bdesc->next;

	mov	ecx, DWORD PTR [esi+4]

; 155  : // ��ʼ�����µ�Ͱ������������������������0��Ͱ�Ĵ�С���ڶ�ӦͰĿ¼�Ĵ�С������һ�ڴ�ҳ�棬
; 156  : // ����������ҳ��ָ��page ָ���ҳ�棻�����ڴ�ָ��Ҳָ���ҳ��ͷ����Ϊ��ʱȫΪ���С�
; 157  : 		bdesc->refcnt = 0;
; 158  : 		bdesc->bucket_size = bdir->size;

	mov	dx, WORD PTR [ebx]
	mov	DWORD PTR _free_bucket_desc, ecx
	mov	WORD PTR [esi+12], 0
	mov	WORD PTR [esi+14], dx

; 159  : 		bdesc->page = bdesc->freeptr = (void *) cp = (void *)get_free_page();

	call	_get_free_page
	mov	edi, eax

; 160  : // ��������ڴ�ҳ�����ʧ�ܣ�����ʾ������Ϣ��������
; 161  : 		if (!cp)

	test	edi, edi
	mov	DWORD PTR [esi+8], edi
	mov	DWORD PTR [esi], edi
	jne	SHORT $L148

; 162  : 			panic("Out of memory in kernel malloc()");

	push	OFFSET FLAT:$SG149
	call	_panic
	add	esp, 4
$L148:

; 163  : 		/* �ڸ�ҳ�����ڴ��н������ж������� */
; 164  : // �Ը�ͰĿ¼��ָ����Ͱ��СΪ���󳤶ȣ��Ը�ҳ�ڴ���л��֣���ʹÿ������Ŀ�ʼ4 �ֽ�����
; 165  : // ��ָ����һ�����ָ�롣
; 166  : 		for (i=PAGE_SIZE/bdir->size; i > 1; i--) {

	mov	ecx, DWORD PTR [ebx]
	mov	eax, 4096				; 00001000H
	cdq
	idiv	ecx
	cmp	eax, 1
	jle	SHORT $L152
	lea	edx, DWORD PTR [eax-1]
$L150:

; 167  : 			*((char **) cp) = cp + bdir->size;

	lea	eax, DWORD PTR [ecx+edi]
	dec	edx
	mov	DWORD PTR [edi], eax

; 168  : 			cp += bdir->size;

	mov	edi, eax
	jne	SHORT $L150
$L152:

; 169  : 		}
; 170  : // ���һ������ʼ����ָ������Ϊ0(NULL)��
; 171  : // Ȼ���ø�Ͱ����������һ������ָ���ֶ�ָ���ӦͰĿ¼��ָ��chain ��ָ������������ͰĿ¼��
; 172  : // chain ָ���Ͱ��������Ҳ���������������뵽����������ͷ����
; 173  : 		*((char **) cp) = 0;
; 174  : 		bdesc->next = bdir->chain; /* OK, link it in! */

	mov	eax, DWORD PTR [ebx+4]
	mov	DWORD PTR [edi], 0
	mov	DWORD PTR [esi+4], eax

; 175  : 		bdir->chain = bdesc;

	mov	DWORD PTR [ebx+4], esi
	pop	edi
$L142:

; 176  : 	}
; 177  : // ����ָ�뼴���ڸ���������Ӧҳ��ĵ�ǰ����ָ�롣Ȼ������ÿ��пռ�ָ��ָ����һ�����ж���
; 178  : // ��ʹ�������ж�Ӧҳ���ж������ü�����1��
; 179  : 	retval = (void *) bdesc->freeptr;

	mov	eax, DWORD PTR [esi+8]

; 180  : 	bdesc->freeptr = *((void **) retval);
; 181  : 	bdesc->refcnt++;

	inc	WORD PTR [esi+12]
	mov	ecx, DWORD PTR [eax]
	mov	DWORD PTR [esi+8], ecx

; 182  : // ��󿪷��жϣ�������ָ������ڴ�����ָ�롣
; 183  : 	sti();	/* OK�����������ְ�ȫ�� */

	sti

; 180  : 	bdesc->freeptr = *((void **) retval);
; 181  : 	bdesc->refcnt++;

	pop	esi
	pop	ebx

; 184  : 	return(retval);
; 185  : }

	pop	ebp
	ret	0
_malloc	ENDP
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
PUBLIC	_free_s
EXTRN	_free_page:NEAR
_DATA	SEGMENT
	ORG $+3
$SG177	DB	'Bad address passed to kernel free_s()', 00H
	ORG $+2
$SG190	DB	'malloc bucket chains corrupted', 00H
_DATA	ENDS
_TEXT	SEGMENT
_obj$ = 8
_size$ = 12
_bdesc$ = 8
_prev$ = 8
_free_s	PROC NEAR

; 196  : {

	push	ebp
	mov	ebp, esp

; 197  : 	void		*page;
; 198  : 	struct _bucket_dir	*bdir;
; 199  : 	struct bucket_desc	*bdesc, *prev;
; 200  : 
; 201  : 	/* ����ö������ڵ�ҳ�� */
; 202  : 	page = (void *)  ((unsigned long) obj & 0xfffff000);

	mov	edx, DWORD PTR _obj$[ebp]

; 203  : 	/* ���������洢ͰĿ¼�������ӵ�Ͱ��������Ѱ�Ҹ�ҳ�� */
; 204  : 	for (bdir = bucket_dir; bdir->size; bdir++) {

	mov	eax, DWORD PTR _bucket_dir
	mov	ecx, edx
	push	ebx
	and	ecx, -4096				; fffff000H
	push	esi
	test	eax, eax
	push	edi
	mov	ebx, OFFSET FLAT:_bucket_dir
	je	SHORT $L229

; 206  : 		/* �������size ��0�������������϶���false */
; 207  : 		if (bdir->size < size)

	mov	esi, DWORD PTR _bdesc$[ebp]
$L168:

; 205  : 		prev = 0;

	xor	edi, edi

; 206  : 		/* �������size ��0�������������϶���false */
; 207  : 		if (bdir->size < size)

	cmp	eax, DWORD PTR _size$[ebp]
	jl	SHORT $L169

; 208  : 			continue;
; 209  : // ������ӦĿ¼�������ӵ����������������Ҷ�Ӧҳ�档���ĳ������ҳ��ָ�����page ���ʾ�ҵ�
; 210  : // ����Ӧ������������ת��found����������������ж�Ӧpage������������ָ��prev ָ�����������
; 211  : 		for (bdesc = bdir->chain; bdesc; bdesc = bdesc->next) {

	mov	esi, DWORD PTR [ebx+4]
	test	esi, esi
	je	SHORT $L169
$L172:

; 212  : 			if (bdesc->page == page) 

	cmp	DWORD PTR [esi], ecx
	je	SHORT $found$176

; 213  : 				goto found;
; 214  : 			prev = bdesc;

	mov	edi, esi
	mov	esi, DWORD PTR [esi+4]
	test	esi, esi
	jne	SHORT $L172
$L169:

; 203  : 	/* ���������洢ͰĿ¼�������ӵ�Ͱ��������Ѱ�Ҹ�ҳ�� */
; 204  : 	for (bdir = bucket_dir; bdir->size; bdir++) {

	mov	eax, DWORD PTR [ebx+8]
	add	ebx, 8
	test	eax, eax
	jne	SHORT $L168
	jmp	SHORT $L170
$L229:
	mov	edi, DWORD PTR _prev$[ebp]
	mov	esi, DWORD PTR _bdesc$[ebp]
$L170:

; 215  : 		}
; 216  : 	}
; 217  : // �������˶�ӦĿ¼���������������û���ҵ�ָ����ҳ�棬����ʾ������Ϣ��������
; 218  : 	panic("Bad address passed to kernel free_s()");

	push	OFFSET FLAT:$SG177
	call	_panic
	mov	edx, DWORD PTR _obj$[ebp]
	add	esp, 4
$found$176:

; 219  : found:
; 220  : // �ҵ���Ӧ��Ͱ�����������ȹ��жϡ�Ȼ�󽫸ö����ڴ��������п���������У�
; 221  : // ��ʹ���������Ķ������ü�����1��
; 222  : 	cli(); /* Ϊ�˱��⾺������ */

	cli

; 223  : 	*((void **)obj) = bdesc->freeptr;

	mov	eax, DWORD PTR [esi+8]

; 224  : 	bdesc->freeptr = obj;
; 225  : 	bdesc->refcnt--;

	dec	WORD PTR [esi+12]

; 226  : // ������ü����ѵ���0�������ǾͿ����ͷŶ�Ӧ���ڴ�ҳ��͸�Ͱ��������
; 227  : 	if (bdesc->refcnt == 0) {

	cmp	WORD PTR [esi+12], 0
	mov	DWORD PTR [edx], eax
	mov	DWORD PTR [esi+8], edx
	jne	SHORT $L179

; 228  : 		/*
; 229  : 		 * ������Ҫȷ��prev ��Ȼ����ȷ�ģ���ĳ�����³���ж�������
; 230  : 		 * ���п��ܲ����ˡ�
; 231  : 		 */
; 232  : // ���prev �Ѿ���������������������ǰһ����������������������ǰ��������ǰһ����������
; 233  : 		if ((prev && (prev->next != bdesc)) ||
; 234  : 		    (!prev && (bdir->chain != bdesc)))

	test	edi, edi
	je	SHORT $L227
	cmp	DWORD PTR [edi+4], esi
	jne	SHORT $L181

; 240  : 			prev->next = bdesc->next;

	mov	ecx, DWORD PTR [esi+4]
	mov	DWORD PTR [edi+4], ecx

; 241  : // ���prev==NULL����˵����ǰһ���������Ǹ�Ŀ¼���׸���������Ҳ��Ŀ¼����chain Ӧ��ֱ��
; 242  : // ָ��ǰ������bdesc�������ʾ���������⣬����ʾ������Ϣ����������ˣ�Ϊ�˽���ǰ������
; 243  : // ��������ɾ����Ӧ����chain ָ����һ����������
; 244  : 		else {

	jmp	SHORT $L188
$L227:

; 228  : 		/*
; 229  : 		 * ������Ҫȷ��prev ��Ȼ����ȷ�ģ���ĳ�����³���ж�������
; 230  : 		 * ���п��ܲ����ˡ�
; 231  : 		 */
; 232  : // ���prev �Ѿ���������������������ǰһ����������������������ǰ��������ǰһ����������
; 233  : 		if ((prev && (prev->next != bdesc)) ||
; 234  : 		    (!prev && (bdir->chain != bdesc)))

	mov	ecx, DWORD PTR [ebx+4]
	cmp	ecx, esi
	je	SHORT $L189
$L181:

; 235  : 			for (prev = bdir->chain; prev; prev = prev->next)

	mov	ecx, DWORD PTR [ebx+4]
	mov	edi, ecx
	test	edi, edi
	je	SHORT $L187
$L183:

; 236  : 				if (prev->next == bdesc)

	mov	eax, DWORD PTR [edi+4]
	cmp	eax, esi
	je	SHORT $L223
	mov	edi, eax
	test	edi, edi
	jne	SHORT $L183
$L187:

; 245  : 			if (bdir->chain != bdesc)

	cmp	ecx, esi
	je	SHORT $L189

; 246  : 				panic("malloc bucket chains corrupted");

	push	OFFSET FLAT:$SG190
	call	_panic
	add	esp, 4
$L189:

; 247  : 			bdir->chain = bdesc->next;

	mov	edx, DWORD PTR [esi+4]
	mov	DWORD PTR [ebx+4], edx
$L188:

; 248  : 		}
; 249  : // �ͷŵ�ǰ���������������ڴ�ҳ�棬�����������������������������ʼ����
; 250  : 		free_page((unsigned long) bdesc->page);

	mov	eax, DWORD PTR [esi]
	push	eax
	call	_free_page

; 251  : 		bdesc->next = free_bucket_desc;

	mov	ecx, DWORD PTR _free_bucket_desc
	add	esp, 4
	mov	DWORD PTR [esi+4], ecx

; 252  : 		free_bucket_desc = bdesc;

	mov	DWORD PTR _free_bucket_desc, esi
$L179:

; 253  : 	}
; 254  : // ���жϣ����ء�
; 255  : 	sti();

	sti

; 252  : 		free_bucket_desc = bdesc;

	pop	edi
	pop	esi
	pop	ebx

; 256  : 	return;
; 257  : }

	pop	ebp
	ret	0
$L223:

; 237  : 					break;
; 238  : // ����ҵ���ǰһ�����������������������ɾ����ǰ��������
; 239  : 		if (prev)

	test	edi, edi
	je	SHORT $L187

; 240  : 			prev->next = bdesc->next;

	mov	ecx, DWORD PTR [esi+4]
	mov	DWORD PTR [edi+4], ecx

; 241  : // ���prev==NULL����˵����ǰһ���������Ǹ�Ŀ¼���׸���������Ҳ��Ŀ¼����chain Ӧ��ֱ��
; 242  : // ָ��ǰ������bdesc�������ʾ���������⣬����ʾ������Ϣ����������ˣ�Ϊ�˽���ǰ������
; 243  : // ��������ɾ����Ӧ����chain ָ����һ����������
; 244  : 		else {

	jmp	SHORT $L188
_free_s	ENDP
_TEXT	ENDS
END
