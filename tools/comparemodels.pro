pro comparemodels, T, logg, broad

; read complete models
readtlusty,T,logg,tx,ty
readcmfgen,T,logg,cx,cy

; read continuum
readtlustycont,T,logg,txc,tyc
readcmfgencont,T,logg,cxc,cyc

; Convolve model
gaussconvol,tx,ty,broad,txout,tyout
gaussconvol,cx,cy,broad,cxout,cyout

; Rebin continuum
ty2 = interpol(tyc,txc,txout)
cy2 = interpol(cyc,cxc,cxout)

plot,txout,tyout/ty2,xrange=[3000,8000]
oplot,cxout-4,cyout/cy2,LINESTYLE=1

return
end

@./tools/gaussconvol.pro
@./tlusty/readtlusty.pro
@./cmfgen/readcmfgen.pro
@./tlusty/readtlustycont.pro
@./cmfgen/readcmfgencont.pro