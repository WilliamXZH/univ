	TITLE	..\kernel\mktime.c
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
_DATA	SEGMENT
_month	DD	00H
	DD	028de80H
	DD	04f1a00H
	DD	077f880H
	DD	09f8580H
	DD	0c86400H
	DD	0eff100H
	DD	0118cf80H
	DD	0141ae00H
	DD	01693b00H
	DD	01921980H
	DD	01b9a680H
_DATA	ENDS
PUBLIC	_kernel_mktime
_TEXT	SEGMENT
_tm$ = 8
_kernel_mktime PROC NEAR

; 54   : {

	push	ebp
	mov	ebp, esp
	push	esi

; 55   :   long res;
; 56   :   int year;
; 57   : 
; 58   :   year = tm->tm_year - 70;	// 从70 年到现在经过的年数(2 位表示方式)，

	mov	esi, DWORD PTR _tm$[ebp]
	push	edi
	mov	ecx, DWORD PTR [esi+20]

; 59   :   // 因此会有2000 年问题。
; 60   :   /* magic offsets (y+1) needed to get leapyears right. */
; 61   :   /* 为了获得正确的闰年数，这里需要这样一个魔幻偏值(y+1) */
; 62   :   res = YEAR * year + DAY * ((year + 1) / 4);	// 这些年经过的秒数时间 + 每个闰年时多1 天
; 63   :   res += month[tm->tm_mon];	// 的秒数时间，在加上当年到当月时的秒数。

	mov	edi, DWORD PTR [esi+16]
	sub	ecx, 70					; 00000046H
	lea	eax, DWORD PTR [ecx+1]
	cdq
	and	edx, 3
	add	eax, edx
	lea	edx, DWORD PTR [ecx+ecx*8]
	sar	eax, 2
	lea	edx, DWORD PTR [ecx+edx*8]
	lea	edx, DWORD PTR [edx+edx*4]
	add	eax, edx
	mov	edx, eax
	shl	edx, 4
	sub	edx, eax
	lea	eax, DWORD PTR [edx+edx*4]
	lea	edx, DWORD PTR [eax+eax*8]
	mov	eax, DWORD PTR _month[edi*4]
	shl	edx, 7
	add	edx, eax

; 64   :   /* and (y+2) here. If it wasn't a leap-year, we have to adjust */
; 65   :   /* 以及(y+2)。如果(y+2)不是闰年，那么我们就必须进行调整(减去一天的秒数时间)。 */
; 66   :   if (tm->tm_mon > 1 && ((year + 2) % 4))

	cmp	edi, 1
	jle	SHORT $L88
	add	ecx, 2
	and	ecx, -2147483645			; 80000003H
	jns	SHORT $L92
	dec	ecx
	or	ecx, -4					; fffffffcH
	inc	ecx
$L92:
	je	SHORT $L88

; 67   :     res -= DAY;

	sub	edx, 86400				; 00015180H
$L88:

; 68   :   res += DAY * (tm->tm_mday - 1);	// 再加上本月过去的天数的秒数时间。
; 69   :   res += HOUR * tm->tm_hour;	// 再加上当天过去的小时数的秒数时间。
; 70   :   res += MINUTE * tm->tm_min;	// 再加上1 小时内过去的分钟数的秒数时间。
; 71   :   res += tm->tm_sec;		// 再加上1 分钟内已过的秒数。
; 72   :   return res;			// 即等于从1970 年以来经过的秒数时间。

	mov	eax, DWORD PTR [esi+12]
	mov	ecx, DWORD PTR [esi+8]
	pop	edi
	lea	eax, DWORD PTR [eax+eax*2]
	lea	eax, DWORD PTR [ecx+eax*8-24]
	mov	ecx, eax
	shl	ecx, 4
	sub	ecx, eax
	mov	eax, DWORD PTR [esi+4]
	lea	eax, DWORD PTR [eax+ecx*4]
	mov	ecx, eax
	shl	ecx, 4
	sub	ecx, eax
	mov	eax, DWORD PTR [esi]
	pop	esi
	lea	eax, DWORD PTR [eax+ecx*4]
	add	eax, edx

; 73   : }

	pop	ebp
	ret	0
_kernel_mktime ENDP
_TEXT	ENDS
END
