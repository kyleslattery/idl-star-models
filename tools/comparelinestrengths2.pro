; This works in a similar fashion to comparelinestrengths.pro, but it iterates
; over logg, rather than over temperature.

; Line should be specified in angstroms
pro comparelinestrengths2, line
	
; Array of available model temperatures for T of 30000K:
tlustyloggs = [3.00,3.25,3.50,3.75,4.00,4.25,4.50,4.75]
cmfgenloggs = [3.00,3.25,4.00,4.25]

tlustystrengths = dblarr(8)
cmfgenstrengths = dblarr(4)

; Get tlusty values for lines
for i = 0, 7 do begin
	print, "TLUSTY: " + string(tlustyloggs(i))
	
	readtlustyrect, 30000, tlustyloggs(i), 2, w, f
	plot,w,f,xrange=[line-50,line+50]
	
	; Get lower and upper bounds for line
	print, "Please choose the lower wavelength bound for the line"
	cursor, x1, y1
	wait,1
	
	print, "Please choose the upper wavelength bound for the line"
	cursor, x2, y2

	width = x2-x1
	
	good = where(w ge x1 and w le x2)
	w = w(good)
	f = f(good)
	
	integral = int_tabulated(w, 1-f)

	tlustystrengths(i) = integral
endfor

; Get CMFGEN values for lines
for i = 0, 3 do begin
	print, "CMFGEN: " + string(cmfgenloggs(i))
	
	readcmfgenrect, 30000, cmfgenloggs(i), 2, w, f
	plot,w,f,xrange=[line-50,line+50]
	
	; Get lower and upper bounds for line
	print, "Please choose the lower wavelength bound for the line"
	cursor, x1, y1
	wait,1
	
	print, "Please choose the upper wavelength bound for the line"
	cursor, x2, y2

	width = x2-x1
	
	good = where(w ge x1 and w le x2)
	w = w(good)
	f = f(good)
	
	integral = int_tabulated(w, 1-f)

	cmfgenstrengths(i) = integral
endfor


plot, tlustyloggs, tlustystrengths
oplot, cmfgenloggs, cmfgenstrengths, LINESTYLE=1
	
return
end

@./cmfgen/readcmfgenrect.pro
@./tlusty/readtlustyrect.pro