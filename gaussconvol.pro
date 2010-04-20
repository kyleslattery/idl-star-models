; x: x values to convolve
; y: y values to convolve
; broadening: instrumental broadening value to use, in Angstroms
; xout: returned x values
; yout: returned y values
pro gaussconvol, x, y, broadening, xout, yout

; Determine size of array
sizearr = double(size(x))
N       = sizearr(1)

; Rebin to uniform grid
newdx = mean(deriv(x))
x0 = x(0)
newx = findgen(N)*newdx+x0
newy = interpol(y,x,newx)

newbroadening = broadening/newdx
;print,x

; Create Gaussian function
; Docs: http://idlastro.gsfc.nasa.gov/ftp/pro/image/psf_gaussian.pro
gauss = PSF_GAUSSIAN(NPIXEL=newbroadening*10, FWHM=newbroadening, /NORMAL, NDIMEN=1)

; CONVOL with the Gauss function
yout = CONVOL(newy, gauss)
xout = newx

return
end
