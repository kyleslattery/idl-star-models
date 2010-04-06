; x: x values to convolve
; y: y values to convolve
; broadening: instrumental broadening value to use, in Angstroms
; xout: returned x values
; yout: returned y values
pro gaussconvol, x, y, broadening, xout, yout

; Create Gaussian function
gauss = PSF_GAUSSIAN(NPIXEL=100, FWHM=broadening, /NORMAL, NDIMEN=1)

return
end
