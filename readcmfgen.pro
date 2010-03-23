pro readcmfgen, T, logg, w, f

T = double(T)
Tstring = strmid(t,7,5)
loggstring = strn(fix(logg*100.))

model = "NT" + Tstring + "_logg" + loggstring + "/obs/obs_fin_10"
dir   = "/Users/kslattery/Desktop/cmfgen/"

openr,1,dir+model

i = 0
totaldata = 0

header = STRARR(3)
READF, 1, header
Nstring = strmid(header(2),25,6)
N = long(Nstring)
print,N

w = dblarr(N)
f = dblarr(N)

; determine how many rows need to be read
wrownum = N/9 
if N mod 9 gt 0 then wrownum = wrownum + 1

frownum = N/10
if N mod 10 gt 0 then frownum = frownum + 1

; wrows stores the frequency value
wrows = strarr(wrownum)
frows = strarr(frownum)

obsheaderrows = strarr(4)

; read wavelenths
READF,1,wrows

; read intensity header
READF,1,obsheaderrows

; read flux
READF,1,frows

w = dblarr(N)
f = dblarr(N)

for i = long(0), N-1 do begin
	wrow = i/9
	wpos = i MOD 9
	
	; freq is in units of 10^15 Hz
	freq = double(strmid(wrows(wrow), 3+wpos*14,12))

	frow = i/10
	fpos = i MOD 10
	fstr = strmid(frows(frow), 3+fpos*12,10)

	if strmid(fstr,6,1) eq '-' then fstr = strmid(fstr,0,6) + 'E' + strmid(fstr,6,4)

	w(i) = double(3.e8*1.e10/(freq*1.e15))
		
	; The coefficient of 3.333333e-12 takes into account several conversion factors:
	; 10^-23 (janskys to ergs) * [(10^15)^2 / 3e8] (convert to flux units) / 1.e10 (convert to angstroms)
	f(i) = double(fstr)*freq*freq*3.333333e-12
endfor

close,1
print,w(100)
plot,w,f,xrange=[3000,8000]
print, 'done'
return
end
