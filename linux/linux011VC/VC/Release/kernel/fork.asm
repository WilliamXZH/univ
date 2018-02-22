	TITLE	..\kernel\fork.c
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
;	COMDAT __set_tssldt_desc
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
FLAT	GROUP _DATA, CONST, _BSS
	ASSUME	CS: FLAT, DS: FLAT, SS: FLAT
endif
PUBLIC	_last_pid
_BSS	SEGMENT
_last_pid DD	01H DUP (?)
_BSS	ENDS
PUBLIC	_verify_area
EXTRN	_current:DWORD
EXTRN	_write_verify:NEAR
_TEXT	SEGMENT
_addr$ = 8
_size$ = 12
_start$ = -4
$T743 = -8
$T744 = -12
_verify_area PROC NEAR

; 35   : {

	push	ebp
	mov	ebp, esp
	sub	esp, 12					; 0000000cH
	push	ebx
	push	esi
	push	edi

; 36   : 	unsigned long start;
; 37   : 
; 38   : 	start = (unsigned long) addr;

	mov	eax, DWORD PTR _addr$[ebp]
	mov	DWORD PTR _start$[ebp], eax

; 41   : 	size += start & 0xfff;

	mov	ecx, DWORD PTR _start$[ebp]
	and	ecx, 4095				; 00000fffH
	mov	edx, DWORD PTR _size$[ebp]
	add	edx, ecx
	mov	DWORD PTR _size$[ebp], edx

; 42   : 	start &= 0xfffff000;

	mov	eax, DWORD PTR _start$[ebp]
	and	eax, -4096				; fffff000H
	mov	DWORD PTR _start$[ebp], eax

; 43   : 	start += get_base (current->ldt[2]);// 此时start 变成系统整个线性空间中的地址位置。

	mov	ecx, DWORD PTR _current
	add	ecx, 736				; 000002e0H
	mov	DWORD PTR $T743[ebp], ecx

; 36   : 	unsigned long start;
; 37   : 
; 38   : 	start = (unsigned long) addr;

	mov	ebx, DWORD PTR $T743[ebp]

; 39   : // 将起始地址start 调整为其所在页的左边界开始位置，同时相应地调整验证区域大小。

	mov	ah, BYTE PTR [ebx+7]

; 40   : // 此时start 是当前进程空间中的线性地址。

	mov	al, BYTE PTR [ebx+4]

; 41   : 	size += start & 0xfff;

	shl	eax, 16					; 00000010H

; 42   : 	start &= 0xfffff000;

	mov	ax, WORD PTR [ebx+2]

; 43   : 	start += get_base (current->ldt[2]);// 此时start 变成系统整个线性空间中的地址位置。

	mov	DWORD PTR $T744[ebp], eax
	mov	edx, DWORD PTR _start$[ebp]
	add	edx, DWORD PTR $T744[ebp]
	mov	DWORD PTR _start$[ebp], edx
$L622:

; 44   : 	while (size > 0)

	cmp	DWORD PTR _size$[ebp], 0
	jle	SHORT $L623

; 46   : 		size -= 4096;

	mov	eax, DWORD PTR _size$[ebp]
	sub	eax, 4096				; 00001000H
	mov	DWORD PTR _size$[ebp], eax

; 47   : // 写页面验证。若页面不可写，则复制页面。（mm/memory.c，261 行）
; 48   : 		write_verify (start);

	mov	ecx, DWORD PTR _start$[ebp]
	push	ecx
	call	_write_verify
	add	esp, 4

; 49   : 		start += 4096;

	mov	edx, DWORD PTR _start$[ebp]
	add	edx, 4096				; 00001000H
	mov	DWORD PTR _start$[ebp], edx

; 50   : 	}

	jmp	SHORT $L622
$L623:

; 51   : }

	pop	edi
	pop	esi
	pop	ebx
	mov	esp, ebp
	pop	ebp
	ret	0
_verify_area ENDP
_TEXT	ENDS
PUBLIC	_copy_mem
EXTRN	_copy_page_tables:NEAR
EXTRN	_free_page_tables:NEAR
EXTRN	_panic:NEAR
_DATA	SEGMENT
$SG639	DB	'We don''t support separate I&D', 00H
	ORG $+2
$SG641	DB	'Bad data_limit', 00H
_DATA	ENDS
_TEXT	SEGMENT
_nr$ = 8
_p$ = 12
_old_data_base$ = -4
_new_data_base$ = -20
_data_limit$ = -24
_old_code_base$ = -16
_new_code_base$ = -12
_code_limit$ = -8
$T749 = -28
$T753 = -32
$T757 = -36
$T761 = -40
$T765 = -44
$T769 = -48
_copy_mem PROC NEAR

