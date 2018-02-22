	TITLE	..\kernel\printk.c
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
FLAT	GROUP _DATA, CONST, _BSS
	ASSUME	CS: FLAT, DS: FLAT, SS: FLAT
endif
PUBLIC	_printk
EXTRN	_tty_write:NEAR
EXTRN	_vsprintf:NEAR
_BSS	SEGMENT
_buf	DB	0400H DUP (?)
_BSS	ENDS
_TEXT	SEGMENT
_fmt$ = 8
_i$ = -4
_printk	PROC NEAR

; 31   : {

	push	ebp
	mov	ebp, esp
	push	ecx

; 32   : 	va_list args;			// va_list 实际上是一个字符指针类型。
; 33   : 	int i;
; 34   : 
; 35   : 	va_start (args, fmt);		// 参数处理开始函数。在（include/stdarg.h,13）
; 36   : 	i = vsprintf (buf, fmt, args);	// 使用格式串fmt 将参数列表args 输出到buf 中。

	mov	ecx, DWORD PTR _fmt$[ebp]
	lea	eax, DWORD PTR _fmt$[ebp+4]
	push	eax
	push	ecx
	push	OFFSET FLAT:_buf
	call	_vsprintf
	add	esp, 12					; 0000000cH
	mov	DWORD PTR _i$[ebp], eax

; 37   : // 返回值i 等于输出字符串的长度。
; 38   : 	va_end (args);		// 参数处理结束函数。
; 39   : 	_asm{
; 40   : 		push fs	// 保存fs。

	push	fs

; 41   : 		push ds

	push	ds

; 42   : 		pop fs	// 令fs = ds。

	pop	fs

; 43   : 		push i	// 将字符串长度压入堆栈(这三个入栈是调用参数)。

	push	DWORD PTR _i$[ebp]

; 44   : 		push offset buf	// 将buf 的地址压入堆栈。

	push	OFFSET FLAT:_buf

; 45   : 		push 0	// 将数值0 压入堆栈。是通道号channel。

	push	0

; 46   : 		call tty_write	// 调用tty_write 函数。(kernel/chr_drv/tty_io.c,290)。

	call	_tty_write

; 47   : 		add esp,8	// 跳过（丢弃）两个入栈参数(buf,channel)。

	add	esp, 8

; 48   : 		pop i	// 弹出字符串长度值，作为返回值。

	pop	DWORD PTR _i$[ebp]

; 49   : 		pop fs		// 恢复原fs 寄存器。

	pop	fs

; 50   : 	}
; 51   :  /* __asm__ ("push %%fs\n\t"
; 52   : 	   "push %%ds\n\t" "pop %%fs\n\t"
; 53   : 	   "pushl %0\n\t"
; 54   : 	   "pushl $_buf\n\t"
; 55   : 	   "pushl $0\n\t"
; 56   : 	   "call _tty_write\n\t"
; 57   : 	   "addl $8,%%esp\n\t"
; 58   : 	   "popl %0\n\t"
; 59   : 	   "pop %%fs"
; 60   : ::"r" (i):"ax", "cx", "dx");	// 通知编译器，寄存器ax,cx,dx 值可能已经改变。*/
; 61   : 	return i;			// 返回字符串长度。

	mov	eax, DWORD PTR _i$[ebp]

; 62   : }

	mov	esp, ebp
	pop	ebp
	ret	0
_printk	ENDP
_TEXT	ENDS
END
