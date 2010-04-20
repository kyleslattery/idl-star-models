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
dx = mean(deriv(x))
x0 = x(0)
newx = findgen(N)*dx+x0
newy = interpol(y,x,newx)
x = newx
y = newy

broadening = broadening/dx
;print,x

; Create Gaussian function
; Docs: http://idlastro.gsfc.nasa.gov/ftp/pro/image/psf_gaussian.pro
gauss = PSF_GAUSSIAN(NPIXEL=broadening*10, FWHM=broadening, /NORMAL, NDIMEN=1)

; CONVOL with the Gauss function
yout = CONVOL(y, gauss)
xout = x

return
end
