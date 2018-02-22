INCLUDE Irvine32.inc
.CODE
main PROC
	
	MOV EAX,5
	ADD EAX,6
	CALL dumpregs
	ret

main endp
end main