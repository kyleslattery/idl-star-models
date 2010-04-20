pro comparemodels, T, logg, broad

readtlusty,T,logg,tx,ty
readcmfgen,T,logg,cx,cy

gaussconvol,tx,ty,broad,txout,tyout
gaussconvol,cx,cy,broad,cxout,cyout

plot,txout,tyout
oplot,cxout,cyout,LINESTYLE=1

return
end

@./gaussconvol.pro
@./readtlusty.pro
@./readcmfgen.pro