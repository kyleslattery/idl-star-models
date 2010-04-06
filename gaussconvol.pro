; x: x values to convolve
; y: y values to convolve
; broadening: instrumental broadening value to use, in Angstroms
; xout: returned x values
; yout: returned y values
pro gaussconvol, x, y, broadening, xout, yout

; Create Gaussian function
; Docs: http://idlastro.gsfc.nasa.gov/ftp/pro/image/psf_gaussian.pro
gauss = PSF_GAUSSIAN(NPIXEL=10*broadening, FWHM=broadening, /NORMAL, NDIMEN=1)

; CONVOL with the Gauss function
yout = CONVOL(y, gauss)
xout = x

return
end