; 56   : {

	push	ebp
	mov	ebp, esp
	sub	esp, 48					; 00000030H
	push	ebx
	push	esi
	push	edi

; 60   : 	code_limit = get_limit (0x0f);	// 取局部描述符表中代码段描述符项中段限长。

	mov	DWORD PTR $T749[ebp], 15		; 0000000fH

; 57   : 	unsigned long old_data_base, new_data_base, data_limit;
; 58   : 	unsigned long old_code_base, new_code_base, code_limit;
; 59   : 

	mov	eax, DWORD PTR $T749[ebp]

; 60   : 	code_limit = get_limit (0x0f);	// 取局部描述符表中代码段描述符项中段限长。

	lsl	eax, eax
	mov	DWORD PTR _code_limit$[ebp], eax

; 61   : 	data_limit = get_limit (0x17);	// 取局部描述符表中数据段描述符项中段限长。

	mov	DWORD PTR $T753[ebp], 23		; 00000017H

; 57   : 	unsigned long old_data_base, new_data_base, data_limit;
; 58   : 	unsigned long old_code_base, new_code_base, code_limit;
; 59   : 

	mov	eax, DWORD PTR $T753[ebp]

; 60   : 	code_limit = get_limit (0x0f);	// 取局部描述符表中代码段描述符项中段限长。

	lsl	eax, eax

; 61   : 	data_limit = get_limit (0x17);	// 取局部描述符表中数据段描述符项中段限长。

	mov	DWORD PTR _data_limit$[ebp], eax

; 62   : 	old_code_base = get_base (current->ldt[1]);	// 取原代码段基址。

	mov	eax, DWORD PTR _current
	add	eax, 728				; 000002d8H
	mov	DWORD PTR $T757[ebp], eax

; 57   : 	unsigned long old_data_base, new_data_base, data_limit;
; 58   : 	unsigned long old_code_base, new_code_base, code_limit;
; 59   : 

	mov	ebx, DWORD PTR $T757[ebp]

; 60   : 	code_limit = get_limit (0x0f);	// 取局部描述符表中代码段描述符项中段限长。

	mov	ah, BYTE PTR [ebx+7]

; 61   : 	data_limit = get_limit (0x17);	// 取局部描述符表中数据段描述符项中段限长。

	mov	al, BYTE PTR [ebx+4]

; 62   : 	old_code_base = get_base (current->ldt[1]);	// 取原代码段基址。

	shl	eax, 16					; 00000010H

; 63   : 	old_data_base = get_base (current->ldt[2]);	// 取原数据段基址。

	mov	ax, WORD PTR [ebx+2]

; 62   : 	old_code_base = get_base (current->ldt[1]);	// 取原代码段基址。

	mov	DWORD PTR _old_code_base$[ebp], eax

; 63   : 	old_data_base = get_base (current->ldt[2]);	// 取原数据段基址。

	mov	ecx, DWORD PTR _current
	add	ecx, 736				; 000002e0H
	mov	DWORD PTR $T761[ebp], ecx

; 57   : 	unsigned long old_data_base, new_data_base, data_limit;
; 58   : 	unsigned long old_code_base, new_code_base, code_limit;
; 59   : 

	mov	ebx, DWORD PTR $T761[ebp]

; 60   : 	code_limit = get_limit (0x0f);	// 取局部描述符表中代码段描述符项中段限长。

	mov	ah, BYTE PTR [ebx+7]

; 61   : 	data_limit = get_limit (0x17);	// 取局部描述符表中数据段描述符项中段限长。

	mov	al, BYTE PTR [ebx+4]

; 62   : 	old_code_base = get_base (current->ldt[1]);	// 取原代码段基址。

	shl	eax, 16					; 00000010H

; 63   : 	old_data_base = get_base (current->ldt[2]);	// 取原数据段基址。

	mov	ax, WORD PTR [ebx+2]
	mov	DWORD PTR _old_data_base$[ebp], eax

; 64   : 	if (old_data_base != old_code_base)	// 0.11 版不支持代码和数据段分立的情况。

	mov	edx, DWORD PTR _old_data_base$[ebp]
	cmp	edx, DWORD PTR _old_code_base$[ebp]
	je	SHORT $L638

; 65   : 		panic ("We don't support separate I&D");

	push	OFFSET FLAT:$SG639
	call	_panic
	add	esp, 4
$L638:

; 66   : 	if (data_limit < code_limit)	// 如果数据段长度 < 代码段长度也不对。

	mov	eax, DWORD PTR _data_limit$[ebp]
	cmp	eax, DWORD PTR _code_limit$[ebp]
	jae	SHORT $L640

; 67   : 		panic ("Bad data_limit");

	push	OFFSET FLAT:$SG641
	call	_panic
	add	esp, 4
$L640:

; 68   : 	new_data_base = new_code_base = nr * 0x4000000;	// 新基址=任务号*64Mb(任务大小)。

	mov	ecx, DWORD PTR _nr$[ebp]
	shl	ecx, 26					; 0000001aH
	mov	DWORD PTR _new_code_base$[ebp], ecx
	mov	edx, DWORD PTR _new_code_base$[ebp]
	mov	DWORD PTR _new_data_base$[ebp], edx

; 69   : 	p->start_code = new_code_base;

	mov	eax, DWORD PTR _p$[ebp]
	mov	ecx, DWORD PTR _new_code_base$[ebp]
	mov	DWORD PTR [eax+536], ecx

; 70   : 	set_base (p->ldt[1], new_code_base);	// 设置代码段描述符中基址域。

	mov	edx, DWORD PTR _p$[ebp]
	add	edx, 728				; 000002d8H
	mov	DWORD PTR $T765[ebp], edx

; 60   : 	code_limit = get_limit (0x0f);	// 取局部描述符表中代码段描述符项中段限长。

	mov	ebx, DWORD PTR $T765[ebp]

; 61   : 	data_limit = get_limit (0x17);	// 取局部描述符表中数据段描述符项中段限长。

	mov	edx, DWORD PTR _new_code_base$[ebp]

; 62   : 	old_code_base = get_base (current->ldt[1]);	// 取原代码段基址。

	mov	WORD PTR [ebx+2], dx

; 63   : 	old_data_base = get_base (current->ldt[2]);	// 取原数据段基址。

	ror	edx, 16					; 00000010H

; 64   : 	if (old_data_base != old_code_base)	// 0.11 版不支持代码和数据段分立的情况。

	mov	BYTE PTR [ebx+4], dl

; 65   : 		panic ("We don't support separate I&D");

	mov	BYTE PTR [ebx+7], dh

; 71   : 	set_base (p->ldt[2], new_data_base);	// 设置数据段描述符中基址域。

	mov	eax, DWORD PTR _p$[ebp]
	add	eax, 736				; 000002e0H
	mov	DWORD PTR $T769[ebp], eax

; 60   : 	code_limit = get_limit (0x0f);	// 取局部描述符表中代码段描述符项中段限长。

	mov	ebx, DWORD PTR $T769[ebp]

; 61   : 	data_limit = get_limit (0x17);	// 取局部描述符表中数据段描述符项中段限长。

	mov	edx, DWORD PTR _new_data_base$[ebp]

; 62   : 	old_code_base = get_base (current->ldt[1]);	// 取原代码段基址。

	mov	WORD PTR [ebx+2], dx

; 63   : 	old_data_base = get_base (current->ldt[2]);	// 取原数据段基址。

	ror	edx, 16					; 00000010H

; 64   : 	if (old_data_base != old_code_base)	// 0.11 版不支持代码和数据段分立的情况。

	mov	BYTE PTR [ebx+4], dl

; 65   : 		panic ("We don't support separate I&D");

	mov	BYTE PTR [ebx+7], dh

; 72   : 	if (copy_page_tables (old_data_base, new_data_base, data_limit))

	mov	ecx, DWORD PTR _data_limit$[ebp]
	push	ecx
	mov	edx, DWORD PTR _new_data_base$[ebp]
	push	edx
	mov	eax, DWORD PTR _old_data_base$[ebp]
	push	eax
	call	_copy_page_tables
	add	esp, 12					; 0000000cH
	test	eax, eax
	je	SHORT $L646

; 74   : 		free_page_tables (new_data_base, data_limit);	// 如果出错则释放申请的内存。

	mov	ecx, DWORD PTR _data_limit$[ebp]
	push	ecx
	mov	edx, DWORD PTR _new_data_base$[ebp]
	push	edx
	call	_free_page_tables
	add	esp, 8

; 75   : 		return -ENOMEM;

	mov	eax, -12				; fffffff4H
	jmp	SHORT $L629
$L646:

; 77   : 	return 0;

	xor	eax, eax
$L629:

; 78   : }

	pop	edi
	pop	esi
	pop	ebx
	mov	esp, ebp
	pop	ebp
	ret	0
