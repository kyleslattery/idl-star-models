pro readtlustycont, T, logg, w, f

; Convert inputs to strings
Tstring = strmid(double(T),7,5)
loggstring = strn(fix(logg*100.))

; automatically generate model name for continuum flux
model = 'G'+Tstring+'g'+loggstring+'v10.vis.17'
dir = '/Users/kslattery/Desktop/Tlusty/Gvispec/'

openr,1,dir+model
N = long(1000000)
w = dblarr(N)
f = dblarr(N)

i = long(0)
while not EOF(1) do begin
    readf,1,tmp1,tmp2
    w(i)= tmp1

    ; convert to observed flux at 1kpc
    f(i) = tmp2*4.*!pi
    i = i+1
endwhile
close,1

good = where(w ne 0)
w = w(good)
f = f(good)

return
end