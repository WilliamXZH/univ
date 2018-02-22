	TITLE	..\kernel\traps.c
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
;	COMDAT __str
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
;	COMDAT __outb
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT __outb_p
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT __inb_p
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT _get_seg_byte
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT _get_seg_long
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT __fs
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
$l1$42:

; 39   : 	l1:	lodsb	// 加载DS:[esi]处1 字节->al，并更新esi。

	lodsb

; 40   : 		stosb		// 存储字节al->ES:[edi]，并更新edi。

	stosb

; 41   : 		test al,al	// 刚存储的字节是0？

	test	al, al

; 42   : 		jne l1	// 不是则跳转到标号l1 处，否则结束。

	jne	SHORT $l1$42

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
PUBLIC	_do_double_fault
_DATA	SEGMENT
$SG903	DB	'double fault', 00H
_DATA	ENDS
_TEXT	SEGMENT
_esp$ = 8
_error_code$ = 12
_do_double_fault PROC NEAR

; 139  : {

	push	ebp
	mov	ebp, esp

; 140  : 	die("double fault",esp,error_code);

	mov	eax, DWORD PTR _error_code$[ebp]
	mov	ecx, DWORD PTR _esp$[ebp]
	push	eax
	push	ecx
	push	OFFSET FLAT:$SG903
	call	_die
	add	esp, 12					; 0000000cH

; 141  : }

	pop	ebp
	ret	0
_do_double_fault ENDP
_TEXT	ENDS
EXTRN	_current:DWORD
EXTRN	_printk:NEAR
EXTRN	_do_exit:NEAR
_DATA	SEGMENT
	ORG $+3
$SG876	DB	'%s: %04x', 0aH, 0dH, 00H
	ORG $+1
$SG877	DB	'EIP:', 09H, '%04x:%p', 0aH, 'EFLAGS:', 09H, '%p', 0aH, 'E'
	DB	'SP:', 09H, '%04x:%p', 0aH, 00H
	ORG $+2
$SG878	DB	'fs: %04x', 0aH, 00H
	ORG $+2
$SG880	DB	'base: %p, limit: %p', 0aH, 00H
	ORG $+3
$SG882	DB	'Stack: ', 00H
$SG887	DB	'%p ', 00H
$SG888	DB	0aH, 00H
	ORG $+2
$SG890	DB	'Pid: %d, process nr: %d', 0aH, 0dH, 00H
	ORG $+2
$SG895	DB	'%02x ', 00H
	ORG $+2
$SG896	DB	0aH, 0dH, 00H
_DATA	ENDS
_TEXT	SEGMENT
___res$1133 = 8
$T1138 = 8
$T1143 = 8
___res$1148 = -4
$T1149 = 12
$T1150 = 8
$T1155 = 8
___res$1159 = -4
$T1160 = 12
$T1161 = 8
_str$ = 8
_esp_ptr$ = 12
_nr$ = 16
_i$ = 16
_die	PROC NEAR

; 114  : {

	push	ebp
	mov	ebp, esp
	push	ecx

; 118  : 	printk("%s: %04x\n\r",str,nr&0xffff);

	mov	eax, DWORD PTR _nr$[ebp]
	mov	ecx, DWORD PTR _str$[ebp]
	push	ebx
	and	eax, 65535				; 0000ffffH
	push	esi
	push	eax
	push	ecx
	push	OFFSET FLAT:$SG876
	call	_printk

; 120  : 		esp[1],esp[0],esp[2],esp[4],esp[3]);

	mov	esi, DWORD PTR _esp_ptr$[ebp]
	mov	edx, DWORD PTR [esi+12]
	mov	eax, DWORD PTR [esi+16]
	mov	ecx, DWORD PTR [esi+8]
	push	edx
	mov	edx, DWORD PTR [esi]
	push	eax
	mov	eax, DWORD PTR [esi+4]
	push	ecx
	push	edx
	push	eax
	push	OFFSET FLAT:$SG877
	call	_printk

; 116  : 	int i;

	mov	ax, fs

; 117  : 

	mov	WORD PTR ___res$1133[ebp], ax

; 121  : 	printk("fs: %04x\n",_fs());

	mov	ecx, DWORD PTR ___res$1133[ebp]
	and	ecx, 65535				; 0000ffffH
	push	ecx
	push	OFFSET FLAT:$SG878
	call	_printk

; 122  : 	printk("base: %p, limit: %p\n",get_base(current->ldt[1]),get_limit(0x17));

	mov	DWORD PTR $T1138[ebp], 23		; 00000017H

; 117  : 

	mov	eax, DWORD PTR $T1138[ebp]

; 118  : 	printk("%s: %04x\n\r",str,nr&0xffff);

	lsl	eax, eax

; 122  : 	printk("base: %p, limit: %p\n",get_base(current->ldt[1]),get_limit(0x17));

	mov	edx, DWORD PTR _current
	mov	ecx, eax
	add	edx, 728				; 000002d8H
	mov	DWORD PTR $T1143[ebp], edx

; 117  : 

	mov	ebx, DWORD PTR $T1143[ebp]

; 118  : 	printk("%s: %04x\n\r",str,nr&0xffff);

	mov	ah, BYTE PTR [ebx+7]

; 119  : 	printk("EIP:\t%04x:%p\nEFLAGS:\t%p\nESP:\t%04x:%p\n",

	mov	al, BYTE PTR [ebx+4]

; 120  : 		esp[1],esp[0],esp[2],esp[4],esp[3]);

	shl	eax, 16					; 00000010H

; 121  : 	printk("fs: %04x\n",_fs());

	mov	ax, WORD PTR [ebx+2]

; 122  : 	printk("base: %p, limit: %p\n",get_base(current->ldt[1]),get_limit(0x17));

	push	ecx
	push	eax
	push	OFFSET FLAT:$SG880
	call	_printk

