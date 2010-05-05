; Read a rectified version of Tlusty

pro readtlustyrect, T, logg, broad, w, f
	
readtlusty,T,logg,xf,yf
readtlustycont,T,logg,xc,yc

gaussconvol,xf,yf,broad,xg,yg

yrebin = interpol(yc,xc,xg)

w = xg
f = yg/yrebin
	
return
end

@./tools/gaussconvol.pro
@./tlusty/readtlusty.pro
@./tlusty/readtlustycont.pro