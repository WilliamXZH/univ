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

; 243  : 	set_trap_gate(0,&divide_error);// ���ó�����������ж�����ֵ��������ͬ��

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

; 260  : // ���潫int17-48 ���������Ⱦ�����Ϊreserved���Ժ�ÿ��Ӳ����ʼ��ʱ�����������Լ��������š�
; 261  : 	for (i=17;i<48;i++)
; 262  : 		set_trap_gate(i,&reserved);

	mov	DWORD PTR [eax], ecx
	mov	DWORD PTR [eax+4], edx
	add	eax, 8
	cmp	eax, OFFSET FLAT:_idt+384
	jl	SHORT $L1072

; 263  : 	set_trap_gate(45,&irq13);// ����Э�������������š�

	mov	ecx, OFFSET FLAT:_irq13
	mov	edx, OFFSET FLAT:_irq13
	and	ecx, 65535				; 0000ffffH
	and	edx, -65536				; ffff0000H
	add	ecx, 524288				; 00080000H
	add	edx, 36608				; 00008f00H
	mov	DWORD PTR _idt+360, ecx

; 264  : 	outb_p(inb_p(0x21)&0xfb,0x21);// ������8259A оƬ��IRQ2 �ж�����

	mov	ecx, 33					; 00000021H
	mov	DWORD PTR _idt+364, edx
	mov	DWORD PTR $T1265[ebp], ecx

; 243  : 	set_trap_gate(0,&divide_error);// ���ó�����������ж�����ֵ��������ͬ��

	mov	dx, WORD PTR $T1265[ebp]

; 244  : 	set_trap_gate(1,&debug);

	in	al, dx

; 246  : 	set_system_gate(3,&int3);	/* int3-5 can be called from all */

	jmp	SHORT $l1$1263
$l1$1263:

; 247  : 	set_system_gate(4,&overflow);

	jmp	SHORT $l2$1264
$l2$1264:

; 264  : 	outb_p(inb_p(0x21)&0xfb,0x21);// ������8259A оƬ��IRQ2 �ж�����

	and	al, 251					; 000000fbH
	mov	DWORD PTR $T1273[ebp], ecx
	mov	BYTE PTR $T1272[ebp], al

; 241  : 	int i;

	mov	al, BYTE PTR $T1272[ebp]

; 242  : 

	mov	dx, WORD PTR $T1273[ebp]

; 243  : 	set_trap_gate(0,&divide_error);// ���ó�����������ж�����ֵ��������ͬ��

	out	dx, al

; 244  : 	set_trap_gate(1,&debug);

	jmp	SHORT $l1$1270
$l1$1270:

; 245  : 	set_trap_gate(2,&nmi);

	jmp	SHORT $l2$1271
$l2$1271:

; 265  : 	outb(inb_p(0xA1)&0xdf,0xA1);// �����8259A оƬ��IRQ13 �ж�����

	mov	ecx, 161				; 000000a1H
	mov	DWORD PTR $T1279[ebp], ecx

; 243  : 	set_trap_gate(0,&divide_error);// ���ó�����������ж�����ֵ��������ͬ��

	mov	dx, WORD PTR $T1279[ebp]

; 244  : 	set_trap_gate(1,&debug);

	in	al, dx

; 246  : 	set_system_gate(3,&int3);	/* int3-5 can be called from all */

	jmp	SHORT $l1$1277
$l1$1277:

; 247  : 	set_system_gate(4,&overflow);

	jmp	SHORT $l2$1278
$l2$1278:

; 265  : 	outb(inb_p(0xA1)&0xdf,0xA1);// �����8259A оƬ��IRQ13 �ж�����

	and	al, 223					; 000000dfH
	mov	DWORD PTR $T1285[ebp], ecx
	mov	BYTE PTR $T1284[ebp], al

; 241  : 	int i;

	mov	dx, WORD PTR $T1285[ebp]

; 242  : 

	mov	al, BYTE PTR $T1284[ebp]

; 243  : 	set_trap_gate(0,&divide_error);// ���ó�����������ж�����ֵ��������ͬ��

	out	dx, al

; 266  : 	set_trap_gate(39,&parallel_interrupt);// ���ò��пڵ������š�

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