_copy_mem ENDP
_TEXT	ENDS
PUBLIC	_copy_process
EXTRN	_gdt:BYTE
EXTRN	_get_free_page:NEAR
EXTRN	_free_page:NEAR
EXTRN	_task:BYTE
EXTRN	_last_task_used_math:DWORD
EXTRN	_jiffies:DWORD
_TEXT	SEGMENT
_nr$ = 8
_ebp$ = 12
_edi$ = 16
_esi$ = 20
_gs$ = 24
_ebx$ = 32
_ecx$ = 36
_edx$ = 40
_fs$ = 44
_es$ = 48
_ds$ = 52
_eip$ = 56
_cs$ = 60
_eflags$ = 64
_esp$ = 68
_ss$ = 72
_p$ = -4
_i$ = -12
_f$ = -8
_p_i387$ = -16
$T774 = -20
$T775 = -24
$T779 = -28
$T780 = -32
_copy_process PROC NEAR

; 89   : {

	push	ebp
	mov	ebp, esp
	sub	esp, 32					; 00000020H
	push	ebx
	push	esi
	push	edi

; 90   : 	struct task_struct *p;
; 91   : 	int i;
; 92   : 	struct file *f;
; 93   : 	struct i387_struct *p_i387;
; 94   : 
; 95   : 	p = (struct task_struct *) get_free_page ();	// 为新任务数据结构分配内存。

	call	_get_free_page
	mov	DWORD PTR _p$[ebp], eax

; 96   : 	if (!p)			// 如果内存分配出错，则返回出错码并退出。

	cmp	DWORD PTR _p$[ebp], 0
	jne	SHORT $L688

; 97   : 		return -EAGAIN;

	mov	eax, -11				; fffffff5H
	jmp	$L682
$L688:

; 98   : 	task[nr] = p;			// 将新任务结构指针放入任务数组中。

	mov	eax, DWORD PTR _nr$[ebp]
	mov	ecx, DWORD PTR _p$[ebp]
	mov	DWORD PTR _task[eax*4], ecx

; 100  : 	*p = *current;		/* NOTE! this doesn't copy the supervisor stack */

	mov	esi, DWORD PTR _current
	mov	ecx, 239				; 000000efH
	mov	edi, DWORD PTR _p$[ebp]
	rep movsd

; 102  : 	p->state = TASK_UNINTERRUPTIBLE;	// 将新进程的状态先置为不可中断等待状态。

	mov	edx, DWORD PTR _p$[ebp]
	mov	DWORD PTR [edx], 2

; 103  : 	p->pid = last_pid;		// 新进程号。由前面调用find_empty_process()得到。

	mov	eax, DWORD PTR _p$[ebp]
	mov	ecx, DWORD PTR _last_pid
	mov	DWORD PTR [eax+556], ecx

; 104  : 	p->father = current->pid;	// 设置父进程号。

	mov	edx, DWORD PTR _p$[ebp]
	mov	eax, DWORD PTR _current
	mov	ecx, DWORD PTR [eax+556]
	mov	DWORD PTR [edx+560], ecx

; 105  : 	p->counter = p->priority;

	mov	edx, DWORD PTR _p$[ebp]
	mov	eax, DWORD PTR _p$[ebp]
	mov	ecx, DWORD PTR [eax+8]
	mov	DWORD PTR [edx+4], ecx

; 106  : 	p->signal = 0;		// 信号位图置0。

	mov	edx, DWORD PTR _p$[ebp]
	mov	DWORD PTR [edx+12], 0

; 107  : 	p->alarm = 0;

	mov	eax, DWORD PTR _p$[ebp]
	mov	DWORD PTR [eax+588], 0

; 108  : 	p->leader = 0;		/* process leadership doesn't inherit */

	mov	ecx, DWORD PTR _p$[ebp]
	mov	DWORD PTR [ecx+572], 0

; 109  : /* 进程的领导权是不能继承的 */
; 110  : 	p->utime = p->stime = 0;	// 初始化用户态时间和核心态时间。

	mov	edx, DWORD PTR _p$[ebp]
	mov	DWORD PTR [edx+596], 0
	mov	eax, DWORD PTR _p$[ebp]
	mov	DWORD PTR [eax+592], 0

; 111  : 	p->cutime = p->cstime = 0;	// 初始化子进程用户态和核心态时间。

	mov	ecx, DWORD PTR _p$[ebp]
	mov	DWORD PTR [ecx+604], 0
	mov	edx, DWORD PTR _p$[ebp]
	mov	DWORD PTR [edx+600], 0

; 112  : 	p->start_time = jiffies;	// 当前滴答数时间。

	mov	eax, DWORD PTR _p$[ebp]
	mov	ecx, DWORD PTR _jiffies
	mov	DWORD PTR [eax+608], ecx

; 113  : // 以下设置任务状态段TSS 所需的数据（参见列表后说明）。
; 114  : 	p->tss.back_link = 0;

	mov	edx, DWORD PTR _p$[ebp]
	mov	DWORD PTR [edx+744], 0

; 115  : 	p->tss.esp0 = PAGE_SIZE + (long) p;	// 堆栈指针（由于是给任务结构p 分配了1 页

	mov	eax, DWORD PTR _p$[ebp]
	add	eax, 4096				; 00001000H
	mov	ecx, DWORD PTR _p$[ebp]
	mov	DWORD PTR [ecx+748], eax

; 116  : // 新内存，所以此时esp0 正好指向该页顶端）。
; 117  : 	p->tss.ss0 = 0x10;		// 堆栈段选择符（内核数据段）[??]。

	mov	edx, DWORD PTR _p$[ebp]
	mov	DWORD PTR [edx+752], 16			; 00000010H

; 118  : 	p->tss.eip = eip;		// 指令代码指针。

	mov	eax, DWORD PTR _p$[ebp]
	mov	ecx, DWORD PTR _eip$[ebp]
	mov	DWORD PTR [eax+776], ecx

; 119  : 	p->tss.eflags = eflags;	// 标志寄存器。

	mov	edx, DWORD PTR _p$[ebp]
	mov	eax, DWORD PTR _eflags$[ebp]
	mov	DWORD PTR [edx+780], eax

; 120  : 	p->tss.eax = 0;

	mov	ecx, DWORD PTR _p$[ebp]
	mov	DWORD PTR [ecx+784], 0

; 121  : 	p->tss.ecx = ecx;

	mov	edx, DWORD PTR _p$[ebp]
	mov	eax, DWORD PTR _ecx$[ebp]
	mov	DWORD PTR [edx+788], eax

; 122  : 	p->tss.edx = edx;

	mov	ecx, DWORD PTR _p$[ebp]
	mov	edx, DWORD PTR _edx$[ebp]
	mov	DWORD PTR [ecx+792], edx

; 123  : 	p->tss.ebx = ebx;

	mov	eax, DWORD PTR _p$[ebp]
	mov	ecx, DWORD PTR _ebx$[ebp]
	mov	DWORD PTR [eax+796], ecx

; 124  : 	p->tss.esp = esp;

	mov	edx, DWORD PTR _p$[ebp]
	mov	eax, DWORD PTR _esp$[ebp]
	mov	DWORD PTR [edx+800], eax

; 125  : 	p->tss.ebp = ebp;

	mov	ecx, DWORD PTR _p$[ebp]
	mov	edx, DWORD PTR _ebp$[ebp]
	mov	DWORD PTR [ecx+804], edx

; 126  : 	p->tss.esi = esi;

	mov	eax, DWORD PTR _p$[ebp]
	mov	ecx, DWORD PTR _esi$[ebp]
	mov	DWORD PTR [eax+808], ecx

; 127  : 	p->tss.edi = edi;

	mov	edx, DWORD PTR _p$[ebp]
	mov	eax, DWORD PTR _edi$[ebp]
	mov	DWORD PTR [edx+812], eax

; 128  : 	p->tss.es = es & 0xffff;	// 段寄存器仅16 位有效。

	mov	ecx, DWORD PTR _es$[ebp]
	and	ecx, 65535				; 0000ffffH
	mov	edx, DWORD PTR _p$[ebp]
	mov	DWORD PTR [edx+816], ecx

; 129  : 	p->tss.cs = cs & 0xffff;

	mov	eax, DWORD PTR _cs$[ebp]
	and	eax, 65535				; 0000ffffH
	mov	ecx, DWORD PTR _p$[ebp]
	mov	DWORD PTR [ecx+820], eax

; 130  : 	p->tss.ss = ss & 0xffff;

	mov	edx, DWORD PTR _ss$[ebp]
	and	edx, 65535				; 0000ffffH
	mov	eax, DWORD PTR _p$[ebp]
	mov	DWORD PTR [eax+824], edx

; 131  : 	p->tss.ds = ds & 0xffff;

	mov	ecx, DWORD PTR _ds$[ebp]
	and	ecx, 65535				; 0000ffffH
	mov	edx, DWORD PTR _p$[ebp]
	mov	DWORD PTR [edx+828], ecx

; 132  : 	p->tss.fs = fs & 0xffff;

	mov	eax, DWORD PTR _fs$[ebp]
	and	eax, 65535				; 0000ffffH
	mov	ecx, DWORD PTR _p$[ebp]
	mov	DWORD PTR [ecx+832], eax

; 133  : 	p->tss.gs = gs & 0xffff;

	mov	edx, DWORD PTR _gs$[ebp]
	and	edx, 65535				; 0000ffffH
	mov	eax, DWORD PTR _p$[ebp]
	mov	DWORD PTR [eax+836], edx

; 134  : 	p->tss.ldt = _LDT (nr);	// 该新任务nr 的局部描述符表选择符（LDT 的描述符在GDT 中）。

	mov	ecx, DWORD PTR _nr$[ebp]
	shl	ecx, 4
	add	ecx, 40					; 00000028H
	mov	edx, DWORD PTR _p$[ebp]
	mov	DWORD PTR [edx+840], ecx

; 135  : 	p->tss.trace_bitmap = 0x80000000;

	mov	eax, DWORD PTR _p$[ebp]
	mov	DWORD PTR [eax+844], -2147483648	; 80000000H

; 136  : // 如果当前任务使用了协处理器，就保存其上下文。
; 137  : 	p_i387 = &p->tss.i387;

	mov	ecx, DWORD PTR _p$[ebp]
	add	ecx, 848				; 00000350H
	mov	DWORD PTR _p_i387$[ebp], ecx

; 138  : 	if (last_task_used_math == current)

	mov	edx, DWORD PTR _last_task_used_math
	cmp	edx, DWORD PTR _current
	jne	SHORT $L691

; 139  : 	_asm{
; 140  : 		mov ebx, p_i387

	mov	ebx, DWORD PTR _p_i387$[ebp]

; 141  : 		clts

	clts

; 142  : 		fnsave [p_i387]

	fnsave	DWORD PTR _p_i387$[ebp]
$L691:

; 143  : 	}
; 144  : //    __asm__ ("clts ; fnsave %0"::"m" (p->tss.i387));
; 145  : // 设置新任务的代码和数据段基址、限长并复制页表。如果出错（返回值不是0），则复位任务数组中
; 146  : // 相应项并释放为该新任务分配的内存页。
; 147  : 	if (copy_mem (nr, p))

	mov	eax, DWORD PTR _p$[ebp]
	push	eax
	mov	ecx, DWORD PTR _nr$[ebp]
	push	ecx
	call	_copy_mem
	add	esp, 8
	test	eax, eax
	je	SHORT $L692

; 149  : 		task[nr] = NULL;

	mov	edx, DWORD PTR _nr$[ebp]
	mov	DWORD PTR _task[edx*4], 0

; 150  : 		free_page ((long) p);

	mov	eax, DWORD PTR _p$[ebp]
	push	eax
	call	_free_page
	add	esp, 4

; 151  : 		return -EAGAIN;

	mov	eax, -11				; fffffff5H
	jmp	$L682
$L692:

; 153  : // 如果父进程中有文件是打开的，则将对应文件的打开次数增1。
; 154  : 	for (i = 0; i < NR_OPEN; i++)

	mov	DWORD PTR _i$[ebp], 0
	jmp	SHORT $L694
$L695:
	mov	ecx, DWORD PTR _i$[ebp]
	add	ecx, 1
	mov	DWORD PTR _i$[ebp], ecx
$L694:
	cmp	DWORD PTR _i$[ebp], 20			; 00000014H
	jge	SHORT $L696

; 155  : 		if (f = p->filp[i])

	mov	edx, DWORD PTR _i$[ebp]
	mov	eax, DWORD PTR _p$[ebp]
	mov	ecx, DWORD PTR [eax+edx*4+640]
	mov	DWORD PTR _f$[ebp], ecx
	cmp	DWORD PTR _f$[ebp], 0
	je	SHORT $L697

; 156  : 			f->f_count++;

	mov	edx, DWORD PTR _f$[ebp]
	mov	ax, WORD PTR [edx+4]
	add	ax, 1
	mov	ecx, DWORD PTR _f$[ebp]
	mov	WORD PTR [ecx+4], ax
$L697:

; 157  : // 将当前进程（父进程）的pwd, root 和executable 引用次数均增1。
; 158  : 	if (current->pwd)

	jmp	SHORT $L695
$L696:
	mov	edx, DWORD PTR _current
	cmp	DWORD PTR [edx+624], 0
	je	SHORT $L698

; 159  : 		current->pwd->i_count++;

	mov	eax, DWORD PTR _current
	mov	ecx, DWORD PTR [eax+624]
	mov	dx, WORD PTR [ecx+48]
	add	dx, 1
	mov	eax, DWORD PTR _current
	mov	ecx, DWORD PTR [eax+624]
	mov	WORD PTR [ecx+48], dx
$L698:

; 160  : 	if (current->root)

	mov	edx, DWORD PTR _current
	cmp	DWORD PTR [edx+628], 0
	je	SHORT $L699

; 161  : 		current->root->i_count++;

	mov	eax, DWORD PTR _current
	mov	ecx, DWORD PTR [eax+628]
	mov	dx, WORD PTR [ecx+48]
	add	dx, 1
	mov	eax, DWORD PTR _current
	mov	ecx, DWORD PTR [eax+628]
	mov	WORD PTR [ecx+48], dx
$L699:

; 162  : 	if (current->executable)

	mov	edx, DWORD PTR _current
	cmp	DWORD PTR [edx+632], 0
	je	SHORT $L700

; 163  : 		current->executable->i_count++;

	mov	eax, DWORD PTR _current
	mov	ecx, DWORD PTR [eax+632]
	mov	dx, WORD PTR [ecx+48]
	add	dx, 1
	mov	eax, DWORD PTR _current
	mov	ecx, DWORD PTR [eax+632]
	mov	WORD PTR [ecx+48], dx
$L700:

; 164  : // 在GDT 中设置新任务的TSS 和LDT 描述符项，数据从task 结构中取。
; 165  : // 在任务切换时，任务寄存器tr 由CPU 自动加载。
; 166  : 	set_tss_desc (gdt + (nr << 1) + FIRST_TSS_ENTRY, &(p->tss));

	mov	edx, DWORD PTR _p$[ebp]
	add	edx, 744				; 000002e8H
	mov	DWORD PTR $T775[ebp], edx
	mov	eax, DWORD PTR _nr$[ebp]
	shl	eax, 1
	lea	ecx, DWORD PTR _gdt[eax*8+32]
	mov	DWORD PTR $T774[ebp], ecx

; 96   : 	if (!p)			// 如果内存分配出错，则返回出错码并退出。

	mov	ebx, DWORD PTR $T774[ebp]

; 97   : 		return -EAGAIN;

	mov	ax, 104					; 00000068H

; 98   : 	task[nr] = p;			// 将新任务结构指针放入任务数组中。

	mov	WORD PTR [ebx], ax

; 99   : // 其中nr 为任务号，由前面find_empty_process()返回。

	mov	eax, DWORD PTR $T775[ebp]

; 100  : 	*p = *current;		/* NOTE! this doesn't copy the supervisor stack */

	mov	WORD PTR [ebx+2], ax

; 101  : /* 注意！这样做不会复制超级用户的堆栈 （只复制当前进程内容）。*/ 

	ror	eax, 16					; 00000010H

; 102  : 	p->state = TASK_UNINTERRUPTIBLE;	// 将新进程的状态先置为不可中断等待状态。

	mov	BYTE PTR [ebx+4], al

; 103  : 	p->pid = last_pid;		// 新进程号。由前面调用find_empty_process()得到。

	mov	al, -119				; ffffff89H

; 104  : 	p->father = current->pid;	// 设置父进程号。

	mov	BYTE PTR [ebx+5], al

; 105  : 	p->counter = p->priority;

	mov	al, 0

; 106  : 	p->signal = 0;		// 信号位图置0。

	mov	BYTE PTR [ebx+6], al

; 107  : 	p->alarm = 0;

	mov	BYTE PTR [ebx+7], ah

; 108  : 	p->leader = 0;		/* process leadership doesn't inherit */

	ror	eax, 16					; 00000010H

; 167  : 	set_ldt_desc (gdt + (nr << 1) + FIRST_LDT_ENTRY, &(p->ldt));

	mov	edx, DWORD PTR _p$[ebp]
	add	edx, 720				; 000002d0H
	mov	DWORD PTR $T780[ebp], edx
	mov	eax, DWORD PTR _nr$[ebp]
	shl	eax, 1
	lea	ecx, DWORD PTR _gdt[eax*8+40]
	mov	DWORD PTR $T779[ebp], ecx

; 96   : 	if (!p)			// 如果内存分配出错，则返回出错码并退出。

	mov	ebx, DWORD PTR $T779[ebp]

; 97   : 		return -EAGAIN;

	mov	ax, 104					; 00000068H

; 98   : 	task[nr] = p;			// 将新任务结构指针放入任务数组中。

	mov	WORD PTR [ebx], ax

; 99   : // 其中nr 为任务号，由前面find_empty_process()返回。

	mov	eax, DWORD PTR $T780[ebp]

; 100  : 	*p = *current;		/* NOTE! this doesn't copy the supervisor stack */

	mov	WORD PTR [ebx+2], ax

; 101  : /* 注意！这样做不会复制超级用户的堆栈 （只复制当前进程内容）。*/ 

	ror	eax, 16					; 00000010H

; 102  : 	p->state = TASK_UNINTERRUPTIBLE;	// 将新进程的状态先置为不可中断等待状态。

	mov	BYTE PTR [ebx+4], al

; 103  : 	p->pid = last_pid;		// 新进程号。由前面调用find_empty_process()得到。

	mov	al, -126				; ffffff82H

; 104  : 	p->father = current->pid;	// 设置父进程号。

	mov	BYTE PTR [ebx+5], al

; 105  : 	p->counter = p->priority;

	mov	al, 0

; 106  : 	p->signal = 0;		// 信号位图置0。

	mov	BYTE PTR [ebx+6], al

; 107  : 	p->alarm = 0;

	mov	BYTE PTR [ebx+7], ah

; 108  : 	p->leader = 0;		/* process leadership doesn't inherit */

	ror	eax, 16					; 00000010H

; 168  : 	p->state = TASK_RUNNING;	/* do this last, just in case */

	mov	edx, DWORD PTR _p$[ebp]
	mov	DWORD PTR [edx], 0

; 169  : /* 最后再将新任务设置成可运行状态，以防万一 */
; 170  : 	return last_pid;		// 返回新进程号（与任务号是不同的）。

	mov	eax, DWORD PTR _last_pid
$L682:

; 171  : }

	pop	edi
	pop	esi
	pop	ebx
	mov	esp, ebp
	pop	ebp
	ret	0