; 123  : 	if (esp[4] == 0x17) {

	mov	eax, DWORD PTR [esi+16]
	add	esp, 56					; 00000038H
	cmp	eax, 23					; 00000017H
	jne	SHORT $L881

; 124  : 		printk("Stack: ");

	push	OFFSET FLAT:$SG882
	call	_printk
	add	esp, 4

; 125  : 		for (i=0;i<4;i++)

	xor	eax, eax
	mov	DWORD PTR _i$[ebp], eax

; 126  : 			printk("%p ",get_seg_long(0x17,i+(long *)esp[3]));

	mov	DWORD PTR $T1149[ebp], 23		; 00000017H
$L883:
	mov	ecx, DWORD PTR [esi+12]
	lea	edx, DWORD PTR [ecx+eax*4]
	mov	DWORD PTR $T1150[ebp], edx

; 117  : 

	push	fs

; 118  : 	printk("%s: %04x\n\r",str,nr&0xffff);

	mov	ax, WORD PTR $T1149[ebp]

; 119  : 	printk("EIP:\t%04x:%p\nEFLAGS:\t%p\nESP:\t%04x:%p\n",

	mov	fs, ax

; 120  : 		esp[1],esp[0],esp[2],esp[4],esp[3]);

	mov	ebx, DWORD PTR $T1150[ebp]

; 121  : 	printk("fs: %04x\n",_fs());

	mov	eax, DWORD PTR fs:[ebx]

; 122  : 	printk("base: %p, limit: %p\n",get_base(current->ldt[1]),get_limit(0x17));

	mov	DWORD PTR ___res$1148[ebp], eax

; 123  : 	if (esp[4] == 0x17) {

	pop	fs

; 126  : 			printk("%p ",get_seg_long(0x17,i+(long *)esp[3]));

	mov	eax, DWORD PTR ___res$1148[ebp]
	push	eax
	push	OFFSET FLAT:$SG887
	call	_printk
	mov	eax, DWORD PTR _i$[ebp]
	add	esp, 8
	inc	eax
	cmp	eax, 4
	mov	DWORD PTR _i$[ebp], eax
	jl	SHORT $L883

; 127  : 		printk("\n");

	push	OFFSET FLAT:$SG888
	call	_printk
	add	esp, 4
$L881:

; 128  : 	}
; 129  : 	str(i);

	lea	ecx, DWORD PTR _i$[ebp]
	mov	DWORD PTR $T1155[ebp], ecx

; 115  : 	long * esp = (long *) esp_ptr;

	xor	eax, eax

; 116  : 	int i;

	str	ax

; 117  : 

	sub	eax, 32					; 00000020H

; 118  : 	printk("%s: %04x\n\r",str,nr&0xffff);

	shr	eax, 4

; 119  : 	printk("EIP:\t%04x:%p\nEFLAGS:\t%p\nESP:\t%04x:%p\n",

	mov	ebx, DWORD PTR $T1155[ebp]

; 120  : 		esp[1],esp[0],esp[2],esp[4],esp[3]);

	mov	DWORD PTR [ebx], eax

; 130  : 	printk("Pid: %d, process nr: %d\n\r",current->pid,0xffff & i);

	mov	edx, DWORD PTR _i$[ebp]
	mov	eax, DWORD PTR _current
	and	edx, 65535				; 0000ffffH
	mov	ecx, DWORD PTR [eax+556]
	push	edx
	push	ecx
	push	OFFSET FLAT:$SG890
	call	_printk
	add	esp, 12					; 0000000cH

; 131  : 	for(i=0;i<10;i++)

	xor	eax, eax
	mov	DWORD PTR _i$[ebp], eax
$L891:

; 132  : 		printk("%02x ",0xff & get_seg_byte(esp[1],(i+(char *)esp[0])));

	mov	edx, DWORD PTR [esi]
	add	edx, eax
	mov	ax, WORD PTR [esi+4]
	mov	DWORD PTR $T1161[ebp], edx
	mov	DWORD PTR $T1160[ebp], eax

; 117  : 

	push	fs

; 118  : 	printk("%s: %04x\n\r",str,nr&0xffff);

	mov	ax, WORD PTR $T1160[ebp]

; 119  : 	printk("EIP:\t%04x:%p\nEFLAGS:\t%p\nESP:\t%04x:%p\n",

	mov	fs, ax

; 120  : 		esp[1],esp[0],esp[2],esp[4],esp[3]);

	mov	ebx, DWORD PTR $T1161[ebp]

; 121  : 	printk("fs: %04x\n",_fs());

	mov	al, BYTE PTR fs:[ebx]

; 122  : 	printk("base: %p, limit: %p\n",get_base(current->ldt[1]),get_limit(0x17));

	mov	BYTE PTR ___res$1159[ebp], al

; 123  : 	if (esp[4] == 0x17) {

	pop	fs

; 132  : 		printk("%02x ",0xff & get_seg_byte(esp[1],(i+(char *)esp[0])));

	mov	ecx, DWORD PTR ___res$1159[ebp]
	and	ecx, 255				; 000000ffH
	push	ecx
	push	OFFSET FLAT:$SG895
	call	_printk
	mov	eax, DWORD PTR _i$[ebp]
	add	esp, 8
	inc	eax
	cmp	eax, 10					; 0000000aH
	mov	DWORD PTR _i$[ebp], eax
	jl	SHORT $L891

; 133  : 	printk("\n\r");

	push	OFFSET FLAT:$SG896
	call	_printk

; 134  : 	do_exit(11);		/* play segment exception */

	push	11					; 0000000bH
	call	_do_exit
	add	esp, 8

; 135  : }

	pop	esi
	pop	ebx
	mov	esp, ebp
	pop	ebp
	ret	0
_die	ENDP
_TEXT	ENDS
PUBLIC	_do_general_protection
_DATA	SEGMENT
	ORG $+1
$SG910	DB	'general protection', 00H
_DATA	ENDS
_TEXT	SEGMENT
_esp$ = 8
_error_code$ = 12
_do_general_protection PROC NEAR

; 144  : {

	push	ebp
	mov	ebp, esp

; 145  : 	die("general protection",esp,error_code);

	mov	eax, DWORD PTR _error_code$[ebp]
	mov	ecx, DWORD PTR _esp$[ebp]
	push	eax
	push	ecx
	push	OFFSET FLAT:$SG910
	call	_die
	add	esp, 12					; 0000000cH

; 146  : }

	pop	ebp
	ret	0
_do_general_protection ENDP
_TEXT	ENDS
PUBLIC	_do_divide_error
_DATA	SEGMENT
	ORG $+1
$SG917	DB	'divide error', 00H
_DATA	ENDS
_TEXT	SEGMENT
_esp$ = 8
_error_code$ = 12
_do_divide_error PROC NEAR

; 149  : {

	push	ebp
	mov	ebp, esp

; 150  : 	die("divide error",esp,error_code);

	mov	eax, DWORD PTR _error_code$[ebp]
	mov	ecx, DWORD PTR _esp$[ebp]
	push	eax
	push	ecx
	push	OFFSET FLAT:$SG917
	call	_die
	add	esp, 12					; 0000000cH

; 151  : }

	pop	ebp
	ret	0
_do_divide_error ENDP
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
$l1$59:

; 115  : 	l1: lodsb	// 取源字符串字节ds:[esi]->al，并esi++。

	lodsb

; 116  : 		stosb		// 将该字节存到es:[edi]，并edi++。

	stosb

; 117  : 		test al,al	// 该字节是0？

	test	al, al

; 118  : 		jne l1	// 不是，则向后跳转到标号1 处继续拷贝，否则结束。

	jne	SHORT $l1$59

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
PUBLIC	_do_int3
_DATA	SEGMENT
	ORG $+3
$SG945	DB	'eax', 09H, 09H, 'ebx', 09H, 09H, 'ecx', 09H, 09H, 'edx', 0aH
	DB	0dH, '%8x', 09H, '%8x', 09H, '%8x', 09H, '%8x', 0aH, 0dH, 00H
	ORG $+2
$SG947	DB	'esi', 09H, 09H, 'edi', 09H, 09H, 'ebp', 09H, 09H, 'esp', 0aH
	DB	0dH, '%8x', 09H, '%8x', 09H, '%8x', 09H, '%8x', 0aH, 0dH, 00H
	ORG $+2
$SG948	DB	0aH, 0dH, 'ds', 09H, 'es', 09H, 'fs', 09H, 'tr', 0aH, 0dH
	DB	'%4x', 09H, '%4x', 09H, '%4x', 09H, '%4x', 0aH, 0dH, 00H
	ORG $+3
$SG949	DB	'EIP: %8x   CS: %4x  EFLAGS: %8x', 0aH, 0dH, 00H
_DATA	ENDS
_TEXT	SEGMENT
_esp$ = 8
_fs$ = 16
_es$ = 20
_ds$ = 24
_ebp$ = 28
_esi$ = 32
_edi$ = 36
_edx$ = 40
_ecx$ = 44
_ebx$ = 48
_eax$ = 52
_tr$ = -4
_do_int3 PROC NEAR

; 157  : {

	push	ebp
	mov	ebp, esp
	push	ecx
	push	esi

; 158  : 	int tr;
; 159  : 
; 160  : //	__asm__("str %%ax":"=a" (tr):"0" (0));
; 161  : 	_asm xor eax,eax

	xor	eax, eax

; 162  : 	_asm str ax

	str	ax

; 163  : 	_asm mov tr,eax

	mov	DWORD PTR _tr$[ebp], eax

; 164  : 	printk("eax\t\tebx\t\tecx\t\tedx\n\r%8x\t%8x\t%8x\t%8x\n\r",
; 165  : 		eax,ebx,ecx,edx);

	mov	eax, DWORD PTR _edx$[ebp]
	mov	ecx, DWORD PTR _ecx$[ebp]
	mov	edx, DWORD PTR _ebx$[ebp]
	push	eax
	mov	eax, DWORD PTR _eax$[ebp]
	push	ecx
	push	edx
	push	eax
	push	OFFSET FLAT:$SG945
	call	_printk

; 166  : 	printk("esi\t\tedi\t\tebp\t\tesp\n\r%8x\t%8x\t%8x\t%8x\n\r",
; 167  : 		esi,edi,ebp,(long) esp);

	mov	esi, DWORD PTR _esp$[ebp]
	mov	ecx, DWORD PTR _ebp$[ebp]
	mov	edx, DWORD PTR _edi$[ebp]
	mov	eax, DWORD PTR _esi$[ebp]
	push	esi
	push	ecx
	push	edx
	push	eax
	push	OFFSET FLAT:$SG947
	call	_printk

; 168  : 	printk("\n\rds\tes\tfs\ttr\n\r%4x\t%4x\t%4x\t%4x\n\r",
; 169  : 		ds,es,fs,tr);

	mov	ecx, DWORD PTR _tr$[ebp]
	mov	edx, DWORD PTR _fs$[ebp]
	mov	eax, DWORD PTR _es$[ebp]
	push	ecx
	mov	ecx, DWORD PTR _ds$[ebp]
	push	edx
	push	eax
	push	ecx
	push	OFFSET FLAT:$SG948
	call	_printk

; 170  : 	printk("EIP: %8x   CS: %4x  EFLAGS: %8x\n\r",esp[0],esp[1],esp[2]);

	mov	edx, DWORD PTR [esi+8]
	mov	eax, DWORD PTR [esi+4]
	mov	ecx, DWORD PTR [esi]
	push	edx
	push	eax
	push	ecx
	push	OFFSET FLAT:$SG949
	call	_printk
	add	esp, 76					; 0000004cH
	pop	esi

; 171  : }

	mov	esp, ebp
	pop	ebp
	ret	0
_do_int3 ENDP
_TEXT	ENDS
PUBLIC	_do_nmi
_DATA	SEGMENT
	ORG $+2
$SG956	DB	'nmi', 00H
_DATA	ENDS
_TEXT	SEGMENT
_esp$ = 8
_error_code$ = 12
_do_nmi	PROC NEAR

; 174  : {

	push	ebp
	mov	ebp, esp

; 175  : 	die("nmi",esp,error_code);

	mov	eax, DWORD PTR _error_code$[ebp]
	mov	ecx, DWORD PTR _esp$[ebp]
	push	eax
	push	ecx
	push	OFFSET FLAT:$SG956
	call	_die
	add	esp, 12					; 0000000cH

; 176  : }

	pop	ebp
	ret	0
_do_nmi	ENDP
_TEXT	ENDS
PUBLIC	_do_debug
_DATA	SEGMENT
$SG963	DB	'debug', 00H
_DATA	ENDS
_TEXT	SEGMENT
_esp$ = 8
_error_code$ = 12
_do_debug PROC NEAR

; 179  : {

	push	ebp
	mov	ebp, esp

; 180  : 	die("debug",esp,error_code);

	mov	eax, DWORD PTR _error_code$[ebp]
	mov	ecx, DWORD PTR _esp$[ebp]
	push	eax
	push	ecx
	push	OFFSET FLAT:$SG963
	call	_die
	add	esp, 12					; 0000000cH

; 181  : }

	pop	ebp
	ret	0
_do_debug ENDP
_TEXT	ENDS
PUBLIC	_do_overflow
_DATA	SEGMENT
	ORG $+2
$SG970	DB	'overflow', 00H
_DATA	ENDS
_TEXT	SEGMENT
_esp$ = 8
_error_code$ = 12
_do_overflow PROC NEAR

; 184  : {

	push	ebp
	mov	ebp, esp

; 185  : 	die("overflow",esp,error_code);

	mov	eax, DWORD PTR _error_code$[ebp]
	mov	ecx, DWORD PTR _esp$[ebp]
	push	eax
	push	ecx
	push	OFFSET FLAT:$SG970
	call	_die
	add	esp, 12					; 0000000cH

; 186  : }

	pop	ebp
	ret	0
_do_overflow ENDP
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
$l1$76:

; 201  :   l1: lodsb	// 取字符串2 的字节ds:[esi]??al，并且esi++。

	lodsb

; 202  : 	  scasb		// al 与字符串1 的字节es:[edi]作比较，并且edi++。

	scasb

; 203  : 	  jne l2		// 如果不相等，则向前跳转到标号2。

	jne	SHORT $l2$77

; 204  : 	  test al,al	// 该字节是0 值字节吗（字符串结尾）？

	test	al, al

; 205  : 	  jne l1		// 不是，则向后跳转到标号1，继续比较。

	jne	SHORT $l1$76

; 206  : 	  xor eax,eax	// 是，则返回值eax 清零，

	xor	eax, eax

; 207  : 	  jmp l3		// 向前跳转到标号3，结束。

	jmp	SHORT $l3$78
$l2$77:

; 208  :   l2: mov eax,1	// eax 中置1。

	mov	eax, 1

; 209  : 	  jl l3		// 若前面比较中串2 字符<串1 字符，则返回正值，结束。

	jl	SHORT $l3$78

; 210  : 	  neg eax	// 否则eax = -eax，返回负值，结束。

	neg	eax
$l3$78:

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
PUBLIC	_do_bounds
_DATA	SEGMENT
	ORG $+3
$SG977	DB	'bounds', 00H
_DATA	ENDS
_TEXT	SEGMENT
_esp$ = 8
_error_code$ = 12
_do_bounds PROC NEAR

; 189  : {

	push	ebp
	mov	ebp, esp

; 190  : 	die("bounds",esp,error_code);

	mov	eax, DWORD PTR _error_code$[ebp]
	mov	ecx, DWORD PTR _esp$[ebp]
	push	eax
	push	ecx
	push	OFFSET FLAT:$SG977
	call	_die
	add	esp, 12					; 0000000cH

; 191  : }

	pop	ebp
	ret	0
_do_bounds ENDP
_TEXT	ENDS
PUBLIC	_do_invalid_op
_DATA	SEGMENT
	ORG $+1
$SG984	DB	'invalid operand', 00H
_DATA	ENDS
_TEXT	SEGMENT
_esp$ = 8
_error_code$ = 12
_do_invalid_op PROC NEAR

; 194  : {

	push	ebp
	mov	ebp, esp

; 195  : 	die("invalid operand",esp,error_code);

	mov	eax, DWORD PTR _error_code$[ebp]
	mov	ecx, DWORD PTR _esp$[ebp]
	push	eax
	push	ecx
	push	OFFSET FLAT:$SG984
	call	_die
	add	esp, 12					; 0000000cH

; 196  : }

	pop	ebp
	ret	0
_do_invalid_op ENDP
_TEXT	ENDS
PUBLIC	_do_device_not_available
_DATA	SEGMENT
$SG991	DB	'device not available', 00H
_DATA	ENDS
_TEXT	SEGMENT
_esp$ = 8
_error_code$ = 12
_do_device_not_available PROC NEAR

; 199  : {

	push	ebp
	mov	ebp, esp

; 200  : 	die("device not available",esp,error_code);

	mov	eax, DWORD PTR _error_code$[ebp]
	mov	ecx, DWORD PTR _esp$[ebp]
	push	eax
	push	ecx
	push	OFFSET FLAT:$SG991
	call	_die
	add	esp, 12					; 0000000cH

; 201  : }

	pop	ebp
	ret	0
_do_device_not_available ENDP
_TEXT	ENDS
PUBLIC	_do_coprocessor_segment_overrun
_DATA	SEGMENT
	ORG $+3
$SG998	DB	'coprocessor segment overrun', 00H
_DATA	ENDS
_TEXT	SEGMENT
_esp$ = 8
_error_code$ = 12
_do_coprocessor_segment_overrun PROC NEAR

; 204  : {

	push	ebp
	mov	ebp, esp

; 205  : 	die("coprocessor segment overrun",esp,error_code);

	mov	eax, DWORD PTR _error_code$[ebp]
	mov	ecx, DWORD PTR _esp$[ebp]
	push	eax
	push	ecx
	push	OFFSET FLAT:$SG998
	call	_die
	add	esp, 12					; 0000000cH

; 206  : }

	pop	ebp
	ret	0
_do_coprocessor_segment_overrun ENDP
_TEXT	ENDS
PUBLIC	_do_invalid_TSS
_DATA	SEGMENT
$SG1005	DB	'invalid TSS', 00H
_DATA	ENDS
_TEXT	SEGMENT
_esp$ = 8
_error_code$ = 12
_do_invalid_TSS PROC NEAR

; 209  : {

	push	ebp
	mov	ebp, esp

; 210  : 	die("invalid TSS",esp,error_code);

	mov	eax, DWORD PTR _error_code$[ebp]
	mov	ecx, DWORD PTR _esp$[ebp]
	push	eax
	push	ecx
	push	OFFSET FLAT:$SG1005
	call	_die
	add	esp, 12					; 0000000cH

; 211  : }

	pop	ebp
	ret	0
_do_invalid_TSS ENDP
_TEXT	ENDS
PUBLIC	_do_segment_not_present
_DATA	SEGMENT
$SG1012	DB	'segment not present', 00H
_DATA	ENDS
_TEXT	SEGMENT
_esp$ = 8
_error_code$ = 12
_do_segment_not_present PROC NEAR

; 214  : {

	push	ebp
	mov	ebp, esp

; 215  : 	die("segment not present",esp,error_code);

	mov	eax, DWORD PTR _error_code$[ebp]
	mov	ecx, DWORD PTR _esp$[ebp]
	push	eax
	push	ecx
	push	OFFSET FLAT:$SG1012
	call	_die
	add	esp, 12					; 0000000cH

; 216  : }

	pop	ebp
	ret	0
_do_segment_not_present ENDP
_TEXT	ENDS
PUBLIC	_do_stack_segment
_DATA	SEGMENT
$SG1019	DB	'stack segment', 00H
_DATA	ENDS
_TEXT	SEGMENT
_esp$ = 8
_error_code$ = 12
_do_stack_segment PROC NEAR

; 219  : {

	push	ebp
	mov	ebp, esp

; 220  : 	die("stack segment",esp,error_code);

	mov	eax, DWORD PTR _error_code$[ebp]
	mov	ecx, DWORD PTR _esp$[ebp]
	push	eax
	push	ecx
	push	OFFSET FLAT:$SG1019
	call	_die
	add	esp, 12					; 0000000cH

; 221  : }

	pop	ebp
	ret	0
_do_stack_segment ENDP
_TEXT	ENDS
PUBLIC	_do_coprocessor_error
EXTRN	_last_task_used_math:DWORD
_DATA	SEGMENT
	ORG $+2
$SG1027	DB	'coprocessor error', 00H
_DATA	ENDS
_TEXT	SEGMENT
_esp$ = 8
_error_code$ = 12
_do_coprocessor_error PROC NEAR

; 224  : {

	push	ebp
	mov	ebp, esp

; 225  : 	if (last_task_used_math != current)

	mov	eax, DWORD PTR _last_task_used_math
	mov	ecx, DWORD PTR _current
	cmp	eax, ecx
	jne	SHORT $L1025

; 226  : 		return;
; 227  : 	die("coprocessor error",esp,error_code);

	mov	ecx, DWORD PTR _error_code$[ebp]
	mov	edx, DWORD PTR _esp$[ebp]
	push	ecx
	push	edx
	push	OFFSET FLAT:$SG1027
	call	_die
	add	esp, 12					; 0000000cH
$L1025:

; 228  : }

	pop	ebp
	ret	0
_do_coprocessor_error ENDP
_TEXT	ENDS
PUBLIC	_do_reserved
_DATA	SEGMENT
	ORG $+2
$SG1034	DB	'reserved (15,17-47) error', 00H
_DATA	ENDS
_TEXT	SEGMENT
_esp$ = 8
_error_code$ = 12
_do_reserved PROC NEAR

; 231  : {

	push	ebp
	mov	ebp, esp

; 232  : 	die("reserved (15,17-47) error",esp,error_code);

	mov	eax, DWORD PTR _error_code$[ebp]
	mov	ecx, DWORD PTR _esp$[ebp]
	push	eax
	push	ecx
	push	OFFSET FLAT:$SG1034
	call	_die
	add	esp, 12					; 0000000cH

; 233  : }

	pop	ebp
	ret	0
_do_reserved ENDP
_TEXT	ENDS
PUBLIC	_trap_init
EXTRN	_idt:BYTE
EXTRN	_divide_error:NEAR
EXTRN	_debug:NEAR
EXTRN	_nmi:NEAR
EXTRN	_int3:NEAR
EXTRN	_overflow:NEAR
EXTRN	_bounds:NEAR
EXTRN	_invalid_op:NEAR
EXTRN	_device_not_available:NEAR
EXTRN	_double_fault:NEAR
EXTRN	_coprocessor_segment_overrun:NEAR
EXTRN	_invalid_TSS:NEAR
EXTRN	_segment_not_present:NEAR
EXTRN	_stack_segment:NEAR
EXTRN	_general_protection:NEAR
EXTRN	_page_fault:NEAR
EXTRN	_reserved:NEAR
EXTRN	_coprocessor_error:NEAR
EXTRN	_parallel_interrupt:NEAR
EXTRN	_irq13:NEAR
_TEXT	SEGMENT
$T1265 = -8
$T1272 = -1
$T1273 = -8
$T1279 = -8
$T1284 = -1
$T1285 = -8
_trap_init PROC NEAR

; 240  : {

	push	ebp
	mov	ebp, esp
	sub	esp, 8

; 243  : 	set_trap_gate(0,&divide_error);// 设置除操作出错的中断向量值。以下雷同。

	mov	eax, OFFSET FLAT:_divide_error
	mov	ecx, OFFSET FLAT:_divide_error
	and	eax, 65535				; 0000ffffH
	and	ecx, -65536				; ffff0000H
	add	eax, 524288				; 00080000H
	add	ecx, 36608				; 00008f00H
	mov	DWORD PTR _idt, eax
	mov	DWORD PTR _idt+4, ecx

; 244  : 	set_trap_gate(1,&debug);

	mov	edx, OFFSET FLAT:_debug
	mov	eax, OFFSET FLAT:_debug

; 245  : 	set_trap_gate(2,&nmi);

	mov	ecx, OFFSET FLAT:_nmi
	and	edx, 65535				; 0000ffffH
	and	eax, -65536				; ffff0000H
	and	ecx, 65535				; 0000ffffH
	add	edx, 524288				; 00080000H
	add	eax, 36608				; 00008f00H
	add	ecx, 524288				; 00080000H
	mov	DWORD PTR _idt+8, edx
	mov	DWORD PTR _idt+12, eax
	mov	DWORD PTR _idt+16, ecx
	mov	edx, OFFSET FLAT:_nmi

; 246  : 	set_system_gate(3,&int3);	/* int3-5 can be called from all */

	mov	eax, OFFSET FLAT:_int3
	mov	ecx, OFFSET FLAT:_int3
	and	edx, -65536				; ffff0000H
	and	eax, 65535				; 0000ffffH
	and	ecx, -65536				; ffff0000H
	add	edx, 36608				; 00008f00H
	add	eax, 524288				; 00080000H
	add	ecx, 61184				; 0000ef00H
	mov	DWORD PTR _idt+20, edx
	mov	DWORD PTR _idt+24, eax
	mov	DWORD PTR _idt+28, ecx

; 247  : 	set_system_gate(4,&overflow);

	mov	edx, OFFSET FLAT:_overflow
	mov	eax, OFFSET FLAT:_overflow

; 248  : 	set_system_gate(5,&bounds);

	mov	ecx, OFFSET FLAT:_bounds
	and	edx, 65535				; 0000ffffH
	and	eax, -65536				; ffff0000H
	and	ecx, 65535				; 0000ffffH
	add	edx, 524288				; 00080000H
	add	eax, 61184				; 0000ef00H
	add	ecx, 524288				; 00080000H
	mov	DWORD PTR _idt+32, edx
	mov	DWORD PTR _idt+36, eax
	mov	DWORD PTR _idt+40, ecx
	mov	edx, OFFSET FLAT:_bounds

; 249  : 	set_trap_gate(6,&invalid_op);

	mov	eax, OFFSET FLAT:_invalid_op
	mov	ecx, OFFSET FLAT:_invalid_op
	and	edx, -65536				; ffff0000H
	and	eax, 65535				; 0000ffffH
	and	ecx, -65536				; ffff0000H
	add	edx, 61184				; 0000ef00H
	add	eax, 524288				; 00080000H
	add	ecx, 36608				; 00008f00H
	mov	DWORD PTR _idt+44, edx
	mov	DWORD PTR _idt+48, eax
	mov	DWORD PTR _idt+52, ecx

; 250  : 	set_trap_gate(7,&device_not_available);

	mov	edx, OFFSET FLAT:_device_not_available
	mov	eax, OFFSET FLAT:_device_not_available

; 251  : 	set_trap_gate(8,&double_fault);

	mov	ecx, OFFSET FLAT:_double_fault
	and	edx, 65535				; 0000ffffH
	and	eax, -65536				; ffff0000H
	and	ecx, 65535				; 0000ffffH
	add	edx, 524288				; 00080000H
	add	eax, 36608				; 00008f00H
	add	ecx, 524288				; 00080000H
	mov	DWORD PTR _idt+56, edx
	mov	DWORD PTR _idt+60, eax
	mov	DWORD PTR _idt+64, ecx
	mov	edx, OFFSET FLAT:_double_fault

; 252  : 	set_trap_gate(9,&coprocessor_segment_overrun);

	mov	eax, OFFSET FLAT:_coprocessor_segment_overrun
	mov	ecx, OFFSET FLAT:_coprocessor_segment_overrun
	and	edx, -65536				; ffff0000H
	and	eax, 65535				; 0000ffffH
	and	ecx, -65536				; ffff0000H
	add	edx, 36608				; 00008f00H
	add	eax, 524288				; 00080000H
	add	ecx, 36608				; 00008f00H
	mov	DWORD PTR _idt+68, edx
	mov	DWORD PTR _idt+72, eax
	mov	DWORD PTR _idt+76, ecx

; 253  : 	set_trap_gate(10,&invalid_TSS);

	mov	edx, OFFSET FLAT:_invalid_TSS
	mov	eax, OFFSET FLAT:_invalid_TSS

; 254  : 	set_trap_gate(11,&segment_not_present);

	mov	ecx, OFFSET FLAT:_segment_not_present
	and	eax, -65536				; ffff0000H
	and	edx, 65535				; 0000ffffH
	add	eax, 36608				; 00008f00H
	and	ecx, 65535				; 0000ffffH
	mov	DWORD PTR _idt+84, eax

; 255  : 	set_trap_gate(12,&stack_segment);

	mov	eax, OFFSET FLAT:_stack_segment
	add	edx, 524288				; 00080000H
	add	ecx, 524288				; 00080000H
	and	eax, 65535				; 0000ffffH
	mov	DWORD PTR _idt+80, edx
	mov	DWORD PTR _idt+88, ecx
	add	eax, 524288				; 00080000H
	mov	edx, OFFSET FLAT:_segment_not_present
	mov	ecx, OFFSET FLAT:_stack_segment
	mov	DWORD PTR _idt+96, eax
	and	edx, -65536				; ffff0000H
	and	ecx, -65536				; ffff0000H

; 256  : 	set_trap_gate(13,&general_protection);

	mov	eax, OFFSET FLAT:_general_protection
	add	edx, 36608				; 00008f00H
	add	ecx, 36608				; 00008f00H
	and	eax, -65536				; ffff0000H
	mov	DWORD PTR _idt+92, edx
	mov	DWORD PTR _idt+100, ecx
	add	eax, 36608				; 00008f00H
	mov	edx, OFFSET FLAT:_general_protection

; 257  : 	set_trap_gate(14,&page_fault);

	mov	ecx, OFFSET FLAT:_page_fault
	mov	DWORD PTR _idt+108, eax
	and	edx, 65535				; 0000ffffH
	and	ecx, 65535				; 0000ffffH

; 258  : 	set_trap_gate(15,&reserved);

	mov	eax, OFFSET FLAT:_reserved
	add	edx, 524288				; 00080000H
	add	ecx, 524288				; 00080000H
	and	eax, 65535				; 0000ffffH
	mov	DWORD PTR _idt+104, edx
	mov	DWORD PTR _idt+112, ecx
	mov	edx, OFFSET FLAT:_page_fault
	lea	ecx, DWORD PTR [eax+524288]

; 259  : 	set_trap_gate(16,&coprocessor_error);

	mov	eax, OFFSET FLAT:_coprocessor_error
	and	edx, -65536				; ffff0000H
	and	eax, 65535				; 0000ffffH
	add	edx, 36608				; 00008f00H
	add	eax, 524288				; 00080000H
	mov	DWORD PTR _idt+116, edx
	mov	edx, OFFSET FLAT:_reserved
	mov	DWORD PTR _idt+128, eax
	mov	eax, OFFSET FLAT:_coprocessor_error
	and	edx, -65536				; ffff0000H
	and	eax, -65536				; ffff0000H
	add	edx, 36608				; 00008f00H
	add	eax, 36608				; 00008f00H
	mov	DWORD PTR _idt+132, eax
	mov	DWORD PTR _idt+120, ecx
	mov	DWORD PTR _idt+124, edx
	mov	eax, OFFSET FLAT:_idt+136
$L1072:

; 260  : // 下面将int17-48 的陷阱门先均设置为reserved，以后每个硬件初始化时会重新设置自己的陷阱门。
; 261  : 	for (i=17;i<48;i++)
; 262  : 		set_trap_gate(i,&reserved);

	mov	DWORD PTR [eax], ecx
	mov	DWORD PTR [eax+4], edx
	add	eax, 8
	cmp	eax, OFFSET FLAT:_idt+384
	jl	SHORT $L1072

; 263  : 	set_trap_gate(45,&irq13);// 设置协处理器的陷阱门。

	mov	ecx, OFFSET FLAT:_irq13
	mov	edx, OFFSET FLAT:_irq13
	and	ecx, 65535				; 0000ffffH
	and	edx, -65536				; ffff0000H
	add	ecx, 524288				; 00080000H
	add	edx, 36608				; 00008f00H
	mov	DWORD PTR _idt+360, ecx

; 264  : 	outb_p(inb_p(0x21)&0xfb,0x21);// 允许主8259A 芯片的IRQ2 中断请求。

	mov	ecx, 33					; 00000021H
	mov	DWORD PTR _idt+364, edx
	mov	DWORD PTR $T1265[ebp], ecx

; 243  : 	set_trap_gate(0,&divide_error);// 设置除操作出错的中断向量值。以下雷同。

	mov	dx, WORD PTR $T1265[ebp]

; 244  : 	set_trap_gate(1,&debug);

	in	al, dx

; 246  : 	set_system_gate(3,&int3);	/* int3-5 can be called from all */

	jmp	SHORT $l1$1263
$l1$1263:

; 247  : 	set_system_gate(4,&overflow);

	jmp	SHORT $l2$1264
$l2$1264:

; 264  : 	outb_p(inb_p(0x21)&0xfb,0x21);// 允许主8259A 芯片的IRQ2 中断请求。

	and	al, 251					; 000000fbH
	mov	DWORD PTR $T1273[ebp], ecx
	mov	BYTE PTR $T1272[ebp], al

; 241  : 	int i;

	mov	al, BYTE PTR $T1272[ebp]

; 242  : 

	mov	dx, WORD PTR $T1273[ebp]

; 243  : 	set_trap_gate(0,&divide_error);// 设置除操作出错的中断向量值。以下雷同。

	out	dx, al

; 244  : 	set_trap_gate(1,&debug);

	jmp	SHORT $l1$1270
$l1$1270:

; 245  : 	set_trap_gate(2,&nmi);

	jmp	SHORT $l2$1271
$l2$1271:

; 265  : 	outb(inb_p(0xA1)&0xdf,0xA1);// 允许从8259A 芯片的IRQ13 中断请求。

	mov	ecx, 161				; 000000a1H
	mov	DWORD PTR $T1279[ebp], ecx

; 243  : 	set_trap_gate(0,&divide_error);// 设置除操作出错的中断向量值。以下雷同。

	mov	dx, WORD PTR $T1279[ebp]

; 244  : 	set_trap_gate(1,&debug);

	in	al, dx

; 246  : 	set_system_gate(3,&int3);	/* int3-5 can be called from all */

	jmp	SHORT $l1$1277
$l1$1277:

; 247  : 	set_system_gate(4,&overflow);

	jmp	SHORT $l2$1278
$l2$1278:

; 265  : 	outb(inb_p(0xA1)&0xdf,0xA1);// 允许从8259A 芯片的IRQ13 中断请求。

	and	al, 223					; 000000dfH
	mov	DWORD PTR $T1285[ebp], ecx
	mov	BYTE PTR $T1284[ebp], al

; 241  : 	int i;

	mov	dx, WORD PTR $T1285[ebp]

; 242  : 

	mov	al, BYTE PTR $T1284[ebp]

; 243  : 	set_trap_gate(0,&divide_error);// 设置除操作出错的中断向量值。以下雷同。

	out	dx, al

; 266  : 	set_trap_gate(39,&parallel_interrupt);// 设置并行口的陷阱门。

	mov	eax, OFFSET FLAT:_parallel_interrupt
	mov	ecx, OFFSET FLAT:_parallel_interrupt
	and	eax, 65535				; 0000ffffH
	and	ecx, -65536				; ffff0000H
	add	eax, 524288				; 00080000H
	add	ecx, 36608				; 00008f00H
	mov	DWORD PTR _idt+312, eax
	mov	DWORD PTR _idt+316, ecx

; 267  : }

	mov	esp, ebp
	pop	ebp
	ret	0
_trap_init ENDP
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
$l1$114:

; 396  :   l1: lodsb	// 取串1 字符ds:[esi]->al，并且esi++。

	lodsb

; 397  : 	  test al,al	// 该字符等于0 值吗（串1 结尾）？

	test	al, al

; 398  : 	  je l2		// 如果是，则向前跳转到标号2 处。

	je	SHORT $l2$115

; 399  : 	  mov edi,ebx	// 取串2 头指针放入edi 中。

	mov	edi, ebx

; 400  : 	  mov ecx,edx	// 再将串2 的长度值放入ecx 中。

	mov	ecx, edx

; 401  : 	  repne scasb	// 比较al 与串2 中字符es:[edi]，并且edi++。如果不相等就继续比较。

	repnz	 scasb

; 402  : 	  je l1		// 如果相等，则向后跳转到标号1 处。

	je	SHORT $l1$114
$l2$115:

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
$l1$123:

; 454  : 	l1: lodsb	// 取串1 字符ds:[esi]->al，并且esi++。

	lodsb

; 455  : 		test al,al	// 该字符等于0 值吗（串1 结尾）？

	test	al, al

; 456  : 		je l2		// 如果是，则向前跳转到标号2 处。

	je	SHORT $l2$124

; 457  : 		mov edi,ebx	// 取串2 头指针放入edi 中。

	mov	edi, ebx

; 458  : 		mov ecx,edx 	// 再将串2 的长度值放入ecx 中。

	mov	ecx, edx

; 459  : 		repne scasb	// 比较al 与串2 中字符es:[edi]，并且edi++。如果不相等就继续比较。

	repnz	 scasb

; 460  : 		jne l1		// 如果不相等，则向后跳转到标号1 处。

	jne	SHORT $l1$123
$l2$124:

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
$l1$131:

; 512  : 	l1: lodsb	// 取串1 字符ds:[esi]??al，并且esi++。

	lodsb

; 513  : 		test al,al	// 该字符等于0 值吗（串1 结尾）？

	test	al, al

; 514  : 		je l2		// 如果是，则向前跳转到标号2 处。

	je	SHORT $l2$132

; 515  : 		mov edi,ebx	// 取串2 头指针放入edi 中。

	mov	edi, ebx

; 516  : 		mov ecx,edx	// 再将串2 的长度值放入ecx 中。

	mov	ecx, edx

; 517  : 		repne scasb		// 比较al 与串2 中字符es:[edi]，并且edi++。如果不相等就继续比较。

	repnz	 scasb

; 518  : 		jne l1	// 如果不相等，则向后跳转到标号1 处。

	jne	SHORT $l1$131

; 519  : 		dec esi	// esi--，指向一个包含在串2 中的字符。

	dec	esi

; 520  : 		jmp l3		// 向前跳转到标号3 处。

	jmp	SHORT $l3$133
$l2$132:

; 521  : 	l2: xor esi,esi	// 没有找到符合条件的，将返回值为NULL。

	xor	esi, esi
$l3$133:

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
$l1$140:

; 576  : 	l1: mov edi,ebx	// 取串2 头指针放入edi 中。

	mov	edi, ebx

; 577  : 		mov ecx,edx	// 再将串2 的长度值放入ecx 中。

	mov	ecx, edx

; 578  : 		mov eax,esi	// 将串1 的指针复制到eax 中。

	mov	eax, esi

; 579  : 		repe cmpsb// 比较串1 和串2 字符(ds:[esi],es:[edi])，esi++,edi++。若对应字符相等就一直比较下去。

	rep	 cmpsb

; 580  : 		je l2

	je	SHORT $l2$141

; 581  : // 对空串同样有效，见上面 // 若全相等，则转到标号2。
; 582  : 		xchg esi,eax	// 串1 头指针->esi，比较结果的串1 指针->eax。

	xchg	esi, eax

; 583  : 		inc esi	// 串1 头指针指向下一个字符。

	inc	esi

; 584  : 		cmp [eax-1],0	// 串1 指针(eax-1)所指字节是0 吗？

	cmp	BYTE PTR [eax-1], 0

; 585  : 		jne l1	// 不是则跳转到标号1，继续从串1 的第2 个字符开始比较。

	jne	SHORT $l1$140

; 586  : 		xor eax,eax	// 清eax，表示没有找到匹配。

	xor	eax, eax
$l2$141:

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

	jne	SHORT $l1$153

; 678  : 		mov ebx,strtok

	mov	ebx, DWORD PTR _strtok

; 679  : 		test ebx,ebx	// 如果是NULL，则表示此次是后续调用，测ebx(__strtok)。

	test	ebx, ebx

; 680  : 		je l8		// 如果ebx 指针是NULL，则不能处理，跳转结束。

	je	SHORT $l8$154

; 681  : 		mov esi,ebx	// 将ebx 指针复制到esi。

	mov	esi, ebx
$l1$153:

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

	je	SHORT $l7$155

; 691  : 		mov edx,ecx	// 将串2 长度暂存入edx。

	mov	edx, ecx
$l2$156:

; 692  : 	l2: lodsb	// 取串1 的字符ds:[esi]->al，并且esi++。

	lodsb

; 693  : 		test al,al	// 该字符为0 值吗(串1 结束)？

	test	al, al

; 694  : 		je l7		// 如果是，则跳转标号7。

	je	SHORT $l7$155

; 695  : 		mov edi,ct	// edi 再次指向串2 首。

	mov	edi, DWORD PTR _ct$[ebp]

; 696  : 		mov ecx,edx	// 取串2 的长度值置入计数器ecx。

	mov	ecx, edx

; 697  : 		repne scasb// 将al 中串1 的字符与串2 中所有字符比较，判断该字符是否为分割符。

	repnz	 scasb

; 698  : 		je l2		// 若能在串2 中找到相同字符（分割符），则跳转标号2。

	je	SHORT $l2$156

; 699  : 		dec esi	// 若不是分割符，则串1 指针esi 指向此时的该字符。

	dec	esi

; 700  : 		cmp [esi],0	// 该字符是NULL 字符吗？

	cmp	BYTE PTR [esi], 0

; 701  : 		je l7		// 若是，则跳转标号7 处。

	je	SHORT $l7$155

; 702  : 		mov ebx,esi	// 将该字符的指针esi 存放在ebx。

	mov	ebx, esi
$l3$157:

; 703  : 	l3: lodsb	// 取串1 下一个字符ds:[esi]->al，并且esi++。

	lodsb

; 704  : 		test al,al	// 该字符是NULL 字符吗？

	test	al, al

; 705  : 		je l5		// 若是，表示串1 结束，跳转到标号5。

	je	SHORT $l5$158

; 706  : 		mov edi,ct	// edi 再次指向串2 首。

	mov	edi, DWORD PTR _ct$[ebp]

; 707  : 		mov ecx,edx	// 串2 长度值置入计数器ecx。

	mov	ecx, edx

; 708  : 		repne scasb // 将al 中串1 的字符与串2 中每个字符比较，测试al 字符是否是分割符。

	repnz	 scasb

; 709  : 		jne l3		// 若不是分割符则跳转标号3，检测串1 中下一个字符。

	jne	SHORT $l3$157

; 710  : 		dec esi	// 若是分割符，则esi--，指向该分割符字符。

	dec	esi

; 711  : 		cmp [esi],0	// 该分割符是NULL 字符吗？

	cmp	BYTE PTR [esi], 0

; 712  : 		je l5		// 若是，则跳转到标号5。

	je	SHORT $l5$158

; 713  : 		mov [esi],0	// 若不是，则将该分割符用NULL 字符替换掉。

	mov	BYTE PTR [esi], 0

; 714  : 		inc esi	// esi 指向串1 中下一个字符，也即剩余串首。

	inc	esi

; 715  : 		jmp l6		// 跳转标号6 处。

	jmp	SHORT $l6$159
$l5$158:

; 716  : 	l5: xor esi,esi	// esi 清零。

	xor	esi, esi
$l6$159:

; 717  : 	l6: cmp [ebx],0	// ebx 指针指向NULL 字符吗？

	cmp	BYTE PTR [ebx], 0

; 718  : 		jne l7	// 若不是，则跳转标号7。

	jne	SHORT $l7$155

; 719  : 		xor ebx,ebx	// 若是，则让ebx=NULL。

	xor	ebx, ebx
$l7$155:

; 720  : 	l7: test ebx,ebx	// ebx 指针为NULL 吗？

	test	ebx, ebx

; 721  : 		jne l8	// 若不是则跳转8，结束汇编代码。

	jne	SHORT $l8$154

; 722  : 		mov esi,ebx	// 将esi 置为NULL。

	mov	esi, ebx
$l8$154:

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

	je	SHORT $l1$186

; 881  : 		mov eax,1	// 否则eax 置1，

	mov	eax, 1

; 882  : 		jl l1		// 若内存块2 内容的值<内存块1，则跳转标号1。

	jl	SHORT $l1$186

; 883  : 		neg eax	// 否则eax = -eax。

	neg	eax
$l1$186:

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
	jne	SHORT $L195

; 914  :     return NULL;

	xor	eax, eax

; 928  : 	}
; 929  : //  return __res;			// 返回字符指针。
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

; 920  : 		cld		// 清方向位。

	cld

; 921  : 		repne scasb// al 中字符与es:[edi]字符作比较，并且edi++，如果不相等则重复执行下面语句，

	repnz	 scasb

; 922  : 		je l1		// 如果相等则向前跳转到标号1 处。

	je	SHORT $l1$196

; 923  : 		mov edi,1	// 否则edi 中置1。

	mov	edi, 1
$l1$196:

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

	je	SHORT $l1$672

; 278  : 		xchg ecx,current/* current = task[n]； */

	xchg	ecx, DWORD PTR _current

; 279  : 		/*执行长跳转，造成任务切换 (头大了很长时间，多多包涵)*/
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

; 289  : // 在任务切换回来后才会继续执行下面的语句。
; 290  : 		cmp last_task_used_math,ecx /* 新任务上次使用过协处理器吗？*/

	cmp	DWORD PTR _last_task_used_math, ecx

; 291  : 		jne l1

	jne	SHORT $l1$672

; 292  : 		clts/* 新任务上次使用过协处理器，则清cr0 的TS 标志。*/

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
