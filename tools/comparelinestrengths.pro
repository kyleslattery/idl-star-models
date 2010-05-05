; Line should be specified in angstroms
pro comparelinestrengths, line
	
; Array of available model temperatures for surface gravity of 4.00:
tlustytemps = [27500, 30000, 32500, 35000, 37500, 40000, 42500, 45000, 47500, 50000, 52500, 55000]
cmfgentemps = [30000, 32500, 35000, 40000, 42500, 48500]

tlustystrengths = dblarr(12)
cmfgenstrengths = dblarr(6)

; Get tlusty values for lines
for i = 0, 11 do begin
	print, "TLUSTY: " + string(tlustytemps(i))
	
	readtlustyrect, tlustytemps(i), 4.00, 2, w, f
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
for i = 0, 5 do begin
	print, "CMFGEN: " + string(cmfgentemps(i))
	
	readcmfgenrect, cmfgentemps(i), 4.00, 2, w, f
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


plot, tlustytemps, tlustystrengths
oplot, cmfgentemps, cmfgenstrengths, LINESTYLE=1
	
return
end

@./cmfgen/readcmfgenrect.pro
@./tlusty/readtlustyrect.pro