_copy_process ENDP
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
	push	esi
	push	edi

; 86   : 	_asm mov ebx,head

	mov	ebx, DWORD PTR _head$[ebp]

; 87   : 	_asm inc dword ptr [ebx]

	inc	DWORD PTR [ebx]

; 88   : 	_asm and dword ptr [ebx],4095

	and	DWORD PTR [ebx], 4095			; 00000fffH

; 89   : }

	pop	edi
	pop	esi
	pop	ebx
	pop	ebp
	ret	0
__INC_PIPE ENDP
_TEXT	ENDS
PUBLIC	_switch_to
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

	je	SHORT $l1$501

; 278  : 		xchg ecx,current/* current = task[n]； */

	xchg	ecx, DWORD PTR _current

; 279  : 		/*执行长跳转，造成任务切换 (头大了很长时间，多多包涵)*/
; 280  : 		mov ax, __tmp

	mov	ax, WORD PTR ___tmp$[ebp]

; 281  : 		mov word ptr ds:[lcs],ax

	mov	WORD PTR ds:$lcs$502, ax

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
$lcs$502:

; 287  : lcs:	_emit 0		// cs

	DB	0

; 288  : 		_emit 0

	DB	0

; 289  : // 在任务切换回来后才会继续执行下面的语句。
; 290  : 		cmp last_task_used_math,ecx /* 新任务上次使用过协处理器吗？*/

	cmp	DWORD PTR _last_task_used_math, ecx

