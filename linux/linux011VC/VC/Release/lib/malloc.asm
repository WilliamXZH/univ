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
; 118  :  * 首先我们搜索存储桶目录bucket_dir 来寻找适合请求的桶大小。
; 119  :  */
; 120  : // 搜索存储桶目录，寻找适合申请内存块大小的桶描述符链表。如果目录项的桶字节
; 121  : // 数大于请求的字节数，就找到了对应的桶目录项。
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
; 125  : // 如果搜索完整个目录都没有找到合适大小的目录项，则表明所请求的内存块大小太大，超出了该
; 126  : // 程序的分配限制(最长为1 个页面)。于是显示出错信息，死机。
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
; 133  : 	 * 现在我们来搜索具有空闲空间的桶描述符。
; 134  : 	 */
; 135  : 	cli();	/* 为了避免出现竞争条件，首先关中断 */

	cli

; 136  : // 搜索对应桶目录项中描述符链表，查找具有空闲空间的桶描述符。如果桶描述符的空闲内存指针
; 137  : // freeptr 不为空，则表示找到了相应的桶描述符。
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
; 142  : 	 * 如果没有找到具有空闲空间的桶描述符，那么我们就要新建立一个该目录项的描述符。
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
; 148  : // 若free_bucket_desc 还为空时，表示第一次调用该程序，则对描述符链表进行初始化。
; 149  : // free_bucket_desc 指向第一个空闲桶描述符。
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

; 152  : // 取free_bucket_desc 指向的空闲桶描述符，并让free_bucket_desc 指向下一个空闲桶描述符。
; 153  : 		bdesc = free_bucket_desc;
; 154  : 		free_bucket_desc = bdesc->next;

	mov	ecx, DWORD PTR [esi+4]

; 155  : // 初始化该新的桶描述符。令其引用数量等于0；桶的大小等于对应桶目录的大小；申请一内存页面，
; 156  : // 让描述符的页面指针page 指向该页面；空闲内存指针也指向该页开头，因为此时全为空闲。
; 157  : 		bdesc->refcnt = 0;
; 158  : 		bdesc->bucket_size = bdir->size;

	mov	dx, WORD PTR [ebx]
	mov	DWORD PTR _free_bucket_desc, ecx
	mov	WORD PTR [esi+12], 0
	mov	WORD PTR [esi+14], dx

; 159  : 		bdesc->page = bdesc->freeptr = (void *) cp = (void *)get_free_page();

	call	_get_free_page
	mov	edi, eax

; 160  : // 如果申请内存页面操作失败，则显示出错信息，死机。
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

; 163  : 		/* 在该页空闲内存中建立空闲对象链表 */
; 164  : // 以该桶目录项指定的桶大小为对象长度，对该页内存进行划分，并使每个对象的开始4 字节设置
; 165  : // 成指向下一对象的指针。
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
; 170  : // 最后一个对象开始处的指针设置为0(NULL)。
; 171  : // 然后让该桶描述符的下一描述符指针字段指向对应桶目录项指针chain 所指的描述符，而桶目录的
; 172  : // chain 指向该桶描述符，也即将该描述符插入到描述符链链头处。
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
; 177  : // 返回指针即等于该描述符对应页面的当前空闲指针。然后调整该空闲空间指针指向下一个空闲对象，
; 178  : // 并使描述符中对应页面中对象引用计数增1。
; 179  : 	retval = (void *) bdesc->freeptr;

	mov	eax, DWORD PTR [esi+8]

; 180  : 	bdesc->freeptr = *((void **) retval);
; 181  : 	bdesc->refcnt++;

	inc	WORD PTR [esi+12]
	mov	ecx, DWORD PTR [eax]
	mov	DWORD PTR [esi+8], ecx

; 182  : // 最后开放中断，并返回指向空闲内存对象的指针。
; 183  : 	sti();	/* OK，现在我们又安全了 */

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

; 114  : 	_asm mov word ptr [ebx],ax // 将TSS 长度放入描述符长度域(第0-1 字节)。

	mov	WORD PTR [ebx], ax

; 115  : 	_asm mov eax,addr 

	mov	eax, DWORD PTR _addr$[ebp]

; 116  : 	_asm mov word ptr [ebx+2],ax // 将基地址的低字放入描述符第2-3 字节。

	mov	WORD PTR [ebx+2], ax

; 117  : 	_asm ror eax,16 // 将基地址高字移入ax 中。

	ror	eax, 16					; 00000010H

; 118  : 	_asm mov byte ptr [ebx+4],al // 将基地址高字中低字节移入描述符第4 字节。

	mov	BYTE PTR [ebx+4], al

; 119  : 	_asm mov al,tp

	mov	al, BYTE PTR _tp$[ebp]

; 120  : 	_asm mov byte ptr [ebx+5],al // 将标志类型字节移入描述符的第5 字节。

	mov	BYTE PTR [ebx+5], al

; 121  : 	_asm mov al,0 

	mov	al, 0

; 122  : 	_asm mov byte ptr [ebx+6],al // 描述符的第6 字节置0。

	mov	BYTE PTR [ebx+6], al

