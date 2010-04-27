; Read a rectified version of CMFGEN

pro readcmfgenrect, T, logg, broad, w, f
	
readcmfgen,T,logg,xf,yf
readcmfgencont,T,logg,xc,yc

gaussconvol,xf,yf,broad,xg,yg

yrebin = interpol(yc,xc,xg)

w = xg
f = yg/yrebin
	
return
end

@./gaussconvol.pro
@./readcmfgen.pro
@./readcmfgencont.pro