; 291  : 		jne l1

	jne	SHORT $l1$501

; 292  : 		clts/* 新任务上次使用过协处理器，则清cr0 的TS 标志。*/

	clts
$l1$501:

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
	push	esi
	push	edi

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

; 329  : }

	pop	edi
	pop	esi
	pop	ebx
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
	push	esi
	push	edi

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

; 351  : }

	pop	edi
	pop	esi
	pop	ebx
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
	push	esi
	push	edi

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

; 382  : //		_asm mov __base,eax 
; 383  : 		} 
; 384  : //	return __base; 
; 385  : }

	pop	edi
	pop	esi
	pop	ebx
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
	push	ebx
	push	esi
	push	edi

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

	pop	edi
	pop	esi
	pop	ebx
	pop	ebp
	ret	0
_get_limit ENDP
_TEXT	ENDS
PUBLIC	_find_empty_process
_TEXT	SEGMENT
_i$ = -4
_find_empty_process PROC NEAR

; 175  : {

	push	ebp
	mov	ebp, esp
	push	ecx
$repeat$711:

; 176  : 	int i;
; 177  : 
; 178  : repeat:
; 179  : 	if ((++last_pid) < 0)

	mov	eax, DWORD PTR _last_pid
	add	eax, 1
	mov	DWORD PTR _last_pid, eax
	cmp	DWORD PTR _last_pid, 0
	jge	SHORT $L712

; 180  : 		last_pid = 1;

	mov	DWORD PTR _last_pid, 1
$L712:

; 181  : 	for (i = 0; i < NR_TASKS; i++)

	mov	DWORD PTR _i$[ebp], 0
	jmp	SHORT $L713
$L714:
	mov	ecx, DWORD PTR _i$[ebp]
	add	ecx, 1
	mov	DWORD PTR _i$[ebp], ecx
$L713:
	cmp	DWORD PTR _i$[ebp], 64			; 00000040H
	jge	SHORT $L715

; 182  : 		if (task[i] && task[i]->pid == last_pid)

	mov	edx, DWORD PTR _i$[ebp]
	cmp	DWORD PTR _task[edx*4], 0
	je	SHORT $L716
	mov	eax, DWORD PTR _i$[ebp]
	mov	ecx, DWORD PTR _task[eax*4]
	mov	edx, DWORD PTR [ecx+556]
	cmp	edx, DWORD PTR _last_pid
	jne	SHORT $L716

; 183  : 			goto repeat;

	jmp	SHORT $repeat$711
$L716:

; 184  : 	for (i = 1; i < NR_TASKS; i++)	// 任务0 排除在外。

	jmp	SHORT $L714
$L715:
	mov	DWORD PTR _i$[ebp], 1
	jmp	SHORT $L717
$L718:
	mov	eax, DWORD PTR _i$[ebp]
	add	eax, 1
	mov	DWORD PTR _i$[ebp], eax
$L717:
	cmp	DWORD PTR _i$[ebp], 64			; 00000040H
	jge	SHORT $L719

; 185  : 		if (!task[i])

	mov	ecx, DWORD PTR _i$[ebp]
	cmp	DWORD PTR _task[ecx*4], 0
	jne	SHORT $L720

; 186  : 			return i;

	mov	eax, DWORD PTR _i$[ebp]
	jmp	SHORT $L709
$L720:

; 187  : 	return -EAGAIN;

	jmp	SHORT $L718
$L719:
	mov	eax, -11				; fffffff5H
$L709:

; 188  : }

	mov	esp, ebp
	pop	ebp
	ret	0