; 123  : 	_asm mov byte ptr [ebx+7],ah // 将基地址高字中高字节移入描述符第7 字节。

	mov	BYTE PTR [ebx+7], ah

; 124  : 	_asm ror eax,16 // eax 清零。

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
; 201  : 	/* 计算该对象所在的页面 */
; 202  : 	page = (void *)  ((unsigned long) obj & 0xfffff000);

	mov	edx, DWORD PTR _obj$[ebp]

; 203  : 	/* 现在搜索存储桶目录项所链接的桶描述符，寻找该页面 */
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

; 206  : 		/* 如果参数size 是0，则下面条件肯定是false */
; 207  : 		if (bdir->size < size)

	mov	esi, DWORD PTR _bdesc$[ebp]
$L168:

; 205  : 		prev = 0;

	xor	edi, edi

; 206  : 		/* 如果参数size 是0，则下面条件肯定是false */
; 207  : 		if (bdir->size < size)

	cmp	eax, DWORD PTR _size$[ebp]
	jl	SHORT $L169

; 208  : 			continue;
; 209  : // 搜索对应目录项中链接的所有描述符，查找对应页面。如果某描述符页面指针等于page 则表示找到
; 210  : // 了相应的描述符，跳转到found。如果描述符不含有对应page，则让描述符指针prev 指向该描述符。
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

; 203  : 	/* 现在搜索存储桶目录项所链接的桶描述符，寻找该页面 */
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
; 217  : // 若搜索了对应目录项的所有描述符都没有找到指定的页面，则显示出错信息，死机。
; 218  : 	panic("Bad address passed to kernel free_s()");

	push	OFFSET FLAT:$SG177
	call	_panic
	mov	edx, DWORD PTR _obj$[ebp]
	add	esp, 4
$found$176:

; 219  : found:
; 220  : // 找到对应的桶描述符后，首先关中断。然后将该对象内存块链入空闲块对象链表中，
; 221  : // 并使该描述符的对象引用计数减1。
; 222  : 	cli(); /* 为了避免竞争条件 */

	cli

; 223  : 	*((void **)obj) = bdesc->freeptr;

	mov	eax, DWORD PTR [esi+8]

; 224  : 	bdesc->freeptr = obj;
; 225  : 	bdesc->refcnt--;

	dec	WORD PTR [esi+12]

; 226  : // 如果引用计数已等于0，则我们就可以释放对应的内存页面和该桶描述符。
; 227  : 	if (bdesc->refcnt == 0) {

	cmp	WORD PTR [esi+12], 0
	mov	DWORD PTR [edx], eax
	mov	DWORD PTR [esi+8], edx
	jne	SHORT $L179

; 228  : 		/*
; 229  : 		 * 我们需要确信prev 仍然是正确的，若某程序粗鲁地中断了我们
; 230  : 		 * 就有可能不是了。
; 231  : 		 */
; 232  : // 如果prev 已经不是搜索到的描述符的前一个描述符，则重新搜索当前描述符的前一个描述符。
; 233  : 		if ((prev && (prev->next != bdesc)) ||
; 234  : 		    (!prev && (bdir->chain != bdesc)))

	test	edi, edi
	je	SHORT $L227
	cmp	DWORD PTR [edi+4], esi
	jne	SHORT $L181

; 240  : 			prev->next = bdesc->next;

	mov	ecx, DWORD PTR [esi+4]
	mov	DWORD PTR [edi+4], ecx

; 241  : // 如果prev==NULL，则说明当前一个描述符是该目录项首个描述符，也即目录项中chain 应该直接
; 242  : // 指向当前描述符bdesc，否则表示链表有问题，则显示出错信息，死机。因此，为了将当前描述符
; 243  : // 从链表中删除，应该让chain 指向下一个描述符。
; 244  : 		else {

	jmp	SHORT $L188
$L227:

; 228  : 		/*
; 229  : 		 * 我们需要确信prev 仍然是正确的，若某程序粗鲁地中断了我们
; 230  : 		 * 就有可能不是了。
; 231  : 		 */
; 232  : // 如果prev 已经不是搜索到的描述符的前一个描述符，则重新搜索当前描述符的前一个描述符。
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
; 249  : // 释放当前描述符所操作的内存页面，并将该描述符插入空闲描述符链表开始处。
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
; 254  : // 开中断，返回。
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
; 238  : // 如果找到该前一个描述符，则从描述符链中删除当前描述符。
; 239  : 		if (prev)

	test	edi, edi
	je	SHORT $L187

; 240  : 			prev->next = bdesc->next;

	mov	ecx, DWORD PTR [esi+4]
	mov	DWORD PTR [edi+4], ecx

; 241  : // 如果prev==NULL，则说明当前一个描述符是该目录项首个描述符，也即目录项中chain 应该直接
; 242  : // 指向当前描述符bdesc，否则表示链表有问题，则显示出错信息，死机。因此，为了将当前描述符
; 243  : // 从链表中删除，应该让chain 指向下一个描述符。
; 244  : 		else {

	jmp	SHORT $L188
_free_s	ENDP
_TEXT	ENDS
END