_find_empty_process ENDP
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
	push	esi
	push	edi

; 8    : //  unsigned register char _v;
; 9    : 
; 10   : // __asm__ ("movb %%fs:%1,%0": "=r" (_v):"m" (*addr));
; 11   :   _asm mov ebx,addr

	mov	ebx, DWORD PTR _addr$[ebp]

; 12   :   _asm mov al,byte ptr fs:[ebx];

	mov	al, BYTE PTR fs:[ebx]

; 13   : //  _asm mov _v,al;
; 14   : //  return _v;
; 15   : }

	pop	edi
	pop	esi
	pop	ebx
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
	push	esi
	push	edi

; 24   : //  unsigned short _v;
; 25   : 
; 26   : //__asm__ ("movw %%fs:%1,%0": "=r" (_v):"m" (*addr));
; 27   :   _asm mov ebx,addr

	mov	ebx, DWORD PTR _addr$[ebp]

; 28   :   _asm mov ax,word ptr fs:[ebx];

	mov	ax, WORD PTR fs:[ebx]

; 29   : //  _asm mov _v,ax;
; 30   : //  return _v;
; 31   : }

	pop	edi
	pop	esi
	pop	ebx
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
	push	esi
	push	edi

; 40   : //  unsigned long _v;
; 41   : 
; 42   : //__asm__ ("movl %%fs:%1,%0": "=r" (_v):"m" (*addr));
; 43   :   _asm mov ebx,addr

	mov	ebx, DWORD PTR _addr$[ebp]

; 44   :   _asm mov eax,dword ptr fs:[ebx];

	mov	eax, DWORD PTR fs:[ebx]

; 45   : //  _asm mov _v,eax;
; 46   : //  return _v;
; 47   : }

	pop	edi
	pop	esi
	pop	ebx
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
	push	esi
	push	edi

; 55   : //  __asm__ ("movb %0,%%fs:%1"::"r" (val), "m" (*addr));
; 56   : 	_asm mov ebx,addr

	mov	ebx, DWORD PTR _addr$[ebp]

; 57   : 	_asm mov al,val;

	mov	al, BYTE PTR _val$[ebp]

; 58   : 	_asm mov byte ptr fs:[ebx],al;

	mov	BYTE PTR fs:[ebx], al

; 59   : }

	pop	edi
	pop	esi
	pop	ebx
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
	push	esi
	push	edi

; 67   : //  __asm__ ("movw %0,%%fs:%1"::"r" (val), "m" (*addr));
; 68   : 	_asm mov ebx,addr

	mov	ebx, DWORD PTR _addr$[ebp]

; 69   : 	_asm mov ax,val;

	mov	ax, WORD PTR _val$[ebp]

; 70   : 	_asm mov word ptr fs:[ebx],ax;

	mov	WORD PTR fs:[ebx], ax

; 71   : }

	pop	edi
	pop	esi
	pop	ebx
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
	push	esi
	push	edi

; 79   : //  __asm__ ("movl %0,%%fs:%1"::"r" (val), "m" (*addr));
; 80   : 	_asm mov ebx,addr

	mov	ebx, DWORD PTR _addr$[ebp]

; 81   : 	_asm mov eax,val;

	mov	eax, DWORD PTR _val$[ebp]

; 82   : 	_asm mov dword ptr fs:[ebx],eax;

	mov	DWORD PTR fs:[ebx], eax

; 83   : }

	pop	edi
	pop	esi
	pop	ebx
	pop	ebp
	ret	0
_put_fs_long ENDP
_TEXT	ENDS
PUBLIC	_get_fs
;	COMDAT _get_fs
_TEXT	SEGMENT
_get_fs	PROC NEAR					; COMDAT

; 96   : {

	push	ebp
	mov	ebp, esp
	push	ebx
	push	esi
	push	edi

; 97   : //  unsigned short _v;
; 98   : //__asm__ ("mov %%fs,%%ax": "=a" (_v):);
; 99   :   _asm mov ax,fs;

	mov	ax, fs

; 100  : //  _asm mov _v,ax;
; 101  : //  return _v;
; 102  : }

	pop	edi
	pop	esi
	pop	ebx
	pop	ebp
	ret	0
_get_fs	ENDP
_TEXT	ENDS
PUBLIC	_get_ds
;	COMDAT _get_ds
_TEXT	SEGMENT
_get_ds	PROC NEAR					; COMDAT

; 108  : {

	push	ebp
	mov	ebp, esp
	push	ebx
	push	esi
	push	edi

; 109  : //  unsigned short _v;
; 110  : //__asm__ ("mov %%ds,%%ax": "=a" (_v):);
; 111  :   _asm mov ax,fs;

	mov	ax, fs

; 112  : //  _asm mov _v,ax;
; 113  : //  return _v;
; 114  : }

	pop	edi
	pop	esi
	pop	ebx
	pop	ebp
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
	push	ebx
	push	esi
	push	edi

; 121  : //  __asm__ ("mov %0,%%fs"::"a" ((unsigned short) val));
; 122  : 	_asm mov eax,val;

	mov	eax, DWORD PTR _val$[ebp]

; 123  : 	_asm mov fs,ax;

	mov	fs, ax

; 124  : }

	pop	edi
	pop	esi
	pop	ebx
	pop	ebp
	ret	0
_set_fs	ENDP
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
	push	esi
	push	edi

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

; 125  : }

	pop	edi
	pop	esi
	pop	ebx
	pop	ebp
	ret	0
__set_tssldt_desc ENDP
_TEXT	ENDS
END
